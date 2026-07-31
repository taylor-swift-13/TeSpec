#!/usr/bin/env bash
set -euo pipefail

tespec_root=${TESPEC_ROOT:-/opt/tespec}
selftest_root=$(mktemp -d /tmp/tespec-offline-selftest.XXXXXX)

"$tespec_root/scripts/check-runtime.sh" >"$selftest_root/runtime.txt"
coqc -v >"$selftest_root/coq-version.txt"
grep -q 'version 8.20' "$selftest_root/coq-version.txt"

test -s "$tespec_root/skills/qcp-spec-test/SKILL.md"
test -s "$tespec_root/skills/tespec-e2e/SKILL.md"
test -s "$tespec_root/skills/tespec-artifacts/SKILL.md"
python3 "$tespec_root/skills/tespec-e2e/scripts/run_mutation_matrix.py" \
  --help >"$selftest_root/mutation-matrix-help.txt"

qcp-spectest analyze \
  "$tespec_root/cases/callee_heap/callee_heap.c" \
  --function callee_heap \
  --write-binds "$selftest_root/generated-binds.json" \
  --compact >"$selftest_root/analyze.json"

qcp-spectest run \
  "$tespec_root/cases/callee_heap/callee_heap.c" \
  --function callee_heap \
  --binds "$tespec_root/cases/callee_heap/job.json" \
  -I QCP_examples/QCP_demos_LLM \
  --output-dir "$selftest_root/callee_heap" \
  --compact >"$selftest_root/callee_heap.stdout.json"

for case_name in closed_struct_array composite_loop_dll residual_vc; do
  qcp-spectest check \
    "$tespec_root/cases/$case_name/job.json" \
    --output-dir "$selftest_root/$case_name" \
    --compact >"$selftest_root/$case_name.stdout.json"
done

qcp-spectest check-proof \
  "$selftest_root/residual_vc/quantified_tautology/vc/manifest.json" \
  --compact >"$selftest_root/proof-report.stdout.json"

python3 - "$selftest_root" <<'PY'
import json
from pathlib import Path
import sys

root = Path(sys.argv[1])
expected = {
    "callee_heap": 2,
    "closed_struct_array": 2,
    "composite_loop_dll": 2,
    "residual_vc": 1,
}
for name, total in expected.items():
    report = json.loads((root / name / "report.json").read_text())
    summary = report["summary"]
    assert summary["total"] == total, (name, summary)
    assert summary["PASS"] == total, (name, summary)
    assert summary["FAIL"] == summary["UNKNOWN"] == summary["ERROR"] == 0
proof = json.loads(
    (root / "residual_vc/quantified_tautology/vc/proof_report.json").read_text()
)
assert proof["status"] == "PASS", proof
binds = json.loads((root / "generated-binds.json").read_text())
assert len(binds) == 1
assert set(binds[0]) >= {"id", "args", "values"}
PY

printf '%s\n' \
  "TeSpec offline self-test passed." \
  "Network is not required by any tested TeSpec/QCP/Coq operation." \
  "Artifacts: $selftest_root"
