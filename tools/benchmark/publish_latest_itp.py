#!/usr/bin/env python3
"""Publish compact ITP evidence on the latest finite matrix, keeping verified reuse explicit."""
import argparse
import fcntl
import time
from collections import Counter, defaultdict
from pathlib import Path

from collect_current_itp import gather
from organize_tespec_routes import ROOT, RESULTS, branch_counts, fingerprint, read, save

IDENTITY = ("variant","case","strategy","executor_case_id","source_sha256","executed_source_sha256",
            "input_sha256","goal_sha256","original_goal_identity","batch_native_report_sha256","expected","expected_fault_code")


# The source snapshot may predate a new evidence schema or a late proof
# receipt. Keep validated refreshes in memory across the watcher passes.
REFRESHED = {}


def no_stage(model=False):
    m={"invoked":False,"wall_seconds":0,"max_process_rss_kib":None,"tokens":0}
    if model:
        m.update(input_tokens=0,output_tokens=0)
    return m


def checked_binding(path, row):
    b=read(path)
    if (b["old_proof_key"] != b["new_proof_key"] or not b["checked_roots"]
            or b["proof_status"] != "VALID" or b["polarity"] != "negative" or b["kernel_replay_mode"] != "full"
            or b["unexpected_assumptions"] or b["assumptions_audited_goals"] < len(b["checked_roots"])
            or any(b[k]!=row[k] for k in ("group","variant","case","strategy","input_sha256","executed_source_sha256",
                                          "goal_sha256","native_report_sha256","batch_native_report_sha256"))):
        raise ValueError(f"inconsistent shared check {path}")
    archived=b["archived_source"]["archive_receipt"]
    if fingerprint(ROOT/archived["path"])!=archived["sha256"]:
        raise ValueError(f"changed archived certificate {archived}")
    return b


