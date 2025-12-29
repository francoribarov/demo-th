#!/usr/bin/env bash
set -euo pipefail

if command -v fvm >/dev/null 2>&1 && [ -f ".fvm/fvm_config.json" ]; then
  FLUTTER="fvm flutter"
else
  FLUTTER="flutter"
fi

target="apk"
if [ "$#" -gt 0 ]; then
  target="$1"
  shift
fi

$FLUTTER build "$target" "$@"
