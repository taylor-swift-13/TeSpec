From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_pop_precondition_wit_1 : Goal.pop_precondition_wit_1.
Proof.
  unfold Goal.pop_precondition_wit_1.
  exists (cons 1 (@nil Z)), 2, 8192, 4096.
  (* Unresolved: construct a concrete satisfying heap with stack size 2,
     stack data pointer 8192, and two disjoint list nodes containing 2 and 1.
     This assertion does not hold on the empty model. *)
Abort.

End Proofs.
