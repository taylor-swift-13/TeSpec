From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_split_return_wit_1 : Goal.IntList_split_return_wit_1.
Proof.
  unfold Goal.IntList_split_return_wit_1.
  right.
  intros l xs y H1 H2 H3 H4 H5 H6 H7.
  subst l.
  cbn [cn_split_fst cn_split_snd cn_split fst snd].
  entailer!.
Qed.

Lemma proof_of_IntList_split_precondition_wit_1 : Goal.IntList_split_precondition_wit_1.
Proof.
Abort.

End Proofs.
