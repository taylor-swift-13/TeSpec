#!/usr/bin/env python3
"""Compile and independently replay the paper's mechanized semantic core."""

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import time

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--switch", default="qcp-8.20")
    args = parser.parse_args()
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    out.mkdir(parents=True, exist_ok=True)
    modules = [
        ("InstanceChecking", 8),
        ("CallFrames", 13),
        ("LeastRootRewrite", 1),
        ("LayoutBridge", 18),
        ("PreconditionOracle", 4),
        ("AffineOffsets", 10),
        ("HeapObservation", 9),
        ("ClosedListEquality", 5),
        ("WitnessInhabitance", 7),
        ("DefinitionNormalization", 7),
    ]
    sources = {}
    for module, _ in modules:
        source = ROOT / "paper/theory" / (module + ".v")
        target = out / source.name
        shutil.copyfile(source, target)
        sources[module] = hashlib.sha256(target.read_bytes()).hexdigest()
    prefix = ["opam", "exec", "--switch=" + args.switch, "--"]
    rows = []
    commands = [("version", prefix + ["coqc", "--version"])]
    for module, _ in modules:
        commands.extend(
            [
                (
                    "compile_" + module,
                    prefix + ["coqc", "-Q", str(out), "TeSpecTheory", module + ".v"],
                ),
                (
                    "kernel_replay_" + module,
                    prefix
                    + [
                        "coqchk",
                        "-Q",
                        str(out),
                        "TeSpecTheory",
                        "TeSpecTheory." + module,
                    ],
                ),
            ]
        )
    for name, command in commands:
        start = time.monotonic()
        with (out / (name + ".log")).open("w") as log:
            result = subprocess.run(
                command, cwd=out, stdout=log, stderr=subprocess.STDOUT, timeout=120
            )
        rows.append(
            {
                "stage": name,
                "command": command,
                "exit_code": result.returncode,
                "wall_seconds": time.monotonic() - start,
            }
        )
        if result.returncode:
            break
    checked = []
    for module, expected in modules:
        log = out / ("compile_" + module + ".log")
        compiled = log.read_text() if log.exists() else ""
        closed = compiled.count("Closed under the global context")
        checked.append(
            {
                "module": module,
                "source_sha256": sources[module],
                "principal_theorems_closed": closed,
                "expected_closed": expected,
            }
        )
    passed = (
        len(rows) == len(commands)
        and all(r["exit_code"] == 0 for r in rows)
        and all(m["principal_theorems_closed"] == m["expected_closed"] for m in checked)
    )
    report = {
        "schema": "tespec-theory-replay/v1",
        "scope": "execution core, scalar-cell calls, arithmetic rewriting, layout bridge, initial-VC polarity, exact local-frame observations, closed list equality typed-witness inhabitance and budgeted definition normalization; not C implementation refinement",
        "modules": checked,
        "principal_theorems_closed": sum(
            m["principal_theorems_closed"] for m in checked
        ),
        "passed": passed,
        "stages": rows,
    }
    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
    return 0 if passed else 1


if __name__ == "__main__":
    raise SystemExit(main())
