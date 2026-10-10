#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "$script_dir/.." && pwd)"
qcp_source=${QCP_SOURCE_DIR:-"$project_root/../sac_c_parser"}
build_dir=${QCP_BUILD_DIR:-"$qcp_source/build-spectest-tool"}
install_path=${QCP_SPECTEST_BINARY:-"$project_root/bin/tespec-symexec"}
if [[ ! -f "$qcp_source/CMakeLists.txt" || ! -f "$qcp_source/smt_solver/CMakeLists.txt" ]]; then
  echo "A sac checkout with its current SMT submodule is required: $qcp_source" >&2
  exit 2
fi

# Build the supplied checkout. Do not patch or switch its SMT submodule.
cmake -S "$qcp_source" -B "$build_dir"
cmake --build "$build_dir" --target symexec -j"${QCP_BUILD_JOBS:-2}"
install -D -m 0755 "$build_dir/symexec" "$install_path"

echo "Installed $install_path"
