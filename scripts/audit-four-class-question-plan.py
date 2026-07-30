#!/usr/bin/env python3
"""Reject an unbalanced, leaky, or weak four-class construction plan."""

from __future__ import annotations

import argparse
import hashlib
import json
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any

PROJECT_ROOT = Path(__file__).resolve().parents[1]
LABELS = ("correct", "soundness", "complete", "incomparable")
TIERS = ("hard", "expert")
EXTRA_LABEL_PAIRS = (
    ("correct", "soundness"),
    ("soundness", "complete"),
    ("complete", "incomparable"),
    ("incomparable", "correct"),
)
LABEL_BITS = {
    "correct": {"sound": True, "complete": True},
    "soundness": {"sound": True, "complete": False},
    "complete": {"sound": False, "complete": True},
    "incomparable": {"sound": False, "complete": False},
}
LABEL_RELATIONS = {
    "correct": "equivalent",
    "soundness": "strictly_stronger",
    "complete": "strictly_weaker",
    "incomparable": "incomparable",
}
LABEL_ROLES = {
    "correct": ["equivalence"],
    "soundness": ["strengthening"],
    "complete": ["weakening"],
    "incomparable": ["weakening", "strengthening"],
}
EXACT_PUBLIC_INPUTS = ["impl.c", "spec.qcp"]
COMMON_CHECKS = {
    "semantic_review_gold_required",
    "operator_and_label_hidden_from_public_input",
    "source_family_locked_to_single_split",
    "balanced_surface_statistics",
    "label_blind_mutation_review",
    "gpt5_nano_three_attempt_gate",
}
EXPERT_CHECKS = {
    "surface_camouflage_required",
    "composed_mutation_nonredundancy",
}
COMMON_GOLD = {
    "semantic_review_record",
    "soundness_review_rationale",
    "completeness_review_rationale",
    "legal_input_domain_review",
    "difficulty_gate_certificate",
    "gpt5_nano_difficulty_gate",
    "surface_statistics_audit",
    "label_blind_mutation_audit",
}


def add_error(errors: list[str], question_id: str, message: str) -> None:
    errors.append(f"{question_id}: {message}")


def expected_dimensions(entry: dict[str, Any], tier: str) -> list[str]:
    dimensions = ["relation_inclusion"]
    if entry["loops"] or entry["branches"]:
        dimensions.append("path_sensitive_control")
    if entry["heap"]:
        dimensions.append("heap_and_aliasing")
    if entry["multi_call"]:
        dimensions.append("interprocedural_effects")
    if entry["native_float"] or entry["float_model"]:
        dimensions.append("floating_point_semantics")
    if entry["singly_linked"] or entry["doubly_linked"]:
        dimensions.append("inductive_shape")
    if entry["structure"]:
        dimensions.append("aggregate_state")
    if entry["quantified"]:
        dimensions.append("quantified_relation")
    if entry["custom_coq"]:
        dimensions.append("custom_logical_definitions")
    if entry["logical_list"]:
        dimensions.append("logical_sequence")
    if len(dimensions) == 1:
        dimensions.append("scalar_dataflow")
    if tier == "expert":
        dimensions.append("composed_semantic_mutation")
    return dimensions


def expected_score(
    entry: dict[str, Any],
    tier: str,
    step_count: int,
    dimension_count: int,
) -> float:
    tier_bonus = 8 if tier == "hard" else 18
    return round(
        min(float(entry["difficulty_score"]), 60.0) * 0.5
        + step_count * 6
        + dimension_count * 3
        + tier_bonus,
        3,
    )


def expected_base_slots(base_index: int) -> Counter[tuple[str, str]]:
    slots: Counter[tuple[str, str]] = Counter()
    for label_index, label in enumerate(LABELS):
        tier = "hard" if (base_index + label_index) % 2 == 0 else "expert"
        slots[(label, tier)] += 1
    for label in EXTRA_LABEL_PAIRS[base_index % len(EXTRA_LABEL_PAIRS)]:
        label_index = LABELS.index(label)
        tier = "expert" if (base_index + label_index) % 2 == 0 else "hard"
        slots[(label, tier)] += 1
    return slots


