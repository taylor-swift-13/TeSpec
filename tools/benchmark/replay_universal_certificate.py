#!/usr/bin/env python3
"""Meter a local replay of a content-addressed universal QCP certificate."""
import argparse
import hashlib
from pathlib import Path
import shlex
import shutil
import subprocess
from tempfile import TemporaryDirectory
import time

from meter_read_itp_coq import COQ, RUNTIME
from organize_tespec_routes import ROOT, RESULTS, read, save, reference, fingerprint


def checked(ref):
    path = ROOT / ref["path"]
    if fingerprint(path) != ref["sha256"]:
        raise ValueError(f"Changed certificate input: {path}")
    return path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--group", required=True)
    args = parser.parse_args()
    base = RESULTS / args.group / "qcp"
    result = read(base / "results.json")
    proof = read(checked(result["certificate"]))
    checked(proof["source"])
    for ref in proof["runtime_identity"]:
        checked(ref)
    targets = proof["targets"]
    if len(targets) != result["obligations"] or set(targets) != set(result["original_vc_correct_targets"]):
        raise ValueError("Incomplete original interface")
    inputs = [*proof["dependencies"], proof["goal"], proof["candidate"],
              *(v for k,v in proof["proof_files"].items() if k.endswith(".v"))]
    policy = checked(proof["assumption_differential"])
    dest = base / "proof/local-replay.json"
    if dest.exists():
        raise FileExistsError(f"Existing measurement: {dest}")
    record = {"schema":"qcp-local-certificate-replay/v1", "certificate":result["certificate"],
              "targets":targets, "assumption_policy":reference(policy), "model_calls":0, "tokens":0, "stages":[]}
    parts = shlex.split((RUNTIME / "_CoqProject").read_text())
    flags = [str(RUNTIME / arg) if i % 3 == 1 else arg for i,arg in enumerate(parts)]
    with TemporaryDirectory() as tmp:
        work = Path(tmp)
        names = []
        for ref in inputs:
            p = checked(ref)
            if p.name not in names:
                shutil.copyfile(p, work / p.name)
                names.append(p.name)
        for name in names + ["kernel"]:
            kernel = name == "kernel"
            cmd = ([str(COQ / "coqchk"), "-silent", *flags, "-Q", str(work), "", "Candidate"] if kernel else
                   [str(COQ / "coqc"), *flags, "-Q", str(work), "", name])
            started = time.monotonic()
            proc = subprocess.run(["/usr/bin/time","-q","-f","%M","-o",str(work/"rss"), *cmd],
                                  cwd=work, capture_output=True)
            record["stages"].append({"stage":"kernel" if kernel else "coq", "file":name,
                "command":[s.replace(str(work),"<work>") for s in cmd], "exit_code":proc.returncode,
                "wall_seconds":time.monotonic()-started, "max_process_rss_kib":int((work/"rss").read_text()),
                "tokens":0, "stdout_sha256":hashlib.sha256(proc.stdout).hexdigest(),
                "stderr_sha256":hashlib.sha256(proc.stderr).hexdigest()})
            if not kernel and name in ("PerGoalAudit.v", "RuntimeAxiomAudit.v", "StatementAudit.v"):
                source_checks = next(a for a in proof["attempts"] if a["attempt"] == proof["selected_attempt"])["checks"]
                accepted_log = source_checks[-1]["source_logs"][name]
                record["stages"][-1]["matches_audited_output"] = record["stages"][-1]["stdout_sha256"] == accepted_log
                if not proc.returncode and not record["stages"][-1]["matches_audited_output"]:
                    record.update(status="ASSUMPTION_AUDIT_CHANGED", diagnostic=name)
                    break
            if proc.returncode:
                record.update(status="REPLAY_FAILED", diagnostic=proc.stderr.decode(errors="replace")[-1400:].replace(str(work),"<work>"))
                break
        else:
            record["status"] = "KERNEL_REPLAYED"
    save(dest, record)
    print(args.group, record["status"], record.get("diagnostic",""), flush=True)
    return int(record["status"] != "KERNEL_REPLAYED")


if __name__ == "__main__":
    raise SystemExit(main())
