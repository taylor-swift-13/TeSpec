#!/usr/bin/env python3
"""Replay the original allocator's native harness with staged failure reporting."""

import argparse
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location(
    "comparison", ROOT / "scripts/run-comparison-smoke.py"
)
comparison = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(comparison)


def native_outcome(stage, code, log):
    if code == "TIMEOUT":
        return stage.upper() + "_TIMEOUT"
    if code == 0:
        return "NATIVE_CHECKS_PASSED" if stage == "execution" else "STAGE_PASSED"
    if stage != "execution":
        return stage.upper() + "_ERROR"
    if "Failed at" in log:
        return "RUNTIME_CHECK_FAILURE"
    return "NATIVE_EXECUTION_ERROR"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--revision", default="4a2f776eaac34488531253c04a6eb42bbc08ed9f"
    )
    parser.add_argument("--catalog", choices=("partial", "buggy"), default="partial")
    parser.add_argument("--cases", type=int, nargs="+")
    parser.add_argument("--switch", default="tespec-cn-5.2")
    parser.add_argument("--cc", default="/usr/bin/clang-18")
    parser.add_argument("--timeout", type=float, default=180)
    args = parser.parse_args()
    repo, out = args.repo.resolve(), args.output.resolve()
    if out.is_relative_to(ROOT):
        parser.error("external source worktrees must remain outside TeSpec")
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    if args.timeout <= 0:
        parser.error("timeout must be positive")
    catalog_path = (
        "benchmark/partial_spec.json"
        if args.catalog == "partial"
        else "pbt_bench/bug_finding.json"
    )
    revision = subprocess.check_output(
        ["git", "-C", str(repo), "rev-parse", args.revision], text=True
    ).strip()
    data = subprocess.check_output(
        ["git", "-C", str(repo), "show", revision + ":" + catalog_path]
    )
    catalog = json.loads(data)
    selected = args.cases if args.cases is not None else list(range(len(catalog) + 1))
    if len(selected) != len(set(selected)) or any(
        number < 0 or number > len(catalog) for number in selected
    ):
        parser.error(
            "cases must be distinct: 0 for the complete control, 1..N for patches"
        )
    out.mkdir(parents=True)
    (out / "catalog.json").write_bytes(data)
    shutil.copyfile(__file__, out / "executed-driver.py.txt")
    prefix = ["opam", "exec", "--switch=" + args.switch, "--"]
    binary_path = Path(
        subprocess.check_output(prefix + ["which", "cn"], text=True).strip()
    )
    report = {
        "scope": "original-native-harness-inventory-probe-not-performance",
        "source_revision": revision,
        "catalog": catalog_path,
        "catalog_sha256": comparison.sha(out / "catalog.json"),
        "selected_cases": selected,
        "cn_version": subprocess.check_output(
            prefix + ["cn", "--version"], text=True
        ).strip(),
        "cn_binary_sha256": comparison.sha(binary_path),
        "compiler": subprocess.check_output(
            [args.cc, "--version"], text=True
        ).splitlines()[0],
        "switch": args.switch,
        "timeout_seconds_per_stage": args.timeout,
        "driver_sha256": comparison.sha(Path(__file__)),
        "input_policy": "unmodified original src/main.c harness, including its embedded seed",
        "runs": [],
    }

    def save():
        (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")

    save()
    for number in selected:
        folder = out / f"case-{number:02d}"
        folder.mkdir()
        work = folder / "subject"
        entry = catalog[number - 1] if number else {"description": "complete control"}
        row = {"case": number, "entry": entry, "stages": []}
        commands = [
            (
                "checkout",
                [
                    "git",
                    "-C",
                    str(repo),
                    "worktree",
                    "add",
                    "--detach",
                    str(work),
                    revision,
                ],
                repo,
            ),
            (
                "patch",
                ["./benchmark/switch_to.sh", str(number or 1), catalog_path],
                work,
            ),
        ]
        if number == 0:
            commands.append(
                ("control", ["git", "apply", "--reverse", catalog[0]["path"]], work)
            )
        commands.extend(
            [
                (stage, prefix + ["make", target, "CC=" + args.cc], work)
                for stage, target in [
                    ("preprocess", "main.pp.c"),
                    ("instrument", "main.pp.exec.c"),
                    ("build", "main.exe"),
                ]
            ]
        )
        commands.append(("execution", [str(work / "main.exe")], work))
        for stage, command, cwd in commands:
            result = comparison.run(
                command, folder, stage, cwd=cwd, timeout=args.timeout
            )
            result["stage"] = stage
            row["stages"].append(result)
            row["status"] = native_outcome(
                stage,
                result["returncode"],
                Path(result["log"]).read_text(errors="replace"),
            )
            if result["returncode"] != 0:
                break
        row["files_sha256"] = {
            name: comparison.sha(work / name)
            for name in [
                "src/alloc.c",
                "src/main.c",
                "src/shim.c",
                "specs/spec.c",
                "include/linux/list.h",
                "patches/workaround.patch",
                "Makefile",
                "main.pp.c",
                "main.pp.exec.c",
                "main.exe",
                *([entry["path"]] if number else []),
            ]
            if (work / name).is_file()
        }
        report["runs"].append(row)
        save()
        print(json.dumps({"case": number, "status": row["status"]}), flush=True)


if __name__ == "__main__":
    main()
