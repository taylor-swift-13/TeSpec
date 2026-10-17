#!/usr/bin/env python3
"""Run the original allocator bug catalog in isolated external worktrees.

Defaults are an inventory probe, not the paper's full statistical experiment.
Every selected subject and outcome is retained, including setup/build errors.
"""

import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "comparison", ROOT / "scripts/run-comparison-smoke.py"
)
comparison = importlib.util.module_from_spec(spec)
spec.loader.exec_module(comparison)


def classify(code, text):
    if code == "TIMEOUT":
        return "TIMEOUT"
    summary = re.findall(
        r"cases:\s*(\d+), passed:\s*(\d+), failed:\s*(\d+), errored:\s*(\d+), skipped:\s*(\d+)",
        text,
    )
    if len(summary) == 1:
        cases, passed, failed, errored, skipped = map(int, summary[0])
        if cases != passed + failed + errored + skipped or cases != 1:
            return "UNEXPECTED_SUMMARY"
        if failed and code == 1:
            return (
                "COUNTEREXAMPLE_REPORTED"
                if "Failing input" in text
                else "TEST_FAILURE_REPORTED"
            )
        if passed == 1 and code == 0:
            return "SAMPLES_PASSED"
        if errored and "FAILED TO GENERATE VALID INPUT" in text:
            return "GENERATION_FAILED"
        if errored:
            return "GENERATION_OR_TEST_ERROR"
        if skipped:
            return "SKIPPED"
        return "INCONSISTENT_RESULT"
    if any(
        x in text
        for x in [
            "Failed to compile",
            "Failed to link",
            "undefined reference",
            "fatal error:",
        ]
    ):
        return "BUILD_ERROR"
    if "FAILED TO GENERATE" in text:
        return "GENERATION_FAILED"
    return "TOOL_ERROR" if code else "MISSING_TEST_SUMMARY"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", type=Path, required=True)
    parser.add_argument(
        "--revision", default="4a2f776eaac34488531253c04a6eb42bbc08ed9f"
    )
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--switch", default="tespec-cn-5.2")
    parser.add_argument("--cases", type=int, nargs="+")
    parser.add_argument(
        "--engines", choices=("bennet", "darcy"), nargs="+", default=["bennet", "darcy"]
    )
    parser.add_argument("--samples", type=int, default=10)
    parser.add_argument("--variant", choices=("buggy", "correct"), default="buggy")
    parser.add_argument("--trials", type=int, default=1)
    parser.add_argument("--timeout", type=float, default=120)
    parser.add_argument("--cc", default="/usr/bin/gcc")
    args = parser.parse_args()
    if min(args.samples, args.trials, args.timeout) <= 0:
        parser.error("samples, trials and timeout must be positive")
    repo, out = args.repo.resolve(), args.output.resolve()
    if out.is_relative_to(ROOT):
        parser.error("baseline source worktrees must remain outside teSpec")
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    revision = subprocess.check_output(
        ["git", "-C", str(repo), "rev-parse", args.revision], text=True
    ).strip()
    catalog_bytes = subprocess.check_output(
        ["git", "-C", str(repo), "show", revision + ":pbt_bench/bug_finding.json"]
    )
    catalog = json.loads(catalog_bytes)
    selected = args.cases or list(range(1, len(catalog) + 1))
    if len(selected) != len(set(selected)) or any(
        n < 1 or n > len(catalog) for n in selected
    ):
        parser.error("case indices must be distinct and in the catalog")
    out.mkdir(parents=True)
    shutil.copyfile(__file__, out / "driver.py")
    (out / "catalog.json").write_bytes(catalog_bytes)
    metadata = {
        "scope": "original-subject-inventory-probe",
        "source_revision": revision,
        "catalog_sha256": hashlib.sha256(catalog_bytes).hexdigest(),
        "switch": args.switch,
        "cn_version": subprocess.check_output(
            ["opam", "exec", "--switch=" + args.switch, "--", "cn", "--version"],
            text=True,
        ).strip(),
        "driver_sha256": comparison.sha(out / "driver.py"),
        "selected_cases": selected,
        "engines": args.engines,
        "samples": args.samples,
        "variant": args.variant,
        "trials": args.trials,
        "timeout_seconds": args.timeout,
        "timing_scope": "generation, compilation and test execution combined; not isolated performance data",
        "seed_policy": "trial index, starting at zero",
        "runs": [],
    }
    (out / "report.json").write_text(json.dumps(metadata, indent=2) + "\n")
    for number in selected:
        entry = catalog[number - 1]
        case = out / f"case-{number:02d}"
        case.mkdir()
        work = case / "subject"
        setup = comparison.run(
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
            case,
            "checkout",
        )
        if setup["returncode"] == 0:
            setup = comparison.run(
                ["./benchmark/switch_to.sh", str(number)], case, "apply", cwd=work
            )
        if setup["returncode"] == 0 and args.variant == "correct":
            setup = comparison.run(
                ["git", "apply", "--reverse", entry["path"]],
                case,
                "remove_bug_patch",
                cwd=work,
            )
        if setup["returncode"]:
            row = {
                "case": number,
                "entry": entry,
                "status": "SETUP_ERROR",
                "stage": setup,
            }
            metadata["runs"].append(row)
        else:
            source_hashes = {
                name: comparison.sha(work / name)
                for name in [
                    "src/alloc.c",
                    "src/main.c",
                    "src/shim.c",
                    "specs/spec.c",
                    "include/linux/list.h",
                    "patches/workaround.patch",
                    entry["path"],
                ]
            }
            for engine in args.engines:
                script = (
                    "./test-symbolic.sh" if engine == "darcy" else "./test-random.sh"
                )
                for trial in range(args.trials):
                    command = [
                        "opam",
                        "exec",
                        "--switch=" + args.switch,
                        "--",
                        script,
                        "--cc=" + args.cc,
                        "--only=" + entry["fut"],
                        "--no-replicas",
                        "--no-replays",
                        "--exit-fast",
                        "--num-samples=" + str(args.samples),
                        "--seed=" + str(trial),
                        *entry.get("args", []),
                    ]
                    row = comparison.run(
                        command,
                        case,
                        f"{engine}-{trial}",
                        cwd=work,
                        timeout=args.timeout,
                    )
                    row.update(
                        case=number,
                        entry=entry,
                        engine=engine,
                        trial=trial,
                        seed=trial,
                        source_hashes=source_hashes,
                        status=classify(
                            row["returncode"],
                            Path(row["log"]).read_text(errors="replace"),
                        ),
                    )
                    log_text = Path(row["log"]).read_text(errors="replace")
                    counts = re.findall(
                        r"Testing [^\r\n]+?: (\d+) runs(?:, (\d+) discards)?", log_text
                    )
                    row["completed_runs"] = int(counts[-1][0]) if counts else None
                    row["discards"] = int(counts[-1][1] or 0) if counts else None
                    row["input_witness_printed"] = "Failing input" in log_text
                    trace = (
                        work
                        / ("_test_symbolic" if engine == "darcy" else "_test_random")
                        / "results.jsonl"
                    )
                    if trace.exists():
                        archived_trace = case / f"{engine}-{trial}-trace.jsonl"
                        shutil.copyfile(trace, archived_trace)
                        row["trace"] = str(archived_trace)
                        row["trace_sha256"] = comparison.sha(archived_trace)
                    metadata["runs"].append(row)
                    with (out / "runs.jsonl").open("a") as stream:
                        stream.write(json.dumps(row) + "\n")
                    (out / "report.json").write_text(
                        json.dumps(metadata, indent=2) + "\n"
                    )
                    print(
                        json.dumps(
                            {
                                key: row[key]
                                for key in [
                                    "case",
                                    "engine",
                                    "trial",
                                    "status",
                                    "wall_seconds",
                                ]
                            }
                        ),
                        flush=True,
                    )
        (out / "report.json").write_text(json.dumps(metadata, indent=2) + "\n")


if __name__ == "__main__":
    main()
