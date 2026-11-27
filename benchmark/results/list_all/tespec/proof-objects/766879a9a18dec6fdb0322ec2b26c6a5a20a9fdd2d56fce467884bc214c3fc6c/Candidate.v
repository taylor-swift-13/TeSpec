From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_length_precondition_wit_1 : Goal.IntList_length_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_precondition_wit_1.
  exists (cons INT_MAX (cons 0%Z (cons INT_MIN (@nil Z)))).
  exists 8192%Z.
  (* Unresolved: construct a concrete state satisfying the three-node sll. *)
Abort.

End Proofs.
