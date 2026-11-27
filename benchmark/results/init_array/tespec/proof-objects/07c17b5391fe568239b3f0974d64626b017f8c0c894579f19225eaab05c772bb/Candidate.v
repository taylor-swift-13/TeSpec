From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac expand_arrays :=
  cbn [CharArray.seg CharArray.full CharArray.undef_seg
       CharArray.undef_full repeat_Z];
  simpl.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Proof.
  unfold Goal.init_array2_entail_wit_5.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Proof.
  unfold Goal.init_array2_entail_wit_6.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_7 : Goal.init_array2_entail_wit_7.
Proof.
  unfold Goal.init_array2_entail_wit_7.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_8 : Goal.init_array2_entail_wit_8.
Proof.
  unfold Goal.init_array2_entail_wit_8.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_9 : Goal.init_array2_entail_wit_9.
Proof.
  unfold Goal.init_array2_entail_wit_9.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_10 : Goal.init_array2_entail_wit_10.
Proof.
  unfold Goal.init_array2_entail_wit_10.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_11 : Goal.init_array2_entail_wit_11.
Proof.
  unfold Goal.init_array2_entail_wit_11.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_12 : Goal.init_array2_entail_wit_12.
Proof.
  unfold Goal.init_array2_entail_wit_12.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_13 : Goal.init_array2_entail_wit_13.
Proof.
  unfold Goal.init_array2_entail_wit_13.
  left.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_14 : Goal.init_array2_entail_wit_14.
Proof.
  unfold Goal.init_array2_entail_wit_14.
  right.
  expand_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros.
  subst p_pre n_pre.
  Exists (repeat_Z 0 13).
  expand_arrays.
  entailer!.
Qed.

End Proofs.
