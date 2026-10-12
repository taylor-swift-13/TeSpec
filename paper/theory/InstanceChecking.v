From Coq Require Import List Arith.
Import ListNotations.
Set Implicit Arguments.

(* A semantic core, not an embedding of C or a proof of the C implementation.
   Program states can include a heap, local environment, pc and call stack.
   The operational relation and assertion interpretation are explicit parameters. *)

Section TypedInstances.
  Context {Var : Type} {Value : Var -> Type} {State : Type}.
  Definition Env := forall x : Var, Value x.
  Definition Binding := forall x : Var, option (Value x).
  Definition agrees (theta : Binding) (eta : Env) : Prop :=
    forall x v, theta x = Some v -> eta x = v.
  Definition extends (theta1 theta2 : Binding) : Prop :=
    forall x v, theta1 x = Some v -> theta2 x = Some v.
  Definition domain (R : Env -> State -> Prop) (theta : Binding) (s : State) :=
    exists eta, agrees theta eta /\ R eta s.

  Theorem stronger_binding_smaller_domain R theta1 theta2 :
    extends theta1 theta2 ->
    forall s, domain R theta2 s -> domain R theta1 s.
  Proof.
    intros Hext s [eta [Hag HR]]. exists eta. split; [|exact HR].
    intros x v H. apply Hag. apply Hext. exact H.
  Qed.

  Theorem verified_domain_specializes R theta1 theta2 (Good : State -> Prop) :
    extends theta1 theta2 ->
    (forall s, domain R theta1 s -> Good s) ->
    forall s, domain R theta2 s -> Good s.
  Proof.
    intros Hext Hall s Hin. apply Hall.
    eapply stronger_binding_smaller_domain; eauto.
  Qed.

  (* Nonemptiness is a separate obligation, not a consequence of correctness. *)
  Definition nonvacuous (P Good : State -> Prop) : Prop :=
    (exists s, P s) /\ (forall s, P s -> Good s).
  Theorem empty_domain_never_nonvacuous (Good : State -> Prop) :
    ~ nonvacuous (fun _ => False) Good.
  Proof. intros [[s H] _]. exact H. Qed.
End TypedInstances.

