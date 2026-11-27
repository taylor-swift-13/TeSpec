From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_append_precondition_wit_1 : Goal.IntList_append_precondition_wit_1.
Proof.
  unfold Goal.IntList_append_precondition_wit_1.
  exists (@nil Z).
  exists (cons INT_MAX (cons 0 (cons INT_MIN (@nil Z)))).
  exists 8192.
  exists 0.
  (* Unresolved: construct a concrete state containing three disjoint
     list nodes and prove that it satisfies the instantiated assertion. *)
Abort.

End Proofs.
