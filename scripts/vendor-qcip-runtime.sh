#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "$script_dir/.." && pwd)"
source_root=${QCIP_SOURCE_DIR:-"$project_root/../QCIP"}
target_root=${QCIP_RUNTIME_DIR:-"$project_root/runtime/qcip"}

required_directories=(
  SeparationLogic
  QCP_examples
)

if [[ ! -d "$source_root" ]]; then
  echo "QCIP source does not exist: $source_root" >&2
  exit 2
fi

if [[ "$source_root" -ef "$target_root" ]]; then
  echo "QCIP source and runtime target must be different directories" >&2
  exit 2
fi

for directory in "${required_directories[@]}"; do
  if [[ ! -d "$source_root/$directory" ]]; then
    echo "Required QCIP resource is missing: $source_root/$directory" >&2
    exit 2
  fi
done

mkdir -p "$target_root"
for directory in "${required_directories[@]}"; do
  mkdir -p "$target_root/$directory"
  cp -a "$source_root/$directory/." "$target_root/$directory/"
done

if [[ -f "$source_root/LICENSE" ]]; then
  cp -a "$source_root/LICENSE" "$target_root/LICENSE"
fi

echo "Vendored QCIP runtime resources into $target_root"