Section ExecutionCertificates.
  Context {State : Type}.
  Variable step : State -> State -> Prop.
  Variable terminal safe post : State -> Prop.
  Definition Assertion := State -> Prop.
  Definition entails (P Q : Assertion) := forall s, P s -> Q s.
  Definition equiv (P Q : Assertion) := forall s, P s <-> Q s.

  (* The tree records a finite covering symbolic execution. Normalization and
     checks are administrative nodes and consume no program transition.
     A binary split can encode any finite successor list. *)
  Inductive tree : Type :=
  | Done (P : Assertion)
  | Advance (P : Assertion) (left right : tree)
  | Normalize (P : Assertion) (child : tree)
  | Boundary (P A : Assertion) (child : tree)
  | Unfinished (P : Assertion).

  Definition root (t : tree) : Assertion :=
    match t with
    | Done P | Advance P _ _ | Normalize P _
    | Boundary P _ _ | Unfinished P => P
    end.

  Definition final_ok s :=
    safe s /\ terminal s /\ post s /\ (forall u, ~ step s u).

  Fixpoint obligations (t : tree) : Prop :=
    match t with
    | Done P => forall s, P s -> final_ok s
    | Advance P l r =>
        (forall s, P s ->
          safe s /\ ~ terminal s /\ (exists u, step s u)) /\
        (forall s u, P s -> step s u -> root l u \/ root r u) /\
        obligations l /\ obligations r
    | Normalize P child => equiv P (root child) /\ obligations child
    | Boundary P A child =>
        entails P A /\ root child = P /\ obligations child
    | Unfinished _ => False
    end.

  (* This inductive judgment covers all possible successors, demands progress,
     and proves termination, safety and the postcondition for its state. *)
  Inductive safe_terminating : State -> Prop :=
  | finished : forall s, final_ok s -> safe_terminating s
  | progressing : forall s,
      safe s -> ~ terminal s -> (exists u, step s u) ->
      (forall u, step s u -> safe_terminating u) -> safe_terminating s.

  Theorem closed_tree_sound t :
    obligations t -> forall s, root t s -> safe_terminating s.
  Proof.
    induction t as [P|P l IHl r IHr|P child IH|P A child IH|P];
      simpl; intros H s HP.
    - apply finished. apply H. exact HP.
    - destruct H as [Hlocal [Hcover [Hl Hr]]].
      destruct (Hlocal s HP) as [Hs [Ht Hprogress]].
      apply progressing; try assumption.
      intros u Hstep. destruct (Hcover s u HP Hstep) as [Hu|Hu].
      + exact (IHl Hl u Hu).
      + exact (IHr Hr u Hu).
    - destruct H as [Heq Hchild]. apply IH; [exact Hchild|].
      apply (proj1 (Heq s)); exact HP.
    - destruct H as [Hannotation [Hsame Hchild]].
      apply IH; [exact Hchild|]. rewrite Hsame. exact HP.
    - contradiction.
  Qed.

  Theorem checked_boundary_observed P A child :
    obligations (Boundary P A child) -> forall s, P s -> A s.
  Proof. intros [H _]. exact H. Qed.

  Theorem unfinished_has_no_certificate P :
    ~ obligations (Unfinished P).
  Proof. simpl. tauto. Qed.

  Theorem boundary_retains_state P A child :
    obligations (Boundary P A child) -> root child = P.
  Proof. intros [_ [H _]]. exact H. Qed.

  Theorem safe_terminating_safe s : safe_terminating s -> safe s.
  Proof. intros H. destruct H as [s [Hs _]|s Hs _ _ _]; exact Hs. Qed.

  Theorem safe_terminating_post s :
    safe_terminating s -> terminal s -> post s.
  Proof.
    intros H Ht. destruct H as [s [_ [_ [Hp _]]]|s _ Hnt _ _].
    - exact Hp.
    - contradiction.
  Qed.

  Theorem safe_terminating_step s u :
    safe_terminating s -> step s u -> safe_terminating u.
  Proof.
    intros H Hstep. destruct H as [s [_ [_ [_ Hnone]]]|s _ _ _ Hnext].
    - exfalso. exact (Hnone u Hstep).
    - exact (Hnext u Hstep).
  Qed.

  Inductive reaches : State -> State -> Prop :=
  | reaches_refl : forall s, reaches s s
  | reaches_next : forall s u v, step s u -> reaches u v -> reaches s v.

  Theorem safe_terminating_reaches s u :
    reaches s u -> safe_terminating s -> safe_terminating u.
  Proof.
    intros Hreach. induction Hreach; intros Hsafe.
    - exact Hsafe.
    - apply IHHreach. eapply safe_terminating_step; eauto.
  Qed.

  Theorem certified_reachable_states t s u :
    obligations t -> root t s -> reaches s u ->
    safe u /\ (terminal u -> post u).
  Proof.
    intros Hclosed Hin Hreach.
    assert (Hgood : safe_terminating u).
    { eapply safe_terminating_reaches; [exact Hreach|].
      eapply closed_tree_sound; eauto. }
    split.
    - apply safe_terminating_safe; exact Hgood.
    - apply safe_terminating_post; exact Hgood.
  Qed.

  Definition accepted (P : Assertion) (t : tree) :=
    (exists s, P s) /\ equiv P (root t) /\ obligations t.

  Theorem accepted_instance_sound P t :
    accepted P t ->
    (exists s, P s) /\ (forall s, P s -> safe_terminating s).
  Proof.
    intros [Hsat [Hroot Hclosed]]. split; [exact Hsat|].
    intros s Hin. eapply closed_tree_sound; [exact Hclosed|].
    apply (proj1 (Hroot s)); exact Hin.
  Qed.

  Definition bad_state (u : State) :=
    ~ safe u \/ (terminal u /\ ~ post u).

  (* A negative certificate includes an initial model and its reachability.
     Refuting an entailment over an overapproximation is not enough. *)
  Definition execution_counterexample (P : Assertion) :=
    exists s u, P s /\ reaches s u /\ bad_state u.

  Theorem accepted_excludes_counterexample P t :
    accepted P t -> ~ execution_counterexample P.
  Proof.
    intros Hacc [s [u [HP [Hreach Hbad]]]].
    destruct Hacc as [Hsat [Heq Hclosed]].
    assert (Hroot : root t s) by (apply (proj1 (Heq s)); exact HP).
    assert (Hgood : safe u /\ (terminal u -> post u)).
    { eapply certified_reachable_states; eauto. }
    destruct Hgood as [Hs Hp].
    destruct Hbad as [Hunsafe | [Hterminal Hpost]].
    - exact (Hunsafe Hs).
    - exact (Hpost (Hp Hterminal)).
  Qed.

  Definition all_models_reachable (P A : Assertion) :=
    forall u, A u -> exists s, P s /\ reaches s u.

  Theorem reachable_model_yields_counterexample P A :
    all_models_reachable P A ->
    (exists u, A u /\ bad_state u) -> execution_counterexample P.
  Proof.
    intros Hreal [u [HA Hbad]].
    destruct (Hreal u HA) as [s [HP Hreach]].
    exists s, u. auto.
  Qed.
