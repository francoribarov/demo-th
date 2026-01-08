#!/usr/bin/env bash
set -euo pipefail

if command -v fvm >/dev/null 2>&1 && [ -f ".fvmrc" ]; then
  # Extract version from JSON (simple regex)
  EXPECTED_VERSION=$(grep -o '"flutter": *"[^"]*"' .fvmrc | cut -d'"' -f4)
  if fvm list 2>/dev/null | grep -q "$EXPECTED_VERSION"; then
    FLUTTER="fvm flutter"
  else
    echo "⚠️  Warning: FVM installed but version $EXPECTED_VERSION not found. Using system Flutter."
    FLUTTER="flutter"
  fi
else
  FLUTTER="flutter"
fi

$FLUTTER test "$@"
