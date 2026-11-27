From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac array_head t :=
  lazymatch t with
  | ?f ?x => array_head f
  | _ => t
  end.

Ltac array_normal_form p :=
  lazymatch p with
  | emp => constr:(p)
  | TT => constr:(p)
  | (?a # Char |-> ?v) => constr:(p)
  | (?a # Char |->_) => constr:(p)
  | “ ?q ” => constr:(p)
  | ?a ** ?b =>
      let a' := array_normal_form a in
      let b' := array_normal_form b in
      constr:(a' ** b')
  | ?a && ?b =>
      let a' := array_normal_form a in
      let b' := array_normal_form b in
      constr:(a' && b')
  | _ =>
      let h := array_head p in
      let q := eval unfold h in p in
      let q' := eval cbv beta iota zeta in q in
      array_normal_form q'
  end.

Ltac finish_array :=
  first
    [ solve [unfold CharArray.full; simpl; entailer!]
    | solve [unfold CharArray.undef_full; simpl; entailer!]
    | lazymatch goal with
      | |- ?lhs |-- ?rhs =>
          let lhs' := array_normal_form lhs in
          let rhs' := array_normal_form rhs in
          change (lhs' |-- rhs');
          simpl; entailer!
      end ].

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_5 : Goal.init_array2_entail_wit_5.
Proof.
  unfold Goal.init_array2_entail_wit_5.
  right.
  finish_array.
Qed.

Lemma proof_of_init_array2_entail_wit_6 : Goal.init_array2_entail_wit_6.
Proof.
  unfold Goal.init_array2_entail_wit_6.
  right.
  let lhs := match goal with |- ?lhs |-- _ => lhs end in
  let rhs := match goal with |- _ |-- ?rhs => rhs end in
  let lhs' := array_normal_form lhs in
  let rhs' := array_normal_form rhs in
  change (lhs' |-- rhs');
  simpl; entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  right.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6
         PreH7 PreH8 PreH9 PreH10.
  subst p_pre; subst n_pre.
  Exists (repeat_Z 0 5).
  finish_array.
Qed.

End Proofs.
