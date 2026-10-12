#!/usr/bin/env python3
"""Exercise certificate rejection of inconsistent imported address axioms.

This is an adversarial trust-boundary test, not a program verification result.
No new axioms are introduced. The imported runtime supplies the contradiction.
"""

import argparse
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from spectest.certificates import check_certificate, digest, prepare_certificate  # noqa: E402


PROOF = """Require Import Goal Coq.ZArith.ZArith Coq.Strings.String.
From SimpleC.SL Require Import CNotation SeparationLogic.
Import {rules}.
Local Open Scope Z_scope.
Local Open Scope string_scope.
(* Adversarial audit only: never count this as a successful program proof. *)
Module Proofs.
Lemma proof_of_required : Goal.required.
Proof.
  unfold Goal.required.
  pose (R := RE_add_pi (RE_const 0 FET_int) 0).
  assert (eval_addr_expr (RE_addr_of (LE_arrow_field
    (RE_const (eval_addr_expr R) FET_int) "field")) =
    eval_addr_expr (RE_addr_of (LE_arrow_field R "field"))) as H.
  {{ apply eval_addr_expr_congr. apply RE_addr_of_congr.
     apply LE_arrow_field_congr; [apply eval_addr | reflexivity]. }}
  apply addr_of_arrow_field_inv in H.
  unfold R in H. discriminate H.
Qed.
End Proofs.
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--runtime", type=Path, default=ROOT / "runtime/qcip")
    parser.add_argument(
        "--rules", choices=("naive_C_Rules", "naive_C_Rules64"), default="naive_C_Rules"
    )
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    out.mkdir(parents=True, exist_ok=True)
    goal = out / "input_goal.v"
    goal.write_text(
        "Definition required : Prop := False.\n"
        "Module Type VC_Correct.\n"
        "Axiom proof_of_required : required.\nEnd VC_Correct.\n"
    )
    original = out / "original.json"
    original.write_text(
        json.dumps(
            {
                "schema": "qcp-spectest-vc-manifest/v1",
                "files": {"goal": str(goal)},
                "immutable_sha256": {"goal": digest(goal)},
                "qcip_root": str(args.runtime.resolve()),
                "coq_dependencies": [],
            },
            indent=2,
        )
        + "\n"
    )
    prepared = prepare_certificate(original, out / "certificate")
    Path(prepared["editable"]).write_text(PROOF.format(rules=args.rules))
    report = check_certificate(Path(prepared["manifest"]), prepared["manifest_sha256"])
    rejected = (
        report["status"] == "UNKNOWN"
        and report["reason"] == "unapproved_transitive_assumptions"
        and "CNotation.addr_of_arrow_field_inv" in report["unexpected_assumptions"]
        and all(stage["exit_code"] == 0 for stage in report["stages"])
        and report["stages"][-1]["stage"] == "compile_Assumptions.v"
    )
    result = {
        "scope": "adversarial runtime axiom audit; not a program test",
        "expected_rejection_observed": rejected,
        "runtime": str(args.runtime.resolve()),
        "rules": args.rules,
        "driver_sha256": digest(Path(__file__)),
        "manifest_sha256": prepared["manifest_sha256"],
        "certificate_report": report,
    }
    (out / "analysis.json").write_text(json.dumps(result, indent=2) + "\n")
    print(
        json.dumps(
            {
                "expected_rejection_observed": rejected,
                "analysis": str(out / "analysis.json"),
            }
        )
    )
    return 0 if rejected else 1


if __name__ == "__main__":
    raise SystemExit(main())
