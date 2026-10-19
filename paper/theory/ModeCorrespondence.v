From Coq Require Import List ZArith Lia.
Import ListNotations.
Set Implicit Arguments.

(* A parameterized boundary-level theorem, not a refinement proof of C or
   sac. A boundary step may hide internal steps only when their safety and
   selected observations are represented at the boundary. Views include
   selected check identities/order, visible heaps, and return values.
   Relation R must retain entry bindings, live values, ownership and frames.
   Sampling one member of a loose contract does not satisfy the interface. *)

Section LooseSummary.
  Definition body_result (r : Z) := r = 1%Z.
  Definition loose_summary (r : Z) := r = 0%Z \/ r = 1%Z.
  Definition tested_post (r : Z) := r = 1%Z.

  Theorem sound_summary_need_not_preserve_test_results :
    (forall r, body_result r -> loose_summary r) /\
    (forall r, body_result r -> tested_post r) /\
    (exists r, loose_summary r /\ ~ tested_post r).
  Proof.
    repeat split.
    - intros r Hr. right. exact Hr.
    - intros r Hr. exact Hr.
    - exists 0%Z. split; [left; reflexivity|].
      unfold tested_post. lia.
  Qed.

  Theorem legal_summary_sample_can_fail_a_passing_body :
    body_result 1%Z /\ tested_post 1%Z /\
    loose_summary 0%Z /\ ~ tested_post 0%Z.
  Proof.
    repeat split; try reflexivity.
    - left; reflexivity.
    - unfold tested_post; lia.
  Qed.
End LooseSummary.

Inductive boundary_run {S : Type} (step : S -> S -> Prop) :
    S -> list S -> S -> Prop :=
| run_stop : forall s, boundary_run step s [s] s
| run_next : forall s u xs t,
    step s u -> boundary_run step u xs t ->
    boundary_run step s (s :: xs) t.

