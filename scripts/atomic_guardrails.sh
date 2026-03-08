#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

strict=false
json=false

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --strict) strict=true ;;
    --json) json=true ;;
    --help)
      cat <<'USAGE'
Usage: ./scripts/atomic_guardrails.sh [--strict] [--json]

Checks (presentation layer):
- direct ScaffoldMessenger.of(...).showSnackBar(...)
- ad-hoc destructive inline text style snippets
- manual CTA spinner snippets (SizedBox(18) + CircularProgressIndicator)
- widgets importing core/routing/app_router.dart
- templates/organisms importing presentation/blocs/*
- templates/organisms calling context.read/watch<...Bloc>()
- templates/organisms calling context.go/push/popOrGo()
- page steps importing presentation/blocs/*
- page steps calling context.read/watch<...Bloc>()

Default mode is report-only and always exits 0.
USAGE
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
  shift
done

check_scaffold='ScaffoldMessenger\.of\(.*\)\s*\.?\s*showSnackBar\('
check_inline='AppTypography\.bodySmall\.copyWith\([[:space:][:print:]]*AppColors\.destructive[[:space:][:print:]]*FontWeight\.w600'
check_spinner='SizedBox\([^\)]*18[^\)]*\)[[:space:][:print:]]*CircularProgressIndicator\('
check_router_import='core/routing/app_router\.dart'
check_template_organism_bloc_import="^import 'package:mobile_table_hopping/presentation/blocs/"
check_template_organism_bloc_context='context\.(read|watch)<[^>]*Bloc>\('
check_template_organism_navigation='context\.(go|push|popOrGo)\('

scaffold_hits="$(rg -n -P "$check_scaffold" lib/presentation || true)"
inline_hits="$(rg -n -P "$check_inline" lib/presentation || true)"
spinner_hits="$(rg -n -P "$check_spinner" lib/presentation || true)"
router_import_hits="$(
  rg -n -P "$check_router_import" lib/presentation/widgets lib/core/widgets 2>/dev/null || true
)"
template_organism_bloc_import_hits="$(
  rg -n -P "$check_template_organism_bloc_import" \
    lib/presentation/widgets/templates lib/presentation/widgets/organisms 2>/dev/null || true
)"
template_organism_bloc_context_hits="$(
  rg -n -P "$check_template_organism_bloc_context" \
    lib/presentation/widgets/templates lib/presentation/widgets/organisms 2>/dev/null || true
)"
template_organism_navigation_hits="$(
  rg -n -P "$check_template_organism_navigation" \
    lib/presentation/widgets/templates lib/presentation/widgets/organisms 2>/dev/null || true
)"
step_bloc_import_hits="$(
  rg -n -P "$check_template_organism_bloc_import" lib/presentation/pages 2>/dev/null | \
    rg '/steps/' || true
)"
step_bloc_context_hits="$(
  rg -n -P "$check_template_organism_bloc_context" lib/presentation/pages 2>/dev/null | \
    rg '/steps/' || true
)"

count_lines() {
  local value="$1"
  if [[ -z "$value" ]]; then
    echo 0
  else
    printf '%s\n' "$value" | wc -l | tr -d ' '
  fi
}

scaffold_count="$(count_lines "$scaffold_hits")"
inline_count="$(count_lines "$inline_hits")"
spinner_count="$(count_lines "$spinner_hits")"
router_import_count="$(count_lines "$router_import_hits")"
template_organism_bloc_import_count="$(count_lines "$template_organism_bloc_import_hits")"
template_organism_bloc_context_count="$(count_lines "$template_organism_bloc_context_hits")"
template_organism_navigation_count="$(count_lines "$template_organism_navigation_hits")"
step_bloc_import_count="$(count_lines "$step_bloc_import_hits")"
step_bloc_context_count="$(count_lines "$step_bloc_context_hits")"

total=$((
  scaffold_count +
    inline_count +
    spinner_count +
    router_import_count +
    template_organism_bloc_import_count +
    template_organism_bloc_context_count +
    template_organism_navigation_count +
    step_bloc_import_count +
    step_bloc_context_count
))

print_block() {
  local title="$1"
  local payload="$2"
  if [[ -n "$payload" ]]; then
    echo "$title"
    printf '%s\n' "$payload"
    echo
  fi
}

if [[ "$json" == true ]]; then
  cat <<JSON
{
  "strict": $strict,
  "violations": {
    "direct_scaffold_messenger": $scaffold_count,
    "inline_destructive_text": $inline_count,
    "manual_button_spinner": $spinner_count,
    "widgets_import_app_router": $router_import_count,
    "template_organism_import_bloc": $template_organism_bloc_import_count,
    "template_organism_read_watch_bloc": $template_organism_bloc_context_count,
    "template_organism_direct_navigation": $template_organism_navigation_count,
    "steps_import_bloc": $step_bloc_import_count,
    "steps_read_watch_bloc": $step_bloc_context_count
  },
  "total": $total
}
JSON
else
  echo "[atomic-guardrails] Scan summary"
  echo "- direct ScaffoldMessenger: $scaffold_count"
  echo "- ad-hoc destructive inline text: $inline_count"
  echo "- manual CTA spinner snippets: $spinner_count"
  echo "- widgets importing app_router: $router_import_count"
  echo "- templates/organisms importing presentation/blocs: $template_organism_bloc_import_count"
  echo "- templates/organisms read/watch bloc: $template_organism_bloc_context_count"
  echo "- templates/organisms direct navigation calls: $template_organism_navigation_count"
  echo "- page steps importing presentation/blocs: $step_bloc_import_count"
  echo "- page steps read/watch bloc: $step_bloc_context_count"
  echo "- total findings: $total"
  echo

  print_block "[direct ScaffoldMessenger]" "$scaffold_hits"
  print_block "[inline destructive text]" "$inline_hits"
  print_block "[manual CTA spinner]" "$spinner_hits"
  print_block "[widgets importing app_router]" "$router_import_hits"
  print_block "[templates/organisms importing presentation/blocs]" "$template_organism_bloc_import_hits"
  print_block "[templates/organisms read/watch bloc]" "$template_organism_bloc_context_hits"
  print_block "[templates/organisms direct navigation calls]" "$template_organism_navigation_hits"
  print_block "[page steps importing presentation/blocs]" "$step_bloc_import_hits"
  print_block "[page steps read/watch bloc]" "$step_bloc_context_hits"

  if [[ "$total" -eq 0 ]]; then
    echo "[atomic-guardrails] No findings."
  fi
fi

if [[ "$strict" == true && "$total" -gt 0 ]]; then
  exit 1
fi

exit 0