End ExecutionCertificates.

(* An abstract endpoint includes 1, which violates postcondition n=0.
   The real initial state is 0 and there are no transitions. Every reachable
   endpoint satisfies the postcondition despite the refutable abstract VC. *)
Example refutable_vc_without_reachable_violation :
  ~ (forall n : nat, True -> n = 0) /\
  (forall n : nat, reaches (fun _ _ : nat => False) 0 n -> n = 0).
Proof.
  split.
  - intros H. specialize (H 1 I). discriminate.
  - intros n H. inversion H; subst; [reflexivity | contradiction].
Qed.

Section JointObservation.
  Context {Env State Value : Type}.
  Definition observe (body : Env -> State -> Prop) (term : Env -> Value)
      (s : State) (v : Value) := exists eta, body eta s /\ term eta = v.
  Theorem joint_rewrite_preserves_observation
      (P Q : Env -> State -> Prop) (t u : Env -> Value) :
    (forall eta s, P eta s <-> Q eta s) ->
    (forall eta s, P eta s -> t eta = u eta) ->
    forall s v, observe P t s v <-> observe Q u s v.
  Proof.
    intros Hbody Hterm s v. split.
    - intros [eta [HP Hv]]. exists eta. split.
      + apply (proj1 (Hbody eta s)); exact HP.
      + rewrite <- (Hterm eta s HP). exact Hv.
    - intros [eta [HQ Hv]]. exists eta.
      assert (HP : P eta s) by (apply (proj2 (Hbody eta s)); exact HQ).
      split; [exact HP|]. rewrite (Hterm eta s HP). exact Hv.
  Qed.
End JointObservation.

(* Regression theorem for the return-variable elimination bug: projecting away
   a witness preserves the closed assertion but changes external observations. *)
Example existential_projection_same_assertion :
  (exists r : nat, r = 2) <-> (exists r : nat, True).
Proof. split; intros _; exists 2; auto. Qed.

Example existential_projection_changes_return :
  ~ ((exists r : nat, r = 2 /\ r = 1) <->
     (exists r : nat, True /\ r = 1)).
Proof.
  intros [_ H]. assert (Hin : exists r : nat, True /\ r = 1).
  { exists 1; auto. }
  destruct (H Hin) as [r [H2 H1]]. rewrite H2 in H1. discriminate.
Qed.

Print Assumptions stronger_binding_smaller_domain.
Print Assumptions closed_tree_sound.
Print Assumptions accepted_instance_sound.
Print Assumptions certified_reachable_states.
Print Assumptions joint_rewrite_preserves_observation.
Print Assumptions accepted_excludes_counterexample.
Print Assumptions reachable_model_yields_counterexample.
Print Assumptions refutable_vc_without_reachable_violation.
