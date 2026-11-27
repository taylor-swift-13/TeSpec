From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

(* Expand array representations while retaining the separation-logic
   connectives and primitive character cells. *)
Ltac normalize_array_assertion P :=
  lazymatch P with
  | emp => constr:(emp)
  | (?A ** ?B) =>
      let A' := normalize_array_assertion A in
      let B' := normalize_array_assertion B in
      constr:(A' ** B')
  | (?A && ?B) =>
      let A' := normalize_array_assertion A in
      let B' := normalize_array_assertion B in
      constr:(A' && B')
  | “ ?F ” =>
      let F' := eval cbv in F in
      constr:(“ F' ”)
  | (?p # Char |-> ?v) =>
      let p' := eval cbv in p in
      let v' := eval cbv in v in
      constr:(p' # Char |-> v')
  | (?p # Char |->_) =>
      let p' := eval cbv in p in
      constr:(p' # Char |->_)
  | _ =>
      let P' := eval red in P in
      lazymatch P' with
      | P => constr:(P)
      | _ => normalize_array_assertion P'
      end
  end.

Ltac finish_array :=
  lazymatch goal with
  | |- ?P |-- ?Q =>
      let P' := normalize_array_assertion P in
      let Q' := normalize_array_assertion Q in
      change (P' |-- Q')
  end;
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
