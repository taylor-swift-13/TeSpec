#!/usr/bin/env python3
"""Replay one archived standalone QCP primary without changing the benchmark."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import time

ROOT = Path(__file__).resolve().parents[2]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def checked(ref):
    path = ROOT / ref["path"]
    if sha(path) != ref["sha256"]:
        raise ValueError(f"artifact hash mismatch: {path}")
    return path


def replay(group, scratch, compiler_dir):
    directory = ROOT / "benchmark/results" / group / "qcp/standalone"
    evidence = json.loads((directory / "receipt.json").read_bytes())
    checked(evidence["binary"])
    checked(evidence["source"])
    scratch.mkdir(parents=True, exist_ok=False)
    (scratch / "vc").mkdir()
    costs = []

    def execute(stage, args):
        stdout, stderr, meter = (scratch / f"{stage}.{ext}" for ext in ("out", "err", "rss"))
        start = time.monotonic()
        with stdout.open("wb") as out, stderr.open("wb") as err:
            result = subprocess.run(["/usr/bin/time", "-q", "-o", meter, "-f", "%M", *args],
                                    cwd=scratch, stdout=out, stderr=err)
        costs.append(dict(stage=stage, exit_code=result.returncode, wall_seconds=time.monotonic()-start,
                          max_process_rss_kib=int(meter.read_text()), tokens=0, model_calls=0))
        (scratch / "cost.json").write_text(json.dumps(costs, indent=2) + "\n")
        return result.returncode

    cmd = [arg.replace("$REPO", str(ROOT)).replace("$WORK", str(scratch)) for arg in evidence["command"]]
    code = execute("native", cmd)
    if code != evidence["native"]["exit"]:
        raise ValueError("native result changed")
    if code:
        actual = re.sub(r"\x1b\[[0-9;]*m", "", (scratch / "native.err").read_text())
        if actual[:950].replace(str(ROOT) + "/", "") != evidence["diagnostic"]:
            raise ValueError("native diagnostic changed")
        return
    goal, = (scratch / "vc").glob("*_goal.v")
    checked(evidence["goal"])
    if sha(goal) != evidence["goal"]["sha256"]:
        raise ValueError("generator produced different original obligations")
    shutil.copyfile(goal, scratch / "Primary.v")
    candidate = checked(evidence["certificate"])
    shutil.copyfile(candidate, scratch / candidate.name)
    runtime = ROOT / "runtime/qcip/SeparationLogic"
    environment = evidence["runtime"]
    project = checked(environment["coq_project"])
    for tool in ("coqc", "coqchk"):
        if sha(compiler_dir / tool) != environment[f"{tool}_sha256"]:
            raise ValueError(f"Coq tool differs from the measured build: {tool}")
    tokens = shlex.split(project.read_text())
    flags = [str(runtime / t) if i % 3 == 1 else t for i, t in enumerate(tokens)]
    flags.extend(["-Q", str(scratch), ""])
    sources = []
    for ref in evidence["helpers"]:
        helper = checked(ref)
        if helper.is_relative_to(runtime / "examples/QCP_demos_human"):
            lib = scratch / "runtime"
            lib.mkdir(exist_ok=True)
            flags.extend(["-Q", str(lib), "SimpleC.EE.QCP_demos_human"])
            path = lib / helper.name
        else:
            path = scratch / helper.name
        shutil.copyfile(helper, path)
        sources.append(path)
    for path in [*sources, scratch / "Primary.v", scratch / candidate.name]:
        if execute(path.stem, [compiler_dir / "coqc", "-q", *flags, path]):
            raise ValueError(f"Coq compilation failed: {path.name}")
    if sha(scratch / f"{candidate.stem}.out") != evidence["audit_stdout_sha256"]:
        raise ValueError("proof assumption audit changed")
    if execute("kernel", [compiler_dir / "coqchk", "-silent", *flags, candidate.stem]):
        raise ValueError("independent kernel check failed")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--group", required=True)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--compiler-dir", type=Path, default=Path("/home/yangfp/.opam/qcp-8.20/bin"))
    options = parser.parse_args()
    replay(options.group, options.scratch.resolve(), options.compiler_dir.resolve())
