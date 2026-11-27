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

Ltac expand_array_assertion fuel t k :=
  lazymatch fuel with
  | O => k t
  | S ?fuel' =>
    lazymatch t with
    | ?P ** ?Q =>
        expand_array_assertion fuel' P ltac:(fun P' =>
          expand_array_assertion fuel' Q ltac:(fun Q' =>
            let r := constr:(P' ** Q') in k r))
    | ?P && ?Q =>
        expand_array_assertion fuel' P ltac:(fun P' =>
          expand_array_assertion fuel' Q ltac:(fun Q' =>
            let r := constr:(P' && Q') in k r))
    | “ ?P ” => k t
    | emp => k t
    | TT => k t
    | (?p # Char |-> ?v) => k t
    | (?p # Char |->_) => k t
    | _ =>
        let h := array_head t in
        tryif is_const h then
          let u := eval unfold h in t in
          let u := eval cbn beta iota zeta in u in
          tryif constr_eq t u then k t
          else expand_array_assertion fuel' u k
        else k t
    end
  end.

Ltac expand_arrays :=
  lazymatch goal with
  | |- ?P |-- ?Q =>
      let fuel := eval compute in (32%nat) in
      expand_array_assertion fuel P ltac:(fun P' =>
        expand_array_assertion fuel Q ltac:(fun Q' =>
          change (P' |-- Q')))
  end.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  expand_arrays.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  right.
  expand_arrays.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  right.
  expand_arrays.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  right.
  expand_arrays.
  simpl.
  entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  right.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8.
  subst p_pre.
  subst n_pre.
  Exists (repeat_Z 0 3).
  expand_arrays.
  simpl.
  entailer!.
Qed.

End Proofs.
