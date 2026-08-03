#!/usr/bin/env python3
"""Public syntax-only checker for bidirectional synthesis submissions."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile
from typing import Any


ROOT = Path(__file__).resolve().parents[3]
TARGET = Path(__file__).resolve().parent

for import_root in (ROOT, TARGET):
    if str(import_root) not in sys.path:
        sys.path.insert(0, str(import_root))

from spectest.core import (  # noqa: E402
    JobError,
    analyze_source,
    attach_spec_to_source,
    run_job,
)
from state_adapter import StateBindingError, candidate_field_binders  # noqa: E402


def result(valid: bool, stage: str, diagnostic: str = "") -> dict[str, Any]:
    return {
        "schema": "tespec-syntax-check/v1",
        "syntax_valid": valid,
        "stage": stage,
        "diagnostic": diagnostic[:1200],
    }


def check_spec(
    implementation: Path, specification: Path, function: str
) -> dict[str, Any]:
    try:
        source = implementation.read_text(encoding="utf-8")
        spec = specification.read_text(encoding="utf-8")
        combined = attach_spec_to_source(source, spec, function)
        analysis = analyze_source(combined, function)
        if not analysis["supported"]:
            return result(
                False,
                "analyze",
                str(analysis.get("unsupported_reason") or "unsupported QCP binding"),
            )
        if function == "ModeConvert_AMMFun":
            try:
                candidate_field_binders(spec)
            except StateBindingError as error:
                return result(False, "state-interface", str(error))
    except (JobError, OSError, UnicodeError) as error:
        return result(False, "analyze", str(error))

    with tempfile.TemporaryDirectory(prefix="tespec-public-spec-syntax-") as temp:
        root = Path(temp)
        source_path = root / "impl.c"
        spec_path = root / "candidate.qcp"
        job_path = root / "job.json"
        source_path.write_text(source, encoding="utf-8")
        spec_path.write_text(spec, encoding="utf-8")
        job_path.write_text(
            json.dumps(
                {
                    "source": str(source_path),
                    "spec_file": str(spec_path),
                    "function": function,
                    "binds": analysis["binds_template"],
                }
            ),
            encoding="utf-8",
        )
        try:
            report = run_job(job_path, root / "output")
        except (JobError, OSError) as error:
            return result(False, "qcp-parse", str(error))
        first = report["results"][0]
        if first["status"] != "ERROR":
            return result(True, "qcp-parse")
        diagnostic = first.get("error") or first.get("reason") or "QCP parse failed"
        stderr_path = first.get("stderr")
        if isinstance(stderr_path, str) and Path(stderr_path).is_file():
            diagnostic += "\n" + Path(stderr_path).read_text(
                encoding="utf-8", errors="replace"
            )
        return result(False, "qcp-parse", diagnostic)


def check_code(interface: Path, code: Path, function: str) -> dict[str, Any]:
    try:
        interface_text = interface.read_text(encoding="utf-8")
        code_text = code.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as error:
        return result(False, "read", str(error))
    if "/*@" in code_text:
        return result(False, "policy", "generated C must not contain a QCP annotation")
    definition = re.compile(
        rf"\b{re.escape(function)}\s*\([^;{{}}]*\)\s*\{{",
        re.DOTALL,
    )
    if definition.search(code_text) is None:
        return result(False, "interface", f"missing definition of {function}")
    with tempfile.TemporaryDirectory(prefix="tespec-public-code-syntax-") as temp:
        source = Path(temp) / "candidate.c"
        source.write_text(interface_text + "\n" + code_text, encoding="utf-8")
        completed = subprocess.run(
            ["cc", "-std=c11", "-fsyntax-only", str(source)],
            capture_output=True,
            text=True,
            check=False,
        )
    if completed.returncode == 0:
        return result(True, "c-parser")
    return result(False, "c-parser", completed.stderr)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("direction", choices=("code-to-spec", "spec-to-code"))
    parser.add_argument("--submission", type=Path, required=True)
    parser.add_argument("--implementation", type=Path)
    parser.add_argument("--interface", type=Path)
    parser.add_argument("--function", default="ModeConvert_AMMFun")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    if args.direction == "code-to-spec":
        implementation = args.implementation or TARGET / "input/impl.c"
        report = check_spec(implementation, args.submission, args.function)
    else:
        interface = args.interface or TARGET / "input/interface.h"
        report = check_code(interface, args.submission, args.function)
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if report["syntax_valid"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
