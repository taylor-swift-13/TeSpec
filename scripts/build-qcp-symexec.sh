#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "$script_dir/.." && pwd)"
qcp_source=${QCP_SOURCE_DIR:-"$project_root/../sac_c_parser"}
build_dir=${QCP_BUILD_DIR:-"$qcp_source/build-spectest-tool"}
install_path=${QCP_SPECTEST_BINARY:-"$project_root/bin/qcp-symexec"}
smt_source=${QCP_SMT_SOLVER_DIR:-}
patch_legacy_solver=0

if [[ ! -f "$qcp_source/CMakeLists.txt" ]]; then
  echo "QCP source does not exist: $qcp_source" >&2
  exit 2
fi

if [[ -z "$smt_source" ]]; then
  submodule="$qcp_source/smt_solver"
  if [[ -f "$submodule/CMakeLists.txt" ]]; then
    smt_source=$submodule
  else
    smt_source="$build_dir/smt-v2-proof"
    patch_legacy_solver=1
    if [[ ! -d "$smt_source/.git" && ! -f "$smt_source/.git" ]]; then
      git -C "$submodule" worktree add --detach \
        "$smt_source" origin/smt_v2_proof
    fi
  fi
fi

if [[ "$patch_legacy_solver" -eq 1 ]]; then
  python3 "$script_dir/patch-legacy-smt-capacity.py" "$smt_source"
fi

cmake -S "$qcp_source" -B "$build_dir" \
  -DSAC_SMT_SOLVER_DIR="$smt_source"
cmake --build "$build_dir" --target symexec -j"${QCP_BUILD_JOBS:-2}"
install -D -m 0755 "$build_dir/symexec" "$install_path"

echo "Installed $install_path"
