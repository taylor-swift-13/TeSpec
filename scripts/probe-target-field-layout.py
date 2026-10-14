#!/usr/bin/env python3
"""Compare emitted field offsets against GCC's selected target layout.

This audits VC translation, not proof discharge or frontend correctness.
All inputs, compiler diagnostics, executor output, and goals are retained.
"""

import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import time


CASES = [
    (
        "padding",
        "struct S { char tag; int value; };",
        "struct S",
        "value",
        4,
        "int",
        "7",
        "p->value",
        "__return == 7",
    ),
    (
        "nested",
        "struct I { char tag; int value; }; struct S { char tag; struct I inner; };",
        "struct S",
        "inner.value",
        8,
        "int",
        "7",
        "p->inner.value",
        "__return == 7",
    ),
    (
        "recursive_pointer",
        "struct S { char tag; struct S *next; int value; };",
        "struct S",
        "next",
        None,
        "struct S *",
        "0",
        "p->next == 0",
        "__return == 1",
    ),
    (
        "after_pointer",
        "struct S { char tag; struct S *next; int value; };",
        "struct S",
        "value",
        None,
        "int",
        "7",
        "p->value",
        "__return == 7",
    ),
    (
        "array_member",
        "struct S { char tag; int items[3]; };",
        "struct S",
        "items[1]",
        8,
        "int",
        "7",
        "p->items[1]",
        "__return == 7",
    ),
    (
        "wrong_post",
        "struct S { char tag; int value; };",
        "struct S",
        "value",
        4,
        "int",
        "7",
        "p->value",
        "__return == 8",
    ),
    (
        "union_overlap",
        "union S { int left; int right; };",
        "union S",
        "left",
        0,
        "int",
        "7",
        "p->left",
        "__return == 7",
    ),
]


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--binary", type=Path, required=True)
    ap.add_argument("--bits", type=int, choices=(32, 64), required=True)
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument("--executor-cwd", type=Path, required=True)
    args = ap.parse_args()
    root = args.output.resolve()
    root.mkdir(parents=True, exist_ok=False)
    binary = args.binary.resolve()
    rows = []
    for name, decl, typ, field, offset, celltype, value, expr, post in CASES:
        if name == "recursive_pointer":
            offset = args.bits // 8
        elif name == "after_pointer":
            offset = args.bits // 4
        d = root / name
        d.mkdir()
        oracle = d / "layout-oracle.c"
        oracle.write_text(
            decl
            + f'\n_Static_assert(__builtin_offsetof({typ}, {field}) == {offset}, "offset");\n'
        )
        cc = subprocess.run(
            ["gcc", f"-m{args.bits}", "-std=c11", "-fsyntax-only", str(oracle)],
            capture_output=True,
            text=True,
            timeout=30,
        )
        (d / "gcc.log").write_text(cc.stdout + cc.stderr)
        heap = f"data_at(&(p->{field}), {celltype}, {value})"
        if name == "union_overlap":
            heap += " * data_at(&(p->right), int, 8)"
        source = d / "subject.c"
        source.write_text(
            decl
            + f"\nint sample({typ} *p)\n/*@ Require {heap} Ensure {post} && {heap} */\n{{ return {expr}; }}\n"
        )
        for mode in ("entry-exit", "all-boundaries"):
            out = d / mode
            out.mkdir()
            cmd = [
                str(binary),
                "--input-file=" + str(source),
                "--spec-test" if mode == "entry-exit" else "--spec-test-no-expand",
                "--function=sample",
                f"--arch={args.bits}",
                "--full-auto",
                "--emit-residual-vc",
                "--Json-output",
                "--no-strategy-gen",
                "--no-logic-path",
                "--coq-output-dir=" + str(out),
            ]
            start = time.monotonic()
            p = subprocess.run(
                cmd, cwd=args.executor_cwd, capture_output=True, text=True, timeout=30
            )
            elapsed = time.monotonic() - start
            (out / "stdout.json").write_text(p.stdout)
            (out / "stderr.log").write_text(p.stderr)
            try:
                report = json.loads(p.stdout)
            except json.JSONDecodeError:
                report = {}
            goals = "\n".join(x.read_text() for x in out.glob("*_goal.v"))
            markers = re.findall(
                r"tespec-target-field-address-v1: bits=(\d+); offset=(\d+); size=(\d+); align=(\d+)",
                goals,
            )
            expected_fields = [(offset, 4, 4)]
            if name == "nested":
                expected_fields = [(4, 8, 4), (4, 4, 4)]
            elif name == "array_member":
                expected_fields = [(4, 12, 4)]
            elif name == "recursive_pointer":
                expected_fields = [(offset, args.bits // 8, args.bits // 8)]
            expected_markers = sorted(
                {tuple(map(str, (args.bits, *field))) for field in expected_fields}
            )
            checks = {
                "gcc_layout_agrees": cc.returncode == 0,
                "emitted_layout_agrees": sorted(set(markers)) == expected_markers,
                "executor_completed_without_signal": p.returncode >= 0 and bool(report),
                "negative_not_accepted": name not in ("wrong_post", "union_overlap")
                or report.get("verificationStatus") in ("unproved", "failed"),
            }
            rows.append(
                {
                    "case": name,
                    "mode": mode,
                    "command": cmd,
                    "gcc_exit": cc.returncode,
                    "expected_offset": offset,
                    "exit": p.returncode,
                    "wall_seconds": elapsed,
                    "status": report.get("verificationStatus"),
                    "preconditions": report.get("preconditions"),
                    "markers": sorted(set(markers)),
                    "expected_markers": expected_markers,
                    "checks": checks,
                    "goal_files": [str(x) for x in out.glob("*_goal.v")],
                }
            )
    result = {
        "schema": "tespec-field-layout-probe/v1",
        "bits": args.bits,
        "binary": str(binary),
        "binary_sha256": hashlib.sha256(binary.read_bytes()).hexdigest(),
        "scope": "translation probe; compiler offsets are independent evidence, not a refinement proof",
        "results": rows,
        "translation_checks_passed": all(all(r["checks"].values()) for r in rows),
    }
    (root / "report.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))
    return 0 if result["translation_checks_passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
