From Coq Require Import Arith.
Set Implicit Arguments.

(* A denotation-level contract for budgeted rewriting of joint state/value
   observations. It does not certify the parser or the executor's C code. *)
Section LicensedNormalization.
  Context {State Value : Type}.
  Definition Image := State -> Value -> Prop.
  Variable reduce : Image -> option Image.
  Hypothesis licensed : forall P Q, reduce P = Some Q ->
    forall s v, P s v <-> Q s v.

  Fixpoint normalize (budget : nat) (P : Image) : Image :=
    match budget with
    | O => P
    | S remaining =>
        match reduce P with
        | None => P
        | Some Q => normalize remaining Q
        end
    end.

  Theorem budgeted_normalization_preserves_observations budget P :
    forall s v, P s v <-> normalize budget P s v.
  Proof.
    revert P. induction budget as [|remaining IH]; intros P s v; simpl.
    - reflexivity.
    - destruct (reduce P) as [Q|] eqn:Hstep; [|reflexivity].
      transitivity (Q s v); [apply licensed with (P:=P) (Q:=Q); exact Hstep|apply IH].
  Qed.

  Theorem budgeted_normalization_preserves_nonemptiness budget P :
    (exists s v, P s v) <-> (exists s v, normalize budget P s v).
  Proof.
    split; intros [s [v H]]; exists s,v.
    - apply (proj1 (budgeted_normalization_preserves_observations budget P s v)); exact H.
    - apply (proj2 (budgeted_normalization_preserves_observations budget P s v)); exact H.
  Qed.

  Theorem budgeted_normalization_preserves_validity budget P (Good : Image) :
    (forall s v, P s v -> Good s v) <->
    (forall s v, normalize budget P s v -> Good s v).
  Proof.
    split; intros H s v HP; apply H.
    - apply (proj2 (budgeted_normalization_preserves_observations budget P s v)); exact HP.
    - apply (proj1 (budgeted_normalization_preserves_observations budget P s v)); exact HP.
  Qed.

  Theorem budgeted_normalization_preserves_countermodels budget P (Good : Image) :
    (exists s v, P s v /\ ~ Good s v) <->
    (exists s v, normalize budget P s v /\ ~ Good s v).
  Proof.
    split; intros [s [v [HP Hbad]]]; exists s,v; split; [|exact Hbad| |exact Hbad].
    - apply (proj1 (budgeted_normalization_preserves_observations budget P s v)); exact HP.
    - apply (proj2 (budgeted_normalization_preserves_observations budget P s v)); exact HP.
  Qed.

  Theorem zero_budget_retains_input P : normalize 0 P = P.
  Proof. reflexivity. Qed.

  Theorem blocked_reduction_retains_input budget P :
    reduce P = None -> normalize budget P = P.
  Proof. intros H. destruct budget; simpl; [reflexivity|rewrite H; reflexivity]. Qed.

  Theorem normalization_composes a b P :
    forall s v, P s v <-> normalize b (normalize a P) s v.
  Proof.
    intros s v. transitivity (normalize a P s v).
    - apply budgeted_normalization_preserves_observations.
    - apply budgeted_normalization_preserves_observations.
  Qed.
End LicensedNormalization.

Print Assumptions budgeted_normalization_preserves_observations.
Print Assumptions budgeted_normalization_preserves_nonemptiness.
Print Assumptions budgeted_normalization_preserves_validity.
Print Assumptions budgeted_normalization_preserves_countermodels.
Print Assumptions zero_budget_retains_input.
Print Assumptions blocked_reduction_retains_input.
Print Assumptions normalization_composes.
