#!/usr/bin/env python3
"""Inventory Assertion definitions against the current normalization grammar.

This is a parser coverage report, not a proof or execution verdict.
"""

import argparse
from collections import Counter
import json
from pathlib import Path
import re
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from spectest.certificates import digest  # noqa: E402
from spectest.core import JobError, _coq_dependency_code  # noqa: E402
from spectest.rocq_predicates import (  # noqa: E402
    parse_predicate,
    referenced_symbols,
    emit_pure_projection_rules,
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("root", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--pure-facts-only", action="store_true")
    args = parser.parse_args()
    root = args.root.resolve()
    if not root.is_dir():
        parser.error("root must be a directory")
    if args.output.exists():
        parser.error("output must be fresh")
    headers = re.compile(
        r"\b(Fixpoint|Definition)\s+([A-Za-z_][A-Za-z0-9_']*)(?![\w'])\s*"
        r"(?:\([^)]*\)\s*)*:\s*Assertion\s*:="
    )
    records = []
    for path in sorted(root.rglob("*.v")):
        source = path.read_text()
        for header in headers.finditer(_coq_dependency_code(source)):
            record = {
                "file": str(path.relative_to(root)),
                "source_sha256": digest(path),
                "line": source.count("\n", 0, header.start()) + 1,
                "declaration": header[1],
                "predicate": header[2],
            }
            try:
                clauses = parse_predicate(source, header[2])
                record.update(
                    status="PARSED",
                    clauses=len(clauses),
                    symbols=referenced_symbols(clauses),
                )
                if args.pure_facts_only:
                    rules = emit_pure_projection_rules(clauses, scope="checked_facts")
                    record.update(
                        status="PREPARABLE_UNCHECKED",
                        pure_fact_rules=rules.count("left_add("),
                    )
            except JobError as error:
                record.update(
                    status="NO_ELIGIBLE_FACT"
                    if args.pure_facts_only
                    and str(error).startswith("definition has no eligible")
                    else "UNSUPPORTED",
                    reason=str(error),
                )
            records.append(record)
    report = {
        "schema": "tespec-pure-fact-inventory/v1"
        if args.pure_facts_only
        else "tespec-normalization-parser-inventory/v1",
        "root": str(root),
        "parser_sha256": digest(
            Path(__file__).resolve().parents[1] / "spectest/rocq_predicates.py"
        ),
        "scope": "explicit Assertion headers with parenthesized parameters"
        + ("; pure-fact preparation only" if args.pure_facts_only else ""),
        "proof": "NOT_RUN",
        "execution": "NOT_RUN",
        "counts": dict(Counter(record["status"] for record in records)),
        "barriers": dict(
            Counter(record["reason"] for record in records if "reason" in record)
        ),
        "records": records,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(
        json.dumps(
            {"counts": report["counts"], "barriers": report["barriers"]}, indent=2
        )
    )


if __name__ == "__main__":
    main()
