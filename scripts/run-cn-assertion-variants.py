#!/usr/bin/env python3
"""Measure CN verification and instrumentation of equivalent assertion variants.

The caller supplies the equivalence argument; this runner checks identical C
bodies and preserves failures without interpreting them as counterexamples.
"""

import argparse
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "comparison", ROOT / "scripts/run-comparison-smoke.py"
)
comparison = importlib.util.module_from_spec(spec)
spec.loader.exec_module(comparison)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("sources", nargs="+", type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--switch", default="tespec-cn-5.2")
    parser.add_argument("--timeout", type=int, default=120)
    args = parser.parse_args()
    sources = [p.resolve() for p in args.sources]
    if len({comparison.body(p.read_text()) for p in sources}) != 1:
        parser.error("C bodies differ")
    if len({p.name for p in sources}) != len(sources):
        parser.error("source basenames must be unique")
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    out.mkdir(parents=True, exist_ok=True)
    prefix = ["opam", "exec", "--switch=" + args.switch, "--"]
    binary = Path(subprocess.check_output(prefix + ["which", "cn"], text=True).strip())
    report = {
        "schema": "tespec-cn-assertion-variants/v1",
        "scope": "identical C bodies; assertion equivalence supplied separately",
        "cn_binary_sha256": comparison.sha(binary),
        "compiler_sha256": comparison.sha(Path("/usr/bin/gcc")),
        "version": comparison.run(prefix + ["cn", "--version"], out, "version"),
        "runs": [],
    }
    for source in sources:
        copied = out / source.name
        shutil.copy2(source, copied)
        for mode in ["verify", "instrument"]:
            target = out / (source.name + "-" + mode)
            target.mkdir()
            cmd = prefix + ["cn", mode]
            if mode == "instrument":
                cmd += ["--run", "--cc=/usr/bin/gcc", "--output-dir=" + str(target)]
            cmd += [str(copied)]
            row = comparison.run(cmd, target, "run", timeout=args.timeout)
            row.update(
                source=source.name, source_sha256=comparison.sha(copied), mode=mode
            )
            report["runs"].append(row)
            (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