def collect(row, scratch, base):
    h=row["native_report_sha256"]
    folder=scratch/h
    if fingerprint(folder/"out/native/report.json")!=h:
        raise ValueError("projection differs: "+h)
    item={k:row[k] for k in IDENTITY}
    item.update(native_status=row["native_status"], proof_implementation="teSpec ITP",
                branch_evaluation=None, final_status="PENDING", needs_model=True,
                itp_model=None,itp_coq=None,itp_kernel=None,itp_binding=None)
    # The original native report is already indexed by source hash; branch decisions
    # belong to the native run and are not added twice to ITP phase totals.
    orig=read(folder/"out/native/report.json")
    case,=orig["results"]
    item["branch_evaluation"]=branch_counts(case)
    committed=folder/"frozen-itp-evidence.json"
    completed=None
    snapshot_sha=fingerprint(committed) if committed.is_file() else None
    if snapshot_sha:
        previous=REFRESHED.get(h)
        completed=previous[1] if previous and previous[0]==snapshot_sha else read(committed)
    bound=folder/"legacy-verified-binding.json"
    binding=checked_binding(bound,row) if bound.is_file() else None
    first=folder/"current-itp/routes.json"
    direct_checks = [read(path) for path in folder.glob("legacy-negative-replay-*/itp/*proof/case_*/certificate-report.json")
                     if (path.parents[3]/"routes.json").is_file()]
    direct_negative = any(c.get("proof_status")=="VALID" and c.get("polarity")=="negative" for c in direct_checks)
    if completed:
        captured={r["report_sha256"] for r in completed["attempts"]}
        after=[p for pattern in ("current-itp","generated-itp","repair-itp","runtime-source-replay-*",
                                 "legacy-negative-replay-*","peer-positive-replay-*","peer-negative-replay-*")
               for p in folder.glob(pattern+"/routes.json")]
        # Late proof rounds, model receipts and resource-failure replays can
        # arrive after the original terminal status. Keep their costs even if
        # the new evidence does not change the verdict.
        failure_file = folder / "resource-failures.json"
        failure_events = read(failure_file)["events"] if failure_file.exists() else []
        peer_sources = {
            fingerprint(path): read(path.with_name("peer-source.json"))
            for path in after if path.with_name("peer-source.json").is_file()
        }
        recorded_peers = {attempt["report_sha256"]: attempt.get("replayed_peer")
                          for attempt in completed["attempts"]}
        refreshed = (
            any(fingerprint(p) not in captured for p in after)
            or any(recorded_peers.get(report_sha) != source
                   for report_sha, source in peer_sources.items())
            or any(step["stage"] == "compile_Candidate.v" and "candidate_resource_policy" not in step
                   for check in completed["checks"] for step in check["stages"])
            or len(list(folder.glob("model-receipts/*.json"))) != len(completed.get("model_attempts", []))
            or any("receipt_sha256" not in model for model in completed.get("model_attempts", []))
            or failure_events != completed.get("resource_failures", [])
            or [read(p) for p in sorted(folder.glob("memory-limit-replay-*/receipt.json"))]
                != completed.get("resource_protection_replays", [])
            or [read(p) for p in sorted(folder.glob("resource-replay-*/receipt.json"))]
                != completed.get("resource_replays", [])
        )
        if refreshed:
            latest=gather(folder,row,base)
            if latest is not None:
                completed=latest
    if not completed and first.is_file():
        local=read(first)
        single,=local["cases"]
        if local["native_report_sha256"]!=h or single["case_id"]!=row["executor_case_id"]:
            raise ValueError(f"initial attempt bound to other execution: {h}")
        if single["itp_status"] in ("PASS","FAIL","CRASH") or binding or direct_negative:
            completed=gather(folder,row,base)
    elif not completed and direct_negative:
        completed=gather(folder,row,base)
    if completed and completed.get("resource_protection_replays"):
        # A captured pre-policy receipt can already list the replay but exclude
        # it from its totals. Detect that through raw stage sums on every read.
        def protected_totals_agree(item):
            stages = [stage for check in item["checks"] for stage in check["stages"]]
            stages.extend(stage for rep in item["resource_protection_replays"] for stage in rep["stages"])
            for label, is_kernel in (("itp_coq", False), ("itp_kernel", True)):
                parts = [stage for stage in stages if stage["stage"].startswith("kernel_replay") == is_kernel]
                total = item[label]
                rss = [part["max_process_rss_kib"] for part in parts]
                if (abs(sum(part["wall_seconds"] for part in parts) - total["wall_seconds"]) > 1e-6
                        or total["max_process_rss_kib"] != (max(rss) if rss and None not in rss else None)):
                    return False
            return True

        if not protected_totals_agree(completed):
            completed = gather(folder, row, base)
            if completed is None or not protected_totals_agree(completed):
                raise ValueError("Protected replay costs differ from original stage receipts " + h)
    if completed:
        if any(completed[k]!=row[k] for k in ("variant","case","strategy","input_sha256","goal_sha256","executed_source_sha256")):
            raise ValueError("different proof receipt")
        if snapshot_sha:
            REFRESHED[h] = (snapshot_sha, completed)
        item.update(completed)
        item["cost_basis"]="new_execution"
    if binding:
        status=binding["final_status"]
        if item["final_status"] in ("PASS","FAIL","CRASH") and item["final_status"]!=status:
            raise ValueError(f"conflicting decisions for {h}")
        item["needs_model"]=False
        item["final_status"]=status
        for stage in ("itp_model","itp_coq","itp_kernel"):
            if item.get(stage) is None:
                item[stage]=no_stage(stage=="itp_model")
        item["itp_binding"]=dict(invoked=True,**binding["binding_cost"])
        item["shared_check"]={"id":binding["shared_check_id"],"proof_key":binding["new_proof_key"],
            "old_native_report_sha256":binding["old_native_report_sha256"],"old_receipt":binding["old_receipt"],
            "proof_status":binding["proof_status"],"polarity":binding["polarity"],"roots":binding["checked_roots"],
            "kernel_replay_mode":binding["kernel_replay_mode"],"assumptions":binding["assumptions"],
            "unexpected_assumptions":binding["unexpected_assumptions"],"assumptions_audited_goals":binding["assumptions_audited_goals"],
            "original_vc_judgement":binding["original_vc_judgement"],"execution_counterexample":binding["execution_counterexample"],
            "archive":binding["archived_source"]["archive_receipt"],**binding["cold_check"]}
        item["cost_basis"]="new_stages_plus_measured_binding; referenced cold proof charged separately by shared_check.id"
    if not item["needs_model"]:
        final=item["final_status"]
        item["expected_match"]=(final in ("PASS","FAIL") and final==row["expected"]
                              or final=="CRASH" and item.get("expected_crash_match") is True)
    else:
        item["expected_match"]=None
    return item


