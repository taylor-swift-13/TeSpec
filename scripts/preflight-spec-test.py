#!/usr/bin/env python3
"""Export a spec-test instance's layout and Coq context without execution."""

import argparse
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from spectest.core import JobError  # noqa: E402
from spectest.preflight import export_program_preflight  # noqa: E402


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("job", type=Path)
    parser.add_argument("--case")
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    try:
        result = export_program_preflight(args.job, args.output, case_id=args.case)
    except (JobError, OSError) as error:
        parser.exit(1, f"preflight: {error}\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
