From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac assertion_head t :=
  lazymatch t with
  | ?f ?x => assertion_head f
  | _ => t
  end.

Ltac array_leaf t :=
  lazymatch t with
  | ?P ** ?Q => first [array_leaf P | array_leaf Q]
  | ?P && ?Q => first [array_leaf P | array_leaf Q]
  | emp => fail
  | TT => fail
  | “ ?P ” => fail
  | (?p # Char |-> ?v) => fail
  | (?p # Char |->_) => fail
  | _ =>
      let f := assertion_head t in
      is_const f;
      progress unfold f
  end.

Ltac normalize_arrays :=
  repeat progress (
    simpl;
    match goal with
    | |- ?P |-- ?Q => array_leaf Q
    end);
  simpl.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  left.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  left.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  left.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Proof.
  unfold Goal.init_array2_entail_wit_5.
  left.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Proof.
  unfold Goal.init_array2_entail_wit_6.
  left.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_7 : Goal.init_array2_entail_wit_7.
Proof.
  unfold Goal.init_array2_entail_wit_7.
  left.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_8 : Goal.init_array2_entail_wit_8.
Proof.
  unfold Goal.init_array2_entail_wit_8.
  left.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_9 : Goal.init_array2_entail_wit_9.
Proof.
  unfold Goal.init_array2_entail_wit_9.
  right.
  normalize_arrays.
  entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9 PreH10 PreH11 PreH12 PreH13 PreH14.
  subst p_pre; subst n_pre.
  Exists (repeat_Z 0 8).
  normalize_arrays.
  entailer!.
Qed.

End Proofs.
