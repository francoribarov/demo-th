#!/usr/bin/env bash
set -euo pipefail

if command -v fvm >/dev/null 2>&1 && [ -f ".fvm/fvm_config.json" ]; then
  DART="fvm dart"
else
  DART="dart"
fi

$DART format --line-length=120 .
