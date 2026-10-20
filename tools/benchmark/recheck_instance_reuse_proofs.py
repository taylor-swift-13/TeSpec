#!/usr/bin/env python3
"""Meter a repaired prior proof against each new original client-7 VC."""
import argparse
import json
import re
import shlex
import shutil
from pathlib import Path

from meter_read_itp_coq import COQ, ROOT, RUNTIME, measure, save, sha
from positive_execution_itp import statements, symbols

OUT = ROOT / "benchmark/results/instance-reuse-20261020/proof-recheck/repaired"
TASKS = Path("/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/instance-reuse-itp-20261020")
OLD = ROOT / "benchmark/results/array_load/20261020-boundary-itp/index.json"
BATCH = ROOT / "benchmark/results/spatial-smt-regressions/20261020-instance-reuse-modular-on"


def main(selected_mode=None, number=1):
    old = json.loads(OLD.read_text())["executions"]
    records = []
    for mode in ((selected_mode,) if selected_mode else ("off", "on")):
        previous = next(x for x in old if x["binding"]["modular_instantiation"] == "on"
                        and x["binding"]["mode"] == mode
                        and x["binding"]["case"] == "original_client_translation7_only_entry")
        prior = ROOT / previous["receipt"]["path"]
        assert sha(prior) == previous["receipt"]["sha256"]
        prior_data = json.loads(prior.read_text())
        original_candidate = prior.parent / "Candidate.v"
        assert sha(original_candidate) == prior_data["model"]["candidate_sha256"]
        task = TASKS / mode
        attempt = task / ("attempt-%d" % number)
        model = json.loads((attempt / "model-receipt.json").read_text())
        candidate = attempt / "Candidate.v"
        assert model["exit_code"] == 0 and model["requested_model"] == "gpt-6.1-sol"
        assert model["token_usage"] and sha(candidate) == model["candidate_sha256"]
        assert sha(task / "ExecutionGoal.v") == model["locked_goal_and_helper_sha256"]["ExecutionGoal.v"]
        text = candidate.read_text()
        targets = previous["binding"]["checked_theorems"]
        assert statements(text) == [tuple(t) for t in targets]
        assert not re.search(r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b", text)
        row = next(json.loads(p.read_text()) for p in BATCH.glob("array_load/case-*/" + mode + "/receipt.json")
                   if json.loads(p.read_text())["case"] == previous["binding"]["case"])
        assert row["source"] == previous["binding"]["source"]
        assert row["binds"] == previous["binding"]["binds"]
        names = [n.removeprefix("proof_of_") for n in row["current"]["residual_vcs"]]
        assert names == previous["binding"]["all_original_residual_vcs"]
        goal = next(x for x in row["vc_artifacts"] if x["kind"] == "goal")
        assert sha(ROOT / goal["path"]) == goal["sha256"]
        assert goal["sha256"] == sha(task / "ExecutionGoal.v")
        folder = (OUT if number == 1 else OUT.parent / ("repaired-%d" % number)) / mode
        src = folder / "proofs"
        src.mkdir(parents=True, exist_ok=False)
        for path in attempt.iterdir():
            if path.is_file():
                shutil.copyfile(path, folder / path.name)
        shutil.copyfile(candidate, src / "Candidate.v")
        shutil.copyfile(ROOT / goal["path"], src / "ExecutionGoal.v")
        (src / "StatementAudit.v").write_text("Require Import ExecutionGoal.\n" + "".join(
            "Print Assumptions ExecutionGoal.%s.\n" % n
            for n in ["main_precondition_wit_1", *names]))
        args = shlex.split((RUNTIME / "_CoqProject").read_text())
        flags = [str(RUNTIME / v) if i % 3 == 1 else v for i, v in enumerate(args)] + ["-Q", str(src), ""]
        receipt = {"schema": "tespec-existing-proof-recheck/v1", "source": row["source"],
                   "binds": row["binds"], "report": row["report"], "original_goal": goal,
                   "previous_receipt": previous["receipt"], "candidate_sha256": sha(candidate),
                   "original_targets": names, "model": model,
                   "tokens": sum(u.get("input_tokens", 0) + u.get("output_tokens", 0) for u in model["token_usage"]),
                   "model_calls": 1,
                   "scope": "Prior proof repaired by actual gpt-6.1-sol; newly generated complete Goal and fresh independent kernel check.",
                   "status": "IN_PROGRESS", "compilation": []}
        for name in ("ExecutionGoal", "Candidate", "StatementAudit"):
            m = measure([COQ / "coqc", *flags, src / (name + ".v")], folder / "compilation" / name, src)
            receipt["compilation"].append(m)
            save(folder / "receipt.json", receipt)
            if m["exit_code"]:
                receipt["status"] = "COMPILE_FAILED"
                save(folder / "receipt.json", receipt)
                raise RuntimeError("Compilation failed: " + m["stderr"])
        proof_audit = (ROOT / receipt["compilation"][1]["stdout"]).read_text()
        original_audit = (ROOT / receipt["compilation"][2]["stdout"]).read_text()
        assert symbols(proof_audit) <= symbols(original_audit) <= {
            "eval_addr_expr", "sizeof_union_type", "sizeof_struct_type", "sizeof_enum_type", "sizeof_alias_type"}
        assert proof_audit.count("Closed under the global context") + proof_audit.count("Axioms:") == len(targets)
        receipt["assumption_audit"] = {"original": sorted(symbols(original_audit)),
                                       "proof": sorted(symbols(proof_audit))}
        receipt["kernel_check"] = measure([COQ / "coqchk", "-silent", *flags, "Candidate"], folder / "kernel-check", src)
        receipt["status"] = "KERNEL_CHECKED" if receipt["kernel_check"]["exit_code"] == 0 else "KERNEL_FAILED"
        save(folder / "receipt.json", receipt)
        assert receipt["status"] == "KERNEL_CHECKED", receipt
        for path in src.iterdir():
            if path.suffix in (".vo", ".vos", ".vok", ".glob", ".aux") or path.name in (".lia.cache", ".nia.cache"):
                path.unlink()
        records.append({"mode": mode, "receipt": str((folder / "receipt.json").relative_to(ROOT)),
                        "receipt_sha256": sha(folder / "receipt.json"), "final_status": "PASS"})
        save(OUT / "index.json", {"executions": records, "model_calls": len(records),
                                "scope": "Per-execution original residuals proved; costs in each receipt. The failed unchanged-proof attempt is retained separately."})
        print(mode, receipt["status"], flush=True)
    return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mode", choices=("off", "on"))
    parser.add_argument("--attempt", type=int, default=1)
    args = parser.parse_args()
    raise SystemExit(main(args.mode, args.attempt))
