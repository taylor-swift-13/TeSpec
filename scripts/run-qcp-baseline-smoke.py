#!/usr/bin/env python3
"""Run unmodified QCP universal verification on the paired heap fixtures.

The complete translation unit is processed. Target-function outcomes are
reported separately; command timing includes other functions and VC emission.
"""

import argparse
import importlib.util
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "comparison", ROOT / "scripts/run-comparison-smoke.py"
)
comparison = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(comparison)


def target_outcome(code, output, function):
    if code == "TIMEOUT":
        return "TIMEOUT", None
    if code != 0:
        return "TOOL_ERROR", None
    if output.get("result") != "success":
        return "TOOL_ERROR", None
    matches = [
        row
        for row in output.get("WitnessList", [])
        if row.get("functionName") == function
    ]
    if len(matches) != 1:
        return "MISSING_OR_DUPLICATE_TARGET", None
    counts = matches[0].get("Witness", {}).get("total_witness_count", {})
    if not all(isinstance(counts.get(k), int) for k in ("auto_solved", "manual")):
        return "MISSING_WITNESS_COUNTS", None
    if counts["manual"] > 0:
        return "RESIDUAL", counts
    if counts["manual"] == 0 and counts["auto_solved"] > 0:
        return "AUTOMATICALLY_DISCHARGED", counts
    return "EMPTY_OR_INVALID_WITNESS_COUNTS", counts


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--binary", type=Path, help="explicit binary for compatibility replay")
    parser.add_argument("--binary-revision", help="record the supplied binary source revision")
    parser.add_argument("--timeout", type=float, default=120)
    parser.add_argument(
        "--case",
        action="append",
        dest="selected_cases",
        metavar="NAME",
        help="select a paired case directory by name; repeatable",
    )
    args = parser.parse_args()
    repo, out = args.repo.resolve(), args.output.resolve()
    binary = args.binary.resolve(strict=True) if args.binary else repo / "build/release/symexec"
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")

    def git(path, *command):
        return subprocess.check_output(
            ["git", "-C", str(path), *command], text=True
        ).strip()

    metadata = {
        "scope": "installation-smoke-universal-verification-not-performance",
        "domain": "entire target precondition; no logical input bindings",
        "timing_scope": "whole translation unit, automatic checks and VC emission",
        "certificate": "NOT_CHECKED; auto proof placeholders do not establish kernel proofs",
        "qcp_revision": git(repo, "rev-parse", "HEAD"),
        "qcp_status": git(repo, "status", "--porcelain"),
        "smt_revision": git(repo / "smt_solver", "rev-parse", "HEAD"),
        "smt_status": git(repo / "smt_solver", "status", "--porcelain"),
        "binary_sha256": comparison.sha(binary),
        "binary_override": bool(args.binary),
        "binary_source_revision": args.binary_revision if args.binary else git(repo, "rev-parse", "HEAD"),
        "driver_sha256": comparison.sha(Path(__file__)),
    }
    if metadata["qcp_status"] or metadata["smt_status"]:
        parser.error("baseline source checkouts must be clean")
    out.mkdir(parents=True, exist_ok=True)
    cases = [ROOT / "benchmark/comparison/smoke"] + sorted(
        (ROOT / "benchmark/comparison/paired").iterdir()
    )
    if args.selected_cases:
        selected = set(args.selected_cases)
        unknown = selected - {case.name for case in cases}
        if unknown:
            parser.error("unknown case(s): " + ", ".join(sorted(unknown)))
        cases = [case for case in cases if case.name in selected]
    rows = []
    for case in cases:
        if (case / "case.json").exists():
            config = json.loads((case / "case.json").read_text())
            source = case / "case.qcp.c"
        else:
            config = {
                "function": "bump",
                "category": "single_cell",
                "qcp_mutation": [
                    "Ensure data_at(p, int, v + 1)",
                    "Ensure data_at(p, int, v + 2)",
                ],
            }
            source = case / "cell.qcp.c"
        text = source.read_text()
        if text.count(config["qcp_mutation"][0]) != 1:
            raise ValueError("mutation must match exactly once: " + str(case))
        variants = [("valid", text), ("wrong_post", text)]
        if config.get("qcp_refinement_source"):
            refined = (case / config["qcp_refinement_source"]).read_text()
            if comparison.body(refined) != comparison.body(text):
                raise ValueError("annotation refinement changed the C body")
            if refined.count(config["qcp_mutation"][0]) != 1:
                raise ValueError("refined mutation must match exactly once")
            variants.extend(
                [("valid_refined", refined), ("wrong_post_refined", refined)]
            )
        for variant, variant_source in variants:
            directory = out / case.name / variant
            (directory / "vc").mkdir(parents=True)
            target = directory / "input.c"
            target.write_text(
                variant_source.replace(*config["qcp_mutation"])
                if variant.startswith("wrong_post")
                else variant_source
            )
            # Upstream strategy includes resolve beside the input, not through -I.
            strategy_files = {}
            for relative in re.findall(
                r'include\s+strategies\s+"([^"\n]+)"', variant_source
            ):
                name = Path(relative)
                if name.is_absolute() or ".." in name.parts:
                    raise ValueError("strategy fixture must use a relative path")
                candidates = [
                    (ROOT / include_dir / name).resolve()
                    for include_dir in config.get("qcp_include_dirs", [])
                ]
                source = next((path for path in candidates if path.is_file()), None)
                if source is None:
                    raise ValueError("missing strategy fixture: " + relative)
                staged = directory / name
                staged.parent.mkdir(parents=True, exist_ok=True)
                staged.write_bytes(source.read_bytes())
                strategy_files[relative] = comparison.sha(staged)
            command = [
                str(binary),
                "--input-file=" + str(target),
                "--Json-output",
                "--no-strategy-gen",
                "--gen-and-backup",
                "--coq-output-dir=" + str(directory / "vc"),
                "--no-logic-path",
                "--disable-solver-info",
                "--no-exec-info",
            ]
            command.extend(
                "-I" + str((ROOT / include_dir).resolve())
                for include_dir in config.get("qcp_include_dirs", [])
            )
            row = comparison.run(
                command, directory, "executor", cwd=repo, timeout=args.timeout
            )
            try:
                output = json.loads(Path(row["log"]).read_text())
            except json.JSONDecodeError:
                output = {}
            status, counts = target_outcome(
                row["returncode"], output, config["function"]
            )
            vc_files = sorted((directory / "vc").glob("*.v"))
            row.update(
                case=case.name,
                category=config["category"],
                function=config["function"],
                variant=variant,
                source_sha256=comparison.sha(target),
                status=status,
                target_witness_counts=counts,
                loaded_strategies=output.get("loaded_strategies"),
                staged_strategy_sha256=strategy_files,
                original_json_verification_status=output.get("verificationStatus"),
                vc_files={p.name: comparison.sha(p) for p in vc_files},
                admitted_placeholder_count=sum(
                    len(re.findall(r"\bAdmitted\s*\.", p.read_text())) for p in vc_files
                ),
            )
            rows.append(row)
            (out / "report.json").write_text(
                json.dumps({**metadata, "runs": rows}, indent=2) + "\n"
            )
            print(json.dumps({k: row[k] for k in ["case", "variant", "status"]}))


if __name__ == "__main__":
    main()
