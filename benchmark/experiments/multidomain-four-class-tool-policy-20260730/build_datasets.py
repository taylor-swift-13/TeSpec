#!/usr/bin/env python3
"""Materialize balanced, label-blind tool-policy evaluation datasets."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import shutil


ROOT = Path(__file__).resolve().parents[3]
EXPERIMENT = Path(__file__).resolve().parent
SOURCE = ROOT / "benchmark/pilot/multibase-harder"
QUESTIONS = {
    "h01": {
        "label": "correct",
        "sound": True,
        "complete": True,
        "rationale": (
            "The implementation returns the unique canonical binary sum and "
            "the candidate describes that complete observable behavior."
        ),
    },
    "h02": {
        "label": "complete",
        "sound": False,
        "complete": True,
        "rationale": (
            "Every implementation result has the required row sums, audit, "
            "and return, but the candidate admits other cell values with the "
            "same row sums."
        ),
    },
    "h03": {
        "label": "soundness",
        "sound": True,
        "complete": False,
        "rationale": (
            "The candidate fixes the implementation rotation and adds "
            "HeadLeTail; legal implementation inputs whose rotated head is "
            "greater than the tail are rejected."
        ),
    },
    "h04": {
        "label": "incomparable",
        "sound": False,
        "complete": False,
        "rationale": (
            "An admitted NaN execution violates AllNonNaN, while NumericEq "
            "and unconstrained final flags admit observable signed-zero or "
            "flag states the deterministic implementation does not produce."
        ),
    },
}
CONDITIONS = {
    "tool-enabled": "four-class-tool-enabled",
    "tool-forbidden": "four-class-tool-forbidden",
}
SEMANTICS_REPLACEMENTS = {
    "h01": {
        (
            "Unconstrained buffer suffixes remain observable but are "
            "identical between the\ntwo implementations whenever their "
            "meaningful result is identical."
        ): (
            "Unconstrained buffer suffixes remain observable and are "
            "unchanged by this implementation."
        ),
    },
    "h02": {
        (
            "`GridArithmeticSafe` excludes signed overflow in both programs, "
            "including the\nmutant's `bias+1` and `bias-1`, every per-cell "
            "update, every row sum, and the\nrunning total."
        ): (
            "`GridArithmeticSafe` excludes signed overflow in every per-cell "
            "update, every row sum, and the running total."
        ),
    },
}


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def fenced(name: str, text: str) -> str:
    fence = "```"
    return f"### `{name}`\n\n{fence}\n{text.rstrip()}\n{fence}"


def semantics_text(question_id: str) -> str:
    text = (SOURCE / question_id / "SEMANTICS.md").read_text(encoding="utf-8")
    for old, new in SEMANTICS_REPLACEMENTS.get(question_id, {}).items():
        if old not in text:
            raise RuntimeError(
                f"expected semantics text not found for {question_id}: {old!r}"
            )
        text = text.replace(old, new)
    return text


def task_text(condition: str, question_id: str, skill_text: str) -> str:
    source = SOURCE / question_id
    policy = (
        """
Use the workspace tools before answering. At minimum, issue an action that
reads both `impl.c` and `spec.qcp`. The selected C sources are self-contained:
also compile and execute at least one targeted legal boundary case chosen to
test one of the two inclusions. Treat the probe as an observation, not as a
source of the label.
"""
        if condition == "tool-enabled"
        else """
