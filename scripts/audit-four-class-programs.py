#!/usr/bin/env python3
"""Run TeSpec's analyzer over the selected 100 benchmark targets."""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from collections import Counter
from pathlib import Path
from typing import Any

PROJECT_ROOT = Path(__file__).resolve().parents[1]
WORKSPACE_ROOT = PROJECT_ROOT.parent


def dependency_assets(
    source: Path,
    qcip_root: Path,
    cav_ground_truth_root: Path,
) -> list[str]:
    candidates: set[Path] = set(source.parent.glob("*.v"))
    text = str(source)
    if "/QCP_examples/" in text:
        relative = Path(text.split("/QCP_examples/", 1)[1]).parent
        candidates.update(
            (qcip_root / "SeparationLogic/examples" / relative).glob("*.v")
        )
    if "/QCIP/OUTPUT/" in text:
        case_root = source.parent.parent
        candidates.update((case_root / "rocq").glob("*.v"))
    if "/CAV/main/CAV-bench/input/humaneval/" in text:
        candidates.update((cav_ground_truth_root / source.stem).glob("*.v"))
    return sorted(str(path.resolve()) for path in candidates if path.is_file())


def analyze(
    entry: dict[str, Any],
    qcip_root: Path,
    cav_ground_truth_root: Path,
) -> dict[str, Any]:
    source = Path(entry["source"])
    base_command = [
        sys.executable,
        "-m",
        "spectest",
        "analyze",
        str(source),
        "--function",
        entry["function"],
        "-I",
        str(source.parent),
        "--compact",
    ]

    def run(command: list[str]) -> tuple[subprocess.CompletedProcess[str], Any]:
        completed = subprocess.run(
            command,
            cwd=PROJECT_ROOT,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=60,
        )
        try:
            report = json.loads(completed.stdout)
        except json.JSONDecodeError:
            report = None
        return completed, report

    completed, report = run(base_command)
    selected_spec = None
    if (
        isinstance(report, dict)
        and report.get("requires_spec_selection")
        and report.get("available_specs")
    ):
        names = [item["name"] for item in report["available_specs"]]
        selected_spec = (
            "high_level_spec"
            if "high_level_spec" in names
            else "low_level_spec"
            if "low_level_spec" in names
            else names[0]
        )
        completed, report = run(
            base_command[:-1] + ["--spec", selected_spec, "--compact"]
        )
    supported = bool(
        completed.returncode == 0
        and isinstance(report, dict)
        and report.get("supported")
    )
    assets = dependency_assets(source, qcip_root, cav_ground_truth_root)
    return {
        "id": entry["id"],
        "source": str(source),
        "function": entry["function"],
        "supported": supported,
        "selected_spec": selected_spec,
        "argument_binding_count": (
            len(report.get("argument_bindings", []))
            if isinstance(report, dict)
            else None
        ),
        "value_binding_count": (
            len(report.get("value_bindings", [])) if isinstance(report, dict) else None
        ),
        "type_binding_count": (
            len(report.get("type_bindings", [])) if isinstance(report, dict) else None
        ),
        "unsupported_reason": (
            report.get("unsupported_reason")
            if isinstance(report, dict)
            else (completed.stderr or completed.stdout)[-1000:]
        ),
        "logical_asset_count": len(assets),
        "logical_assets": assets,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--catalog",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/selected-programs.json",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/analyzer-audit.json",
    )
    parser.add_argument(
        "--qcip-root",
        type=Path,
        default=WORKSPACE_ROOT / "QCIP",
    )
    parser.add_argument(
        "--cav-ground-truth-root",
        type=Path,
        default=WORKSPACE_ROOT / "CAV/main/CAV-bench/ground_truth",
    )
    args = parser.parse_args()
    catalog = json.loads(args.catalog.read_text(encoding="utf-8"))
    qcip_root = args.qcip_root.expanduser().resolve()
    cav_ground_truth_root = args.cav_ground_truth_root.expanduser().resolve()
    results = [
        analyze(entry, qcip_root, cav_ground_truth_root) for entry in catalog["tasks"]
    ]
    report = {
        "schema": "tespec-four-class-analyzer-audit/v1",
        "program_count": len(results),
        "supported_count": sum(item["supported"] for item in results),
        "named_spec_selection_count": sum(
            item["selected_spec"] is not None for item in results
        ),
        "logical_assets_found_count": sum(
            item["logical_asset_count"] > 0 for item in results
        ),
        "binding_count_histograms": {
            key: dict(Counter(item[key] for item in results))
            for key in (
                "argument_binding_count",
                "value_binding_count",
                "type_binding_count",
            )
        },
        "results": results,
    }
    target = args.output.resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(
        json.dumps(
            {
                key: report[key]
                for key in (
                    "program_count",
                    "supported_count",
                    "named_spec_selection_count",
                    "logical_assets_found_count",
                )
            },
            ensure_ascii=False,
            indent=2,
        )
    )
    return 0 if report["supported_count"] == len(results) else 1


if __name__ == "__main__":
    raise SystemExit(main())
