"""Remeasure unchanged ITP checks whose original stage lost peak RSS on timeout."""
import argparse
import os
import re
import subprocess
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import shutil

from organize_tespec_routes import RESULTS, fingerprint, read, save
from spectest.certificates import check_certificate


def replay(item):
    folder, bundle, attempt_file, row, check, protected = item
    source = bundle.parent
    sha = fingerprint(attempt_file)
    work = folder / (("memory-limit-replay-" if protected else "resource-replay-") + sha)
    receipt = work / "receipt.json"
    if receipt.is_file():
        return
    if work.exists():
        raise ValueError("Interrupted resource replay needs inspection: " + str(work))
    manifest_hash = check["manifest_sha256"]
    spec = read(bundle)
    if (fingerprint(bundle) != manifest_hash or spec["original_goal_sha256"] != row["goal_sha256"]
            or fingerprint(source / "Candidate.v") != check["candidate_sha256"]
            or fingerprint(folder / "out/native/report.json") != row["native_report_sha256"]):
        raise ValueError("Original Coq inputs changed")
    for name in [*spec["immutable_sha256"], "manifest.json", "Candidate.v",
                 *(dep["file"] for dep in spec["dependencies"])]:
        dest = work / name
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source / name, dest)
    # Same fixed timeout as the original route, including its measured source precheck.
    audit = check_certificate(work / "manifest.json", manifest_hash, timeout=600, measure_candidate_precheck=True)
    stages = []
    for step in audit["stages"]:
        rss = (step.get("resources") or {}).get("max_process_rss_kib")
        if rss is None:
            raise ValueError("Replay did not measure RSS for " + step["stage"])
        stages.append({"stage": step["stage"], "exit_code": step["exit_code"],
                       "wall_seconds": step["wall_seconds"], "max_process_rss_kib": rss,
                       "log_sha256": fingerprint(step["log"]),
                       **{k:step[k] for k in ("queue_seconds", "address_space_limit_bytes", "measured_command", "resource_failure") if k in step}})
    save(receipt, {"schema":"tespec-itp-resource-replay/v1", "original_attempt_sha256":sha,
                   "original_goal_sha256":row["goal_sha256"], "native_report_sha256":row["native_report_sha256"],
                   "manifest_sha256":manifest_hash, "candidate_sha256":audit["candidate_sha256"],
                   "model_calls":0, "tokens":0, "reason":audit["reason"], "status":audit["status"],
                   "kind":"protected_identical_input_replay" if protected else "recovered_measurement",
                   "stages":stages})
    print(row["case"], row["strategy"], sha[:10], audit["reason"], flush=True)


def resource_event(check, folder, kernel_kills, boot):
    for step in check["stages"]:
        if step["stage"] != "compile_Candidate.v" or step["exit_code"] not in (137, 143, -9, -15):
            continue
        log = Path(step["log"])
        mtime = log.with_suffix(".resources.json").stat().st_mtime
        peak = (step.get("resources") or {}).get("max_process_rss_kib")
        record = {"stage":step["stage"], "manifest_sha256":check["manifest_sha256"],
                  "candidate_sha256":check["candidate_sha256"], "exit_code":step["exit_code"],
                  "command":step["command"], "wall_seconds":step["wall_seconds"], "max_process_rss_kib":peak,
                  "stderr_sha256":fingerprint(log), "resource_receipt_end_unix":mtime,
                  "address_space_limit_bytes":step.get("address_space_limit_bytes"), "proof_judgement":"UNKNOWN"}
        if log.with_name("candidate-emergency-stop.json").exists():
            record.update(reason="uncapped_candidate_stopped_to_protect_host",
                          monitor=read(log.with_name("candidate-emergency-stop.json")))
            return record
        close = [(stamp, line) for stamp,line in kernel_kills if abs(stamp - (mtime - boot)) < 8]
        if step["exit_code"] in (137,-9) and len(close) == 1:
            stamp, message = close[0]
            record.update(reason="host_oom_kill", kernel_event=message,
                          resource_end_minus_kernel_event_seconds=round(mtime - boot - stamp,3),
                          kernel_attribution="One Coq OOM kill in the resource receipt time window")
            return record
    return None


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--workers", type=int, default=2)
    parser.add_argument("--resource-failures", action="store_true",
                        help="Record kernel OOM evidence and recheck affected candidates with the comparison memory cap")
    args = parser.parse_args()
    items = []
    if args.resource_failures:
        slots = args.scratch / "resource-slots"
        slots.mkdir(exist_ok=True)
        os.environ["TESPEC_ITP_RESOURCE_DIR"] = str(slots.resolve())
        lists = [args.scratch / "queue.json"]
        boot = time.time() - float(Path("/proc/uptime").read_text().split()[0])
        log = subprocess.run(["dmesg"], capture_output=True, text=True, check=True).stdout
        kernel_kills = [(float(match[1]), text) for text in log.splitlines()
                        if (match := re.match(r"^\[\s*([0-9.]+)\].*Out of memory: Killed process [0-9]+ \(coqc\)", text))]
    else:
        lists = RESULTS.glob("*/tespec/current-executions.json")
    for current in lists:
        for row in read(current)["executions"]:
            if row["auto_status"] == "NOT_RUN":
                continue
            folder = args.scratch / row["native_report_sha256"]
            events = []
            for attempt_file in sorted(folder.glob("*itp/itp/**/attempt-*/attempt.json")):
                check = read(attempt_file)["check"]
                if args.resource_failures:
                    event = resource_event(check, folder, kernel_kills, boot)
                    if event is None:
                        continue
                    events.append(event)
                elif not any(s["exit_code"] == "TIMEOUT" and not s.get("resources") for s in check["stages"]):
                    continue
                stage_dir = next(p for p in attempt_file.parents if p.name == "itp")
                matches = [b for b in stage_dir.glob("*proof/case_*/manifest.json")
                           if fingerprint(b) == check["manifest_sha256"]]
                if len(matches) != 1:
                    raise ValueError("Missing or ambiguous original Coq bundle")
                items.append((folder, matches[0], attempt_file, row, check, args.resource_failures))
            if events:
                save(folder / "resource-failures.json", {"schema":"tespec-itp-process-failures/v1","events":events})
    print("unchanged candidates requiring a resource replay", len(items), flush=True)
    with ThreadPoolExecutor(args.workers) as pool:
        list(pool.map(replay, items))


if __name__ == "__main__":
    main()
