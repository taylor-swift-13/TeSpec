#!/usr/bin/env python3
"""Materialize the binds-only TeSpec ablation without exposing mutation lineage."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import shutil


EXPERIMENT = Path(__file__).resolve().parent
FIXTURES = EXPERIMENT / "fixtures"
LABELS = {
    "q01": {"label": "correct", "sound": True, "complete": True},
    "q02": {"label": "complete", "sound": False, "complete": True},
    "q03": {"label": "soundness", "sound": True, "complete": False},
    "q04": {"label": "incomparable", "sound": False, "complete": False},
}
CONDITIONS = {
    "tool-enabled": "four-class-binds-tool",
    "tool-forbidden": "four-class-no-tool",
}


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def fenced(name: str, text: str) -> str:
    return f"### `{name}`\n\n```\n{text.rstrip()}\n```"


def task_text(condition: str, skill: str, impl: str, spec: str) -> str:
    policy = (
        "Tools are required. Follow the skill's TeSpec protocol. The model may "
        "author only `binds.json`; files emitted by TeSpec itself are allowed."
        if condition == "tool-enabled"
        else "Do not issue any tool call. Reason only from the verbatim inputs below."
    )
    sections = [
            "# Four-class implementation/specification evaluation",
            "Target function: `classify_switch`.",
            "## Assigned reusable skill",
            skill.rstrip(),
            "## Condition policy",
            policy,
            (
                "A formal proof is not required. Return only one JSON object:\n\n"
                '```json\n{"label":"correct|soundness|complete|incomparable|abstain"}\n```'
            ),
        ]
    if condition == "tool-enabled":
        sections.extend(
            [
                "## Semantic inputs",
                (
                    "The exact semantic inputs are the workspace files "
                    "`impl.c` and `spec.qcp`. A response produced without "
                    "running both required TeSpec commands is invalid."
                ),
            ]
        )
    else:
        sections.extend(
            [
                "## Semantic inputs",
                fenced("impl.c", impl),
                fenced("spec.qcp", spec),
            ]
        )
    return "\n\n".join(sections) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-root", type=Path, required=True)
    args = parser.parse_args()
    output = args.output_root.expanduser().resolve()
    if output.exists():
        raise SystemExit(f"refusing to overwrite existing output: {output}")
    output.mkdir(parents=True)
    impl_path = FIXTURES / "impl.c"
    impl = impl_path.read_text(encoding="utf-8")
    manifest: dict[str, object] = {
        "schema": "tespec-binds-only-dataset-manifest/v1",
        "questions": {},
        "skills": {},
    }
    for condition, skill_name in CONDITIONS.items():
        condition_root = output / condition
        condition_root.mkdir()
        skill_path = EXPERIMENT / "conditions" / skill_name / "SKILL.md"
        skill = skill_path.read_text(encoding="utf-8")
        manifest["skills"][condition] = sha256(skill_path)
        catalog: dict[str, object] = {
            "schema": "tespec-four-class-public-index/v1",
            "benchmark": f"tespec-switch-binds-{condition}-v1",
            "questions": [],
        }
        for question_id in LABELS:
            question_root = condition_root / question_id
            input_root = question_root / "input"
            dependency_root = question_root / "dependencies"
            input_root.mkdir(parents=True)
            dependency_root.mkdir()
            spec_path = FIXTURES / f"{question_id}.qcp"
            spec = spec_path.read_text(encoding="utf-8")
            shutil.copy2(impl_path, input_root / "impl.c")
            shutil.copy2(spec_path, input_root / "spec.qcp")
            shutil.copy2(skill_path, dependency_root / "EVALUATION_SKILL.md")
            (question_root / "TASK.md").write_text(
                task_text(condition, skill, impl, spec),
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
                            "source": (
                                f"{question_id}/dependencies/EVALUATION_SKILL.md"
                            ),
                            "destination": "EVALUATION_SKILL.md",
                        }
                    ],
                }
            )
            manifest["questions"][question_id] = {
                "impl_sha256": sha256(impl_path),
                "spec_sha256": sha256(spec_path),
            }
        (condition_root / "questions.json").write_text(
            json.dumps(catalog, indent=2) + "\n",
            encoding="utf-8",
        )
        (condition_root / "gold.json").write_text(
            json.dumps(
                {
                    "schema": "tespec-four-class-gold-index/v1",
                    "benchmark": catalog["benchmark"],
                    "questions": LABELS,
                },
                indent=2,
            )
            + "\n",
            encoding="utf-8",
        )
    (output / "manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n",
        encoding="utf-8",
    )
    print(output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
