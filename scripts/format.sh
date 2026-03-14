#!/usr/bin/env bash
set -euo pipefail

fvm dart format --line-length=80 . "$@"
