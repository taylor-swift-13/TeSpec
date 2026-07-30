#!/usr/bin/env python3
"""Build a balanced 600-question mutation plan with enforced difficulty.

The output is a construction plan. It does not claim that a planned mutation
has the requested semantics: every materialized question must later carry the
checked certificates listed in ``required_gold``.  Difficulty is represented
as a rejectable contract rather than a descriptive label.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
from collections import Counter
from pathlib import Path
from typing import Any

PROJECT_ROOT = Path(__file__).resolve().parents[1]

LABEL_BITS = {
    "correct": {"sound": True, "complete": True},
    "soundness": {"sound": True, "complete": False},
    "complete": {"sound": False, "complete": True},
    "incomparable": {"sound": False, "complete": False},
}

LABEL_ORDER = ("correct", "soundness", "complete", "incomparable")

EXTRA_LABEL_PAIRS = (
    ("correct", "soundness"),
    ("soundness", "complete"),
    ("complete", "incomparable"),
    ("incomparable", "correct"),
)

EQUIVALENT_SPEC_RECIPES = (
    "equivalent_reassociation",
    "equivalent_transparent_fold_unfold",
    "equivalent_quantifier_alpha_rename",
    "equivalent_old_state_normalization",
    "equivalent_predicate_layer_indirection",
    "equivalent_conjunct_permutation",
)

WEAK_SPEC_RECIPES = {
    "default": (
        "drop_post_conjunct",
        "weaken_exact_result",
        "widen_numeric_bound",
        "existentialize_exact_output",
    ),
    "heap": (
        "drop_heap_effect",
        "omit_owned_region_relation",
        "forget_old_to_new_heap_relation",
    ),
    "quantified": (
        "drop_universal_clause",
        "weaken_order_or_permutation",
    ),
    "multi_call": (
        "drop_external_call_effect",
        "forget_callee_visible_state",
    ),
    "native_float": (
        "widen_float_post_relation",
        "drop_finite_or_exact_fp_clause",
    ),
    "singly_linked": (
        "forget_sll_suffix_or_length",
        "drop_sll_content_relation",
    ),
    "doubly_linked": (
        "forget_prev_link_consistency",
        "forget_dll_head_or_tail",
    ),
}

STRONG_SPEC_RECIPES = {
    "default": (
        "add_valid_output_constraint",
        "narrow_valid_input_domain",
        "strengthen_result_equality",
    ),
    "heap": (
        "require_extra_unchanged_cell",
        "overconstrain_final_heap",
    ),
    "quantified": (
        "strengthen_quantified_bound",
        "add_global_order_constraint",
    ),
    "multi_call": (
        "overconstrain_call_result_or_trace",
        "require_extra_callee_effect",
    ),
    "native_float": (
        "narrow_float_range",
        "require_extra_fp_equality",
    ),
    "singly_linked": (
        "require_extra_sll_shape",
        "overconstrain_sll_content",
    ),
    "doubly_linked": (
        "require_extra_prev_next_relation",
        "overconstrain_dll_endpoint",
    ),
}

IMPL_MUTATION_RECIPES = {
    "default": (
        "return_expression_change",
        "branch_condition_change",
        "constant_replacement",
    ),
    "heap": (
        "array_index_shift",
        "omit_heap_write",
        "write_wrong_field_or_cell",
        "loop_bound_off_by_one",
    ),
    "multi_call": (
        "omit_visible_call",
        "swap_call_arguments",
        "change_call_order",
        "ignore_callee_return",
    ),
    "native_float": (
        "float_operator_replacement",
        "float_comparison_boundary",
        "float_literal_replacement",
    ),
    "singly_linked": (
        "skip_or_duplicate_sll_node",
        "wrong_sll_head_or_tail",
        "omit_sll_link_update",
    ),
    "doubly_linked": (
        "omit_prev_or_next_update",
        "swap_dll_endpoint_update",
        "unlink_only_one_direction",
    ),
}


def feature_recipes(
    entry: dict[str, Any], recipes: dict[str, tuple[str, ...]]
) -> list[str]:
    result: list[str] = []
    for feature in (
        "native_float",
        "doubly_linked",
        "singly_linked",
        "multi_call",
        "quantified",
        "heap",
    ):
        if entry.get(feature):
            result.extend(recipes.get(feature, ()))
    result.extend(recipes["default"])
    return list(dict.fromkeys(result))


def pick(items: list[str] | tuple[str, ...], seed: int) -> str:
    return items[seed % len(items)]


def pick_distinct(
    items: list[str] | tuple[str, ...], seed: int, excluded: set[str]
) -> str:
    for offset in range(len(items)):
        candidate = pick(items, seed + offset)
        if candidate not in excluded:
            return candidate
    raise ValueError("cannot choose a distinct mutation recipe")


def safe_id(value: str) -> str:
    return re.sub(r"[^A-Za-z0-9]+", "_", value).strip("_").lower()


def question_slots(base_index: int) -> list[tuple[str, str]]:
    slots: list[tuple[str, str]] = []
    for label_index, label in enumerate(LABEL_ORDER):
        tier = "hard" if (base_index + label_index) % 2 == 0 else "expert"
        slots.append((label, tier))
    for label in EXTRA_LABEL_PAIRS[base_index % len(EXTRA_LABEL_PAIRS)]:
        label_index = LABEL_ORDER.index(label)
        tier = "expert" if (base_index + label_index) % 2 == 0 else "hard"
        slots.append((label, tier))
    return slots


def spec_recipe(
    entry: dict[str, Any], label: str, tier: str, seed: int
) -> dict[str, Any]:
    weak = feature_recipes(entry, WEAK_SPEC_RECIPES)
    strong = feature_recipes(entry, STRONG_SPEC_RECIPES)
    equivalent = pick(EQUIVALENT_SPEC_RECIPES, seed)
    if label == "correct":
        relation = "equivalent"
        operators = [equivalent]
        semantic_roles = ["equivalence"]
    elif label == "soundness":
        relation = "strictly_stronger"
        operators = [pick(strong, seed)]
        semantic_roles = ["strengthening"]
    elif label == "complete":
        relation = "strictly_weaker"
        operators = [pick(weak, seed)]
        semantic_roles = ["weakening"]
    else:
        relation = "incomparable"
        operators = [pick(weak, seed), pick(strong, seed + 1)]
        semantic_roles = ["weakening", "strengthening"]

    if tier == "expert":
        camouflage = pick_distinct(
            EQUIVALENT_SPEC_RECIPES,
            seed + 5,
            set(operators),
        )
        operators.insert(0, camouflage)
        semantic_roles.insert(0, "equivalence")
    return {
        "relation": relation,
        "operators": operators,
        "semantic_roles": semantic_roles,
        "composition": "sequential_nonredundant",
        "camouflage": tier == "expert",
    }


def reasoning_dimensions(entry: dict[str, Any], tier: str) -> list[str]:
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
    return list(dict.fromkeys(dimensions))


def difficulty_contract(
    entry: dict[str, Any],
    tier: str,
    spec: dict[str, Any],
) -> dict[str, Any]:
    dimensions = reasoning_dimensions(entry, tier)
    step_count = len(spec["operators"])
    tier_bonus = 8 if tier == "hard" else 18
    score = round(
        min(float(entry["difficulty_score"]), 60.0) * 0.5
        + step_count * 6
        + len(dimensions) * 3
        + tier_bonus,
        3,
    )
    minimum_score = 22 if tier == "hard" else 40
    minimum_steps = 1 if tier == "hard" else 2
    checks = [
        "semantic_gold_required",
        "operator_and_label_hidden_from_public_input",
        "source_family_locked_to_single_split",
        "balanced_surface_statistics",
        "label_blind_mutation_review",
        "gpt5_nano_three_attempt_gate",
    ]
    if tier == "expert":
        checks.extend(
            [
                "surface_camouflage_required",
                "composed_mutation_nonredundancy",
            ]
        )
    return {
        "tier": tier,
        "score": score,
        "minimum_score": minimum_score,
        "static_base_score": entry["difficulty_score"],
        "reasoning_dimensions": dimensions,
        "minimum_reasoning_dimensions": 2 if tier == "hard" else 3,
        "spec_mutation_step_count": step_count,
        "minimum_spec_mutation_steps": minimum_steps,
        "anti_shortcut_checks": checks,
    }


def required_gold(label: str, tier: str) -> list[str]:
    bits = LABEL_BITS[label]
    result: list[str] = [
        "legal_input_domain_certificate",
        "implementation_hash",
        "spec_typecheck",
        "mutation_lineage_hash",
        "difficulty_gate_certificate",
        "gpt5_nano_difficulty_gate",
        "surface_statistics_audit",
        "label_blind_mutation_audit",
    ]
    if tier == "expert":
        result.append("composed_mutation_nonredundancy_certificate")
    if bits["sound"]:
        result.append("proof_spec_relation_subset_implementation")
    else:
        result.append("checked_spec_only_behavior_witness")
    if bits["complete"]:
        result.append("proof_implementation_subset_spec_relation")
    else:
        result.append("checked_implementation_behavior_rejected_witness")
    return result


def build_questions(tasks: list[dict[str, Any]]) -> list[dict[str, Any]]:
    questions: list[dict[str, Any]] = []
    for base_index, entry in enumerate(tasks):
        impl_recipes = feature_recipes(entry, IMPL_MUTATION_RECIPES)
        for slot, (label, tier) in enumerate(question_slots(base_index), 1):
            seed = base_index * 17 + slot * 11
            question_id = f"{safe_id(entry['id'])}__q{slot:02d}"
            selected_spec_recipe = spec_recipe(entry, label, tier, seed)
            questions.append(
                {
                    "question_id": question_id,
                    "base_index": base_index,
                    "base_id": entry["id"],
                    "source_family": entry["family"],
                    "construction_source": entry["source"],
                    "target_function": entry["function"],
                    "target_label": label,
                    **LABEL_BITS[label],
                    "public_inputs": ["impl.c", "spec.qcp"],
                    "difficulty": difficulty_contract(
                        entry,
                        tier,
                        selected_spec_recipe,
                    ),
                    "mutation_lineage": {
                        "visibility": "hidden",
                        "parent_base_id": entry["id"],
                        "split_group": f"{entry['corpus']}:{entry['family']}",
                        "materialization_order": [
                            "implementation",
                            "specification_against_current_implementation",
                        ],
                        "spec": selected_spec_recipe,
                        "implementation": {
                            "operator": pick(impl_recipes, seed + 3),
                            "must_compile": True,
                            "must_preserve_defined_execution_domain": True,
                            "must_have_checked_parent_divergence": True,
                        },
                    },
                    "required_gold": required_gold(label, tier),
                    "materialization_status": "pending",
                }
            )
    return questions


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--catalog",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/selected-programs.json",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/question-plan-600.json",
    )
    args = parser.parse_args()

    catalog = json.loads(args.catalog.read_text(encoding="utf-8"))
    catalog_sha256 = hashlib.sha256(args.catalog.read_bytes()).hexdigest()
    tasks = catalog["tasks"]
    if len(tasks) != 100:
        raise SystemExit(f"expected 100 base tasks, got {len(tasks)}")
    questions = build_questions(tasks)
    counts = Counter(question["target_label"] for question in questions)
    tier_counts = Counter(question["difficulty"]["tier"] for question in questions)
    label_tier_counts = Counter(
        (question["target_label"], question["difficulty"]["tier"])
        for question in questions
    )
    expected = {
        "correct": 150,
        "soundness": 150,
        "complete": 150,
        "incomparable": 150,
    }
    expected_label_tiers = {
        (label, tier): 75 for label in LABEL_BITS for tier in ("hard", "expert")
    }
    if (
        len(questions) != 600
        or dict(counts) != expected
        or dict(tier_counts) != {"hard": 300, "expert": 300}
        or dict(label_tier_counts) != expected_label_tiers
    ):
        raise SystemExit(
            "unbalanced question plan: "
            f"total={len(questions)}, labels={counts}, tiers={tier_counts}, "
            f"label_tiers={label_tier_counts}"
        )
    report = {
        "schema": "tespec-four-class-question-plan/v2",
        "status": (
            "mutation-plan-requires-materialization-gold-audit-and-gpt5-nano-gate"
        ),
        "catalog_sha256": catalog_sha256,
        "base_program_count": len(tasks),
        "questions_per_base": 6,
        "question_count": len(questions),
        "class_counts": dict(counts),
        "difficulty_tier_counts": dict(tier_counts),
        "difficulty_policy": {
            "authoritative_gate": (
                "openai/gpt-5-nano generic agent, three independent attempts; "
                "retain at 0/3 or 1/3 correct, replace at 2/3 or 3/3 correct"
            ),
            "hard": (
                "at least one semantic spec mutation, two reasoning dimensions, "
                "score >= 22"
            ),
            "expert": (
                "at least two composed nonredundant spec mutations including "
                "surface camouflage, three reasoning dimensions, score >= 40"
            ),
            "release_rule": (
                "a planned tier is not gold until every required certificate "
                "and anti-shortcut audit passes"
            ),
        },
        "class_semantics": {
            "correct": "sound=true, complete=true",
            "soundness": "sound=true, complete=false",
            "complete": "sound=false, complete=true",
            "incomparable": "sound=false, complete=false",
        },
        "questions": questions,
    }
    target = args.output.resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(
        json.dumps(
            {
                "base_program_count": len(tasks),
                "question_count": len(questions),
                "class_counts": dict(counts),
                "difficulty_tier_counts": dict(tier_counts),
                "output": str(target),
            },
            ensure_ascii=False,
            indent=2,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
