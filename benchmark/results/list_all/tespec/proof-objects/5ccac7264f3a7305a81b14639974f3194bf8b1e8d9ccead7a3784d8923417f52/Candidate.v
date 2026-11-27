From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_append_precondition_wit_1 : Goal.IntList_append_precondition_wit_1.
Proof.
  unfold Goal.IntList_append_precondition_wit_1.
  exists (cons INT_MAX (cons 0 (cons INT_MIN (@nil Z)))).
  exists (cons 2 (cons (-1) (@nil Z))).
  exists 8192.
  exists 16384.
  (* Unresolved: construct a concrete heap satisfying both separated lists. *)
Abort.

End Proofs.
