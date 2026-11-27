From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_push_induction_precondition_wit_1 : Goal.push_induction_precondition_wit_1.
Proof.
  unfold Goal.push_induction_precondition_wit_1.
  exists (@nil Z), 16384, 7, 12288, 12288.
  (* Unresolved: construct a concrete state satisfying the two field
     assertions and the empty queue segment, then apply the entailment. *)
Abort.

End Proofs.
