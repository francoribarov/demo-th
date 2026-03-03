#!/usr/bin/env bash
set -euo pipefail

if command -v fvm >/dev/null 2>&1 && [ -f ".fvmrc" ]; then
  # Extract version from JSON (simple regex)
  EXPECTED_VERSION=$(grep -o '"flutter": *"[^"]*"' .fvmrc | cut -d'"' -f4)
  if fvm list 2>/dev/null | grep -q "$EXPECTED_VERSION"; then
    DART="fvm dart"
  else
    echo "⚠️  Warning: FVM installed but version $EXPECTED_VERSION not found. Using system Dart."
    DART="dart"
  fi
else
  DART="dart"
fi

$DART format --line-length=80 . "$@"
