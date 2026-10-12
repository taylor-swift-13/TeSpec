From Coq Require Import List.
Import ListNotations.
Set Implicit Arguments.

(* Reference observation semantics. State includes the control location,
   heap, call stack and immutable logical entry environment. The schedule
   supplies the already resolved assertions at each visited state. Checking
   records obligations; their truth is never a premise of execution. *)
Section ObservationTraces.
  Context {State : Type}.
  Variable step : State -> State -> Prop.
  Definition Assertion := State -> Prop.
  Definition Observation := (State * Assertion)%type.
  Variable schedule : State -> list Assertion.

  Definition record (s : State) : list Observation :=
    map (fun A => (s, A)) (schedule s).
  Definition observations (xs : list State) : list Observation :=
    flat_map record xs.
  Definition discharged (os : list Observation) : Prop :=
    forall s A, In (s, A) os -> A s.

  Inductive execution : State -> list State -> State -> Prop :=
  | execution_stop : forall s, execution s [s] s
  | execution_next : forall s u xs t,
      step s u -> execution u xs t -> execution s (s :: xs) t.

  Inductive monitored : State -> list State -> list Observation -> State -> Prop :=
  | monitored_stop : forall s, monitored s [s] (record s) s
  | monitored_next : forall s u xs os t,
      step s u -> monitored u xs os t ->
      monitored s (s :: xs) (record s ++ os) t.

  Theorem observation_erasure s xs os t :
    monitored s xs os t -> execution s xs t.
  Proof.
    intros H. induction H; [constructor|econstructor; eauto].
  Qed.

  Theorem execution_lifting s xs t :
    execution s xs t -> monitored s xs (observations xs) t.
  Proof.
    intros H. induction H; unfold observations in *; simpl.
    - rewrite app_nil_r. constructor.
    - econstructor; eauto.
  Qed.

  Theorem observation_inventory s xs os t :
    monitored s xs os t -> os = observations xs.
  Proof.
    intros H. induction H; unfold observations in *; simpl.
    - rewrite app_nil_r. reflexivity.
    - now rewrite IHmonitored.
  Qed.

  Theorem observation_membership xs s A :
    In (s, A) (observations xs) <->
    In s xs /\ In A (schedule s).
  Proof.
    unfold observations, record. rewrite in_flat_map. split.
    - intros [u [Hu Hpair]]. apply in_map_iff in Hpair.
      destruct Hpair as [B [Heq HB]]. inversion Heq; subst. auto.
    - intros [Hs HA]. exists s. split; [exact Hs|].
      apply in_map. exact HA.
  Qed.

  Theorem checked_trace_observes_all_boundaries s xs os t :
    monitored s xs os t -> discharged os ->
    forall u A, In u xs -> In A (schedule u) -> A u.
  Proof.
    intros Htrace Hchecked u A Hu HA. apply (Hchecked u A).
    rewrite (observation_inventory Htrace).
    apply observation_membership. auto.
  Qed.

  Theorem observations_do_not_filter_executions s xs t :
    (exists os, monitored s xs os t) <-> execution s xs t.
  Proof.
    split.
    - intros [os H]. eapply observation_erasure; eauto.
    - intros H. exists (observations xs). apply execution_lifting. exact H.
  Qed.
End ObservationTraces.

Print Assumptions observation_erasure.
Print Assumptions execution_lifting.
Print Assumptions observation_inventory.
Print Assumptions observation_membership.
Print Assumptions checked_trace_observes_all_boundaries.
Print Assumptions observations_do_not_filter_executions.
