From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_loop_entail_wit_1 : Goal.IntList_rev_loop_entail_wit_1.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_1.
  left.
  intros y_2 y y_3 H1 H2 H3 H4 H5.
  Exists (@nil Z) (INT_MIN :: 0 :: INT_MAX :: nil).
  simpl sll.
  Exists y_2 8192 0.
  try rewrite !Z.add_0_r.
  entailer!.
Qed.

Lemma proof_of_IntList_rev_loop_entail_wit_2 : Goal.IntList_rev_loop_entail_wit_2.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_2.
  left.
  intros y y_2 y_3 H1 H2 H3 H4.
  Exists (INT_MIN :: nil) (0 :: INT_MAX :: nil).
  simpl sll.
  Exists 8192 0 0.
  try rewrite !Z.add_0_r.
  entailer!.
Qed.

Lemma proof_of_IntList_rev_loop_entail_wit_3 : Goal.IntList_rev_loop_entail_wit_3.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_3.
  left.
  intros y y_2 y_3 H1 H2 H3.
  Exists (0 :: INT_MIN :: nil) (INT_MAX :: nil).
  simpl sll.
  Exists 0 y_2 0.
  try rewrite !Z.add_0_r.
  entailer!.
Qed.

Lemma proof_of_IntList_rev_loop_precondition_wit_1 : Goal.IntList_rev_loop_precondition_wit_1.
Proof. Abort.

End Proofs.
