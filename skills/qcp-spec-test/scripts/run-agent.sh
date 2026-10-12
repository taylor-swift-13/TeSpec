#!/usr/bin/env bash
set -euo pipefail
if [[ $# -lt 1 ]]; then
  echo 'usage: run-agent.sh AUTO-REPORT.json [CONTROLLER-OPTIONS...]' >&2
  exit 2
fi
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec python3 "$script_dir/proof-controller.py" "$@"
