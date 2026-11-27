"""Group current-version ITP work by verified proof identity and check every execution."""
import argparse
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor, as_completed
import fcntl
import hashlib
import json
import os
from pathlib import Path
import shutil
from tempfile import TemporaryDirectory
from types import SimpleNamespace

from collect_current_itp import gather
from complete_current_itp import solve
from organize_tespec_routes import RESULTS, fingerprint, read, save
from replay_source_only_itp import run_replay
from spectest.certificates import prepare_certificate
from spectest.proof_reuse import proof_key
from spectest.routes import itp_command, measure, proof_costs


def context(folder, row):
    native = folder / "out/native/report.json"
    if fingerprint(native) != row["native_report_sha256"]:
        raise ValueError("Wrong native report in frozen ITP queue")
    report = read(native)
    case, = report["results"]
    if case["id"] != row["executor_case_id"] or case["vc"]["immutable_sha256"]["goal"] != row["goal_sha256"]:
        raise ValueError("Different input or original Coq goal in frozen ITP queue")
    return native, report, case


def candidates(folder, row):
    _, report, case = context(folder, row)
    roots = [folder / name for name in ("current-itp", "generated-itp", "repair-itp")]
    roots += sorted(folder.glob("*-replay-*"))
    for root in roots:
        if not (root / "routes.json").exists():
            continue
        for manifest in sorted(root.glob("itp/*proof/case_*/manifest.json")):
            check = manifest.with_name("certificate-report.json")
            if not check.is_file():
                continue
            audit, bundle = read(check), read(manifest)
            source = manifest.with_name("Candidate.v")
            if (bundle["original_goal_sha256"] != row["goal_sha256"]
                    or fingerprint(manifest) != audit["manifest_sha256"]
                    or fingerprint(source) != audit["candidate_sha256"]):
                raise ValueError("Proof source or its original checked target changed")
            yield {"key": proof_key(bundle, report, case), "target": bundle.get("refuted_goal"),
                   "source": source, "sha": audit["candidate_sha256"], "audit": audit,
                   "roots": [g["proof"] for g in bundle["goals"]]}


class DifferentExecution(ValueError):
    """A negative source cannot be transferred to a different concrete input."""


def replay_negative(folder, row, proposal):
    native, report, case = context(folder, row)
    out = folder / ("peer-negative-replay-" + proposal["sha"])
    if (out / "routes.json").exists():
        return
    target = proposal["target"]
    # The native controller exposes precondition and functional refutations through
    # separate APIs. Verify the exact target from its frozen native classifier.
    from spectest.run_certificates import _precondition_refutation_goal
    entry = (any(p.get("goal") and "proof_of_" + p["goal"] == target for p in case.get("preconditions", []))
             and _precondition_refutation_goal(case) == target)
    with TemporaryDirectory() as temp:
        prepared = prepare_certificate(Path(case["vc"]["manifest"]), Path(temp) / "certificate",
                                       refute=target, only={target})
        key = proof_key(read(Path(prepared["manifest"])), report, case)
    if not key or key != proposal["key"]:
        raise DifferentExecution("Refutation source belongs to a different execution identity")
    out.mkdir()
    cache = out / "sources"
    cache.mkdir()
    shutil.copyfile(proposal["source"], cache / (key + ".v"))
    args = SimpleNamespace(itp_config={"agent_timeout":900, "check_timeout":600, "switch":"qcp-8.20"},
                           itp_replay_only=True, proof_cache=cache)
    cmd = itp_command(args, native, out / "itp", {case["id"]})
    cmd += ["--refute-precondition", case["id"]] if entry else ["--refute-vc", case["id"] + "=" + target]
    save(out / "peer-selection.json", {"source": str(proposal["source"].resolve()),
         "candidate_sha256": proposal["sha"], "recipient_proof_key": key})
    stats = measure(cmd, out / "measurements/itp")
    final = read(out / "itp/proof/report.json")
    evidence = final["proof_completion"]["agent"]
    verdict, = final["results"]
    attempt, = evidence["attempts"]
    if (stats["exit_code"] not in (0,1) or verdict["id"] != case["id"]
            or evidence["agent_invocations"] != 0 or evidence["tokens"] != 0
            or attempt["check"]["candidate_sha256"] != proposal["sha"]):
        raise ValueError("Mismatched target or unexpected model invocation in ITP source replay")
    stats.update(status="COMPLETED", report=str(out / "itp/proof/report.json"),
                 candidate_policy="replay_only", tokens=0, model_calls=0, checker_stages=proof_costs(evidence),
                 missing_candidates=[], native_report_sha256=row["native_report_sha256"])
    save(out / "routes.json", {"native_report_sha256":row["native_report_sha256"], "eligible_executions":1,
                              "cases":[{"case_id":case["id"], "eligible":True, "itp_status":verdict["status"]}],
                              "routes":{"itp":stats}})


