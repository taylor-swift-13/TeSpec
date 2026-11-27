From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (cons (1%Z) (@nil Z)), INT_MIN, INT_MIN, (8192%Z).
  (* Unresolved: construct a heap satisfying the singleton list assertion. *)
Abort.

End Proofs.
