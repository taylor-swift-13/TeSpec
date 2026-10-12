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

python3 - "$qcp_source" "$install_path" <<'PYMETA'
import hashlib
import json
from pathlib import Path
import subprocess
import sys

source = Path(sys.argv[1]).resolve()
binary = Path(sys.argv[2]).resolve()
def git(root, *args):
    run = subprocess.run(["git", "-C", str(root), *args], capture_output=True, text=True)
    return run.stdout.strip() if run.returncode == 0 else None
metadata = {
    "schema": "tespec-executor-build/v1",
    "binary_sha256": hashlib.sha256(binary.read_bytes()).hexdigest(),
    "sac_revision": git(source, "rev-parse", "HEAD"),
    "sac_branch": git(source, "branch", "--show-current"),
    "sac_master_base": git(source, "merge-base", "HEAD", "origin/master"),
    "smt_revision": git(source / "smt_solver", "rev-parse", "HEAD"),
    "source_dirty": bool(git(source, "status", "--porcelain")),
    "smt_source_dirty": bool(git(source / "smt_solver", "status", "--porcelain")),
    "execution_semantics": "inline-preserve/v1",
    "result_semantics": "three-valued-conjunction/v1",
    "vc_semantics": "path-vc/v1",
    "architecture_bits": 32,
    "binary_ground_truth": False,
    "certificate": "NOT_CHECKED",
}
binary.with_name(binary.name + ".build.json").write_text(json.dumps(metadata, indent=2) + "\n")
PYMETA

echo "Installed $install_path"
