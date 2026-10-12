#!/usr/bin/env python3
"""Prepare or independently check definition-driven predicate normalization."""

import argparse
import json
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from spectest.normalization_certificates import (  # noqa: E402
    check_predicate_normalization,
    prepare_predicate_normalization,
    seal_predicate_normalization,
)
from spectest.core import JobError  # noqa: E402


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    prepare = commands.add_parser("prepare")
    prepare.add_argument("--definition", type=Path, required=True)
    prepare.add_argument("--module", required=True)
    prepare.add_argument("--predicate", required=True)
    prepare.add_argument("--qcip-root", type=Path, required=True)
    prepare.add_argument("--output", type=Path, required=True)
    prepare.add_argument(
        "--target-layout",
        type=Path,
        help="exported target layout or preflight manifest for nested fields",
    )
    prepare.add_argument("--infer-models", action="store_true")
    prepare.add_argument(
        "--pure-facts-only",
        action="store_true",
        help="retain the predicate and certify witness-independent pure consequences",
    )
    prepare.add_argument(
        "--runtime-definition",
        action="store_true",
        help="import the exact module in the pinned runtime",
    )
    prepare.add_argument("--first-rule-id", type=int, default=10000)
    prepare.add_argument(
        "--execution-scope", help="dedicated scope for execution normalization"
    )
    prepare.add_argument(
        "--notation-import",
        action="append",
        default=[],
        help="notation module used by the original definition",
    )
    prepare.add_argument(
        "--dependency", action="append", default=[], metavar="MODULE=FILE"
    )
    check = commands.add_parser("check")
    check.add_argument("manifest", type=Path)
    check.add_argument("--manifest-sha256", required=True)
    check.add_argument("--switch", default="qcp-8.20")
    check.add_argument("--timeout", type=float, default=300)
    seal = commands.add_parser("seal")
    seal.add_argument("manifest", type=Path)
    seal.add_argument("--manifest-sha256", required=True)
    seal.add_argument("--output", type=Path, required=True)
    seal.add_argument("--switch", default="qcp-8.20")
    seal.add_argument("--timeout", type=float, default=300)
    args = parser.parse_args()
    try:
        if args.command == "prepare":
            target_layout = None
            if args.target_layout:
                layout_data = json.loads(args.target_layout.read_text())
                if not isinstance(layout_data, dict):
                    raise JobError("target layout JSON must be an object")
                target_layout = layout_data.get("target_layout", layout_data)
            dependencies = []
            for item in args.dependency:
                module, sep, path = item.partition("=")
                if not sep or not module or not path:
                    raise JobError("dependency must have MODULE=FILE form")
                dependencies.append((module, Path(path)))
            result = prepare_predicate_normalization(
                args.definition,
                args.module,
                args.predicate,
                args.qcip_root,
                args.output,
                infer_models=args.infer_models,
                dependencies=dependencies,
                runtime_definition=args.runtime_definition,
                first_rule_id=args.first_rule_id,
                execution_scope=args.execution_scope,
                notation_imports=args.notation_import,
                target_layout=target_layout,
                pure_facts_only=args.pure_facts_only,
            )
        elif args.command == "seal":
            result = seal_predicate_normalization(
                args.manifest,
                args.manifest_sha256,
                args.output,
                switch=args.switch,
                timeout=args.timeout,
            )
        else:
            result = check_predicate_normalization(
                args.manifest,
                args.manifest_sha256,
                switch=args.switch,
                timeout=args.timeout,
            )
    except (JobError, OSError, ValueError) as error:
        parser.error(str(error))
    print(json.dumps(result, indent=2))
    return 0 if result["status"] in {"PASS", "PREPARED_UNCHECKED"} else 1


if __name__ == "__main__":
    raise SystemExit(main())
