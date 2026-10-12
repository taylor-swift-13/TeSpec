#!/usr/bin/env python3
"""Prepare a kernel-checkable predicate identity in the parsed program context."""

import argparse
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from spectest.certificates import check_certificate  # noqa: E402
from spectest.core import JobError  # noqa: E402
from spectest.normalization_association import prepare_normalization_association  # noqa: E402


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    prepare = commands.add_parser("prepare")
    prepare.add_argument("--preflight", type=Path, required=True)
    prepare.add_argument("--preflight-sha256", required=True)
    prepare.add_argument("--normalization", type=Path, required=True)
    prepare.add_argument("--normalization-sha256", required=True)
    prepare.add_argument("--output", type=Path, required=True)
    check = commands.add_parser("check")
    check.add_argument("manifest", type=Path)
    check.add_argument("--manifest-sha256", required=True)
    check.add_argument("--switch", default="qcp-8.20")
    check.add_argument("--timeout", type=float, default=300)
    args = parser.parse_args()
    try:
        if args.command == "prepare":
            result = prepare_normalization_association(
                args.preflight,
                args.preflight_sha256,
                args.normalization,
                args.normalization_sha256,
                args.output,
            )
        else:
            bundle = json.loads(args.manifest.read_text())
            if bundle.get("scope") != "program-normalization-association":
                raise JobError("expected program normalization association")
            result = check_certificate(
                args.manifest,
                args.manifest_sha256,
                switch=args.switch,
                timeout=args.timeout,
            )
    except (JobError, OSError, ValueError) as error:
        parser.exit(1, f"association: {error}\n")
    print(json.dumps(result, indent=2))
    return 0 if result.get("status") in ("PASS", "PREPARED_UNCHECKED") else 1


if __name__ == "__main__":
    raise SystemExit(main())