def covers_requested_roots(folder, proposals):
    manifest, = (folder / "current-itp").glob("itp/proof/case_*/manifest.json")
    required = {item["proof"] for item in read(manifest)["goals"]}
    checked = {root for p in proposals if p["audit"].get("proof_status") == "VALID" for root in p["roots"]}
    return bool(required) and required.issubset(checked)


def certificate_identity(folder, row):
    _, report, case = context(folder, row)
    manifest, = (folder / "current-itp").glob("itp/proof/case_*/manifest.json")
    bundle = read(manifest)
    key = proof_key(bundle, report, case)
    if not key:
        raise ValueError("Cannot identify frozen ITP input")
    # This fingerprint only selects candidate *source*. Current-input scope,
    # reachability, costs and verdict always come from the current strict key.
    signature = {k: bundle[k] for k in ("original_goal_sha256", "immutable_sha256", "dependencies", "scope",
                                        "goals", "target_layout", "runtime_sha256", "allowed_assumptions")}
    signature["original_goal_identity"] = row["original_goal_identity"]
    source_key = hashlib.sha256(json.dumps(signature,sort_keys=True).encode()).hexdigest()
    return key, source_key


def finish(row, scratch):
    folder = scratch / row["native_report_sha256"]
    receipt = gather(folder, row, RESULTS / row["group"])
    if not receipt:
        raise ValueError("Completed ITP execution has no collectible receipt")
    # Publishing the compact group index is independent and may run concurrently.
    save(folder / "frozen-itp-evidence.json", receipt)
    return receipt


def already_refuted(folder, row):
    binding = folder / "legacy-verified-binding.json"
    if not binding.exists():
        return False
    checked = read(binding)
    if (checked["schema"] != "tespec-identical-execution-kernel-reuse/v1"
            or any(checked[k] != row[k] for k in ("group", "case", "variant", "strategy", "input_sha256",
                   "executed_source_sha256", "native_report_sha256", "goal_sha256",
                   "batch_native_report_sha256"))
            or checked["old_proof_key"] != checked["new_proof_key"]
            or checked["proof_status"] != "VALID" or checked["polarity"] != "negative"
            or checked["original_vc_judgement"] != "VC_REFUTED" or checked["unexpected_assumptions"]):
        raise ValueError("Nonmatching archived ITP counterproof binding")
    _, report, case = context(folder, row)
    target, = checked["checked_roots"]
    with TemporaryDirectory() as temp:
        frozen = prepare_certificate(Path(case["vc"]["manifest"]), Path(temp) / "certificate",
                                     refute=target, only={target})
        if proof_key(read(Path(frozen["manifest"])), report, case) != checked["new_proof_key"]:
            raise ValueError("Archived negative ITP key is for a different input or original target")
    # The latest-comparison publisher accounts for this shared independent kernel
    # check once. It is not a model call or an execution-level FAIL.
    selected, = (folder / "current-itp").glob("itp/proof/case_*/manifest.json")
    required = {goal["proof"] for goal in read(selected)["goals"]}
    return required.issubset(checked["checked_roots"])


