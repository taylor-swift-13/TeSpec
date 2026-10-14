#!/usr/bin/env python3
"""Replay list proof attempts with unchanged QCP predicates and strategies."""

import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from spectest.certificates import check_certificate, digest, prepare_certificate
from spectest.runtime_modules import prepare_runtime_modules


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--timeout", type=float, default=600)
    args = parser.parse_args()
    out = args.output.resolve()
    if out.exists():
        parser.error("output must be fresh")
    out.mkdir(parents=True)
    inputs = ROOT / "benchmark/comparison/proof-audit/list-itp-original"
    runtime = prepare_runtime_modules(
        ROOT / "runtime/qcip", ["SimpleC.EE.QCP_demos_human.sll_lib"],
        out / "runtime", timeout=args.timeout,
    )
    if runtime["status"] != "COMPILED":
        raise RuntimeError("original runtime module compilation failed")
    strategies = ROOT / "runtime/qcip/QCP_examples/QCP_demos_human/sll.strategies"
    summary = {"strategy_sha256": digest(strategies), "results": []}
    for variant, candidate in [("valid", "CandidateValid.v"),
                               ("wrong_post", "CandidateWrongPost.v")]:
        cell = out / variant
        cell.mkdir()
        command = [sys.executable, "-m", "spectest", "run",
                   str(inputs / (variant + ".c")), "--function", "sample",
                   "--binds", str(inputs / "binds.json"), "--execution-mode", "entry-exit",
                   "--output-dir", str(cell / "automatic"),
                   "--qcip-root", runtime["qcip_root"],
                   "--qcp-binary", str(ROOT / "bin/tespec-symexec"),
                   "-I", str(ROOT / "runtime/qcip/QCP_examples"), "--compact"]
        with (cell / "automatic.log").open("w") as log:
            run = subprocess.run(command, cwd=ROOT, stdout=log,
                                 stderr=subprocess.STDOUT, timeout=args.timeout)
        if run.returncode not in (0, 1):
            raise RuntimeError("symbolic execution failed: " + variant)
        automatic = json.loads((cell / "automatic/report.json").read_text())
        selected = ({f"proof_of_sample_safety_wit_{i}" for i in range(1, 12)}
                    | {"proof_of_sample_return_wit_3"}) if variant == "valid" else {
                        "proof_of_sample_return_wit_1"}
        request = prepare_certificate(
            cell / "automatic/artifacts/two_nodes/vc/manifest.json",
            cell / "certificate", only=selected,
            refute=None if variant == "valid" else "proof_of_sample_return_wit_1",
        )
        (cell / "request.json").write_text(json.dumps(request, indent=2) + "\n")
        shutil.copyfile(inputs / candidate, request["editable"])
        checked = check_certificate(Path(request["manifest"]),
                                    request["manifest_sha256"], timeout=args.timeout)
        (cell / "result.json").write_text(json.dumps(checked, indent=2) + "\n")
        summary["results"].append({
            "variant": variant, "automatic_status": automatic["results"][0]["status"],
            "selected_goals": len(selected), "proof_status": checked.get("proof_status"),
            "certificate_status": checked["status"], "scope": checked["scope"],
            "execution_verdict": "UNKNOWN",
            "reason": "incomplete_positive_coverage" if variant == "valid"
                      else "reachability_not_established",
        })
        if checked.get("proof_status") != "VALID":
            raise RuntimeError("proof replay failed: " + variant)
    if digest(strategies) != summary["strategy_sha256"]:
        raise RuntimeError("QCP strategies changed during replay")
    (out / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
