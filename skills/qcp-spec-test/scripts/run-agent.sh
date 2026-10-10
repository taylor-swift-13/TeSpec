#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: run-agent.sh AUTO-REPORT.json" >&2
  exit 2
fi

report_path="$(readlink -f "$1")"
if [[ ! -f "$report_path" ]]; then
  echo "automatic test report does not exist: $report_path" >&2
  exit 2
fi

itp_count="$(python3 - "$report_path" <<'PY'
import json
import sys
from pathlib import Path

report_path = Path(sys.argv[1])
report = json.loads(report_path.read_text(encoding="utf-8"))
itp_vcs = report.get("itp_vcs")
if not isinstance(itp_vcs, list):
    raise SystemExit("automatic report has no ITP VC inventory")
for index, item in enumerate(itp_vcs):
    if not isinstance(item, dict) or not isinstance(item.get("manifest"), str):
        raise SystemExit(f"invalid ITP VC entry at index {index}")
    if not isinstance(item.get("goals"), list) or not item["goals"]:
        raise SystemExit(f"ITP VC entry {index} has no residual goals")
    manifest_path = Path(item["manifest"])
    if not manifest_path.is_file():
        raise SystemExit(f"ITP VC manifest is missing: {manifest_path}")
print(len(itp_vcs))
PY
)"

if [[ "$itp_count" == "0" ]]; then
  echo "No ITP VCs in $report_path; Agent flow skipped."
  exit 0
fi

codex_bin="${CODEX_BIN:-codex}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
spec_test_root="$(cd "$script_dir/../../.." && pwd)"
mkdir -p "$spec_test_root/.spectest"
run_dir="$(mktemp -d "$spec_test_root/.spectest/agent.XXXXXX")"
stdout_jsonl="$run_dir/agent.stdout.jsonl"
stderr_log="$run_dir/agent.stderr.txt"
last_message="$run_dir/agent.last.txt"
agent_report="$run_dir/agent-report.json"
rss_file="$run_dir/.agent-rss-kb"

prompt='Use $qcp-spec-test to validate every ITP VC in the automatic test report.'
prompt+=$'\n'"Automatic report: $report_path"
prompt+=$'\n'"ITP VC count: $itp_count"
prompt+=$'\n'"Keep artifacts under: $run_dir"
prompt+=$'\n'"The automatic test stage is complete. Do not rerun or alter it. You are the only Agent in this proof stage. Process every entry in report.itp_vcs, edit each listed proof_manual file, and invoke qcp-spectest check-proof for every corresponding manifest. Repair failed proofs and check them again. Update final case status only from the complete set of checker reports."

reasoning_args=(-c model_reasoning_effort=medium)
if "$codex_bin" exec --help 2>&1 | grep -q -- "--reasoning-effort"; then
  reasoning_args=(--reasoning-effort medium)
fi

started_ns="$(date +%s%N)"
set +e
/usr/bin/time -f '%M' -o "$rss_file" -- "$codex_bin" exec \
  --json \
  --skip-git-repo-check \
  --sandbox workspace-write \
  --ephemeral \
  -C "$spec_test_root" \
  -o "$last_message" \
  --model gpt-5.4-mini \
  "${reasoning_args[@]}" \
  - \
  <<<"$prompt" \
  >"$stdout_jsonl" \
  2>"$stderr_log"
agent_exit=$?
set -e
finished_ns="$(date +%s%N)"
python3 - "$report_path" "$stdout_jsonl" "$agent_report" "$rss_file" "$started_ns" "$finished_ns" "$agent_exit" <<'PY'
import json
import sys
from pathlib import Path

automatic_report, events_path, output_path, rss_path, start, finish, exit_code = sys.argv[1:]
automatic = json.loads(Path(automatic_report).read_text(encoding="utf-8"))
usage = None
for line in Path(events_path).read_text(encoding="utf-8", errors="replace").splitlines():
    try:
        event = json.loads(line)
    except json.JSONDecodeError:
        continue
    candidates = [event]
    while candidates:
        value = candidates.pop()
        if isinstance(value, dict):
            found = value.get("usage")
            if isinstance(found, dict) and any("token" in key for key in found):
                usage = found
            candidates.extend(value.values())
        elif isinstance(value, list):
            candidates.extend(value)

try:
    peak_rss_kb = int(Path(rss_path).read_text(encoding="utf-8").strip())
except (OSError, ValueError):
    peak_rss_kb = None
proof_reports = []
for item in automatic.get("itp_vcs", []):
    proof_path = Path(item["manifest"]).parent / "proof_report.json"
    if proof_path.is_file():
        proof_reports.append(json.loads(proof_path.read_text(encoding="utf-8")))
all_checked = len(proof_reports) == len(automatic.get("itp_vcs", []))
all_passed = all(item.get("status") == "PASS" for item in proof_reports)
report = {
    "schema": "qcp-spectest-agent-report/v1",
    "status": "PASS" if int(exit_code) == 0 and all_checked and all_passed else "UNKNOWN",
    "duration_seconds": round((int(finish) - int(start)) / 1_000_000_000, 3),
    "peak_rss_kb": peak_rss_kb,
    "token_usage": usage,
    "itp_vc_count": len(automatic.get("itp_vcs", [])),
    "proof_reports": proof_reports,
    "agent_exit_code": int(exit_code),
    "events": events_path,
}
Path(output_path).write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
PY
rm -f "$rss_file"

echo "$run_dir"
echo "$agent_report"
echo "$last_message"
