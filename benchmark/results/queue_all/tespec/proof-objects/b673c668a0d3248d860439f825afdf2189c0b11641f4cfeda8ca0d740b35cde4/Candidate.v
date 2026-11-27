From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_induction_precondition_wit_1 : Goal.push_induction_precondition_wit_1.
Proof.
  unfold Goal.push_induction_precondition_wit_1.
  exists (@nil Z), 16384, 7, 12288, 12288.
  (* Unresolved: establish satisfiability of the two disjoint field stores. *)
Abort.

End Proofs.
