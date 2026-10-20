#!/usr/bin/env python3
"""Meter one whole modular boundary execution's original residual VC task."""
import argparse
import json
import re
import shlex
import shutil
from pathlib import Path
from meter_read_itp_coq import ROOT, COQ, RUNTIME, measure, save, sha
from positive_execution_itp import statements, symbols

RUN = "20261020-boundary-itp"
OUT = ROOT / "benchmark/results/array_load" / RUN


def prepare(taskroot):
    tasks = []
    for sampling in ("on", "off"):
        batch = ROOT / "benchmark/results/spatial-smt-regressions" / ("20261020-modular-boundary-" + sampling)
        for client in (7, 12):
            case = "original_client_translation%d_only_entry" % client
            for mode in ("off", "on"):
                matches = [json.loads(p.read_text()) for p in batch.glob("array_load/case-*/" + mode + "/receipt.json")]
                row = next(x for x in matches if x["case"] == case)
                report = ROOT / row["report"]["path"]
                assert sha(report) == row["report"]["sha256"]
                raw = json.loads(report.read_text())["results"][0]
                assert raw["status"] == "UNKNOWN" and raw["execution_completed"] and raw["precondition_result"] == "SAT"
                goal = Path(raw["vc"]["files"]["goal"])
                names = [n.removeprefix("proof_of_") for n in raw["residual_vcs"]]
                decisive = "main_entail_wit_6_split_goal_2" if client == 12 else None
                assert decisive is None or decisive in names
                original = goal.read_text()
                pre = "main_precondition_wit_1"
                goals = [("entry_sat", "ExecutionGoal." + pre)]
                if decisive:
                    goals += [("refuted_" + decisive, "~ ExecutionGoal." + decisive)]
                else:
                    goals += [("resolved_" + n, "ExecutionGoal." + n) for n in names]
                header = original.split("(*----- Function ")[0]
                candidate = "Require Import ExecutionGoal.\n" + header + "\n" + (
                    "Definition empty_state : naive_C_Rules.model := "
                    "{| ConAssertion.s_mem := Mem.empty_mem; ConAssertion.s_STS := Sets.full; ConAssertion.s_token := Sets.empty |}.\n")
                candidate += "".join("Theorem %s : %s.\nProof. Admitted.\n" % g for g in goals)
                candidate += "".join("Print Assumptions %s.\n" % n for n, _ in goals)
                binding = {"execution_index": len(tasks), "group": "array_load", "case": case,
                    "modular_instantiation": sampling, "mode": mode,
                    "report": row["report"], "source": row["source"], "binds": row["binds"],
                    "original_goal": {"path": str(goal.relative_to(ROOT)), "sha256": sha(goal)},
                    "all_original_residual_vcs": names, "checked_theorems": goals,
                    "decisive_refuted_original_vc": decisive,
                    "expected": row["expected"], "intended_final_status": "UNKNOWN" if decisive else "PASS",
                    "scope": "Modular contract/invariant obligation. Refutation of the weak callee client is not a counterexample to the inlined C body."}
                task = taskroot / ("execution-%02d" % len(tasks))
                assert not task.exists()
                task.mkdir(parents=True)
                save(task / "binding.json", binding)
                (task / "ExecutionGoal.v").write_bytes(goal.read_bytes())
                (task / "Candidate.v").write_text(candidate)
                (task / "template.txt").write_text(candidate)
                prompt = ("Fill Candidate.v for this ONE actual completed modular test execution. "
                    "All original residual VCs are frozen in ExecutionGoal.v and listed in binding.json. "
                    "Preserve every supplied theorem statement, original definitions/imports and Print Assumptions. "
                    "The entry SAT theorem must be proved too. For the strong-contract client prove all residuals. "
                    "For the weak-contract client formally refute the designated auxiliary pure VC for diagnosis; "
                    "the parent VC still has a spatial alternative, so this auxiliary refutation alone cannot decide the whole execution. "
                    "The benchmark's original expected PASS refers to the inlined body and is NOT changed to fit a modular result. "
                    "No admitted/admit, new axioms/parameters, unsafe casts, delegation, compiler or shell calls. "
                    "Edit Candidate.v only; optionally write diagnosis.txt. Controller compiles and runs full independent coqchk with resource limits. "
                    "Use the exact original target names, not substitute or universal program proofs. "
                    "Useful runtime facts: naive_C_Rules.model is ConAssertion.state with s_mem, s_STS, s_token. "
                    "empty_state is provided using Mem.empty_mem, Sets.full and Sets.empty. "
                    "For an OR goal a valid reflexive entailment alternative can be proved without constructing an array heap. "
                    "The selected weak-client pure target universally claims a bounded integer equals zero; instantiate a legal nonzero integer. "
                    "All actual repairs are separately metered.\n\nBINDING\n" + json.dumps(binding, indent=2) +
                    "\nORIGINAL GOAL\n" + original + "\nCANDIDATE\n" + candidate)
                (task / "prompt.txt").write_text(prompt)
                tasks.append(binding)
    save(OUT / "tasks.json", {"tasks": tasks, "execution_count": len(tasks), "schema": "tespec-boundary-execution-itp/v1"})
    print("Prepared", len(tasks), flush=True)


