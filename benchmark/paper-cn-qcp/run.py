#!/usr/bin/env python3
"""Replay the paired dataset; correctness smoke checks, not isolated timings."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import signal
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def read(path):
    return json.loads(path.read_text())


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def c_body(text):
    # Expand benchmark ABI headers before comparing executable C and layouts.
    def include(match):
        name = match.group(1)
        for directory in [
            ROOT / "runtime/qcip/QCP_examples/QCP_demos_human",
            ROOT / "runtime/qcip/QCP_examples",
        ]:
            path = directory / name
            if path.is_file():
                return path.read_text()
        raise ValueError("unresolved ABI header: " + name)

    text = re.sub(r'^\s*#include\s+"([^"]+)"[^\n]*', include, text, flags=re.M)
    text = re.sub(r"/\*.*?\*/|//[^\n]*", "", text, flags=re.S)
    text = re.sub(r"^\s*#include[^\n]*", "", text, flags=re.M)
    return re.sub(r"\s+", "", text)


def main_source(subject, test, *, oracle=False):
    checks = ""
    if oracle:
        checks = (
            test.get("native_oracle_statements", "")
            + "\nif (!("
            + test["native_check"]
            + ")) return 12;\n"
        )
    return (
        subject
        + "\nint main(void)\n/*@ ensures return == 0; @*/\n{\n"
        + test["native_setup"]
        + "\n"
        + checks
        + "return 0;\n}\n"
    )


def execute(cmd, folder, name, timeout):
    log = folder / (name + ".log")
    start = time.monotonic()
    with log.open("w") as stream:
        p = subprocess.Popen(
            cmd,
            cwd=ROOT,
            stdout=stream,
            stderr=subprocess.STDOUT,
            start_new_session=True,
        )
        try:
            code = p.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            os.killpg(p.pid, signal.SIGKILL)
            p.wait()
            code = "TIMEOUT"
    return {
        "command": cmd,
        "returncode": code,
        "wall_seconds": round(time.monotonic() - start, 3),
        "log": str(log),
        "log_sha256": sha(log),
    }


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument(
        "--tools",
        default="native,qcp,fulminate",
        help="comma-separated native,qcp,fulminate,cn-verify",
    )
    ap.add_argument("--cases", nargs="*")
    ap.add_argument("--variants", nargs="+", default=["reference", "wrong_post"])
    ap.add_argument("--switch", default="tespec-cn-5.2")
    ap.add_argument("--timeout", type=int, default=60)
    args = ap.parse_args()
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        ap.error("use a fresh output directory")
    out.mkdir(parents=True, exist_ok=True)
    tools = args.tools.split(",")
    if set(tools) - {"native", "qcp", "fulminate", "cn-verify"}:
        ap.error("unknown tool")
    manifest = read(HERE / "manifest.json")
    entries = manifest["cases"] + manifest.get("expressibility_items", [])
    names = {r["id"] for r in entries}
    if args.cases and set(args.cases) - names:
        ap.error("unknown case")
    report = {
        "schema": "paired-dataset-smoke/v1",
        "dataset_sha256": sha(HERE / "manifest.json"),
        "purpose": "dataset validation; wall times are not isolated performance measurements",
        "cn_switch": args.switch,
        "qcp_binary_sha256": sha(ROOT / "bin/tespec-symexec"),
        "runs": [],
    }

    def save():
        (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")

    for entry in entries:
        if entry.get("included_in_paired_denominator") is False and not args.cases:
            continue
        if args.cases and entry["id"] not in args.cases:
            continue
        folder = HERE / entry["path"]
        case = read(folder / "case.json")
        cid = case["id"]
        for src in case["sources"]:
            if sha(HERE / src["path"]) != src["sha256"]:
                raise ValueError("changed original: " + src["path"])
        has_cn = (folder / "subject.cn.c").exists()
        ref = (folder / ("subject.cn.c" if has_cn else "subject.qcp.c")).read_text()
        for variant in args.variants:
            stem = "subject" if variant == "reference" else variant
            cnpath = folder / f"{stem}.cn.c"
            qpath = folder / f"{stem}.qcp.c"
            if not cnpath.exists() and not qpath.exists():
                continue
            cn = (cnpath if has_cn else qpath).read_text()
            if c_body(cn) != c_body(ref):
                raise ValueError(cid + ": variant changed C body")
            if qpath.exists() and c_body(cn) != c_body(qpath.read_text()):
                raise ValueError(cid + ": CN/QCP bodies differ")
            dest = out / cid / variant
            dest.mkdir(parents=True)
            for f in case.get("support_files", []):
                shutil.copy2(folder / f, dest / f)
            if qpath.exists():
                shutil.copy2(qpath, dest / "subject.qcp.c")
            # One QCP invocation covers all logical inputs, preserving per-input results.
            if "qcp" in tools and qpath.exists():
                bind = dest / "binds.json"
                bind.write_text(
                    json.dumps([t["qcp_bind"] for t in case["inputs"]], indent=2) + "\n"
                )
                cmd = [
                    sys.executable,
                    "-m",
                    "spectest",
                    "run",
                    str(dest / "subject.qcp.c"),
                    "--function",
                    case["function"],
                    "--binds",
                    str(bind),
                    "--output-dir",
                    str(dest / "qcp"),
                    "--execution-mode",
                    "expand",
                    "--loop-unroll-limit",
                    "128",
                    "--call-depth-limit",
                    "128",
                    "--timeout",
                    str(args.timeout),
                    "--compact",
                ]
                for d in case["qcp_include_dirs"]:
                    cmd += ["-I", str(ROOT / d)]
                row = execute(cmd, dest, "qcp", args.timeout * len(case["inputs"]) + 60)
                rp = dest / "qcp/report.json"
                row.update(case=cid, variant=variant, tool="qcp")
                if rp.exists():
                    r = read(rp)
                    row["summary"] = r.get("summary")
                    row["results"] = [
                        {
                            "id": x.get("id"),
                            "status": x.get("status"),
                            "test_result": x.get("test_result"),
                            "precondition_result": x.get("precondition_result"),
                            "reason": x.get("reason"),
                        }
                        for x in r.get("results", [])
                    ]
                report["runs"].append(row)
                save()
                print(
                    cid,
                    variant,
                    "qcp",
                    row.get("summary", row["returncode"]),
                    flush=True,
                )
            if "cn-verify" in tools and has_cn:
                target = dest / "verify.cn.c"
                target.write_text(cn)
                row = execute(
                    [
                        "opam",
                        "exec",
                        "--switch=" + args.switch,
                        "--",
                        "cn",
                        "verify",
                        "--only=" + case["function"],
                        str(target),
                    ],
                    dest,
                    "cn-verify",
                    args.timeout,
                )
                row.update(
                    case=cid,
                    variant=variant,
                    tool="cn-verify",
                    scope="universal verification; not an instance-test verdict",
                )
                report["runs"].append(row)
                save()
            for test in case["inputs"]:
                td = dest / test["id"]
                td.mkdir()
                source = td / "input.cn.c"
                source.write_text(main_source(cn, test))
                if "native" in tools and variant == "reference":
                    oracle_source = td / "oracle.c"
                    native_subject = re.sub(r"^\s*#include[^\n]*", "", cn, flags=re.M)
                    oracle_source.write_text(
                        main_source(native_subject, test, oracle=True)
                    )
                    for bits in [32, 64]:
                        exe = td / f"native{bits}"
                        row = execute(
                            [
                                "gcc",
                                "-std=c11",
                                "-fno-builtin",
                                "-Wall",
                                "-Wextra",
                                f"-m{bits}",
                                str(oracle_source),
                                "-o",
                                str(exe),
                            ],
                            td,
                            f"native{bits}-build",
                            args.timeout,
                        )
                        row.update(
                            case=cid,
                            variant=variant,
                            input=test["id"],
                            tool=f"native{bits}",
                        )
                        if row["returncode"] == 0:
                            row["execution"] = execute(
                                [str(exe)], td, f"native{bits}-run", args.timeout
                            )
                            row["oracle_pass"] = row["execution"]["returncode"] == 0
                        else:
                            row["oracle_pass"] = False
                        report["runs"].append(row)
                        save()
                if "fulminate" in tools and has_cn:
                    row = execute(
                        [
                            "opam",
                            "exec",
                            "--switch=" + args.switch,
                            "--",
                            "cn",
                            "instrument",
                            "--run",
                            "--cc=/usr/bin/gcc",
                            "--output-dir=" + str(td),
                            str(source),
                        ],
                        td,
                        "fulminate",
                        args.timeout,
                    )
                    log = (td / "fulminate.log").read_text(errors="replace")
                    code = row["returncode"]
                    # Exit 2 alone is not evidence of a violated contract.
                    status = (
                        "PASS"
                        if code == 0
                        else "FAIL"
                        if code == 2
                        and ("Failed at" in log or "CN assertion failed" in log)
                        else "TIMEOUT"
                        if code == "TIMEOUT"
                        else "ERROR"
                    )
                    row.update(
                        case=cid,
                        variant=variant,
                        input=test["id"],
                        tool="fulminate",
                        status=status,
                    )
                    report["runs"].append(row)
                    save()
                    print(cid, variant, test["id"], "fulminate", status, flush=True)
    save()
    failures = [r for r in report["runs"] if r.get("oracle_pass") is False]
    if failures:
        print("Native oracle failures:", len(failures), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
