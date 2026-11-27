From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
From Coq Require Import ZArith List Lia.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_loop_entail_wit_1 : Goal.IntList_rev_loop_entail_wit_1.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_1.
  right.
  intros y y_2 PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7.
  Exists 8192 (cons 2 (@nil Z)) (-1).
  simpl sll.
  Exists 0.
  entailer!.
Qed.

Lemma proof_of_IntList_rev_loop_entail_wit_2 : Goal.IntList_rev_loop_entail_wit_2.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_2.
  right.
  intros y y_2 PreH1 PreH2 PreH3 PreH4 PreH5 PreH6.
  Exists 0 (@nil Z) (-1) (cons 2 (@nil Z)).
  simpl sll.
  Exists 0.
  entailer!.
Qed.

Lemma proof_of_IntList_rev_loop_precondition_wit_1 : Goal.IntList_rev_loop_precondition_wit_1.
Proof.
Abort.

End Proofs.
