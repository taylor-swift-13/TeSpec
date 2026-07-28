#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import sys
import time
from collections import Counter
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
WORKSPACE_ROOT = PROJECT_ROOT.parent
sys.path.insert(0, str(PROJECT_ROOT))

from spectest.core import (
    JobError,
    analyze_catalog,
    source_with_local_includes,
)


DEFAULT_CORPORA = {
    "qcp": WORKSPACE_ROOT / "QCIP/QCP_examples",
    "cav": WORKSPACE_ROOT / "CAV/main/CAV-bench/input",
    "xizi": WORKSPACE_ROOT / "QCIP/OUTPUT/xizi",
}


def analyze_corpus(name: str, root: Path) -> dict[str, object]:
    files = sorted(root.rglob("*.c"))
    errors: list[dict[str, str]] = []
    entries: list[dict[str, object]] = []
    type_counts: Counter[str] = Counter()
    function_count = 0
    spec_count = 0
    argument_binding_count = 0
    value_binding_count = 0

    for source in files:
        try:
            text = source.read_text(encoding="utf-8", errors="replace")
            catalog = analyze_catalog(
                text,
                signature_source=source_with_local_includes(
                    source, (root,), primary_source=text
                ),
            )
        except (JobError, OSError) as error:
            errors.append({"source": str(source), "error": str(error)})
            continue

        function_count += int(catalog["function_count"])
        spec_count += int(catalog["spec_count"])
        unknown_bindings: list[dict[str, str | None]] = []
        for function in catalog["functions"]:
            for spec in function["specs"]:
                argument_binding_count += len(spec["argument_bindings"])
                for binding in spec["value_bindings"]:
                    value_binding_count += 1
                    logic_type = binding["type"]
                    type_counts[logic_type or "<unknown>"] += 1
                    if logic_type is None:
                        unknown_bindings.append(
                            {
                                "function": function["function"],
                                "spec": spec["spec"],
                                "variable": binding["name"],
                            }
                        )
        entries.append(
            {
                "source": str(source),
                "function_count": catalog["function_count"],
                "spec_count": catalog["spec_count"],
                "unknown_bindings": unknown_bindings,
            }
        )

    return {
        "name": name,
        "root": str(root),
        "c_file_count": len(files),
        "analyzed_file_count": len(entries),
        "parser_error_count": len(errors),
        "function_count": function_count,
        "spec_count": spec_count,
        "argument_binding_count": argument_binding_count,
        "value_binding_count": value_binding_count,
        "binding_type_counts": dict(type_counts.most_common()),
        "unknown_binding_count": type_counts["<unknown>"],
        "errors": errors,
        "files": entries,
    }


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Build a complete spec/binding compatibility matrix."
    )
    parser.add_argument(
        "--qcp-root", type=Path, default=DEFAULT_CORPORA["qcp"]
    )
    parser.add_argument(
        "--cav-root", type=Path, default=DEFAULT_CORPORA["cav"]
    )
    parser.add_argument(
        "--xizi-root", type=Path, default=DEFAULT_CORPORA["xizi"]
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(".spectest/corpus-analysis.json"),
    )
    parser.add_argument("--compact", action="store_true")
    args = parser.parse_args()

    started = time.time()
    corpora = [
        analyze_corpus("qcp", args.qcp_root.expanduser().resolve()),
        analyze_corpus("cav", args.cav_root.expanduser().resolve()),
        analyze_corpus("xizi", args.xizi_root.expanduser().resolve()),
    ]
    report = {
        "schema": "qcp-spectest-corpus-analysis/v1",
        "duration_seconds": round(time.time() - started, 6),
        "summary": {
            "c_file_count": sum(item["c_file_count"] for item in corpora),
            "analyzed_file_count": sum(
                item["analyzed_file_count"] for item in corpora
            ),
            "parser_error_count": sum(
                item["parser_error_count"] for item in corpora
            ),
            "function_count": sum(item["function_count"] for item in corpora),
            "spec_count": sum(item["spec_count"] for item in corpora),
            "argument_binding_count": sum(
                item["argument_binding_count"] for item in corpora
            ),
            "value_binding_count": sum(
                item["value_binding_count"] for item in corpora
            ),
            "unknown_binding_count": sum(
                item["unknown_binding_count"] for item in corpora
            ),
        },
        "corpora": corpora,
    }
    target = args.output.expanduser().resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    if args.compact:
        print(json.dumps(report["summary"], ensure_ascii=False))
    else:
        print(json.dumps(report["summary"], ensure_ascii=False, indent=2))
        print(f"report: {target}")
    return 0 if report["summary"]["parser_error_count"] == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
