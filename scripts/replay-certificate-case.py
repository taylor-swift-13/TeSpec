#!/usr/bin/env python3
"""Regenerate an instance's VCs and independently replay its archived proof."""

import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from spectest.certificates import check_certificate, prepare_certificate  # noqa: E402
from spectest.run_certificates import (  # noqa: E402
    check_run_certificates,
    prepare_run_certificates,
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--case", required=True, type=Path)
    parser.add_argument("--switch", default="qcp-8.20")
    parser.add_argument("--timeout", default=300, type=float)
    parser.add_argument("--qcp-binary", type=Path)
    parser.add_argument("--qcip-root", type=Path)
    parser.add_argument(
        "--run-level",
        action="store_true",
        help="replay through the whole-run controller, including initial UNSAT merging",
    )
    args = parser.parse_args()
    output = args.output.resolve()
    if output.exists() and any(output.iterdir()):
        parser.error("output must be empty")
    output.mkdir(parents=True, exist_ok=True)
    inputs = args.case.resolve()
    case = json.loads((inputs / "certificate-case.json").read_text())
    mode = case.get("execution_mode", "expand")
    if mode not in {"expand", "no-expand"}:
        parser.error("case execution_mode must be expand or no-expand")
    arch = case.get("architecture_bits", 32)
    if type(arch) is not int or arch not in (32, 64):
        parser.error("case architecture_bits must be 32 or 64")
    command = [
        sys.executable,
        "-m",
        "spectest",
        "run",
        str((inputs / case["source"]).resolve()),
        "--function",
        case["function"],
        "--binds",
        str((inputs / case["bindings"]).resolve()),
        "--output-dir",
        str(output / "automatic"),
        "--execution-mode",
        mode,
        "--architecture-bits",
        str(arch),
    ]
    for option, path in (
        ("--qcp-binary", args.qcp_binary),
        ("--qcip-root", args.qcip_root),
    ):
        if path is not None:
            command.extend((option, str(path.resolve())))
    with (output / "automatic.log").open("w") as stream:
        process = subprocess.run(
            command, cwd=ROOT, stdout=stream, stderr=subprocess.STDOUT
        )
    manifests = list((output / "automatic/artifacts").glob("*/vc/manifest.json"))
    automatic_path = output / "automatic/report.json"
    automatic = (
        json.loads(automatic_path.read_text()) if automatic_path.exists() else {}
    )
    results = automatic.get("results", [])
    if (
        process.returncode not in {0, 1}
        or len(manifests) != 1
        or len(results) != 1
        or not (
            (
                results[0].get("scope") == "execution"
                and results[0].get("execution_completed") is True
            )
            or (
                results[0].get("scope") == "specification-only"
                and all(
                    results[0].get("phases", {}).get(phase) == "NOT_RUN"
                    for phase in ("execution", "safety", "postcondition", "annotations")
                )
            )
        )
        or results[0].get("mode") != mode
        or results[0].get("architecture_bits") != arch
        or results[0].get("status") not in {"PASS", "UNKNOWN"}
    ):
        raise RuntimeError(
            "automatic run failed or did not produce exactly one VC group"
        )
    if args.run_level:
        prepared = prepare_run_certificates(
            automatic_path,
            output / "proof",
            refute_preconditions={results[0]["id"]} if case.get("refute") else None,
        )
        request = json.loads(Path(prepared["manifest"]).read_text())
        if len(request["certificates"]) != 1:
            raise RuntimeError("replay requires exactly one eligible proof case")
        entry = request["certificates"][0]
        if entry.get("refute_precondition") != case.get("refute"):
            raise RuntimeError("archived refutation is not the original initial VC")
        editable = entry["editable"]
    else:
        prepared = prepare_certificate(
            manifests[0], output / "certificate", refute=case.get("refute")
        )
        editable = prepared["editable"]
    # This controller holds the digest before placing the editable proof.
    (output / "controller-request.json").write_text(
        json.dumps(prepared, indent=2) + "\n"
    )
    shutil.copyfile(
        inputs / "Candidate.v",
        editable,
    )
    checker = check_run_certificates if args.run_level else check_certificate
    report = checker(
        Path(prepared["manifest"]),
        prepared["manifest_sha256"],
        switch=args.switch,
        timeout=args.timeout,
    )
    print(json.dumps(report, indent=2))
    expected = (
        ("INVALID" if args.run_level else "UNKNOWN") if case.get("refute") else "PASS"
    )
    status = report["results"][0]["status"] if args.run_level else report["status"]
    if case.get("refute") and not args.run_level:
        return (
            0
            if (
                status == "UNKNOWN"
                and report.get("proof_status") == "VALID"
                and report.get("polarity") == "negative"
                and report.get("refuted_goal") == case["refute"]
            )
            else 1
        )
    return 0 if status == expected else 1


if __name__ == "__main__":
    raise SystemExit(main())
