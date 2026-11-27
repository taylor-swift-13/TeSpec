From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import FulminateMerge.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_merge_entail_wit_1 : Goal.IntList_merge_entail_wit_1.
Proof.
  unfold Goal.IntList_merge_entail_wit_1.
  right.
  intros.
  entailer!; vm_compute; reflexivity.
Qed.

Lemma proof_of_IntList_merge_entail_wit_2 : Goal.IntList_merge_entail_wit_2.
Proof.
  unfold Goal.IntList_merge_entail_wit_2.
  right.
  intros.
  entailer!; vm_compute; reflexivity.
Qed.

Lemma proof_of_IntList_merge_return_wit_1 : Goal.IntList_merge_return_wit_1.
Proof.
  unfold Goal.IntList_merge_return_wit_1.
  right.
  intros r l xs ys y y2 y3 y4 y5
    H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14 H15 H16 H17 H18 H19.
  assert (E : cn_merge l r = [2; -1; INT_MAX; 0; INT_MIN]).
  { subst l r. vm_compute. reflexivity. }
  rewrite E.
  entailer!.
Qed.

Lemma proof_of_IntList_merge_precondition_wit_1 : Goal.IntList_merge_precondition_wit_1.
Proof.
Abort.

End Proofs.