def reconsider_completed(group, args):
    """An equivalent input that finished later may have produced the first valid proof."""
    _, rows = group
    frozen = []
    valid = {}
    for row in rows:
        folder = args.scratch / row["native_report_sha256"]
        result_file = folder / "frozen-itp-evidence.json"
        if not result_file.is_file():
            continue
        result = read(result_file)
        if result["final_status"] == "PASS":
            for p in candidates(folder, row):
                if p["audit"].get("polarity") == "positive" and p["audit"].get("proof_status") == "VALID":
                    valid[p["sha"]] = p
        elif result["final_status"] in ("UNKNOWN", "ERROR"):
            frozen.append((folder, row))
    for folder, row in frozen:
        prior = list(candidates(folder, row))
        if any(p["audit"].get("polarity") == "negative" and p["audit"].get("proof_status") == "VALID" for p in prior):
            continue
        seen = {p["sha"] for p in prior}
        key, _ = certificate_identity(folder, row)
        for sha, p in valid.items():
            if sha in seen:
                continue
            out = folder / ("peer-positive-replay-" + sha)
            if out.exists() and not (out / "routes.json").is_file():
                continue
            run_replay(folder, folder / "out/native/report.json", p["source"], key, out.name)
            outcome = finish(row, args.scratch)
            print("peer recheck", row["group"], row["case"], row["strategy"], outcome["final_status"], flush=True)
            if outcome["final_status"] in ("PASS", "FAIL", "CRASH"):
                break


def run_group(group, args):
    source_key, _ = group
    claim_dir = args.scratch / "proof-source-claims"
    claim_dir.mkdir(exist_ok=True)
    with (claim_dir / (source_key + ".lock")).open("a") as claim:
        try:
            fcntl.flock(claim, fcntl.LOCK_EX | (fcntl.LOCK_NB if args.backfill else 0))
        except BlockingIOError:
            return
        _run_claimed_group(group, args)


