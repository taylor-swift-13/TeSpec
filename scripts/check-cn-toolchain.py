#!/usr/bin/env python3
"""Check installed CN/Fulminate and bundled generators; retain all attempts."""

import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools/benchmark"))
from cn_toolchain import CN, ENV, installed_identity  # noqa: E402


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--generators",
        action="store_true",
        help="Also probe input-generation engines; unsupported probes fail the check",
    )
    options = parser.parse_args()
    out = options.output.resolve()
    if not out.is_relative_to((ROOT / "benchmark/results").resolve()):
        parser.error("output must be under benchmark/results")
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty; preserve earlier attempts")
    identity = installed_identity()
    out.mkdir(parents=True, exist_ok=True)
    source = """void bump(int *p)
/*@ requires take v = RW<int>(p); 0 <= v; v < 100;
    ensures take w = RW<int>(p); w == v + 1; @*/
{ *p = *p + 1; }
int main(void) /*@ ensures return == 0; @*/
{ int value = 3; bump(&value); return 0; }
"""
    rows = []
    report = {
        "scope": "installation checks, not benchmark performance",
        "toolchain": identity,
        "runs": rows,
    }
    for variant in ("valid", "wrong_post"):
        path = out / (variant + ".cn.c")
        path.write_text(
            source if variant == "valid" else source.replace("w == v + 1", "w == v + 2")
        )
        modes = (
            ("verify", "instrument", "bennet", "darcy", "lucas")
            if options.generators
            else ("verify", "instrument")
        )
        for mode in modes:
            directory = out / (variant + "-" + mode)
            directory.mkdir()
            with tempfile.TemporaryDirectory(prefix="tespec-cn-smoke-") as tmp:
                if mode == "verify":
                    args = ["verify", str(path)]
                elif mode == "instrument":
                    args = [
                        "instrument",
                        "--run",
                        "--cc=/usr/bin/gcc",
                        "--output-dir=" + tmp,
                        str(path),
                    ]
                else:
                    args = [
                        "test",
                        mode,
                        "--cc=/usr/bin/gcc",
                        "--only=bump",
                        "--num-samples=5",
                        "--seed=0",
                        "--print-seed",
                        "--output-dir=" + tmp,
                        str(path),
                    ]
                command = [str(CN), *args]
                started = time.monotonic()
                with (
                    (directory / "stdout.log").open("wb") as stdout,
                    (directory / "stderr.log").open("wb") as stderr,
                ):
                    try:
                        result = subprocess.run(
                            command,
                            cwd=ROOT,
                            env=ENV,
                            stdout=stdout,
                            stderr=stderr,
                            timeout=120,
                        )
                        code = result.returncode
                    except subprocess.TimeoutExpired:
                        code = "TIMEOUT"
                rows.append(
                    {
                        "variant": variant,
                        "mode": mode,
                        "command": command,
                        "source_sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
                        "exit_code": code,
                        "wall_seconds": time.monotonic() - started,
                        "stdout": (directory / "stdout.log")
                        .relative_to(ROOT)
                        .as_posix(),
                        "stderr": (directory / "stderr.log")
                        .relative_to(ROOT)
                        .as_posix(),
                        "expected": "ACCEPT"
                        if variant == "valid"
                        else "REJECT_POSTCONDITION",
                    }
                )
                (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
                print(variant, mode, code, flush=True)
    for row in rows:
        stdout = (ROOT / row["stdout"]).read_text()
        stderr = (ROOT / row["stderr"]).read_text()
        if row["variant"] == "valid":
            row["expected_outcome_confirmed"] = row["exit_code"] == 0
        elif row["mode"] == "verify":
            row["expected_outcome_confirmed"] = (
                row["exit_code"] == 1
                and "Unprovable constraint" in stderr
                and "bump -- fail" in stdout
            )
        elif row["mode"] == "instrument":
            row["expected_outcome_confirmed"] = (
                row["exit_code"] == 2
                and "Failed at" in stdout
                and "function bump," in stdout
            )
        else:
            row["expected_outcome_confirmed"] = (
                row["exit_code"] == 1 and "failed: 1, errored: 0" in stdout
            )
    report["all_expected_outcomes_confirmed"] = all(
        row["expected_outcome_confirmed"] for row in rows
    )
    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    if not report["all_expected_outcomes_confirmed"]:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
