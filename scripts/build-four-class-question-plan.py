#!/usr/bin/env python3
"""Expand 100 base programs into a balanced 600-question mutation plan.

The output is a construction plan. It does not claim that a planned mutation
has the requested semantics: every materialized question must later carry the
checked certificates listed in ``required_gold``.
"""

from __future__ import annotations

import argparse
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


def safe_id(value: str) -> str:
    return re.sub(r"[^A-Za-z0-9]+", "_", value).strip("_").lower()


def question_labels(base_index: int) -> list[str]:
    labels = ["correct", "soundness", "complete", "incomparable"]
    labels.extend(EXTRA_LABEL_PAIRS[base_index % len(EXTRA_LABEL_PAIRS)])
    return labels


def spec_recipe(entry: dict[str, Any], label: str, seed: int) -> dict[str, str]:
    weak = feature_recipes(entry, WEAK_SPEC_RECIPES)
    strong = feature_recipes(entry, STRONG_SPEC_RECIPES)
    if label == "correct":
        return {
            "relation": "equivalent",
            "primary": pick(EQUIVALENT_SPEC_RECIPES, seed),
        }
    if label == "soundness":
        return {
            "relation": "strictly_stronger",
            "primary": pick(strong, seed),
        }
    if label == "complete":
        return {
            "relation": "strictly_weaker",
            "primary": pick(weak, seed),
        }
    return {
        "relation": "incomparable",
        "primary": pick(weak, seed),
        "secondary": pick(strong, seed + 1),
    }


def required_gold(label: str) -> list[str]:
    bits = LABEL_BITS[label]
    result: list[str] = [
        "legal_input_domain_certificate",
        "implementation_hash",
        "spec_typecheck",
        "mutation_lineage_hash",
    ]
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
        for slot, label in enumerate(question_labels(base_index), 1):
            seed = base_index * 13 + slot * 7
            question_id = f"{safe_id(entry['id'])}__q{slot:02d}"
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
                    "mutation_lineage": {
                        "visibility": "hidden",
                        "parent_base_id": entry["id"],
                        "materialization_order": [
                            "implementation",
                            "specification_against_current_implementation",
                        ],
                        "spec": spec_recipe(entry, label, seed),
                        "implementation": {
                            "operator": pick(impl_recipes, seed + 3),
                            "must_compile": True,
                            "must_preserve_defined_execution_domain": True,
                        },
                    },
                    "required_gold": required_gold(label),
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
    tasks = catalog["tasks"]
    if len(tasks) != 100:
        raise SystemExit(f"expected 100 base tasks, got {len(tasks)}")
    questions = build_questions(tasks)
    counts = Counter(question["target_label"] for question in questions)
    expected = {
        "correct": 150,
        "soundness": 150,
        "complete": 150,
        "incomparable": 150,
    }
    if len(questions) != 600 or dict(counts) != expected:
        raise SystemExit(
            f"unbalanced question plan: total={len(questions)}, labels={counts}"
        )
    report = {
        "schema": "tespec-four-class-question-plan/v1",
        "status": "mutation-plan-requires-materialization-and-gold-audit",
        "base_program_count": len(tasks),
        "questions_per_base": 6,
        "question_count": len(questions),
        "class_counts": dict(counts),
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
                "output": str(target),
            },
            ensure_ascii=False,
            indent=2,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