def publish(scratch):
    queue_path=scratch/"queue.json"
    queue=read(queue_path)
    if queue["schema"]!="tespec-latest-itp-queue/v1":
        raise ValueError("unknown cohort")
    groups=defaultdict(dict)
    for row in queue["executions"]:
        g=row["group"]
        h=row["native_report_sha256"]
        if h in groups[g]:raise ValueError("duplicate single-case report")
        groups[g][h]=collect(row,scratch,RESULTS/g)
    totals=Counter()
    queue_sha=fingerprint(queue_path)
    for entry in read(RESULTS/"group-result-cost-index.json")["groups"]:
        g=entry["program_group"]
        data=groups[g];statuses=Counter(r["final_status"] for r in data.values())
        totals.update(statuses)
        output=RESULTS/g/"tespec/latest-itp.json"
        value={"schema":"tespec-latest-itp/v1","group":g,
             "cost_scope":{
                 "itp_model":"All metered model CLI attempts for this execution.",
                 "queue_and_elapsed":"Stage wall_seconds starts after resource-slot admission. Waiting is reported in queue_seconds. The outer attempts[].wall_seconds is end-to-end elapsed time, including waits and orchestration; it is separate from phase costs.",
                 "itp_coq_and_itp_kernel":"Sum of checks[].stages and resource_protection_replays[].stages in locally completed proof rounds, partitioned by stage. Separately referenced shared checks and resource_replays are outside these totals.",
                 "resource_protection_replays":"All measured stages of these additional identical-input replays are already included once in itp_coq and itp_kernel. Each links to its prior attempt by original_attempt_sha256.",
                 "resource_replays":"If an interrupted original lost its RSS, its additional replay is recorded here. itp_coq_comparable substitutes the matched replay; itp_coq_total_observed_wall_seconds adds both attempts.",
                 "itp_binding_and_shared_check":"itp_binding measures matching to archived evidence. Charge the referenced cold proof once by shared_check.id when comparing cohorts."
             },
             "queue_sha256":queue_sha,"total_matrix_executions":queue["total_matrix_executions"],
             "required":len(data),"observed":sum(not x["needs_model"] for x in data.values()),
             "statuses":dict(statuses),"executions":data}
        if not output.is_file() or read(output)!=value:
            save(output,value)
    return totals


def main():
    a=argparse.ArgumentParser(description=__doc__)
    a.add_argument("--scratch",type=Path,required=True)
    a.add_argument("--watch",action="store_true")
    args=a.parse_args()
    previous=None
    while True:
        with (args.scratch/"latest-publish.lock").open("a") as lock:
            fcntl.flock(lock, fcntl.LOCK_EX)
            observed=publish(args.scratch)
        if previous!=observed:
            print(dict(observed),flush=True)
            previous=observed
        if not args.watch:
            break
        if not observed.get("PENDING"):
            # A shared proof can be checked while a different historical
            # candidate is still being measured for the same input.
            rows = read(args.scratch / "queue.json")["executions"]
            busy = False
            for row in rows:
                folder = args.scratch / row["native_report_sha256"]
                if not (folder / "current-itp/routes.json").is_file():
                    busy = True
                    break
                for prefix, receipt in (("generated-itp", "routes.json"), ("repair-itp", "routes.json"),
                        ("peer-*-replay-*", "routes.json"), ("legacy-negative-replay-*", "routes.json"),
                        ("runtime-source-replay-*", "routes.json"), ("memory-limit-replay-*", "receipt.json"),
                        ("resource-replay-*", "receipt.json")):
                    if any(p.is_dir() and not (p / receipt).is_file() for p in folder.glob(prefix)):
                        busy = True
                        break
                if busy:
                    break
            if not busy:
                break
        time.sleep(45)


if __name__=="__main__":
    main()
