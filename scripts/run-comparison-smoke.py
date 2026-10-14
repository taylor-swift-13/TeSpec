#!/usr/bin/env python3
"""Check the installed CN/Fulminate and TeSpec interfaces on a paired heap case.

This is an installation test, not a throughput or coverage experiment.
All tool outputs, including failed attempts, are retained in a fresh directory.
"""

import argparse
import hashlib
import json
import platform
from pathlib import Path
import re
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
INPUT = ROOT / "benchmark/comparison/smoke"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def body(source):
    source = re.sub(r"/\*.*?\*/", "", source, flags=re.S)
    source = re.sub(r"^#include.*$", "", source, flags=re.M)
    return re.sub(r"\s+", "", source)


def run(cmd, directory, name, *, cwd=ROOT, timeout=120):
    logpath = directory / (name + ".log")
    resources = directory / (name + ".resources.json")
    measured = [
        "/usr/bin/time",
        "--quiet",
        "-f",
        '{"user_seconds":%U,"system_seconds":%S,"max_process_rss_kib":%M}',
        "-o",
        str(resources),
        *cmd,
    ]
    start = time.monotonic()
    with logpath.open("w") as log:
        proc = subprocess.Popen(
            measured,
            cwd=cwd,
            stdout=log,
            stderr=subprocess.STDOUT,
            start_new_session=True,
        )
        try:
            code = proc.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            import os
            import signal

            os.killpg(proc.pid, signal.SIGKILL)
            proc.wait()
            code = "TIMEOUT"
    resource_data = None
    if resources.exists():
        try:
            resource_data = json.loads(resources.read_text())
        except json.JSONDecodeError:
            pass
    return {
        "command": cmd,
        "returncode": code,
        "wall_seconds": time.monotonic() - start,
        "log": str(logpath),
        "log_sha256": sha(logpath),
        "resources": resource_data,
    }


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument("--switch", default="tespec-cn-5.2")
    ap.add_argument("--case", type=Path, help="paired case directory with case.json")
    ap.add_argument("--mode", choices=("entry-exit", "all-boundaries", "expand", "no-expand"), default="entry-exit")
    args = ap.parse_args()
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        ap.error("output must be empty")
    out.mkdir(parents=True, exist_ok=True)
    cn_prefix = ["opam", "exec", "--switch=" + args.switch, "--", "cn"]
    inputs = args.case.resolve() if args.case else INPUT
    config = (
        json.loads((inputs / "case.json").read_text())
        if args.case
        else {
            "function": "bump",
            "category": "single_cell",
            "cn_mutation": ["w == v + 1", "w == v + 2"],
            "qcp_mutation": [
                "Ensure data_at(p, int, v + 1)",
                "Ensure data_at(p, int, v + 2)",
            ],
        }
    )
    function = config["function"]
    basename = "case" if args.case else "cell"
    cn_source = (inputs / f"{basename}.cn.c").read_text()
    qcp_source = (inputs / f"{basename}.qcp.c").read_text()
    for source, key in [(cn_source, "cn_mutation"), (qcp_source, "qcp_mutation")]:
        if source.count(config[key][0]) != 1:
            raise RuntimeError("mutation must match exactly one specification location")
    if body(cn_source) != body(qcp_source):
        raise RuntimeError("paired C bodies differ after removing annotations/includes")
    rows = []
    for variant in ("valid", "wrong_post"):
        directory = out / variant
        directory.mkdir()
        for relative in config.get("support_files", []):
            support = Path(relative)
            if support.is_absolute() or ".." in support.parts:
                raise ValueError("support file must be a relative fixture path")
            destination = directory / support
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.write_bytes((inputs / support).read_bytes())
        cs = directory / "cell.cn.c"
        qs = directory / "cell.qcp.c"
        cs.write_text(
            cn_source.replace(*config["cn_mutation"])
            if variant == "wrong_post"
            else cn_source
        )
        qs.write_text(
            qcp_source.replace(*config["qcp_mutation"])
            if variant == "wrong_post"
            else qcp_source
        )
        commands = {
            "cn_verify": cn_prefix + ["verify", "--only=" + function, str(cs)],
            "fulminate": cn_prefix
            + [
                "instrument",
                "--run",
                "--cc=/usr/bin/gcc",
                "--output-dir=" + str(directory),
                str(cs),
            ],
            "tespec": [
                sys.executable,
                "-m",
                "spectest",
                "run",
                str(qs),
                "--execution-mode",
                args.mode,
                "--function",
                function,
                "--binds",
                str(inputs / "binds.json"),
                "--output-dir",
                str(directory / "tespec"),
            ],
        }
        for include_dir in config.get("qcp_include_dirs", []):
            commands["tespec"].extend(
                ["--include-dir", str((ROOT / include_dir).resolve())]
            )
        for tool, cmd in commands.items():
            row = run(cmd, directory, tool)
            row.update(
                tool=tool,
                variant=variant,
                source_sha256=sha(qs if tool == "tespec" else cs),
            )
            text = Path(row["log"]).read_text()
            if tool == "tespec":
                report = directory / "tespec/report.json"
                summary = (
                    json.loads(report.read_text())["summary"] if report.exists() else {}
                )
                row["verdicts"] = summary
                expected = "PASS" if variant == "valid" else "UNKNOWN"
                row["expectation_met"] = summary.get(expected) == 1
            elif variant == "valid":
                row["expectation_met"] = row["returncode"] == 0
            elif tool == "fulminate":
                row["expectation_met"] = (
                    row["returncode"] == 2
                    and "Failed at" in text
                    and (
                        "function " + function in text
                        or config["cn_mutation"][1] in text
                    )
                )
            else:
                row["expectation_met"] = (
                    row["returncode"] == 1
                    and "Unprovable constraint" in text
                    and config["cn_mutation"][1] in text
                )
            rows.append(row)
            print(json.dumps(row), flush=True)
    version = subprocess.run(cn_prefix + ["--version"], capture_output=True, text=True)
    report = {
        "scope": "installation-smoke-not-performance",
        "case": inputs.name,
        "category": config["category"],
        "tespec_mode": args.mode,
        "bindings": json.loads((inputs / "binds.json").read_text()),
        "cn_version": version.stdout.strip(),
        "platform": platform.platform(),
        "paired_c_body_sha256": hashlib.sha256(body(cn_source).encode()).hexdigest(),
        "domain_note": "Fulminate: native main fixture; TeSpec: paired logical bindings, symbolic addresses; CN verify: entire precondition domain",
        "resource_scope": "GNU time, command and descendants, maximum process RSS",
        "expectations_met": sum(row["expectation_met"] for row in rows),
        "total": len(rows),
        "runs": rows,
    }
    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    return 0 if report["expectations_met"] == report["total"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
