#!/usr/bin/env python3
"""Find both inclusion counterexamples for ieee754-clamp-expert."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
from typing import Any


HARNESS = r"""
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "impl_under_test.c"

static uint64_t bits(double value)
{
    uint64_t result;
    memcpy(&result, &value, sizeof(result));
    return result;
}

static void run_case(const char *name, double input)
{
    Sample sample = {
        .input = input,
        .lower = -1.0,
        .upper = 1.0,
        .output = 42.0,
        .flags = 0xffffffffu,
    };
    unsigned int returned = clamp_batch(&sample, 1);
    printf("%s %u %d 0x%016" PRIx64 " %u\n",
           name, returned, isnan(sample.output) ? 1 : 0,
           bits(sample.output), sample.flags);
}

int main(void)
{
    run_case("quiet_nan_payload", nan("0x1234"));
    run_case("negative_zero", -0.0);
    run_case("positive_zero", 0.0);
    return 0;
}
"""


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def require_fragments(text: str, fragments: list[str], source: str) -> None:
    missing = [fragment for fragment in fragments if fragment not in text]
    if missing:
        joined = ", ".join(repr(fragment) for fragment in missing)
        raise ValueError(f"{source} does not match this task; missing {joined}")


def run_implementation(impl: Path) -> dict[str, dict[str, Any]]:
    compiler = os.environ.get("CC", "cc")
    with tempfile.TemporaryDirectory(prefix="tespec-ieee754-clamp-") as temp:
        root = Path(temp)
        shutil.copy2(impl, root / "impl_under_test.c")
        (root / "probe.c").write_text(HARNESS, encoding="utf-8")
        executable = root / "probe"
        compile_result = subprocess.run(
            [
                compiler,
                "-std=c11",
                "-Wall",
                "-Wextra",
                "-Werror",
                str(root / "probe.c"),
                "-lm",
                "-o",
                str(executable),
            ],
            check=False,
            capture_output=True,
            text=True,
        )
        if compile_result.returncode != 0:
            detail = compile_result.stderr.strip() or compile_result.stdout.strip()
            raise RuntimeError(f"compiler failed: {detail}")
        run_result = subprocess.run(
            [str(executable)],
            check=False,
            capture_output=True,
            text=True,
        )
        if run_result.returncode != 0:
            raise RuntimeError(
                f"probe failed with exit {run_result.returncode}: "
                f"{run_result.stderr.strip()}"
            )

    observations: dict[str, dict[str, Any]] = {}
    for line in run_result.stdout.splitlines():
        fields = line.split()
        if len(fields) != 5:
            raise RuntimeError(f"unexpected probe output: {line!r}")
        name, returned, is_nan, output_bits, flags = fields
        observations[name] = {
            "return": int(returned),
            "output_is_nan": bool(int(is_nan)),
            "output_bits": output_bits,
            "flags": int(flags),
        }
    required = {"quiet_nan_payload", "negative_zero", "positive_zero"}
    if observations.keys() != required:
        raise RuntimeError(
            f"probe cases differ: expected {sorted(required)}, "
            f"got {sorted(observations)}"
        )
    return observations


def build_report(
    impl: Path,
    spec: Path,
    semantics: Path,
    definitions: Path,
) -> dict[str, Any]:
    impl_text = impl.read_text(encoding="utf-8")
    spec_text = spec.read_text(encoding="utf-8")
    semantics_text = semantics.read_text(encoding="utf-8")
    definitions_text = definitions.read_text(encoding="utf-8")

    require_fragments(
        impl_text,
        [
            "if (isnan(input))",
            "FLAG_NEGATIVE_ZERO",
            "unsigned int clamp_batch",
        ],
        "impl.c",
    )
    require_fragments(
        spec_text,
        [
            "BatchDomain(inputs, lowers, uppers)",
            "ClampBatchNumeric(inputs, lowers, uppers, outputs)",
            "AllNonNaN(outputs)",
            "__return == ClampCount(inputs, lowers, uppers)",
        ],
        "spec.qcp",
    )
    require_fragments(
        semantics_text,
        [
            "`BatchDomain` permits NaNs",
            "bit patterns and flags, is observable",
            "`NumericEq`",
        ],
        "SEMANTICS.md",
    )
    require_fragments(
        definitions_text,
        [
            "Definition NumericEq",
            "(x = FNegZero /\\ y = FPosZero)",
            "(x = FPosZero /\\ y = FNegZero)",
            "| FNaN _ => False",
            "| FNegZero =>",
        ],
        "definitions.v",
    )

    observations = run_implementation(impl)
    nan_observation = observations["quiet_nan_payload"]
    negative_zero_observation = observations["negative_zero"]

    complete_found = (
        nan_observation["return"] == 0
        and nan_observation["output_is_nan"]
        and nan_observation["flags"] == 1
    )
    sound_found = (
        negative_zero_observation["return"] == 0
        and not negative_zero_observation["output_is_nan"]
        and negative_zero_observation["output_bits"] == "0x8000000000000000"
    )

    return {
        "schema": "tespec-ieee754-clamp-two-axis-witnesses/v1",
        "inputs_sha256": {
            "impl": sha256(impl),
            "spec": sha256(spec),
            "semantics": sha256(semantics),
            "definitions": sha256(definitions),
        },
        "complete_counterexample": {
            "property": "Complete",
            "inclusion": "R_I subseteq R_S",
            "witness_direction": "implementation_satisfies_and_spec_rejects",
            "witness_found": complete_found,
            "pre_state": {
                "input": "quiet NaN payload 0x1234",
                "lower": -1,
                "upper": 1,
                "domain_admits_input": True,
            },
            "implementation_observation": nan_observation,
            "spec_checks": {
                "ClampBatchNumeric_preserves_nan": True,
                "AllNonNaN_outputs": False,
                "postcondition_satisfied": False,
            },
        },
        "sound_counterexample": {
            "property": "Sound",
            "inclusion": "R_S subseteq R_I",
            "witness_direction": "spec_satisfies_and_implementation_rejects",
            "witness_found": sound_found,
            "pre_state": {
                "input": "negative zero",
                "input_bits": "0x8000000000000000",
                "lower": -1,
                "upper": 1,
            },
            "spec_admitted_post_state": {
                "output": "positive zero",
                "output_bits": "0x0000000000000000",
                "flags": negative_zero_observation["flags"],
                "return": 0,
            },
            "spec_checks": {
                "NumericEq_FPosZero_FNegZero": True,
                "AllNonNaN_outputs": True,
                "return_equals_ClampCount": True,
                "all_other_observables_match_implementation": True,
                "postcondition_satisfied": True,
            },
            "implementation_observation": negative_zero_observation,
            "implementation_produces_spec_post_state": False,
            "observable_difference": "output signed-zero bit pattern",
        },
        "all_witnesses_found": complete_found and sound_found,
        "note": "The tool reports two directional witnesses and does not emit a four-class label.",
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--impl", type=Path, required=True)
    parser.add_argument("--spec", type=Path, required=True)
    parser.add_argument("--semantics", type=Path, required=True)
    parser.add_argument("--definitions", type=Path, required=True)
    parser.add_argument("--output", type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        report = build_report(
            args.impl.resolve(),
            args.spec.resolve(),
            args.semantics.resolve(),
            args.definitions.resolve(),
        )
    except (OSError, RuntimeError, ValueError) as error:
        print(
            json.dumps(
                {
                    "schema": "tespec-ieee754-clamp-two-axis-witnesses/v1",
                    "error": str(error),
                    "all_witnesses_found": False,
                },
                indent=2,
                sort_keys=True,
            )
        )
        return 2

    rendered = json.dumps(report, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered, encoding="utf-8")
    print(rendered, end="")
    return 0 if report["all_witnesses_found"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
