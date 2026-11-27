From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (cons INT_MAX (cons 0 (cons INT_MIN (@nil Z)))).
  exists (-1), (-1), 8192.
  (* Unresolved: construct a concrete heap satisfying the three-node sll. *)
Abort.

End Proofs.
