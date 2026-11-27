From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac application_head t :=
  lazymatch t with
  | ?f ?x => application_head f
  | _ => t
  end.

Ltac expand_spatial t :=
  lazymatch t with
  | ?a ** ?b => first [expand_spatial a | expand_spatial b]
  | ?a && ?b => first [expand_spatial b | expand_spatial a]
  | emp => fail 1
  | “ ?p ” => fail 1
  | _ =>
      let h := application_head t in
      progress (unfold h; simpl)
  end.

Ltac finish_array :=
  simpl in *;
  repeat first
    [ solve [entailer!]
    | solve [auto]
    | solve [lia]
    | progress entailer!
    | match goal with
      | |- ?a |-- ?b => first [expand_spatial b | expand_spatial a]
      end
    ];
  try reflexivity.

Lemma two_initialized_chars :
  Goal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold Goal.init_array2_entail_wit_1_split_goal_spatial.
  unfold CharArray.full, CharArray.seg.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  exact two_initialized_chars.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  right.
  unfold CharArray.full, CharArray.seg.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  right.
  unfold CharArray.undef_full, CharArray.undef_seg.
  finish_array.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  right.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7.
  subst p_pre.
  subst n_pre.
  replace (4096 + 0 * sizeof(CHAR)) with 4096 by lia.
  Exists (repeat_Z 0 2).
  exact two_initialized_chars.
Qed.

End Proofs.
