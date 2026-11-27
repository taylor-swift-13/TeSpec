From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac finish_array :=
  cbn [CharArray.full CharArray.seg
       CharArray.undef_full CharArray.undef_seg repeat_Z];
  simpl;
  entailer!.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  left.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  left.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  left.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Proof.
  unfold Goal.init_array2_entail_wit_5.
  left.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Proof.
  unfold Goal.init_array2_entail_wit_6.
  left.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_7 : Goal.init_array2_entail_wit_7.
Proof.
  unfold Goal.init_array2_entail_wit_7.
  left.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_8 : Goal.init_array2_entail_wit_8.
Proof.
  unfold Goal.init_array2_entail_wit_8.
  left.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_9 : Goal.init_array2_entail_wit_9.
Proof.
  unfold Goal.init_array2_entail_wit_9.
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros.
  subst p_pre.
  subst n_pre.
  Exists (repeat_Z 0 8).
  finish_array.
Qed.

End Proofs.
