#!/usr/bin/env python3
"""Complete residual ITP work after local proof-source replay, one execution at a time."""
import argparse
from pathlib import Path
import os
import shlex
import subprocess
import sys

from organize_tespec_routes import ROOT, RESULTS, fingerprint, read


def solve(row, scratch, task_root, windows_python, repair):
    folder = (scratch / row["native_report_sha256"]).resolve()
    native = folder / "out/native/report.json"
    previous = folder / "current-itp/routes.json"
    if not previous.is_file() or read(previous)["cases"][0]["itp_status"] in ("PASS", "FAIL", "CRASH"):
        return False
    out = folder / ("repair-itp" if repair else "generated-itp")
    if repair:
        first = folder / "generated-itp/routes.json"
        if not first.is_file() or read(first)["cases"][0]["itp_status"] not in ("UNKNOWN", "ERROR"):
            return False
    if (out / "routes.json").is_file():
        return False
    if out.exists():
        raise ValueError(f"Inspect the unfinished proof attempt at {out}")
    if fingerprint(native) != row["native_report_sha256"]:
        raise ValueError("Frozen native report changed")
    wrapper = folder / "metered-model"
    bridge = [sys.executable, "-B", str(ROOT / "tools/benchmark/meter_current_itp.py"),
              "--execution", str(folder), "--windows-python", str(windows_python), "--task-root", str(task_root)]
    wrapper.write_text("#!/bin/sh\nexec " + shlex.join(bridge) + "\n")
    wrapper.chmod(0o700)
    env = dict(os.environ, CODEX_BIN=str(wrapper))
    proc = subprocess.run([sys.executable, "-B", "-m", "spectest", "routes", "--native-report", str(native),
                           "--route", "itp", "--proof-cache", str(folder / "replay-source"),
                           "--output-dir", str(out)], cwd=ROOT, env=env, capture_output=True, text=True)
    if not (out / "routes.json").is_file():
        raise RuntimeError(proc.stderr[-1200:])
    d = read(out / "routes.json")
    if d["routes"]["itp"].get("model_calls") and not list(folder.glob("model-receipts/*.json")):
        raise RuntimeError(f"Missing Windows CLI receipt: {folder}")
    print(row["case"], row["strategy"], d["cases"][0]["itp_status"], flush=True)
    for p in folder.glob("model-receipts/*.json"):
        m = read(p)
        if m["exit_code"] not in (0, "INVALID_RESPONSE"):
            raise RuntimeError(f"Model CLI failed: {m['exit_code']} ({p})")
    return True


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--windows-python", type=Path, required=True)
    parser.add_argument("--task-root", type=Path, required=True)
    parser.add_argument("--group", action="append")
    parser.add_argument("--limit", type=int)
    parser.add_argument("--repair", action="store_true")
    args = parser.parse_args()
    groups = args.group or sorted(p.parent.parent.name for p in RESULTS.glob("*/tespec/current-executions.json"))
    done = 0
    for group in groups:
        for row in read(RESULTS / group / "tespec/current-executions.json")["executions"]:
            if row["auto_status"] != "NOT_RUN" and solve(row, args.scratch, args.task_root, args.windows_python, args.repair):
                done += 1
                if args.limit is not None and done >= args.limit:
                    return


if __name__ == "__main__":
    main()
