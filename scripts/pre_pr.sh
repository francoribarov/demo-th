#!/usr/bin/env bash
set -euo pipefail

# Scripts Configuration
# ------------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# Configuration Flags & Defaults
CI_MODE=false
SKIP_BUILD=false
SKIP_TEST=false
SKIP_CODEGEN=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Helper Functions
# ------------------------------------------------------------------------------
log_info() { echo -e "${BLUE}${BOLD}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}${BOLD}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}${BOLD}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}${BOLD}[ERROR]${NC} $1"; }

print_header() {
  echo -e "\n${BOLD}==========================================================${NC}"
  echo -e "${BOLD} $1 ${NC}"
  echo -e "${BOLD}==========================================================${NC}\n"
}

usage() {
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  --ci              Run in CI mode (strict checks, smoke builds)"
  echo "  --skip-build      Skip smoke builds (Android/iOS/Web)"
  echo "  --skip-test       Skip tests"
  echo "  --skip-codegen    Skip code generation"
  echo "  --help            Show this help message"
  exit 1
}

# Argument Parsing
# ------------------------------------------------------------------------------
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --ci) CI_MODE=true ;;
    --skip-build) SKIP_BUILD=true ;;
    --skip-test) SKIP_TEST=true ;;
    --skip-codegen) SKIP_CODEGEN=true ;;
    --help) usage ;;
    *) log_error "Unknown parameter passed: $1"; usage ;;
  esac
  shift
done

# Step 1: Tooling Verification (FVM detection)
# ------------------------------------------------------------------------------
print_header "Step 1: Environment Setup"

FLUTTER_CMD="flutter"
DART_CMD="dart"

# Check for FVM
if [ -d ".fvm" ] || [ -f ".fvmrc" ]; then
  if command -v fvm &> /dev/null; then
    log_info "FVM configuration detected. Using 'fvm flutter' and 'fvm dart'."
    FLUTTER_CMD="fvm flutter"
    DART_CMD="fvm dart"
  else
    log_warn "FVM configuration detected but 'fvm' command not found. Using system flutter."
    log_warn "Install FVM for consistent results: https://fvm.app/docs/getting-started/installation"
  fi
fi

log_info "Using Flutter: $($FLUTTER_CMD --version | head -n 1)"
log_info "Using Dart: $($DART_CMD --version)"

# Step 2: Dependencies
# ------------------------------------------------------------------------------
print_header "Step 2: Bootstrap Dependencies"

log_info "Running 'flutter pub get'..."
$FLUTTER_CMD pub get || { log_error "Failed to install dependencies"; exit 1; }

# Step 3: Code Generation (if build_runner is present)
# ------------------------------------------------------------------------------
if [ "$SKIP_CODEGEN" = false ] && grep -q "build_runner:" pubspec.yaml; then
  print_header "Step 3: Code Generation"
  
  if [ "$CI_MODE" = true ]; then
    log_info "CI Mode: Checking if generated files are up to date..."
    # In CI, we want to ensure generated files are committed and match source.
    # We run build, and then check git status.
    $DART_CMD run build_runner build --delete-conflicting-outputs || { log_error "Codegen failed"; exit 1; }
    
    # Check for changes
    if [ -n "$(git status --porcelain)" ]; then
       log_error "Generated files are not up to date. Run 'dart run build_runner build' locally and commit changes."
       git status --porcelain
       # We only fail if there are changes to generated files specifically, 
       # but for safety in CI gate, any uncommitted change is generally bad.
       exit 1
    else
       log_success "Generated files are consistent."
    fi
  else
    log_info "Running build_runner..."
    $DART_CMD run build_runner build --delete-conflicting-outputs || { log_error "Codegen failed"; exit 1; }
  fi
else
  log_info "Skipping code generation (not configured or skipped)."
fi

# Step 4: Formatting
# ------------------------------------------------------------------------------
print_header "Step 4: Formatting"

if [ "$CI_MODE" = true ]; then
  # In CI, distinct check mode
  log_info "Checking formatting on all files..."
  $DART_CMD format --line-length=80 --output=none --set-exit-if-changed . || { 
    log_error "Formatting issues found. Run 'make format' or 'dart format --line-length=80 .' locally."; 
    exit 1; 
  }
else
  # Locally, apply fixes
  log_info "Applying formatting..."
  $DART_CMD format --line-length=80 . 
fi
log_success "Formatting check passed."

# Step 5: Static Analysis
# ------------------------------------------------------------------------------
print_header "Step 5: Static Analysis"

log_info "Running analyzer..."
$DART_CMD analyze --fatal-infos || { log_error "Analysis failed."; exit 1; }
log_success "Analysis passed."

# Step 5.1: Atomic guardrails (report-only)
# ------------------------------------------------------------------------------
print_header "Step 5.1: Atomic Guardrails (Report Only)"
if [ -x "./scripts/atomic_guardrails.sh" ]; then
  if [ "$CI_MODE" = true ]; then
    log_info "CI Mode: enforcing atomic guardrails in strict mode..."
    ./scripts/atomic_guardrails.sh --strict || {
      log_error "Atomic guardrails failed in strict mode."
      exit 1
    }
  else
    if ! ./scripts/atomic_guardrails.sh; then
      log_warn "Atomic guardrails reported issues."
    fi
  fi
else
  log_warn "atomic_guardrails.sh not found or not executable; skipping."
fi

# Step 6: Testing
# ------------------------------------------------------------------------------
if [ "$SKIP_TEST" = false ]; then
  print_header "Step 6: Tests"
  
  if [ -d "test" ]; then
    log_info "Running tests..."
    # If coverage is needed in future, add --coverage here conditional on CI
    $FLUTTER_CMD test || { log_error "Tests failed."; exit 1; }
    log_success "All tests passed."
  else
    log_warn "No 'test' directory found. Skipping."
  fi
else
  log_info "Skipping tests."
fi


print_header "✅ Pre-PR Check Completed Successfully"
exit 0
