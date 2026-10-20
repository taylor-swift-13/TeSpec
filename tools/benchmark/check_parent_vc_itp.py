#!/usr/bin/env python3
"""Audit a metered full-parent VC proof or explicitly diagnostic candidate."""
import argparse
import json
import re
import shlex
import shutil
from pathlib import Path
from meter_read_itp_coq import ROOT, RUNTIME, COQ, measure, save, sha
from positive_execution_itp import symbols


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--task", type=Path, required=True)
    parser.add_argument("--attempt", type=int, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    task, out = args.task.resolve(), args.output.resolve()
    assert out.is_relative_to(ROOT / "benchmark/results") and not out.exists()
    attempt = task / ("attempt-%d" % args.attempt)
    model = json.loads((attempt / "model-receipt.json").read_text())
    binding = json.loads((task / "binding.json").read_text())
    assert model["requested_model"] == "gpt-6.1-sol" and model["exit_code"] == 0 and model["token_usage"]
    assert sha(attempt / "prompt.txt") == model["prompt_sha256"]
    assert sha(attempt / "Candidate.v") == model["candidate_sha256"]
    for ref in [binding["source"], binding["binds"], binding["report"], *binding["vc_artifacts"]]:
        assert sha(ROOT / ref["path"]) == ref["sha256"]
    goal = next(x for x in binding["vc_artifacts"] if x["kind"] == "goal")
    assert sha(task / "ExecutionGoal.v") == goal["sha256"]
    text = (attempt / "Candidate.v").read_text()
    targets = [(m[1], re.sub(r"\s+", " ", m[2]).strip()) for m in
               re.finditer(r"(?:Theorem|Lemma)\s+(\w+)\s*:\s*(.*?)\.\s*Proof\.", text, re.S)]
    assert targets and not re.search(r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b", text)
    assert "Require Import ExecutionGoal." in text
    # Diagnostics may use definitions, but cannot redefine the frozen original module.
    assert not re.search(r"\b(?:Module|Declare|Load|Extract|Redirect)\b", text)
    for name, digest in model["locked_goal_and_helper_sha256"].items():
        assert sha(task / name) == digest
    src = out / "proofs"
    src.mkdir(parents=True)
    for name in ["model-receipt.json", "usage-events.json", "agent.stdout.jsonl", "agent.stderr.log", "prompt.txt", "Candidate.v"]:
        shutil.copyfile(attempt / name, out / name)
    for name in ["binding.json", "diagnosis.txt"]:
        if (task / name).exists():
            shutil.copyfile(task / name, out / name)
    shutil.copyfile(task / "ExecutionGoal.v", src / "ExecutionGoal.v")
    shutil.copyfile(attempt / "Candidate.v", src / "Candidate.v")
    (src / "StatementAudit.v").write_text("Require Import ExecutionGoal.\n" + "".join(
        "Print Assumptions ExecutionGoal.%s.\n" % n.removeprefix("proof_of_")
        for n in binding["current"]["residual_vcs"]))
    (src / "ProofAudit.v").write_text("Require Import Candidate.\n" + "".join(
        "Print Assumptions Candidate.%s.\n" % n for n, _ in targets))
    parts = shlex.split((RUNTIME / "_CoqProject").read_text())
    flags = [str(RUNTIME / v) if i % 3 == 1 else v for i, v in enumerate(parts)] + ["-Q", str(src), ""]
    receipt = {"schema": "tespec-parent-vc-itp/v1", "binding": binding, "model": model,
               "attempt": args.attempt, "checked_theorems": targets, "status": "IN_PROGRESS", "compilation": [],
               "final_execution_status": "UNKNOWN", "candidate_sha256": sha(src / "Candidate.v"),
               "original_goal_sha256": sha(src / "ExecutionGoal.v")}
    for name in ["ExecutionGoal", "Candidate", "StatementAudit", "ProofAudit"]:
        m = measure([COQ / "coqc", *flags, src / (name + ".v")], out / "compilation" / name, src)
        receipt["compilation"].append(m)
        save(out / "receipt.json", receipt)
        if m["exit_code"]:
            receipt["status"] = "COMPILE_FAILED"
            save(out / "receipt.json", receipt)
            print((ROOT / m["stderr"]).read_text()[-6000:], flush=True)
            return 1
    original = (ROOT / receipt["compilation"][2]["stdout"]).read_text()
    proofs = (ROOT / receipt["compilation"][3]["stdout"]).read_text()
    allowed = symbols(original)
    actual = symbols(proofs)
    receipt["assumption_audit"] = {"original": sorted(allowed), "proof": sorted(actual),
                                   "theorems": len(targets), "globally_closed": proofs.count("Closed under the global context")}
    assert actual <= allowed <= {"eval_addr_expr", "sizeof_union_type", "sizeof_struct_type", "sizeof_enum_type", "sizeof_alias_type"}
    assert proofs.count("Closed under the global context") + proofs.count("Axioms:") == len(targets)
    save(out / "receipt.json", receipt)
    receipt["kernel_check"] = measure([COQ / "coqchk", "-silent", *flags, "Candidate"], out / "kernel-check", src)
    exact = any(n == "refuted_parent" and t == "~ ExecutionGoal.main_entail_wit_6" for n, t in targets)
    receipt["status"] = ("PARENT_REFUTATION_KERNEL_CHECKED" if exact else "DIAGNOSTICS_KERNEL_CHECKED") if receipt["kernel_check"]["exit_code"] == 0 else "KERNEL_FAILED"
    receipt["final_execution_status"] = "FAIL" if receipt["status"] == "PARENT_REFUTATION_KERNEL_CHECKED" else "UNKNOWN"
    receipt["scope"] = "Only an unconditional exact original parent refutation may decide FAIL. Conditional lemmas and branch analysis retain UNKNOWN."
    save(out / "receipt.json", receipt)
    for path in src.iterdir():
        if path.suffix in {".vo", ".vos", ".vok", ".glob", ".aux"} or path.name in {".lia.cache", ".nia.cache"}:
            path.unlink()
    print(receipt["status"], flush=True)
    return int(receipt["kernel_check"]["exit_code"] != 0)


if __name__ == "__main__":
    raise SystemExit(main())
