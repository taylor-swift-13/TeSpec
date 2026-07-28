#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 3 ]]; then
  echo "usage: run-agent.sh SOURCE FUNCTION [BINDS.json]" >&2
  exit 2
fi

codex_bin="${CODEX_BIN:-codex}"
source_path="$(readlink -f "$1")"
function_name="$2"
binds_path=""
if [[ $# -eq 3 ]]; then
  binds_path="$(readlink -f "$3")"
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
spec_test_root="$(cd "$script_dir/../../.." && pwd)"
mkdir -p "$spec_test_root/.spectest"
run_dir="$(mktemp -d "$spec_test_root/.spectest/agent.XXXXXX")"
stdout_jsonl="$run_dir/agent.stdout.jsonl"
stderr_log="$run_dir/agent.stderr.txt"
last_message="$run_dir/agent.last.txt"

prompt='Use $qcp-spec-test to run a concrete QCP spec test.'
prompt+=$'\n'"Source: $source_path"
prompt+=$'\n'"Target function: $function_name"
if [[ -n "$binds_path" ]]; then
  prompt+=$'\n'"Use these human-written binds exactly: $binds_path"
else
  prompt+=$'\n'"Analyze the spec and create a small, purposeful binds file before running."
fi
prompt+=$'\n'"Keep artifacts under: $run_dir"
prompt+=$'\n'"Treat every UNKNOWN / residual_vc_requires_proof as manual work: edit only proof_manual, prove every listed goal, and validate with check-proof."

reasoning_args=(-c model_reasoning_effort=medium)
if "$codex_bin" exec --help 2>&1 | grep -q -- "--reasoning-effort"; then
  reasoning_args=(--reasoning-effort medium)
fi

"$codex_bin" exec \
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

echo "$run_dir"
echo "$last_message"
