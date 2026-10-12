#!/usr/bin/env python3
"""Regenerate a layout interpretation and replay an archived Rocq model probe."""

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from spectest.core import _coq_load_path_args  # noqa: E402
from spectest.layout import generate_layout_source  # noqa: E402


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--case", type=Path, required=True)
    parser.add_argument("--qcip-root", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--switch", default="qcp-8.20")
    parser.add_argument("--timeout", type=float, default=1200)
    args = parser.parse_args()
    source = args.case.resolve()
    output = args.output.resolve()
    if output.exists() and any(output.iterdir()):
        parser.error("output must be empty")
    archive = json.loads((source / "archive.json").read_text())
    for entry in archive["files"]:
        path = (source / entry["file"]).resolve()
        if not path.is_relative_to(source):
            parser.error("archive path escapes case directory")
        if hashlib.sha256(path.read_bytes()).hexdigest() != entry["sha256"]:
            parser.error("archive digest mismatch: " + entry["file"])
    case = json.loads((source / "case.json").read_text())
    layout = json.loads((source / "target-layout.json").read_text())
    generated = generate_layout_source(layout)
    if generated != (source / "GeneratedLayout.v").read_text():
        parser.error("regenerated layout differs from archived interpretation")
    output.mkdir(parents=True, exist_ok=True)
    for path in source.glob("*.v"):
        shutil.copyfile(path, output / path.name)
    (output / "GeneratedLayout.v").write_text(generated)
    flags = _coq_load_path_args(args.qcip_root.resolve() / "SeparationLogic", output)
    stages = []

    def run(tool, modules, name, expected=0, diagnostic=None):
        command = ["opam", "exec", "--switch=" + args.switch, "--", tool]
        command.extend([*flags, *modules])
        started = time.monotonic()
        log_path = output / (name + ".log")
        with log_path.open("w") as log:
            try:
                result = subprocess.run(
                    command,
                    cwd=output,
                    stdout=log,
                    stderr=subprocess.STDOUT,
                    timeout=args.timeout,
                )
                code = result.returncode
            except subprocess.TimeoutExpired:
                code = None
        passed = code == expected and (
            diagnostic is None or diagnostic in log_path.read_text()
        )
        stages.append(
            {
                "stage": name,
                "command": command,
                "exit_code": code,
                "expected_exit": expected,
                "expected_diagnostic": diagnostic,
                "passed": passed,
                "wall_seconds": time.monotonic() - started,
            }
        )
        (output / "report.json").write_text(json.dumps(stages, indent=2) + "\n")
        if not passed:
            raise SystemExit("replay failed: " + name)

    for module in case["compile_modules"]:
        run("coqc", [module + ".v"], "compile_" + module)
    for rejection in case["rejections"]:
        module = rejection["module"]
        run(
            "coqc",
            [module + ".v"],
            "reject_" + module,
            expected=1,
            diagnostic=rejection["diagnostic"],
        )
    run("coqchk", case["kernel_modules"], "kernel_replay")
    print(json.dumps({"status": "PASS", "stages": len(stages)}))


if __name__ == "__main__":
    main()