Section Correspondence.
  Context {I M View : Type}.
  Variables stepI : I -> I -> Prop.
  Variables stepM : M -> M -> Prop.
  Variables viewI : I -> View.
  Variables viewM : M -> View.
  Variables safeI checksI terminalI : I -> Prop.
  Variables safeM checksM terminalM : M -> Prop.
  Variable R : I -> M -> Prop.

  (* Both directions are required. The forward clause prevents the modular
     tree from omitting body behavior; the backward clause rules out additional
     observable behavior not realizable by the body. Safety/check agreement
     includes hidden segment observations, not just endpoint postconditions. *)
  Record mode_interface : Prop := {
    related_views : forall i m, R i m -> viewI i = viewM m;
    related_safety : forall i m, R i m -> (safeI i <-> safeM m);
    related_checks : forall i m, R i m -> (checksI i <-> checksM m);
    related_terminality : forall i m, R i m ->
      (terminalI i <-> terminalM m);
    forward_successors : forall i m i', R i m -> stepI i i' ->
      exists m', stepM m m' /\ R i' m';
    backward_successors : forall i m m', R i m -> stepM m m' ->
      exists i', stepI i i' /\ R i' m'
  }.
  Variable interface : mode_interface.

  Definition goodI i := safeI i /\ checksI i.
  Definition goodM m := safeM m /\ checksM m.
  Definition badI i := ~ safeI i \/ ~ checksI i.
  Definition badM m := ~ safeM m \/ ~ checksM m.

  Lemma related_good i m : R i m -> (goodI i <-> goodM m).
  Proof.
    intros H. unfold goodI, goodM.
    pose proof (related_safety interface H).
    pose proof (related_checks interface H). tauto.
  Qed.
  Lemma related_bad i m : R i m -> (badI i <-> badM m).
  Proof.
    intros H. unfold badI, badM.
    pose proof (related_safety interface H).
    pose proof (related_checks interface H). tauto.
  Qed.

  Theorem forward_trace i xs i' :
    boundary_run stepI i xs i' ->
    forall m, R i m ->
    exists ys m', boundary_run stepM m ys m' /\
                  Forall2 R xs ys /\ R i' m'.
  Proof.
    intros Hrun. induction Hrun as [i|i u xs i' Hstep Hrun IH].
    - intros m HR. exists [m], m. split; [constructor|].
      split; [constructor; [exact HR|constructor]|exact HR].
    - intros m HR.
      destruct (forward_successors interface HR Hstep) as [v [Hmv Huv]].
      destruct (IH v Huv) as [ys [m' [HrunM [Hrel Hend]]]].
      exists (m :: ys), m'. split.
      + econstructor; eauto.
      + split; [constructor; assumption|exact Hend].
  Qed.

  Theorem backward_trace m ys m' :
    boundary_run stepM m ys m' ->
    forall i, R i m ->
    exists xs i', boundary_run stepI i xs i' /\
                  Forall2 R xs ys /\ R i' m'.
  Proof.
    intros Hrun. induction Hrun as [m|m v ys m' Hstep Hrun IH].
    - intros i HR. exists [i], i. split; [constructor|].
      split; [constructor; [exact HR|constructor]|exact HR].
    - intros i HR.
      destruct (backward_successors interface HR Hstep) as [u [Hiu Huv]].
      destruct (IH u Huv) as [xs [i' [HrunI [Hrel Hend]]]].
      exists (i :: xs), i'. split.
      + econstructor; eauto.
      + split; [constructor; assumption|exact Hend].
  Qed.

  Theorem related_trace_views xs ys :
    Forall2 R xs ys -> map viewI xs = map viewM ys.
  Proof.
    intros H. induction H; simpl; [reflexivity|].
    rewrite (related_views interface H), IHForall2. reflexivity.
  Qed.

  Lemma related_trace_good xs ys :
    Forall2 R xs ys -> (Forall goodI xs <-> Forall goodM ys).
  Proof.
    intros H. induction H; [split; intros; constructor|].
    repeat rewrite Forall_cons_iff.
    rewrite (related_good H), IHForall2. tauto.
  Qed.

  Definition successful_traceI i :=
    exists xs i', boundary_run stepI i xs i' /\
      terminalI i' /\ Forall goodI xs.
  Definition successful_traceM m :=
    exists ys m', boundary_run stepM m ys m' /\
      terminalM m' /\ Forall goodM ys.
  Definition reachable_failureI i :=
    exists xs i', boundary_run stepI i xs i' /\ badI i'.
  Definition reachable_failureM m :=
    exists ys m', boundary_run stepM m ys m' /\ badM m'.

  Theorem successful_finite_trace_equivalence i m :
    R i m -> (successful_traceI i <-> successful_traceM m).
  Proof.
    intros HR. split.
    - intros [xs [i' [Hrun [Hterm Hgood]]]].
      destruct (forward_trace Hrun HR) as [ys [m' [HrunM [Hrel Hend]]]].
      exists ys, m'. split; [exact HrunM|]. split.
      + apply (proj1 (related_terminality interface Hend)); exact Hterm.
      + apply (proj1 (related_trace_good Hrel)); exact Hgood.
    - intros [ys [m' [Hrun [Hterm Hgood]]]].
      destruct (backward_trace Hrun HR) as [xs [i' [HrunI [Hrel Hend]]]].
      exists xs, i'. split; [exact HrunI|]. split.
      + apply (proj2 (related_terminality interface Hend)); exact Hterm.
      + apply (proj2 (related_trace_good Hrel)); exact Hgood.
  Qed.

  Theorem reachable_failure_equivalence i m :
    R i m -> (reachable_failureI i <-> reachable_failureM m).
  Proof.
    intros HR. split.
    - intros [xs [i' [Hrun Hbad]]].
      destruct (forward_trace Hrun HR) as [ys [m' [HrunM [Hrel Hend]]]].
      exists ys, m'. split; [exact HrunM|].
      apply (proj1 (related_bad Hend)); exact Hbad.
    - intros [ys [m' [Hrun Hbad]]].
      destruct (backward_trace Hrun HR) as [xs [i' [HrunI [Hrel Hend]]]].
      exists xs, i'. split; [exact HrunI|].
      apply (proj2 (related_bad Hend)); exact Hbad.
  Qed.

  (* This is correctness of all complete finite traces, not a claim of
     termination, finite test coverage, or runtime PASS/UNKNOWN equality. *)
  Definition complete_traces_correctI i :=
    forall xs i', boundary_run stepI i xs i' ->
      terminalI i' -> Forall goodI xs.
  Definition complete_traces_correctM m :=
    forall ys m', boundary_run stepM m ys m' ->
      terminalM m' -> Forall goodM ys.

  Theorem complete_finite_trace_correctness_equivalence i m :
    R i m -> (complete_traces_correctI i <-> complete_traces_correctM m).
  Proof.
    intros HR. split.
    - intros Hall ys m' Hrun Hterm.
      destruct (backward_trace Hrun HR) as [xs [i' [HrunI [Hrel Hend]]]].
      apply (proj1 (related_trace_good Hrel)).
      apply (Hall xs i'); [exact HrunI|].
      apply (proj2 (related_terminality interface Hend)); exact Hterm.
    - intros Hall xs i' Hrun Hterm.
      destruct (forward_trace Hrun HR) as [ys [m' [HrunM [Hrel Hend]]]].
      apply (proj2 (related_trace_good Hrel)).
      apply (Hall ys m'); [exact HrunM|].
      apply (proj1 (related_terminality interface Hend)); exact Hterm.
  Qed.

  (* Semantic well-founded termination is distinct from a tool timeout or
     fuel bound. Bidirectional successor coverage transfers it both ways. *)
  Definition terminatingI i := Acc (fun u v => stepI v u) i.
  Definition terminatingM m := Acc (fun u v => stepM v u) m.

  Lemma termination_forward i :
    terminatingI i -> forall m, R i m -> terminatingM m.
  Proof.
    unfold terminatingI, terminatingM.
    intros Hacc. induction Hacc as [i Hacc IH].
    intros m HR. constructor. intros m' Hstep.
    destruct (backward_successors interface HR Hstep) as [i' [Hii' HR']].
    apply (IH i' Hii' m' HR').
  Qed.

  Lemma termination_backward m :
    terminatingM m -> forall i, R i m -> terminatingI i.
  Proof.
    unfold terminatingI, terminatingM.
    intros Hacc. induction Hacc as [m Hacc IH].
    intros i HR. constructor. intros i' Hstep.
    destruct (forward_successors interface HR Hstep) as [m' [Hmm' HR']].
    apply (IH m' Hmm' i' HR').
  Qed.

  Theorem semantic_termination_equivalence i m :
    R i m -> (terminatingI i <-> terminatingM m).
  Proof.
    intros HR. split; intros H.
    - apply (termination_forward H HR).
    - apply (termination_backward H HR).
  Qed.

  (* Total acceptance requires progress and covers all successors. It cannot
     accept a stuck nonterminal state or a divergent execution by vacuity. *)
  Inductive total_checked_I : I -> Prop :=
  | total_done_I : forall i,
      goodI i -> terminalI i -> (forall u, ~ stepI i u) ->
      total_checked_I i
  | total_step_I : forall i,
      goodI i -> ~ terminalI i -> (exists u, stepI i u) ->
      (forall u, stepI i u -> total_checked_I u) ->
      total_checked_I i.

  Inductive total_checked_M : M -> Prop :=
  | total_done_M : forall m,
      goodM m -> terminalM m -> (forall u, ~ stepM m u) ->
      total_checked_M m
  | total_step_M : forall m,
      goodM m -> ~ terminalM m -> (exists u, stepM m u) ->
      (forall u, stepM m u -> total_checked_M u) ->
      total_checked_M m.

  Lemma total_acceptance_forward i :
    total_checked_I i -> forall m, R i m -> total_checked_M m.
  Proof.
    intros Htotal.
    induction Htotal as
      [i Hgood Hterm Hnone | i Hgood Hnonterm Hprogress Hnext IH].
    - intros m HR. apply total_done_M.
      + apply (proj1 (related_good HR)); exact Hgood.
      + apply (proj1 (related_terminality interface HR)); exact Hterm.
      + intros m' Hstep.
        destruct (backward_successors interface HR Hstep) as [i' [Hii' _]].
        exact (Hnone i' Hii').
    - intros m HR. apply total_step_M.
      + apply (proj1 (related_good HR)); exact Hgood.
      + intros Hterm. apply Hnonterm.
        apply (proj2 (related_terminality interface HR)); exact Hterm.
      + destruct Hprogress as [i' Hstep].
        destruct (forward_successors interface HR Hstep) as [m' [Hmm' _]].
        exists m'; exact Hmm'.
      + intros m' Hstep.
        destruct (backward_successors interface HR Hstep) as [i' [Hii' HR']].
        exact (IH i' Hii' m' HR').
  Qed.

  Lemma total_acceptance_backward m :
    total_checked_M m -> forall i, R i m -> total_checked_I i.
  Proof.
    intros Htotal.
    induction Htotal as
      [m Hgood Hterm Hnone | m Hgood Hnonterm Hprogress Hnext IH].
    - intros i HR. apply total_done_I.
      + apply (proj2 (related_good HR)); exact Hgood.
      + apply (proj2 (related_terminality interface HR)); exact Hterm.
      + intros i' Hstep.
        destruct (forward_successors interface HR Hstep) as [m' [Hmm' _]].
        exact (Hnone m' Hmm').
    - intros i HR. apply total_step_I.
      + apply (proj2 (related_good HR)); exact Hgood.
      + intros Hterm. apply Hnonterm.
        apply (proj1 (related_terminality interface HR)); exact Hterm.
      + destruct Hprogress as [m' Hstep].
        destruct (backward_successors interface HR Hstep) as [i' [Hii' _]].
        exists i'; exact Hii'.
      + intros i' Hstep.
        destruct (forward_successors interface HR Hstep) as [m' [Hmm' HR']].
        exact (IH m' Hmm' i' HR').
  Qed.

  Theorem total_acceptance_equivalence i m :
    R i m -> (total_checked_I i <-> total_checked_M m).
  Proof.
    intros HR. split; intros H.
    - exact (total_acceptance_forward H HR).
    - exact (total_acceptance_backward H HR).
  Qed.

  Variables initialI : I -> Prop.
  Variables initialM : M -> Prop.
  Hypothesis initial_forward : forall i, initialI i ->
    exists m, initialM m /\ R i m.
  Hypothesis initial_backward : forall m, initialM m ->
    exists i, initialI i /\ R i m.

  Theorem entry_nonemptiness_equivalence :
    (exists i, initialI i) <-> (exists m, initialM m).
  Proof.
    split; intros [s H].
    - destruct (initial_forward H) as [t [Ht _]]. exists t; exact Ht.
    - destruct (initial_backward H) as [t [Ht _]]. exists t; exact Ht.
  Qed.

  Theorem nonvacuous_instance_acceptance_equivalence :
    ((exists i, initialI i) /\
      forall i, initialI i -> total_checked_I i) <->
    ((exists m, initialM m) /\
      forall m, initialM m -> total_checked_M m).
  Proof.
    split; intros [Hnonempty Hall]; split.
    - apply (proj1 entry_nonemptiness_equivalence); exact Hnonempty.
    - intros m Hm. destruct (initial_backward Hm) as [i [Hi HR]].
      apply (proj1 (total_acceptance_equivalence HR)).
      apply Hall; exact Hi.
    - apply (proj2 entry_nonemptiness_equivalence); exact Hnonempty.
    - intros i Hi. destruct (initial_forward Hi) as [m [Hm HR]].
      apply (proj2 (total_acceptance_equivalence HR)).
      apply Hall; exact Hm.
  Qed.

  Theorem instance_complete_finite_trace_equivalence :
    ((exists i, initialI i) /\
      forall i, initialI i -> complete_traces_correctI i) <->
    ((exists m, initialM m) /\
      forall m, initialM m -> complete_traces_correctM m).
  Proof.
    split; intros [Hnonempty Hall]; split.
    - apply (proj1 entry_nonemptiness_equivalence); exact Hnonempty.
    - intros m Hm. destruct (initial_backward Hm) as [i [Hi HR]].
      apply (proj1 (complete_finite_trace_correctness_equivalence HR)).
      apply Hall; exact Hi.
    - apply (proj2 entry_nonemptiness_equivalence); exact Hnonempty.
    - intros i Hi. destruct (initial_forward Hi) as [m [Hm HR]].
      apply (proj2 (complete_finite_trace_correctness_equivalence HR)).
      apply Hall; exact Hm.
  Qed.

  Theorem instance_reachable_failure_equivalence :
    (exists i, initialI i /\ reachable_failureI i) <->
    (exists m, initialM m /\ reachable_failureM m).
  Proof.
    split; intros [s [Hstart Hbad]].
    - destruct (initial_forward Hstart) as [m [Hm HR]].
      exists m. split; [exact Hm|].
      apply (proj1 (reachable_failure_equivalence HR)); exact Hbad.
    - destruct (initial_backward Hstart) as [i [Hi HR]].
      exists i. split; [exact Hi|].
      apply (proj2 (reachable_failure_equivalence HR)); exact Hbad.
  Qed.
End Correspondence.

Print Assumptions sound_summary_need_not_preserve_test_results.
Print Assumptions legal_summary_sample_can_fail_a_passing_body.
Print Assumptions forward_trace.
Print Assumptions backward_trace.
Print Assumptions related_trace_views.
Print Assumptions successful_finite_trace_equivalence.
Print Assumptions reachable_failure_equivalence.
Print Assumptions complete_finite_trace_correctness_equivalence.
Print Assumptions entry_nonemptiness_equivalence.
Print Assumptions instance_complete_finite_trace_equivalence.
Print Assumptions instance_reachable_failure_equivalence.
Print Assumptions semantic_termination_equivalence.
Print Assumptions total_acceptance_equivalence.
Print Assumptions nonvacuous_instance_acceptance_equivalence.
