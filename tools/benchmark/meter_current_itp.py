#!/usr/bin/env python3
"""Bridge one frozen WSL proof task to a metered, text-only Windows model client."""
import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

from organize_tespec_routes import ROOT, fingerprint, read, save
from spectest.proof_controller import read_refutation_plan
from spectest.core import _runtime_coq_module
from spectest.certificates import _benchmark_resource_slot


def windows(path):
    return subprocess.check_output(["wslpath", "-w", str(path.resolve())], text=True).strip()


def historical_proof_materials(execution):
    """Return a checked same-group helper and, when available, a matching prior proof."""
    native_path = execution / "out/native/report.json"
    native_hash = fingerprint(native_path)
    queue = execution.parent / "queue.json"
    source = Path(read(execution / "job.json")["source"]).resolve()
    if queue.is_file():
        plan = read(queue)
        if plan.get("schema") != "tespec-latest-itp-queue/v1":
            raise ValueError("Unrecognized frozen ITP queue")
        row = next((r for r in plan["executions"] if r["native_report_sha256"] == native_hash), None)
        if row is None or Path(row["group"]).name != row["group"]:
            raise ValueError("No unique group for original ITP report")
        if fingerprint(source) != read(native_path)["provenance"]["source_sha256"]:
            raise ValueError("Job source changed before original proof replay")
        group = ROOT / "benchmark/results" / row["group"]
    else:
        root = (ROOT / "benchmark/programs").resolve()
        if not source.is_relative_to(root):
            return {}
        group = ROOT / "benchmark/results" / source.relative_to(root).parts[0]
        index = group / "tespec/current-executions.json"
        if not index.is_file():
            return {}
        row = next((r for r in read(index)["executions"] if r["native_report_sha256"] == native_hash), None)
        if row is None:
            return {}
    choices = []
    for archive in sorted(group.glob("*-itp-per-execution")):
        aggregate = archive / "receipt.json"
        if aggregate.is_file():
            old = read(aggregate)
            cases = {case["execution_index"]: case for case in old.get("cases", [])}
            for attempt in old.get("attempts", []):
                case = cases.get(attempt.get("execution_index"))
                if not case or case["case"] != row["case"] or attempt.get("status") != "KERNEL_CHECKED":
                    continue
                if attempt.get("kernel_check", {}).get("exit_code") != 0:
                    continue
                model = ROOT / attempt["model_receipt"]
                if model.resolve().is_relative_to(archive.resolve()) and model.is_file():
                    choices.append((case["variant"] == row["variant"], attempt, read(model), archive))
        for proof_file in sorted(archive.glob("execution-*/attempt-*/coq-receipt.json")):
            attempt = read(proof_file)
            bind = attempt.get("binding", {})
            if (bind.get("case") == row["case"] and attempt.get("status") == "KERNEL_CHECKED"
                    and attempt.get("kernel_check", {}).get("exit_code") == 0):
                choices.append((bind.get("variant") == row["variant"], attempt, attempt["model"], archive))
    for exact, attempt, model, archive in sorted(choices, key=lambda item: not item[0]):
        candidate = (ROOT / attempt["candidate"]).resolve()
        if not candidate.is_relative_to(archive.resolve()) or fingerprint(candidate) != attempt["candidate_sha256"]:
            raise ValueError("Unbound historical ITP candidate")
        materials = {}
        for name, sha in model.get("locked_goal_and_helper_sha256", {}).items():
            if Path(name).name != name or not name.endswith(".v") or "goal" in name.lower():
                continue
            helper = candidate.with_name(name)
            if not helper.is_file() or fingerprint(helper) != sha:
                raise ValueError("Unbound historical ITP helper")
            materials[str(helper.relative_to(ROOT))] = {"sha256": sha, "source": helper.read_text()}
        if materials:
            if exact:
                materials[str(candidate.relative_to(ROOT))] = {
                    "sha256": fingerprint(candidate), "source": candidate.read_text()
                }
            return materials
    return {}