Do not issue any tool call. In particular, do not use file, shell, search,
compiler, interpreter, or test tools. Every semantic input is reproduced
verbatim below, so reason only from this prompt.
"""
    )
    sections = [
        "# Four-class implementation/specification evaluation",
        (
            "The only semantic inputs are the implementation, specification, "
            "and fixed semantic dependencies reproduced below. Mutation "
            "lineage, sibling questions, and file names are not evidence."
        ),
        "## Assigned reusable skill",
        skill_text.rstrip(),
        "## Condition policy",
        policy.strip(),
        (
            "A formal proof is not required. After applying the skill to both "
            "axes, return your best judgment. Return only one JSON object:"
        ),
        '```json\n{"label":"correct|soundness|complete|incomparable|abstain"}\n```',
        "## Semantic inputs",
        fenced("impl.c", (source / "reference.c").read_text(encoding="utf-8")),
        fenced(
            "spec.qcp",
            (source / "candidate.qcp").read_text(encoding="utf-8"),
        ),
        fenced(
            "dependencies/definitions.v",
            (source / "definitions.v").read_text(encoding="utf-8"),
        ),
        fenced(
            "dependencies/SEMANTICS.md",
            semantics_text(question_id),
        ),
    ]
    return "\n\n".join(sections) + "\n"


def build_condition(output_root: Path, condition: str, skill_name: str) -> None:
    destination = output_root / condition
    destination.mkdir(parents=True)
    skill_path = EXPERIMENT / "conditions" / skill_name / "SKILL.md"
    skill_text = skill_path.read_text(encoding="utf-8")
    catalog: dict[str, object] = {
        "schema": "tespec-four-class-public-index/v1",
        "benchmark": f"tespec-multidomain-four-class-{condition}-v1",
        "questions": [],
    }
    for question_id in QUESTIONS:
        source = SOURCE / question_id
        question_root = destination / question_id
        input_root = question_root / "input"
        dependency_root = question_root / "dependencies"
        input_root.mkdir(parents=True)
        dependency_root.mkdir()
        shutil.copy2(source / "reference.c", input_root / "impl.c")
        shutil.copy2(source / "candidate.qcp", input_root / "spec.qcp")
        shutil.copy2(source / "definitions.v", dependency_root / "definitions.v")
        (dependency_root / "SEMANTICS.md").write_text(
            semantics_text(question_id),
            encoding="utf-8",
        )
        shutil.copy2(skill_path, dependency_root / "EVALUATION_SKILL.md")
        (question_root / "TASK.md").write_text(
            task_text(condition, question_id, skill_text),
            encoding="utf-8",
        )
        catalog["questions"].append(
            {
                "id": question_id,
                "impl": f"{question_id}/input/impl.c",
                "spec": f"{question_id}/input/spec.qcp",
                "task": f"{question_id}/TASK.md",
                "dependencies": [
                    {
                        "source": f"{question_id}/dependencies/definitions.v",
                        "destination": "definitions.v",
                    },
                    {
                        "source": f"{question_id}/dependencies/SEMANTICS.md",
                        "destination": "SEMANTICS.md",
                    },
                    {
                        "source": (
                            f"{question_id}/dependencies/EVALUATION_SKILL.md"
                        ),
                        "destination": "EVALUATION_SKILL.md",
                    },
                ],
            }
        )
    (destination / "questions.json").write_text(
        json.dumps(catalog, indent=2) + "\n",
        encoding="utf-8",
    )
    gold = {
        "schema": "tespec-four-class-gold-index/v1",
        "benchmark": catalog["benchmark"],
        "questions": QUESTIONS,
    }
    (destination / "gold.json").write_text(
        json.dumps(gold, indent=2) + "\n",
        encoding="utf-8",
    )


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-root", type=Path, required=True)
    args = parser.parse_args()
    output_root = args.output_root.expanduser().resolve()
    if output_root.exists():
        raise SystemExit(f"refusing to overwrite existing output: {output_root}")
    output_root.mkdir(parents=True)
    for condition, skill_name in CONDITIONS.items():
        build_condition(output_root, condition, skill_name)
    manifest = {
        "schema": "tespec-tool-policy-dataset-manifest/v1",
        "source": str(SOURCE.relative_to(ROOT)),
        "conditions": list(CONDITIONS),
        "questions": {
            question_id: {
                "impl_sha256": sha256(SOURCE / question_id / "reference.c"),
                "spec_sha256": sha256(SOURCE / question_id / "candidate.qcp"),
                "definitions_sha256": sha256(
                    SOURCE / question_id / "definitions.v"
                ),
                "semantics_sha256": sha256(
                    output_root
                    / "tool-enabled"
                    / question_id
                    / "dependencies/SEMANTICS.md"
                ),
            }
            for question_id in QUESTIONS
        },
        "skill_sha256": {
            condition: sha256(
                EXPERIMENT / "conditions" / skill_name / "SKILL.md"
            )
            for condition, skill_name in CONDITIONS.items()
        },
    }
    (output_root / "manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n",
        encoding="utf-8",
    )
    print(output_root)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