def audit(
    payload: dict[str, Any],
    catalog: dict[str, Any],
    catalog_sha256: str,
) -> dict[str, Any]:
    errors: list[str] = []
    if payload.get("schema") != "tespec-four-class-question-plan/v3":
        errors.append("root: unsupported question-plan schema")
    if payload.get("questions_per_base") != 6:
        errors.append("root: questions_per_base must be exactly 6")
    gold_policy = payload.get("gold_policy", {})
    if gold_policy != {
        "mode": "reviewed-semantic-judgment",
        "formal_proof_required": False,
        "checked_counterexample_required": False,
        "reviewer_must_inspect": ["impl.c", "spec.qcp"],
        "required_axis_judgments": ["sound", "complete"],
        "supporting_proofs_and_counterexamples": "optional",
    }:
        errors.append("root: semantic-review gold policy is not frozen")
    if payload.get("catalog_sha256") != catalog_sha256:
        errors.append("root: plan is not bound to the supplied catalog hash")
    authoritative_gate = payload.get("difficulty_policy", {}).get("authoritative_gate")
    if authoritative_gate != (
        "openai/gpt-5-nano generic agent, three independent attempts; "
        "retain at 0/3 or 1/3 correct, replace at 2/3 or 3/3 correct"
    ):
        errors.append("root: authoritative gpt-5-nano gate is not frozen")
    catalog_tasks = {
        entry["id"]: entry for entry in catalog.get("tasks", []) if "id" in entry
    }
    catalog_indices = {
        entry["id"]: index for index, entry in enumerate(catalog.get("tasks", []))
    }
    questions = payload.get("questions")
    if not isinstance(questions, list):
        questions = []
        errors.append("root: questions must be an array")

    ids: set[str] = set()
    base_slots: dict[str, Counter[tuple[str, str]]] = defaultdict(Counter)
    base_subquestion_indices: dict[str, set[int]] = defaultdict(set)
    labels: Counter[str] = Counter()
    tiers: Counter[str] = Counter()
    label_tiers: Counter[str] = Counter()
    dimensions: Counter[str] = Counter()
    spec_operators: Counter[str] = Counter()
    scores: dict[str, list[float]] = defaultdict(list)

    for index, question in enumerate(questions):
        question_id = question.get("question_id", f"<question-{index}>")
        if question_id in ids:
            add_error(errors, question_id, "duplicate question_id")
        ids.add(question_id)

        label = question.get("target_label")
        difficulty = question.get("difficulty", {})
        tier = difficulty.get("tier")
        base_id = question.get("base_id")
        entry = catalog_tasks.get(base_id)
        labels[label] += 1
        tiers[tier] += 1
        label_tiers[f"{label}:{tier}"] += 1
        base_slots[str(base_id)][(label, tier)] += 1
        subquestion_index = question.get("subquestion_index")
        if question.get("subquestion_count") != 6:
            add_error(errors, question_id, "subquestion_count must be exactly 6")
        if not isinstance(subquestion_index, int) or not 1 <= subquestion_index <= 6:
            add_error(errors, question_id, "subquestion_index must be in 1..6")
        elif subquestion_index in base_subquestion_indices[str(base_id)]:
            add_error(errors, question_id, "duplicate subquestion_index in base")
        else:
            base_subquestion_indices[str(base_id)].add(subquestion_index)

        if label not in LABEL_BITS:
            add_error(errors, question_id, f"unsupported label {label!r}")
            continue
        if tier not in TIERS:
            add_error(errors, question_id, f"unsupported tier {tier!r}")
            continue
        if entry is None:
            add_error(errors, question_id, "base_id is absent from frozen catalog")
            continue
        if question.get("base_index") != catalog_indices[base_id]:
            add_error(errors, question_id, "base index differs from frozen catalog")
        if {
            "sound": question.get("sound"),
            "complete": question.get("complete"),
        } != LABEL_BITS[label]:
            add_error(errors, question_id, "label truth bits do not match contract")
        if question.get("source_family") != entry["family"]:
            add_error(errors, question_id, "source family differs from catalog")
        if question.get("construction_source") != entry["source"]:
            add_error(errors, question_id, "construction source differs from catalog")
        if question.get("target_function") != entry["function"]:
            add_error(errors, question_id, "target function differs from catalog")

        if question.get("public_inputs") != EXACT_PUBLIC_INPUTS:
            add_error(errors, question_id, "public_inputs must be impl.c/spec.qcp")
        lineage = question.get("mutation_lineage", {})
        if lineage.get("visibility") != "hidden":
            add_error(errors, question_id, "mutation lineage must be hidden")
        expected_split_group = f"{entry['corpus']}:{entry['family']}"
        if lineage.get("split_group") != expected_split_group:
            add_error(errors, question_id, "incorrect source-family split group")

        spec = lineage.get("spec", {})
        operators = spec.get("operators", [])
        if not isinstance(operators, list) or not all(
            isinstance(operator, str) and operator for operator in operators
        ):
            add_error(errors, question_id, "spec operators must be nonempty names")
            operators = []
        spec_operators.update(operators)
        expected_roles = list(LABEL_ROLES[label])
        if tier == "expert":
            expected_roles.insert(0, "equivalence")
        if spec.get("semantic_roles") != expected_roles:
            add_error(
                errors, question_id, "spec semantic roles do not match label/tier"
            )
        if spec.get("relation") != LABEL_RELATIONS[label]:
            add_error(errors, question_id, "spec relation does not match target label")

        minimum_steps = 1 if tier == "hard" else 2
        if len(operators) < minimum_steps:
            add_error(
                errors,
                question_id,
                f"{tier} needs at least {minimum_steps} spec mutation steps",
            )
        if difficulty.get("spec_mutation_step_count") != len(operators):
            add_error(errors, question_id, "spec mutation step count mismatch")
        if spec.get("composition") != "sequential_nonredundant":
            add_error(errors, question_id, "mutation composition is not constrained")
        if tier == "expert" and spec.get("camouflage") is not True:
            add_error(errors, question_id, "expert question lacks surface camouflage")

        question_dimensions = difficulty.get("reasoning_dimensions", [])
        recomputed_dimensions = expected_dimensions(entry, tier)
        if question_dimensions != recomputed_dimensions:
            add_error(errors, question_id, "reasoning dimensions differ from catalog")
        minimum_dimensions = 2 if tier == "hard" else 3
        if len(set(question_dimensions)) < minimum_dimensions:
            add_error(
                errors,
                question_id,
                f"{tier} needs {minimum_dimensions} reasoning dimensions",
            )
        dimensions.update(set(question_dimensions))

        minimum_score = 22 if tier == "hard" else 40
        score = difficulty.get("score")
        recomputed_score = expected_score(
            entry,
            tier,
            len(operators),
            len(recomputed_dimensions),
        )
        if score != recomputed_score:
            add_error(errors, question_id, "difficulty score was not recomputed")
        if not isinstance(score, (int, float)) or score < minimum_score:
            add_error(errors, question_id, f"difficulty score below {minimum_score}")
        else:
            scores[str(tier)].append(float(score))
        if difficulty.get("minimum_score") != minimum_score:
            add_error(errors, question_id, "incorrect minimum score")
        if difficulty.get("static_base_score") != entry["difficulty_score"]:
            add_error(errors, question_id, "static base score differs from catalog")
        if difficulty.get("minimum_spec_mutation_steps") != minimum_steps:
            add_error(errors, question_id, "incorrect minimum mutation steps")
        if difficulty.get("minimum_reasoning_dimensions") != minimum_dimensions:
            add_error(errors, question_id, "incorrect minimum reasoning dimensions")

        checks = set(difficulty.get("anti_shortcut_checks", []))
        required_checks = COMMON_CHECKS | (EXPERT_CHECKS if tier == "expert" else set())
        if not required_checks <= checks:
            add_error(errors, question_id, "incomplete anti-shortcut checks")
        gold = set(question.get("required_gold", []))
        required_gold = COMMON_GOLD | (
            {"composed_mutation_nonredundancy_review"} if tier == "expert" else set()
        )
        if not required_gold <= gold:
            add_error(errors, question_id, "missing difficulty gold certificate")

    expected_label_counts = {label: 150 for label in LABELS}
    expected_tier_counts = {"hard": 300, "expert": 300}
    expected_label_tiers = {f"{label}:{tier}": 75 for label in LABELS for tier in TIERS}
    if len(questions) != 600:
        errors.append(f"root: expected 600 questions, got {len(questions)}")
    if dict(labels) != expected_label_counts:
        errors.append(f"root: class imbalance: {dict(labels)}")
    if dict(tiers) != expected_tier_counts:
        errors.append(f"root: tier imbalance: {dict(tiers)}")
    if dict(label_tiers) != expected_label_tiers:
        errors.append(f"root: label/tier imbalance: {dict(label_tiers)}")
    if len(base_slots) != 100:
        errors.append(f"root: expected 100 bases, got {len(base_slots)}")
    if set(base_slots) != set(catalog_tasks):
        errors.append("root: question bases differ from frozen catalog")

    for base_id, slots in base_slots.items():
        base_index = catalog_indices.get(base_id)
        if base_index is None or slots != expected_base_slots(base_index):
            errors.append(f"{base_id}: incorrect six-question label/tier schedule")
        if base_subquestion_indices[base_id] != set(range(1, 7)):
            errors.append(f"{base_id}: subquestion indices must be exactly 1..6")

    return {
        "schema": "tespec-four-class-difficulty-audit/v1",
        "passed": not errors,
        "scope": "construction-plan-only",
        "release_ready": False,
        "authoritative_nano_gate_status": "pending-materialized-three-attempt-runs",
        "error_count": len(errors),
        "errors": errors[:200],
        "question_count": len(questions),
        "base_program_count": len(base_slots),
        "catalog_sha256": catalog_sha256,
        "class_counts": dict(labels),
        "tier_counts": dict(tiers),
        "label_tier_counts": dict(label_tiers),
        "difficulty_scores": {
            tier: {
                "minimum": min(values) if values else None,
                "maximum": max(values) if values else None,
            }
            for tier, values in scores.items()
        },
        "reasoning_dimension_counts": dict(dimensions.most_common()),
        "spec_operator_counts": dict(spec_operators.most_common()),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--plan",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/question-plan-600.json",
    )
    parser.add_argument(
        "--catalog",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/selected-programs.json",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/difficulty-audit.json",
    )
    args = parser.parse_args()
    payload = json.loads(args.plan.read_text(encoding="utf-8"))
    catalog = json.loads(args.catalog.read_text(encoding="utf-8"))
    catalog_sha256 = hashlib.sha256(args.catalog.read_bytes()).hexdigest()
    report = audit(payload, catalog, catalog_sha256)
    target = args.output.resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(
        json.dumps(
            {
                "passed": report["passed"],
                "error_count": report["error_count"],
                "question_count": report["question_count"],
                "class_counts": report["class_counts"],
                "tier_counts": report["tier_counts"],
                "difficulty_scores": report["difficulty_scores"],
                "output": str(target),
            },
            ensure_ascii=False,
            indent=2,
        )
    )
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