def recover_finished_calls(execution, task_root):
    """Restore only an already incurred, uniquely bound Windows charge after interruption."""
    if fingerprint(execution / "out/native/report.json") != execution.name:
        raise ValueError("Interrupted model launch belongs to a different native execution")
    recovered = 0
    for path in sorted((execution / "model-launches").glob("*.json")):
        saved = execution / "model-receipts" / path.name
        if saved.exists():
            continue
        launch = read(path)
        task = Path(launch["task"]).resolve()
        if (task.parent != task_root.resolve() or task.name != path.stem
                or launch["native_report_sha256"] != execution.name):
            raise ValueError("Invalid model launch binding")
        # Active bridges publish their own record when the Windows request ends.
        if "bridge_pid" not in launch or Path("/proc", str(launch["bridge_pid"])).exists():
            continue
        receipt = task / "attempt-1/model-receipt.json"
        if not receipt.exists():
            continue
        record = read(receipt)
        if (fingerprint(task / "prompt.txt") != launch["prompt_sha256"]
                or record["prompt_sha256"] != launch["prompt_sha256"]
                or fingerprint(task / "Candidate.v") != record["candidate_sha256"]
                or fingerprint(task / "attempt-1/agent.stdout.jsonl") != record["raw_event_log_sha256"]
                or any(Path(name).name != name or fingerprint(task / name) != sha
                       for name, sha in record["locked_goal_and_helper_sha256"].items())):
            raise ValueError("Unverified Windows cost receipt after interruption")
        record.update(recovered_after_bridge_exit=True, model_queue_seconds=launch["model_queue_seconds"])
        if launch["historical_proof_sha256"]:
            record["historical_proof_sha256"] = launch["historical_proof_sha256"]
        save(saved, record)
        recovered += 1
    return recovered


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--windows-python", type=Path)
    parser.add_argument("--task-root", type=Path, required=True)
    parser.add_argument("--execution", type=Path, required=True)
    parser.add_argument("--recover-costs-only", action="store_true",
                        help="Recover a completed original client receipt without invoking the model or changing a result")
    args = parser.parse_args()
    if args.recover_costs_only:
        print("Recovered model receipts", recover_finished_calls(args.execution.resolve(), args.task_root.resolve()))
        return 0
    if not args.windows_python:
        parser.error("model generation requires --windows-python")
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
    # The goal imports these source-only libraries by their qualified names. Include
    # their original definitions so the model can reason about the same predicates.
    native_manifest = Path(bundle["original_manifest"])
    if fingerprint(native_manifest) != bundle["original_manifest_sha256"]:
        raise ValueError("Changed original proof manifest")
    native = read(native_manifest)
    sources = {}
    for dep in native.get("runtime_dependencies", []):
        if dep.get("compiled") is not None:
            continue
        path = _runtime_coq_module(dep["module"], Path(native["qcip_root"]))
        if path is None or path != Path(dep["source"]).resolve() or fingerprint(path) != dep["sha256"]:
            raise ValueError("Unbound runtime proof source")
        sources[dep["module"]] = path.read_text()
    request["runtime_definitions"] = sources
    historical = historical_proof_materials(args.execution)
    if historical:
        request["historical_proofs_for_reference"] = historical
    history = {}
    rounds = [args.execution / name for name in ("current-itp", "generated-itp", "repair-itp")]
    rounds.extend(sorted(args.execution.glob("runtime-source-replay-*")))
    for run in rounds:
        for src in sorted(run.glob("itp/*proof/case_*/Candidate.v")):
            if src.parent == candidate.parent or not src.with_name("Goal.v").exists():
                continue
            if fingerprint(src.with_name("Goal.v")) != fingerprint(candidate.with_name("Goal.v")):
                continue
            if read(src.with_name("manifest.json")).get("refuted_goal") != bundle["refuted_goal"]:
                continue
            report = src.with_name("certificate-report.json")
            if report.is_file():
                # An original generated alignment proof may fail then be repaired.
                # Give the model the last actual blocking diagnostic for this source.
                failed = next((step for step in reversed(read(report)["stages"]) if step["exit_code"] != 0), None)
                if failed:
                    diagnostic = Path(failed["log"])
                    if not diagnostic.resolve().is_relative_to(src.parent.resolve()):
                        raise ValueError("Invalid proof log location")
                    log = diagnostic.read_text(errors="replace").replace(str(src.parent), ".")
                    history[fingerprint(src)] = {"candidate": src.read_text(), "stage": failed["stage"],
                                                 "exit_code": failed["exit_code"], "coq": log[-2500:]}
    request["previous_compile_errors"] = list(history.values())
    request["example_refute_plan"] = {"refute_vcs": {bundle["case_id"]: bundle["goals"][0]["proof"]}} if bundle["goals"] else {}

    instruction = ("Fill this original Coq Candidate. Return one JSON object with candidate (complete Coq source) "
                   "and optional plan. Preserve the statement, direction, module interface and all original targets. "
                   "No admits, fresh axioms or proof escapes. No tools or delegation. For SimpleC notations import VCPrelude explicitly before importing naive_C_Rules. If the original goal is false, "
                   "use the exact case key and target from the request to propose a named refutation, "
                   "or request entry refutation via refute_preconditions using the actual case id. "
                   "For a SAT obligation whose assertion reduces to emp, the QCP concrete empty model is "
                   "(@ConAssertion.empty_state naive_C_Rules.sts), and its checked helper is "
                   "(@ConAssertion.empty_state_is_empty naive_C_Rules.sts) : emp (@ConAssertion.empty_state naive_C_Rules.sts). "
                   "Use these only if the original instantiated assertion holds on that model. "
                   "If historical proofs are supplied, use only the lemmas needed for the CURRENT Goal. "
                   "Historical modules are not on the load path: copy the required helper definitions and their actual proofs into the candidate. "
                   "Re-check all witness orders, field names and guards against the original Goal before instantiating. "
                   "Leave an unproved target unresolved.\n")
    (task / "prompt.txt").write_text(instruction + json.dumps(request, ensure_ascii=False))
    script = ROOT / "tools/benchmark/meter_itp_model_windows.py"
    command = [str(args.windows_python), windows(script), "--task-dir", windows(task), "--text-only"]
    job_fds = []
    with _benchmark_resource_slot("model_generation", job_fds=job_fds) as model_queue_seconds:
        if job_fds:
            # A killed bridge must leave an unambiguous link to this one Windows
            # receipt. The Linux wrapper retains the lane while Windows is busy.
            launch = {"native_report_sha256": args.execution.name, "task": str(task), "bridge_pid": os.getpid(),
                      "prompt_sha256": fingerprint(task / "prompt.txt"), "model_queue_seconds": model_queue_seconds,
                      "historical_proof_sha256": {n: v["sha256"] for n, v in historical.items()}}
            save(args.execution / "model-launches" / (task.name + ".json"), launch)
            guarded = ["/usr/bin/time", "--quiet", "-o", "/dev/null", "--", *command]
            runner = subprocess.Popen(guarded, start_new_session=True, pass_fds=tuple(job_fds),
                                      stdout=subprocess.DEVNULL)
            code = runner.wait()
            if code:
                raise subprocess.CalledProcessError(code, command)
        else:
            subprocess.run(command, stdout=subprocess.DEVNULL, check=True)
    receipt = task / "attempt-1/model-receipt.json"
    record = read(receipt)
    if record["candidate_sha256"] != fingerprint(task / "Candidate.v"):
        raise ValueError("Metered candidate changed")
    saved = args.execution / "model-receipts"
    saved.mkdir(exist_ok=True)
    if model_queue_seconds:
        record["model_queue_seconds"] = model_queue_seconds
    if historical:
        record["historical_proof_sha256"] = {name: item["sha256"] for name, item in historical.items()}
    save(saved / (task.name + ".json"), record)
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
