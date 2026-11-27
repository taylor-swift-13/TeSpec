"""Replay positive model candidates whose original VC imports were not compiled."""
import argparse
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import shutil
import subprocess
import sys

from collect_current_itp import checkpoint
from organize_tespec_routes import RESULTS, ROOT, read, fingerprint
from spectest.proof_reuse import proof_key


def run_replay(folder, native, candidate, key, output_name):
    out = folder / output_name
    if not (out / "routes.json").is_file():
        if out.exists():
            raise RuntimeError("Interrupted source replay: " + str(out))
        cache = folder / ("source-replay-cache-" + fingerprint(candidate))
        cache.mkdir(exist_ok=True)
        shutil.copyfile(candidate, cache / (key + ".v"))
        proc = subprocess.run([sys.executable, "-B", "-m", "spectest", "routes", "--native-report",
                               str(native), "--route", "itp", "--proof-cache", str(cache),
                               "--itp-replay-only", "--output-dir", str(out)],
                              cwd=ROOT, capture_output=True, text=True)
        if not (out / "routes.json").is_file():
            raise RuntimeError(proc.stderr[-800:])
    data = read(out / "routes.json")
    if data["routes"]["itp"].get("model_calls") != 0 or data["native_report_sha256"] != folder.name:
        raise ValueError("Invalid frozen source replay")
    return data


def matched_positive_tasks(tasks):
    """Match all original goal, input, source, layout and runtime hashes through proof_key."""
    proven = {}
    pending = []
    for current, row, scratch in tasks:
        folder = scratch / row["native_report_sha256"]
        native = folder / "out/native/report.json"
        if fingerprint(native) != folder.name:
            raise ValueError("Frozen native report changed")
        report = read(native)
        case, = report["results"]
        published = read(current.with_name("current-itp.json"))["executions"][folder.name]
        bundles = [p for stage in ("current-itp", "generated-itp", "repair-itp")
                   for p in (folder / stage).glob("itp/proof/case_*/manifest.json")]
        if not bundles:
            continue
        key = proof_key(read(bundles[-1]), report, case)
        if not key:
            continue
        identity = (current.parents[1].name, key)
        if published["final_status"] == "PASS":
            for p in bundles:
                audit_file = p.with_name("certificate-report.json")
                if not audit_file.is_file():
                    continue
                audit = read(audit_file)
                candidate = p.with_name("Candidate.v")
                if (audit.get("status") == "PASS" and audit.get("polarity") == "positive"
                        and audit["manifest_sha256"] == fingerprint(p)
                        and audit["candidate_sha256"] == fingerprint(candidate)
                        and proof_key(read(p), report, case) == key):
                    proven[identity] = candidate
        elif all(not (folder / n).exists() or (folder / n / "routes.json").is_file()
                 for n in ("generated-itp", "repair-itp")):
            pending.append(((current, row, scratch), folder, native, identity))
    for task, folder, native, identity in pending:
        if identity in proven:
            candidate = proven[identity]
            yield task, folder, native, candidate, identity[1]


def check_matched_positive(task):
    _, folder, native, candidate, key = task
    out = "peer-positive-replay-" + fingerprint(candidate)
    result = run_replay(folder, native, candidate, key, out)
    print("matched", folder.name[:12], key[:12], result["cases"][0]["itp_status"], flush=True)
    return True


def replay(task):
    current, row, scratch = task
    folder = scratch / row["native_report_sha256"]
    native = folder / "out/native/report.json"
    if fingerprint(native) != row["native_report_sha256"]:
        raise ValueError("Native report changed")
    report = read(native)
    case, = report["results"]
    if not any(not dep.get("compiled") for dep in case["vc"]["runtime_dependencies"]):
        return False
    seen = set()
    for stage in ("generated-itp", "repair-itp"):
        directory = folder / stage
        if not (directory / "routes.json").is_file():
            continue
        for attempt_file in sorted(directory.glob("itp/case_*/attempt-*/attempt.json")):
            audit = read(attempt_file)["check"]
            if not any(s["stage"] == "compile_Goal.v" and s["exit_code"] != 0 for s in audit["stages"]):
                continue
            sha = audit["candidate_sha256"]
            if sha in seen:
                continue
            bundle_path, = directory.glob("itp/proof/case_*/manifest.json")
            bundle = read(bundle_path)
            candidate = bundle_path.with_name("Candidate.v")
            if bundle.get("refuted_goal") or fingerprint(candidate) != sha:
                continue
            if bundle["original_goal_sha256"] != row["goal_sha256"]:
                raise ValueError("Prior candidate is for a different original root")
            seen.add(sha)
            key = proof_key(bundle, report, case)
            if not key:
                raise ValueError("Original proof identity missing")
            data = run_replay(folder, native, candidate, key, "runtime-source-replay-" + stage + "-" + sha)
            print(current.parents[1].name, row["case"], row["strategy"], data["cases"][0]["itp_status"], flush=True)
    return bool(seen)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", required=True,type=Path)
    parser.add_argument("--workers",default=2,type=int)
    parser.add_argument("--matched-positive", action="store_true", help="Replay newly checked peer sources with identical proof keys")
    args=parser.parse_args()
    tasks=[(f,r,args.scratch) for f in sorted(RESULTS.glob("*/tespec/current-executions.json"))
           for r in read(f)["executions"] if r["auto_status"] != "NOT_RUN"]
    with ThreadPoolExecutor(args.workers) as pool:
        if args.matched_positive:
            matched = list(matched_positive_tasks(tasks))
            print("equivalent checked sources", len(matched), flush=True)
            results = zip((m[0] for m in matched), pool.map(check_matched_positive, matched))
        else:
            results = zip(tasks, pool.map(replay, tasks))
        for (f, row, scratch), retried in results:
            if retried:
                checkpoint(scratch, f, row)


if __name__=="__main__":
    main()