def compile_one(root, index, attempt):
    task = root / ("execution-%02d" % index)
    binding = json.loads((task / "binding.json").read_text())
    md = task / ("attempt-%d" % attempt)
    model = json.loads((md / "model-receipt.json").read_text())
    assert model["exit_code"] == 0 and model["requested_model"] == "gpt-6.1-sol" and model["token_usage"]
    assert sha(md / "prompt.txt") == model["prompt_sha256"]
    for reference in (binding["source"], binding["binds"], binding["report"], binding["original_goal"]):
        assert sha(ROOT / reference["path"]) == reference["sha256"]
    assert sha(task / "ExecutionGoal.v") == binding["original_goal"]["sha256"]
    folder = OUT / task.name / md.name
    assert not (folder / "receipt.json").exists()
    src = folder / "proofs"
    src.mkdir(parents=True)
    for f in ("model-receipt.json", "usage-events.json", "agent.stdout.jsonl", "agent.stderr.log", "prompt.txt", "Candidate.v"):
        shutil.copyfile(md / f, folder / f)
    save(folder / "binding.json", binding)
    text = (md / "Candidate.v").read_text()
    assert sha(md / "Candidate.v") == model["candidate_sha256"]
    receipt = {"schema": "tespec-boundary-itp-receipt/v1", "binding": binding, "model": model,
        "status": "PRE_AUDIT", "attempt": attempt, "compilation": []}
    if statements(text) != [tuple(g) for g in binding["checked_theorems"]] or re.search(
            r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b", text):
        receipt["status"] = "CANDIDATE_REJECTED"
        save(folder / "receipt.json", receipt)
        return 1
    assert all("Print Assumptions " + n + "." in text for n, _ in binding["checked_theorems"])
    for name, h in model["locked_goal_and_helper_sha256"].items():
        assert sha(task / name) == h
        shutil.copyfile(task / name, src / name)
    shutil.copyfile(md / "Candidate.v", src / "Candidate.v")
    parts = shlex.split((RUNTIME / "_CoqProject").read_text())
    flags = [str(RUNTIME / v) if i % 3 == 1 else v for i, v in enumerate(parts)] + ["-Q", str(src), ""]
    for name in ("ExecutionGoal.v", "Candidate.v"):
        m = measure([COQ / "coqc", *flags, src / name], folder / "compilation" / Path(name).stem, src)
        receipt["compilation"].append(m)
        save(folder / "receipt.json", receipt)
        if m["exit_code"]:
            receipt["status"] = "COMPILE_FAILED"
            save(folder / "receipt.json", receipt)
            print((ROOT / m["stderr"]).read_text(), flush=True)
            return 1
    targets = binding["checked_theorems"]
    stmt = src / "StatementAudit.v"
    stmt.write_text("Require Import ExecutionGoal.\n" + "".join(
        "Print Assumptions ExecutionGoal.%s.\n" % (n.removeprefix("ExecutionGoal."))
        for n in (["ExecutionGoal.main_precondition_wit_1"] + ["ExecutionGoal." + name for name in binding["all_original_residual_vcs"]])))
    m = measure([COQ / "coqc", *flags, stmt], folder / "compilation/StatementAudit", src)
    receipt["compilation"].append(m)
    audit = (ROOT / receipt["compilation"][1]["stdout"]).read_text()
    baseline = (ROOT / m["stdout"]).read_text()
    receipt["assumption_audit"] = {"original": sorted(symbols(baseline)), "proof": sorted(symbols(audit)),
        "globally_closed": audit.count("Closed under the global context"), "raw": receipt["compilation"][1]["stdout"],
        "scope": "Only original statement parameters may remain; no added proof/library axioms."}
    if m["exit_code"] or not symbols(audit) <= symbols(baseline) or not symbols(baseline) <= {
            "eval_addr_expr", "sizeof_union_type", "sizeof_struct_type", "sizeof_enum_type", "sizeof_alias_type"} or (
            audit.count("Closed under the global context") + audit.count("Axioms:") != len(targets)):
        receipt["status"] = "ASSUMPTION_AUDIT_REJECTED"
        save(folder / "receipt.json", receipt)
        return 1
    save(folder / "receipt.json", receipt)
    receipt["kernel_check"] = measure([COQ / "coqchk", "-silent", *flags, "Candidate"], folder / "kernel-check", src)
    receipt["status"] = "KERNEL_CHECKED" if receipt["kernel_check"]["exit_code"] == 0 else "KERNEL_FAILED"
    receipt["final_status"] = ("UNKNOWN" if binding["decisive_refuted_original_vc"] else "PASS") if receipt["status"] == "KERNEL_CHECKED" else None
    receipt["proof_scope"] = "Auxiliary split-target refutation only; parent alternatives remain unresolved." if binding["decisive_refuted_original_vc"] else "All original residual targets proved."
    save(folder / "receipt.json", receipt)
    for p in src.iterdir():
        if p.suffix in (".vo", ".vos", ".vok", ".glob", ".aux") or p.name in (".lia.cache", ".nia.cache"):
            p.unlink()
    print(receipt["status"], index, attempt, flush=True)
    return int(receipt["status"] != "KERNEL_CHECKED")


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("action", choices=("prepare", "compile"))
    p.add_argument("--task-root", type=Path, required=True)
    p.add_argument("--execution", type=int)
    p.add_argument("--attempt", type=int, default=1)
    a = p.parse_args()
    if a.action == "prepare":
        prepare(a.task_root)
    else:
        raise SystemExit(compile_one(a.task_root, a.execution, a.attempt))
