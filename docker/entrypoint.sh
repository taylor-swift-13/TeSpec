#!/usr/bin/env bash
set -euo pipefail

export TESPEC_ROOT=${TESPEC_ROOT:-/opt/tespec}
export PYTHONPATH="$TESPEC_ROOT${PYTHONPATH:+:$PYTHONPATH}"

if [[ $# -eq 0 ]]; then
  set -- --help
fi

case "$1" in
  self-test)
    shift
    exec "$TESPEC_ROOT/docker/offline-selftest.sh" "$@"
    ;;
  skill)
    if [[ $# -ne 2 ]]; then
      echo "usage: tespec skill qcp-spec-test|tespec-e2e|tespec-artifacts" >&2
      exit 2
    fi
    skill_file="$TESPEC_ROOT/skills/$2/SKILL.md"
    if [[ ! -f "$skill_file" ]]; then
      echo "unknown bundled skill: $2" >&2
      exit 2
    fi
    exec sed -n '1,10000p' "$skill_file"
    ;;
  shell)
    shift
    exec /bin/bash "$@"
    ;;
esac

exec python3 -m spectest "$@"
