#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "$script_dir/.." && pwd)"
runtime_root="$project_root/runtime/qcip"
binary="$project_root/bin/qcp-symexec"

required_paths=(
  "$binary"
  "$runtime_root/LICENSE"
  "$runtime_root/SeparationLogic/_CoqProject"
  "$runtime_root/QCP_examples/QCP_demos_LLM/verification_stdlib.h"
  "$runtime_root/QCP_examples/QCP_demos_LLM/verification_list.h"
  "$runtime_root/QCP_examples/QCP_demos_LLM/int_array_def.h"
)

for path in "${required_paths[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "Missing bundled runtime resource: $path" >&2
    exit 1
  fi
done

if [[ ! -x "$binary" ]]; then
  echo "Bundled QCP executor is not executable: $binary" >&2
  exit 1
fi

coq_modules=$(find \
  "$runtime_root/SeparationLogic" \
  -type f -name '*.vo' -print | wc -l)
if [[ "$coq_modules" -eq 0 ]]; then
  echo "Bundled runtime contains no compiled Coq modules" >&2
  exit 1
fi

echo "QCP executor: $binary"
echo "QCIP runtime: $runtime_root"
echo "Compiled Coq modules: $coq_modules"

if command -v opam >/dev/null 2>&1; then
  coq_version=$(opam exec --switch=qcp-8.20 -- coqc -v 2>/dev/null | head -n 1 || true)
elif command -v coqc >/dev/null 2>&1; then
  coq_version=$(coqc -v 2>/dev/null | head -n 1 || true)
else
  coq_version=
fi

if [[ "$coq_version" == *"version 8.20"* ]]; then
  echo "Coq proof checker: $coq_version"
else
  echo "Coq proof checker: unavailable or not version 8.20 (execution still works; residual proof checking does not)"
fi
