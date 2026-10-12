#!/usr/bin/env python3
"""Record Bennet/Darcy installation probes for an explicitly selected CN API."""

import argparse
import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "comparison_smoke", ROOT / "scripts/run-comparison-smoke.py"
)
comparison = importlib.util.module_from_spec(spec)
spec.loader.exec_module(comparison)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--switch", required=True)
    parser.add_argument("--interface", choices=("legacy", "engines"), required=True)
    parser.add_argument("--case", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--cc", default="/usr/bin/gcc")
    args = parser.parse_args()
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    out.mkdir(parents=True, exist_ok=True)
    config = json.loads((args.case / "case.json").read_text())
    source = (args.case / "case.cn.c").read_text()
    old, new = config["cn_mutation"]
    if source.count(old) != 1:
        parser.error("mutation must match exactly once")
    rows = []
    for engine in ("bennet", "darcy"):
        for variant in ("valid", "wrong_post"):
            directory = out / (engine + "-" + variant)
            directory.mkdir()
            path = directory / "input.c"
            path.write_text(source if variant == "valid" else source.replace(old, new))
            options = (
                [engine]
                if args.interface == "engines"
                else (["--symbolic"] if engine == "darcy" else [])
            )
            command = [
                "opam",
                "exec",
                "--switch=" + args.switch,
                "--",
                "cn",
                "test",
                *options,
                "--cc=" + args.cc,
                "--only=" + config["function"],
                "--num-samples=10",
                "--seed=0",
                "--print-seed",
                "--output-dir=" + str(directory),
                str(path),
            ]
            row = comparison.run(command, directory, "generator")
            row.update(
                engine=engine, variant=variant, source_sha256=comparison.sha(path)
            )
            rows.append(row)
            print(json.dumps(row), flush=True)
    (out / "report.json").write_text(
        json.dumps(
            {
                "scope": "installation-smoke-not-performance",
                "interface": args.interface,
                "switch": args.switch,
                "seed": 0,
                "requested_samples": 10,
                "runs": rows,
                "classification_note": "Exit codes alone do not distinguish counterexamples, unsupported features, build errors or generator failures; inspect retained logs.",
            },
            indent=2,
        )
        + "\n"
    )


if __name__ == "__main__":
    main()
