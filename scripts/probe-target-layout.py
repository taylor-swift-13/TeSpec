#!/usr/bin/env python3
"""Compare a candidate executor's target layout with a native compiler.

These probes check prerequisite ABI facts; they do not establish full ABI or
executor correctness. Candidate builds and native executables stay external.
"""

import argparse
import importlib.util
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "comparison", ROOT / "scripts/run-comparison-smoke.py"
)
comparison = importlib.util.module_from_spec(spec)
spec.loader.exec_module(comparison)

DECLARATIONS = """struct list_head { struct list_head *next; struct list_head *prev; };
struct chunk_hdr_only {
 unsigned int alloc_size; unsigned int mapped_size; struct list_head node;
 unsigned int hash; unsigned int explicit_padding;
};
"""
PROBES = {
    "pointer_size": "sizeof(void *)",
    "long_size": "sizeof(unsigned long)",
    "list_size": "sizeof(struct list_head)",
    "chunk_size": "sizeof(struct chunk_hdr_only)",
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--binary", type=Path, required=True)
    parser.add_argument("--arch", choices=(32, 64), type=int, required=True)
    parser.add_argument("--cc", default="/usr/bin/clang-18")
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    out, binary = args.output.resolve(), args.binary.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    out.mkdir(parents=True, exist_ok=True)
    report = {
        "scope": "selected ABI prerequisites only",
        "binary_sha256": comparison.sha(binary),
        "arch": args.arch,
        "compiler": subprocess.check_output([args.cc, "--version"], text=True),
        "runs": [],
    }
    for name, expression in PROBES.items():
        directory = out / name
        directory.mkdir()
        native = directory / "native.c"
        native.write_text(
            "#include <stdio.h>\n"
            + DECLARATIONS
            + 'int main(void) { printf("%zu\\n", '
            + expression
            + "); return 0; }\n"
        )
        exe = directory / "native"
        compile_result = comparison.run(
            [args.cc, str(native), "-o", str(exe)], directory, "compile"
        )
        if compile_result["returncode"] != 0:
            raise RuntimeError("native oracle compilation failed")
        value = int(subprocess.check_output([str(exe)], text=True))
        source = directory / "input.c"
        source.write_text(
            DECLARATIONS
            + f"int sample(void) /*@ Require emp Ensure __return=={value} && emp */ {{ return {expression}; }}\n"
        )
        vc = directory / "vc"
        vc.mkdir()
        command = [
            str(binary),
            f"--input-file={source}",
            "--full-auto",
            "--Json-output",
            "--emit-residual-vc",
            "--no-strategy-gen",
            "--gen-and-backup",
            "--coq-output-dir",
            str(vc),
            "--no-logic-path",
            "--disable-solver-info",
            "--no-exec-info",
            "--function",
            "sample",
            "--concrete-bindings",
            f"--arch={args.arch}",
        ]
        run = comparison.run(command, directory, "executor")
        output = Path(run["log"]).read_text()
        decoded = {}
        for offset in [0] + [i + 1 for i, c in enumerate(output) if c == "\n"]:
            if output[offset : offset + 1] != "{":
                continue
            try:
                candidate = json.JSONDecoder().raw_decode(output[offset:])[0]
            except json.JSONDecodeError:
                continue
            if isinstance(candidate, dict) and "spec_test" in candidate:
                decoded = candidate
                break
        result = decoded.get("spec_test", {})
        report["runs"].append(
            {
                "probe": name,
                "native_value": value,
                "compile": compile_result,
                "executor": run,
                "source_sha256": comparison.sha(source),
                "result": result,
                "manual_obligations": decoded.get("manual_obligations"),
            }
        )
        (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(
        json.dumps(
            {
                "results": [
                    (r["probe"], r["native_value"], r["result"].get("overall"))
                    for r in report["runs"]
                ]
            }
        )
    )


if __name__ == "__main__":
    main()
