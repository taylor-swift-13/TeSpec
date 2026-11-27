From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_length_precondition_wit_1 : Goal.IntList_length_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_precondition_wit_1.
  exists (cons (-1) (cons 0 (cons 3 (@nil Z)))).
  exists 8192.
  (* Unresolved: construct a concrete heap satisfying the three-node sll.
     The empty model does not satisfy this instantiated assertion. *)
Abort.

End Proofs.
