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
  right.
  unfold CharArray.undef_full, CharArray.undef_seg.
  simpl.
  first
    [ solve [unfold CharArray.seg; simpl; entailer!]
    | solve [Intros v1 v0;
             Exists (v0 :: v1 :: nil);
             unfold CharArray.seg; simpl; entailer!]
    | solve [entailer!;
             unfold CharArray.seg in *; simpl in *; entailer!]
    | solve [entailer!;
             multimatch goal with
             | x : Z, y : Z |- _ =>
                 Exists (x :: y :: nil);
                 unfold CharArray.seg; simpl; entailer!
             end] ].
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8.
  subst p_pre n_pre.
  Exists (0 :: 0 :: nil).
  unfold CharArray.full, CharArray.seg.
  simpl.
  entailer!.
Qed.

End Proofs.
