From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_loop_entail_wit_1 : Goal.IntList_rev_loop_entail_wit_1.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_1.
  left.
  intros y_2 y y_3 Hy Hy_2 Hy_3.
  Exists (@nil Z) (INT_MIN :: 0 :: INT_MAX :: nil).
  simpl sll.
  Exists y_2 8192 0.
  entailer!.
Qed.

Lemma proof_of_IntList_rev_loop_entail_wit_2 : Goal.IntList_rev_loop_entail_wit_2.
Proof. Abort.

Lemma proof_of_IntList_rev_loop_entail_wit_3 : Goal.IntList_rev_loop_entail_wit_3.
Proof. Abort.

Lemma proof_of_IntList_rev_loop_return_wit_2 : Goal.IntList_rev_loop_return_wit_2.
Proof. Abort.

Lemma proof_of_IntList_rev_loop_return_wit_3 : Goal.IntList_rev_loop_return_wit_3.
Proof. Abort.

Lemma proof_of_IntList_rev_loop_precondition_wit_1 : Goal.IntList_rev_loop_precondition_wit_1.
Proof. Abort.

End Proofs.
