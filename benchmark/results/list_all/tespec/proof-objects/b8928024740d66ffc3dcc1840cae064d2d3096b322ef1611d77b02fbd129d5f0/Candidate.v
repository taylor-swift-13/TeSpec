From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7 FulminateMerge.
From Coq Require Import ZArith List Lia.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_merge_return_wit_1 : Goal.IntList_merge_return_wit_1.
Proof.
  unfold Goal.IntList_merge_return_wit_1.
  right.
  intros.
  subst l___tespec_entry r___tespec_entry.
  assert (Hmerge :
    cn_merge [2; -1] [INT_MAX; 0; INT_MIN] =
    2 :: cn_merge [-1] [INT_MAX; 0; INT_MIN]).
  { vm_compute; reflexivity. }
  entailer!.
Qed.

Lemma proof_of_IntList_merge_precondition_wit_1 : Goal.IntList_merge_precondition_wit_1.
Proof.
Abort.

End Proofs.