def _run_claimed_group(group, args):
    _, rows = group
    store = {}
    # Existing proof attempts (including candidates replayed from the older benchmark)
    # precede any new model invocation. This priority is independent of the expected verdict.
    for row in rows:
        for proposal in candidates(args.scratch / row["native_report_sha256"], row):
            if proposal["audit"].get("proof_status") == "VALID":
                store[(proposal["target"],proposal["sha"])] = proposal
    modeled = set()
    for row in rows:
        folder = args.scratch / row["native_report_sha256"]
        key, _ = certificate_identity(folder, row)
        if already_refuted(folder, row):
            continue
        if (folder / "frozen-itp-evidence.json").is_file():
            prior = read(folder / "frozen-itp-evidence.json")
            if prior["model_attempts"]:
                modeled.add(key)
            for proposal in candidates(folder, row):
                store[(proposal["target"],proposal["sha"])] = proposal
            continue
        own = list(candidates(folder, row))
        own_sha = {p["sha"] for p in own}
        decided = covers_requested_roots(folder, own)
        if not decided:
            proposals = sorted(store.values(), key=lambda p: p["audit"].get("proof_status") != "VALID")
            for p in proposals:
                if p["sha"] in own_sha:
                    continue
                if p["target"] is not None:
                    # The original VC can match even when concrete inputs differ.
                    # Only transfer negative sources with an exact refutation key.
                    try:
                        replay_negative(folder, row, p)
                    except DifferentExecution:
                        continue
                elif p["key"] == key or p["audit"].get("polarity") == "positive" and p["audit"].get("proof_status") == "VALID":
                    run_replay(folder, folder / "out/native/report.json", p["source"], key,
                               "peer-positive-replay-" + p["sha"])
                else:
                    continue
                if covers_requested_roots(folder, candidates(folder, row)):
                    decided = True
                    break
        if not decided and key not in modeled:
            for repair in (False, True):
                solve(row, args.scratch, args.task_root, args.windows_python, repair)
                if covers_requested_roots(folder, candidates(folder, row)):
                    break
            if list(folder.glob("model-receipts/*.json")):
                modeled.add(key)
        for p in candidates(folder, row):
            store[(p["target"],p["sha"])] = p
        receipt = finish(row, args.scratch)
        if receipt["needs_model"]:
            raise ValueError("Frozen source replay left a requested model stage unmeasured: " + folder.name)
        print(row["group"], row["case"], row["strategy"], receipt["final_status"],
              len(receipt["model_attempts"]), flush=True)
    reconsider_completed(group, args)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--windows-python", type=Path)
    parser.add_argument("--task-root", type=Path)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--recheck-completed-peers", action="store_true",
                        help="Only check already generated positive sources on equivalent earlier inconclusive executions")
    parser.add_argument("--refresh-evidence-only", action="store_true",
                        help="Only refresh already collected inputs from original local stage receipts")
    parser.add_argument("--assist-family", help="Process only one family with per-source claims shared by other updated workers")
    parser.add_argument("--backfill", action="store_true",
                        help="Process unclaimed original sources while regular workers await cold checks")
    parser.add_argument("--ready-list", type=Path, help="Use a publisher-verified ready subset of native SHA-256 keys")
    parser.add_argument("--cohort", choices=("all","new","historical"), default="all",
                        help="Separate original targets present in the prior experiment from new targets")
    parser.add_argument("--wait-lock", action="store_true", help="Take over after the previous same-cohort workers finish")
    args = parser.parse_args()
    if args.refresh_evidence_only:
        count = 0
        for row in read(args.scratch / "queue.json")["executions"]:
            if (args.scratch / row["native_report_sha256"] / "frozen-itp-evidence.json").is_file():
                finish(row, args.scratch)
                count += 1
        print("updated frozen ITP receipts", count, flush=True)
        return
    if args.workers < 1 or (not args.recheck_completed_peers and
            (not args.windows_python or not args.windows_python.is_file() or not args.task_root)):
        parser.error("A valid Windows model CLI host and a positive worker count are required")
    guards = []
    lock_names = ("recheck",) if args.recheck_completed_peers else ("new", "historical") if args.cohort == "all" else (args.cohort,)
    if args.assist_family:
        if Path(args.assist_family).name != args.assist_family:
            parser.error("invalid benchmark family")
        lock_names = ("assist-" + args.assist_family,)
    if args.backfill:
        if args.cohort != "new":
            parser.error("Backfill is limited to the distinct new-target cohort")
        lock_names = tuple("backfill-" + name for name in lock_names)
    for cname in lock_names:
        guard = (args.scratch / ("frozen-model-" + cname + ".lock")).open("a")
        fcntl.flock(guard, fcntl.LOCK_EX if args.wait_lock else fcntl.LOCK_EX | fcntl.LOCK_NB)
        guards.append(guard)
    archived_goals = {v["goal_sha256"] for old in RESULTS.glob("*/tespec/current-itp.json")
                      for v in read(old)["executions"].values()}
    slots = args.scratch / "resource-slots"
    slots.mkdir(exist_ok=True)
    os.environ["TESPEC_ITP_RESOURCE_DIR"] = str(slots.resolve())
    queue = read(args.scratch / "queue.json")
    if queue["schema"] != "tespec-latest-itp-queue/v1":
        raise ValueError("Unknown frozen execution queue")
    negative_schedule = args.scratch / "legacy-refutation-schedule.json"
    reserved = read(negative_schedule)["executions"] if negative_schedule.is_file() else {}
    grouped = defaultdict(list)
    waiting = 0
    ready = set(read(args.ready_list)["native_report_sha256"]) if args.ready_list else None
    for row in queue["executions"]:
        if args.assist_family and row["group"] != args.assist_family:
            continue
        if ready is not None and row["native_report_sha256"] not in ready:
            continue
        old = row["goal_sha256"] in archived_goals
        if args.cohort == "new" and old or args.cohort == "historical" and not old:
            continue
        folder = args.scratch / row["native_report_sha256"]
        if (not (folder / "current-itp/routes.json").is_file()
                or (folder.name in reserved and not (folder / "legacy-verified-binding.json").is_file()
                    and not any(folder.glob("legacy-negative-replay-*/routes.json")))):
            waiting += 1
            continue
        _, source_id = certificate_identity(folder, row)
        grouped[(row["group"], source_id)].append(row)
    remaining = defaultdict(int)
    for rows in grouped.values():
        remaining[rows[0]["group"]] += sum(not (args.scratch / r["native_report_sha256"] / "frozen-itp-evidence.json").is_file()
                                           for r in rows)
    batches = [(k[1], rows) for k, rows in sorted(grouped.items(), key=lambda item: remaining[item[0][0]])]
    print("current ITP source identities", len(batches), "ready executions", sum(len(v) for v in grouped.values()),
          "waiting initial replay", waiting, flush=True)
    with ThreadPoolExecutor(args.workers) as workers:
        task_function = reconsider_completed if args.recheck_completed_peers else run_group
        tasks = [workers.submit(task_function, group, args) for group in batches]
        try:
            for task in as_completed(tasks):
                task.result()
        except BaseException:
            for task in tasks:
                task.cancel()
            raise


if __name__ == "__main__":
    main()
