#!/usr/bin/env python3
"""Bridge one frozen WSL proof task to a metered, text-only Windows model client."""
import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

from organize_tespec_routes import ROOT, fingerprint, read
from spectest.proof_controller import read_refutation_plan


def windows(path):
    return subprocess.check_output(["wslpath", "-w", str(path.resolve())], text=True).strip()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--windows-python", type=Path, required=True)
    parser.add_argument("--task-root", type=Path, required=True)
    parser.add_argument("--execution", type=Path, required=True)
    args = parser.parse_args()
    prompt = sys.stdin.read()
    paths = json.loads(prompt.split("\nCandidates: ", 1)[1].split("\n", 1)[0])
    candidate = Path(paths[0]).resolve()
    if len(paths) != 1 or candidate.name != "Candidate.v" or not candidate.is_relative_to(args.execution.resolve()):
        raise ValueError("Invalid candidate location")
    bundle = read(candidate.with_name("manifest.json"))
    task_root = args.task_root.resolve()
    task_root.mkdir(parents=True, exist_ok=True)
    task = Path(tempfile.mkdtemp(prefix="itp-", dir=task_root))
    immutable = []
    for path in sorted(candidate.parent.rglob("*.v")):
        if path != candidate:
            immutable.append((str(path.relative_to(candidate.parent)), path.read_text()))
    shutil.copyfile(candidate, task / "Candidate.v")
    shutil.copyfile(candidate.with_name("Goal.v"), task / "Goal.v")
    request = {"case_id": bundle["case_id"], "targets": bundle["goals"],
               "refuted_goal": bundle["refuted_goal"], "immutable_sources": immutable,
               "candidate": candidate.read_text()}
    history = []
    for run in sorted(args.execution.glob("*-itp")):
        for src in sorted(run.glob("itp/*proof/case_*/Candidate.v")):
            if src.parent == candidate.parent or not src.with_name("Goal.v").exists():
                continue
            if fingerprint(src.with_name("Goal.v")) != fingerprint(candidate.with_name("Goal.v")):
                continue
            diagnosis = src.with_name("compile_Candidate.v.log")
            if diagnosis.is_file() and "Error:" in diagnosis.read_text(errors="replace"):
                history.append({"candidate": src.read_text(), "coq": diagnosis.read_text(errors="replace")[-2500:]})
    request["previous_compile_errors"] = history
    request["example_refute_plan"] = {"refute_vcs": {bundle["case_id"]: bundle["goals"][0]["proof"]}} if bundle["goals"] else {}

    instruction = ("Fill this original Coq Candidate. Return one JSON object with candidate (complete Coq source) "
                   "and optional plan. Preserve the statement, direction, module interface and all original targets. "
                   "No admits, fresh axioms or proof escapes. No tools or delegation. For SimpleC notations import VCPrelude explicitly before importing naive_C_Rules. If the original goal is false, "
                   "use the exact case key and target from the request to propose a named refutation, "
                   "or request entry refutation via refute_preconditions using the actual case id. "
                   "Leave an unproved target unresolved.\n")
    (task / "prompt.txt").write_text(instruction + json.dumps(request, ensure_ascii=False))
    script = ROOT / "tools/benchmark/meter_itp_model_windows.py"
    subprocess.run([str(args.windows_python), windows(script), "--task-dir", windows(task), "--text-only"],
                   stdout=subprocess.DEVNULL, check=True)
    receipt = task / "attempt-1/model-receipt.json"
    record = read(receipt)
    if record["candidate_sha256"] != fingerprint(task / "Candidate.v"):
        raise ValueError("Metered candidate changed")
    saved = args.execution / "model-receipts"
    saved.mkdir(exist_ok=True)
    shutil.copyfile(receipt, saved / (task.name + ".json"))
    for usage in record["token_usage"] or []:
        print(json.dumps({"type": "turn.completed", "usage": usage}), flush=True)
    if record["exit_code"] != 0:
        return 1
    shutil.copyfile(task / "Candidate.v", candidate)
    if (task / "attempt-1/proof-plan.json").exists() and "Optional routing plan: " in prompt:
        dest = Path(prompt.split("Optional routing plan: ",1)[1].split(" with JSON ",1)[0]).resolve()
        if dest.name != "proof-plan.json" or not dest.is_relative_to(args.execution.resolve()):
            raise ValueError("Invalid routing plan destination")
        proposal = task / "attempt-1/proof-plan.json"
        try:
            vcs, entries = read_refutation_plan(proposal, read(args.execution / "out/native/report.json"))
            if (vcs.keys() | entries) - {bundle["case_id"]}:
                raise ValueError("Refutation plan refers to another input")
        except (TypeError, ValueError, KeyError) as exc:
            print(f"Discarded invalid proof routing proposal: {exc}", file=sys.stderr)
        else:
            shutil.copyfile(proposal, dest)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
