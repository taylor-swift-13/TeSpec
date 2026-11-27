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
  right.
  unfold CharArray.undef_full, CharArray.undef_seg.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros.
  subst.
  Exists (repeat_Z 0 8).
  unfold CharArray.full, CharArray.seg.
  simpl.
  entailer!.
Qed.

End Proofs.
