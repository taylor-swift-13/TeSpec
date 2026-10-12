#!/usr/bin/env python3
"""Compile required Rocq libraries under their original runtime module names."""

import argparse
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from spectest.core import JobError  # noqa: E402
from spectest.runtime_modules import prepare_runtime_modules  # noqa: E402


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--qcip-root", type=Path, required=True)
    parser.add_argument("--module", action="append", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--switch", default="qcp-8.20")
    parser.add_argument("--timeout", type=float, default=120)
    args = parser.parse_args()
    try:
        report = prepare_runtime_modules(
            args.qcip_root,
            args.module,
            args.output,
            switch=args.switch,
            timeout=args.timeout,
        )
    except (JobError, OSError) as error:
        parser.exit(1, f"runtime preparation: {error}\n")
    print(
        json.dumps(
            {
                "status": report["status"],
                "scope": report["scope"],
                "qcip_root": report["qcip_root"],
                "report": str(args.output.resolve() / "report.json"),
            },
            indent=2,
        )
    )
    return 0 if report["status"] == "COMPILED" else 1


if __name__ == "__main__":
    raise SystemExit(main())
