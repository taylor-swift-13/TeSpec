From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_merge_return_wit_1 : Goal.IntList_merge_return_wit_1.
Proof.
  unfold Goal.IntList_merge_return_wit_1.
  right.
  intros.
  subst.
  cbn [cn_merge].
  entailer!.
Qed.

Lemma proof_of_IntList_merge_precondition_wit_1 : Goal.IntList_merge_precondition_wit_1.
Proof.
Abort.

End Proofs.
