From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac concrete_array :=
  unfold CharArray.full, CharArray.seg;
  cbn;
  first [solve [cancel] | solve [entailer!]].

Lemma spatial_5 : Goal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold Goal.init_array2_entail_wit_1_split_goal_spatial.
  concrete_array.
Qed.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right. exact spatial_5.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  right. concrete_array.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  right. concrete_array.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  right. concrete_array.
Qed.

Lemma proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Proof.
  unfold Goal.init_array2_entail_wit_5.
  right. concrete_array.
Qed.

Lemma proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Proof.
  unfold Goal.init_array2_entail_wit_6.
  right.
  unfold CharArray.undef_full, CharArray.undef_seg.
  cbn.
  first [solve [cancel] | solve [entailer!]].
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  right.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9 PreH10.
  subst p_pre. subst n_pre.
  replace (4096 + (0 * sizeof(CHAR))) with 4096 by ring.
  Exists (repeat_Z 0 5).
  exact spatial_5.
Qed.

End Proofs.
