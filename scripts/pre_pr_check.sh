#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR/format.sh"
"$SCRIPT_DIR/analyze.sh"
"$SCRIPT_DIR/test.sh"
