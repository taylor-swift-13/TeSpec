From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Proof.
  unfold Goal.init_array2_entail_wit_5.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Proof.
  unfold Goal.init_array2_entail_wit_6.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_7 : Goal.init_array2_entail_wit_7.
Proof.
  unfold Goal.init_array2_entail_wit_7.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_8 : Goal.init_array2_entail_wit_8.
Proof.
  unfold Goal.init_array2_entail_wit_8.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_9 : Goal.init_array2_entail_wit_9.
Proof.
  unfold Goal.init_array2_entail_wit_9.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_10 : Goal.init_array2_entail_wit_10.
Proof.
  unfold Goal.init_array2_entail_wit_10.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_11 : Goal.init_array2_entail_wit_11.
Proof.
  unfold Goal.init_array2_entail_wit_11.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_12 : Goal.init_array2_entail_wit_12.
Proof.
  unfold Goal.init_array2_entail_wit_12.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_13 : Goal.init_array2_entail_wit_13.
Proof.
  unfold Goal.init_array2_entail_wit_13.
  left.
  unfold CharArray.seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_14 : Goal.init_array2_entail_wit_14.
Proof.
  unfold Goal.init_array2_entail_wit_14.
  right.
  unfold CharArray.undef_full, CharArray.undef_seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6
    PreH7 PreH8 PreH9 PreH10 PreH11 PreH12 PreH13 PreH14
    PreH15 PreH16 PreH17 PreH18 PreH19.
  subst p_pre.
  subst n_pre.
  Exists (repeat_Z 0 13).
  unfold CharArray.full, CharArray.seg.
  simpl.
  entailer!.
Qed.

End Proofs.
