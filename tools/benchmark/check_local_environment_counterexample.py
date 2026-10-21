#!/usr/bin/env python3
"""Kernel-check an exact parent's universal local-environment counterexample."""
import argparse
import json
import re
import shlex
import shutil
from pathlib import Path
from meter_read_itp_coq import ROOT, COQ, RUNTIME, measure, save, sha
from positive_execution_itp import statements, symbols


def definition(text, name):
    match = re.search(r"Definition " + re.escape(name) + r"\b.*?\.\s*(?:\n|$)", text, re.S)
    assert match, name
    return re.sub(r"\s+", " ", match[0]).strip()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--task", type=Path, required=True)
    parser.add_argument("--attempt", type=int, required=True)
    parser.add_argument("--validation", type=int, default=1)
    args = parser.parse_args()
    task = args.task.resolve()
    source = task / f"attempt-{args.attempt}"
    folder = ROOT / f"benchmark/results/array_load/20261021-local-counterexample/attempt-{args.attempt}"
    if args.validation != 1:
        folder = folder.with_name(folder.name + f"-check-{args.validation}")
    assert not folder.exists()
    model = json.loads((source / "model-receipt.json").read_text())
    binding = json.loads((task / "binding.json").read_text())
    template = (task / "Template.txt").read_text()
    text = (source / "Candidate.v").read_text()
    assert model["requested_model"] == "gpt-6.1-sol" and model["exit_code"] == 0 and model["token_usage"]
    assert sha(source / "Candidate.v") == model["candidate_sha256"]
    assert sha(source / "prompt.txt") == model["prompt_sha256"]
    for item in [binding["source"], binding["binds"], binding["report"], binding["original_goal"]]:
        assert sha(ROOT / item["path"]) == item["sha256"]
    assert sha(task / "ExecutionGoal.v") == binding["original_goal"]["sha256"]
    assert not re.search(r"\b(?:Admitted|admit|Axiom|Parameter|native_cast_no_check|vm_cast_no_check|exact_no_check)\b", text)
    assert not re.search(r"(?:Unset\s+(?:Guard|Positivity|Universe)|\bModule\b)", text)
    expected = dict(statements(template))
    actual = dict(statements(text))
    assert all(actual.get(name) == theorem for name, theorem in expected.items())
    for name in ["lifted_parent", "legal_layout"]:
        assert definition(text, name) == definition(template, name)
    src = folder / "proofs"
    src.mkdir(parents=True)
    for name in ["model-receipt.json", "usage-events.json", "agent.stdout.jsonl", "agent.stderr.log", "prompt.txt", "Candidate.v"]:
        shutil.copyfile(source / name, folder / name)
    for name in ["ExecutionGoal.v", "Template.txt", "binding.json", "diagnosis.txt"]:
        if (task / name).exists():
            shutil.copyfile(task / name, folder / name)
    shutil.copyfile(task / "ExecutionGoal.v", src / "ExecutionGoal.v")
    shutil.copyfile(source / "Candidate.v", src / "Candidate.v")
    (src / "ProofAudit.v").write_text("Require Import Candidate.\n" + "".join(
        "Print Assumptions Candidate.%s.\n" % name for name in expected))
    parts = shlex.split((RUNTIME / "_CoqProject").read_text())
    flags = [str(RUNTIME / v) if i % 3 == 1 else v for i, v in enumerate(parts)] + ["-Q", str(src), ""]
    receipt = {"schema": "tespec-local-environment-counterexample/v1", "binding": binding,
        "model": model, "validation": args.validation, "model_attempt": args.attempt, "status": "IN_PROGRESS", "compilation": [], "targets": expected,
        "scope": "Full original parent universalized over its local address environment; exact specialization link and concrete legal-layout counterexample. Not a claim about the actual C function body."}
    for name in ["ExecutionGoal", "Candidate", "ProofAudit"]:
        m = measure([COQ / "coqc", *flags, src / (name + ".v")], folder / "compilation" / name, src)
        receipt["compilation"].append(m)
        save(folder / "receipt.json", receipt)
        if m["exit_code"]:
            receipt["status"] = "COMPILE_FAILED"
            save(folder / "receipt.json", receipt)
            print((ROOT / m["stderr"]).read_text()[-8000:], flush=True)
            return 1
    audit = (ROOT / receipt["compilation"][-1]["stdout"]).read_text()
    blocks = audit.split("Closed under the global context")
    receipt["assumption_audit"] = {"symbols": sorted(symbols(audit)), "globally_closed": len(blocks)-1,
        "original_parameters_allowed_only_in_link": ["eval_addr_expr", "sizeof_alias_type", "sizeof_enum_type", "sizeof_struct_type", "sizeof_union_type"]}
    assert symbols(audit) <= set(receipt["assumption_audit"]["original_parameters_allowed_only_in_link"])
    chunks = re.findall(r"Axioms:\n.*?(?=Axioms:\n|Closed under the global context|\Z)|Closed under the global context", audit, re.S)
    assert len(chunks) == 4
    assert not symbols(chunks[1])
    type_parameters = {"sizeof_alias_type", "sizeof_enum_type", "sizeof_struct_type", "sizeof_union_type"}
    assert symbols(chunks[2]) <= type_parameters and symbols(chunks[3]) <= type_parameters
    receipt["assumption_audit"]["by_target"] = {name: sorted(symbols(chunk)) for name, chunk in zip(expected, chunks)}
    save(folder / "receipt.json", receipt)
    receipt["kernel_check"] = measure([COQ / "coqchk", "-silent", *flags, "Candidate"], folder / "kernel-check", src)
    receipt["status"] = "KERNEL_CHECKED" if receipt["kernel_check"]["exit_code"] == 0 else "KERNEL_FAILED"
    receipt["final_modular_verdict"] = "FAIL" if receipt["status"] == "KERNEL_CHECKED" else "UNKNOWN"
    receipt["candidate_sha256"] = sha(src / "Candidate.v")
    save(folder / "receipt.json", receipt)
    for path in src.iterdir():
        if path.suffix in {".vo", ".vos", ".vok", ".glob", ".aux"} or path.name in {".lia.cache", ".nia.cache"}:
            path.unlink()
    print(receipt["status"], flush=True)
    return int(receipt["status"] != "KERNEL_CHECKED")


if __name__ == "__main__":
    raise SystemExit(main())
