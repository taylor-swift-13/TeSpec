From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_merge_entail_wit_1 : Goal.IntList_merge_entail_wit_1.
Proof.
  unfold Goal.IntList_merge_entail_wit_1.
  right.
  intros.
  cbn [cn_merge].
  entailer!.
Qed.

Lemma proof_of_IntList_merge_return_wit_1 : Goal.IntList_merge_return_wit_1.
Proof.
  unfold Goal.IntList_merge_return_wit_1.
  right.
  intros r l xs ys y y2 y3 H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14.
  rewrite H13, H14.
  cbn [cn_merge].
  entailer!.
Qed.

Lemma proof_of_IntList_merge_precondition_wit_1 : Goal.IntList_merge_precondition_wit_1.
Proof.
Abort.

End Proofs.
