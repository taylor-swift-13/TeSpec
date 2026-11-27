From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac normalize_array_assertion fuel t :=
  lazymatch fuel with
  | O => constr:(t)
  | S ?fuel' =>
    lazymatch t with
    | emp => constr:(t)
    | (?p # Char |-> ?v) => constr:(t)
    | (?p # Char |->_) => constr:(t)
    | “ ?P ” => constr:(t)
    | ?P ** ?Q =>
      let P' := normalize_array_assertion fuel' P in
      let Q' := normalize_array_assertion fuel' Q in
      constr:(P' ** Q')
    | ?P && ?Q =>
      let P' := normalize_array_assertion fuel' P in
      let Q' := normalize_array_assertion fuel' Q in
      constr:(P' && Q')
    | _ =>
      let u := eval red in t in
      tryif constr_eq t u then constr:(t)
      else normalize_array_assertion fuel' u
    end
  end.

Ltac expand_array_assertions :=
  lazymatch goal with
  | |- ?P |-- ?Q =>
    let P' := normalize_array_assertion (128%nat) P in
    let Q' := normalize_array_assertion (128%nat) Q in
    change (P' |-- Q')
  end.

Lemma proof_of_init_array2_entail_wit_1 : Goal.init_array2_entail_wit_1.
Proof.
  unfold Goal.init_array2_entail_wit_1.
  right.
  expand_array_assertions.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_2 : Goal.init_array2_entail_wit_2.
Proof.
  unfold Goal.init_array2_entail_wit_2.
  left.
  expand_array_assertions.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_3 : Goal.init_array2_entail_wit_3.
Proof.
  unfold Goal.init_array2_entail_wit_3.
  left.
  expand_array_assertions.
  entailer!.
Qed.

Lemma proof_of_init_array2_entail_wit_4 : Goal.init_array2_entail_wit_4.
Proof.
  unfold Goal.init_array2_entail_wit_4.
  right.
  expand_array_assertions.
  entailer!.
Qed.

Lemma proof_of_init_array2_return_wit_1 : Goal.init_array2_return_wit_1.
Proof.
  unfold Goal.init_array2_return_wit_1.
  left.
  intros p_pre n_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9.
  subst p_pre; subst n_pre.
  Exists (repeat_Z 0 3).
  expand_array_assertions.
  entailer!.
Qed.

End Proofs.
