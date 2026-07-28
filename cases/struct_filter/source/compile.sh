#!/usr/bin/env bash
set -euo pipefail
cc="${CC:-gcc}"
cd "$(dirname "$0")"
main_c="$(find . -maxdepth 1 -type f -name 'IP_*.c' ! -name '*_Demo.c' -printf '%f\n' | sort | head -n 1)"
if [ -z "$main_c" ]; then
  echo "no IP_*.c source found" >&2
  exit 1
fi
"$cc" -std=c11 -fsyntax-only -I. "$main_c"
