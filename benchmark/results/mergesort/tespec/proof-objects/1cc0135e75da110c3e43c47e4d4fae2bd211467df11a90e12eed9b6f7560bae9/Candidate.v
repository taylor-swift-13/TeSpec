From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (cons INT_MAX (cons 0 (cons INT_MIN (@nil Z)))).
  exists (-1).
  exists 8192.
Abort.

End Proofs.
