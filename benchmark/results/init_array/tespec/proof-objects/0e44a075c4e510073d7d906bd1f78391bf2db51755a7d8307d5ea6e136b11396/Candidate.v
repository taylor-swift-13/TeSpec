From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac finish_array :=
  cbn [CharArray.full CharArray.seg CharArray.undef_full
       CharArray.undef_seg repeat_Z];
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
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6
         PreH7 PreH8 PreH9 PreH10 PreH11.
  subst p_pre.
  subst n_pre.
  Exists (repeat_Z 0 5).
  finish_array.
Qed.

End Proofs.
