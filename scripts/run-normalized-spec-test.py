#!/usr/bin/env python3
"""Run a selected instance with independently checked normalization gates."""

import argparse
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from spectest.core import JobError  # noqa: E402
from spectest.normalized_execution import run_normalized_case  # noqa: E402


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("job", type=Path)
    parser.add_argument("--case")
    parser.add_argument("--normalization", type=Path, required=True)
    parser.add_argument("--normalization-sha256", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--switch", default="qcp-8.20")
    parser.add_argument("--proof-timeout", type=float, default=300)
    parser.add_argument("--execution-timeout", type=float, default=30)
    parser.add_argument(
        "--full-kernel-replay",
        action="store_true",
        help="replay all dependency proofs at every gate",
    )
    args = parser.parse_args()
    try:
        result = run_normalized_case(
            args.job,
            args.normalization,
            args.normalization_sha256,
            args.output,
            case_id=args.case,
            switch=args.switch,
            proof_timeout=args.proof_timeout,
            execution_timeout=args.execution_timeout,
            reuse_kernel_dependencies=not args.full_kernel_replay,
        )
    except JobError as error:
        parser.exit(1, f"normalized execution: {error}\n")
    print(
        json.dumps(
            {
                "status": result["status"],
                "execution": result["execution"],
                "reason": result.get("reason"),
                "report": str(args.output.resolve() / "report.json"),
                "automatic_report": result.get("automatic_report"),
                "wall_seconds": result.get("wall_seconds"),
                "pending_itp_groups": len(result.get("itp_vcs", [])),
            },
            indent=2,
        )
    )
    return 0 if result["status"] == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
