From Coq Require Import List Arith Bool.
Import ListNotations.
Set Implicit Arguments.

(* A parameterized partial-correctness theorem. State includes the program
   counter, entry bindings, live values, and owned/framed heap resources.
   The boundary postcondition is relational: it relates the prestate and
   poststate, including every value/resource that must be preserved.

   This file does not prove the C executor, VC generator, or sampler correct.
   Their semantic interfaces are explicit. Neither a relation between modes,
   matching samples, nor equality of traces is assumed. *)

Inductive testing_mode := Inline | Modular.
Inductive test_verdict := PASS | FAIL | UNKNOWN | ERROR.

(* A conclusive, sound judgment. UNKNOWN, errors and exhausted budgets are
   deliberately not completed decisions. Termination of this judgment is
   not implied by partial correctness of the program. *)
Inductive completed_classification (valid : Prop) : test_verdict -> Prop :=
| classify_valid : valid -> completed_classification valid PASS
| classify_invalid : ~ valid -> completed_classification valid FAIL.

Theorem true_property_conclusively_classified_pass (valid : Prop) result :
  valid -> completed_classification valid result -> result = PASS.
Proof.
  intros Hvalid Hdecision. inversion Hdecision; subst; [reflexivity|contradiction].
Qed.

Section ContractComposition.
  Context {Before After : Type}.
  Variables caller_assertion require : Before -> Prop.
  Variables ensure_with_frame : Before -> After -> Prop.
  Variable continuation : After -> Prop.
  Variable sample : Before -> After -> Prop.

  (* These are the relevant modular VC and implementation obligations.
     The continuation VC is universal over every legal Ensure output. *)
  Hypothesis require_verified : forall s, caller_assertion s -> require s.
  Hypothesis continuation_verified : forall s t,
    caller_assertion s -> require s -> ensure_with_frame s t -> continuation t.
  Hypothesis sampling_sound : forall s t,
    caller_assertion s -> sample s t -> ensure_with_frame s t.

  Theorem every_legal_contract_sample_preserves_continuation s t :
    caller_assertion s -> sample s t -> continuation t.
  Proof.
    intros Hcaller Hsample.
    eapply continuation_verified; eauto.
  Qed.
End ContractComposition.

Section VerifiedExecution.
  Context {State Boundary : Type}.
  Variables initial annotation safe selected_checks terminal post : State -> Prop.
  Variable primitive_step : State -> State -> Prop.
  Variable boundary_enabled : testing_mode -> Boundary -> State -> Prop.
  Variable boundary_pre : Boundary -> State -> Prop.
  Variable boundary_post : Boundary -> State -> State -> Prop.
  Variable sample : testing_mode -> Boundary -> State -> State -> Prop.

  (* Inline uses primitive steps for available bodies and loop iterations;
     it can use boundaries for bodyless callees. Modular also uses boundaries
     for calls, invariants and assertions. Modes may take different paths and
     have different numbers of transitions. Selected checks are interpreted
     according to the chosen, independent VC-generation policy. *)
  Definition mode_step mode s t : Prop :=
    primitive_step s t \/
    exists b, boundary_enabled mode b s /\ sample mode b s t.

  (* This record represents CLOSED modular verification obligations for the
     whole annotated program, not just each callee's validity in isolation.
     Loop initiation/preservation/exit and assertion consequence obligations
     are instances of these program-point and boundary implications. A step
     hiding an internal segment must include its safety/selected observations
     in this interface, not merely its endpoint postcondition. *)
  Record verified_annotations : Prop := {
    verified_entry : forall s, initial s -> annotation s;
    verified_primitive : forall s t,
      annotation s -> primitive_step s t -> annotation t;
    verified_boundary_pre : forall mode b s,
      annotation s -> boundary_enabled mode b s -> boundary_pre b s;
    verified_continuation : forall b s t,
      annotation s -> boundary_pre b s -> boundary_post b s t -> annotation t;
    verified_safety : forall s, annotation s -> safe s;
    verified_selected_checks : forall s, annotation s -> selected_checks s;
    verified_exit : forall s, annotation s -> terminal s -> post s
  }.

  (* Soundness concerns ANY produced sample, not existence of a sample or
     termination of search. A solver timeout or sampling failure stays outside
     a completed execution. The relational post includes frame/old-value and
     entry-binding constraints: a sample of a bare Ensure that forgets them
     does not satisfy this premise. *)
  Definition legal_sampling : Prop := forall mode b s t,
    annotation s -> boundary_enabled mode b s -> sample mode b s t ->
    boundary_post b s t.

  Variable verified : verified_annotations.
  Variable sampling : legal_sampling.

  Theorem legal_boundary_preserves_verified_annotation mode b s t :
    annotation s -> boundary_enabled mode b s -> sample mode b s t -> annotation t.
  Proof.
    intros Hannot Henabled Hsample.
    eapply (verified_continuation verified).
    - exact Hannot.
    - eapply (verified_boundary_pre verified); eauto.
    - eapply sampling; eauto.
  Qed.

  Theorem either_mode_preserves_verified_annotation mode s t :
    annotation s -> mode_step mode s t -> annotation t.
  Proof.
    intros Hannot [Hprimitive | [b [Henabled Hsample]]].
    - eapply (verified_primitive verified); eauto.
    - eapply legal_boundary_preserves_verified_annotation; eauto.
  Qed.

  Inductive finite_run (mode : testing_mode) : State -> list State -> State -> Prop :=
  | stop_run : forall s, finite_run mode s [s] s
  | extend_run : forall s u xs t,
      mode_step mode s u -> finite_run mode u xs t ->
      finite_run mode s (s :: xs) t.

  Theorem every_sampled_run_preserves_annotations mode s xs t :
    finite_run mode s xs t -> annotation s ->
    Forall annotation xs /\ annotation t.
  Proof.
    intros Hrun. induction Hrun as [s | s u xs t Hstep Hrun IH].
    - intros Hannot. split; [constructor; [exact Hannot|constructor]|exact Hannot].
    - intros Hannot.
      assert (Hu : annotation u).
      { eapply either_mode_preserves_verified_annotation; eauto. }
      destruct (IH Hu) as [Hxs Ht]. split; [constructor; assumption|exact Ht].
  Qed.

  Definition observations_hold xs t : Prop :=
    Forall (fun s => safe s /\ selected_checks s) xs /\ post t.

  Theorem verified_finite_completed_execution_passes mode s xs t :
    initial s -> finite_run mode s xs t -> terminal t -> observations_hold xs t.
  Proof.
    intros Hinitial Hrun Hterminal.
    assert (Hannot : annotation s) by (apply (verified_entry verified); exact Hinitial).
    destruct (every_sampled_run_preserves_annotations Hrun Hannot) as [Hxs Ht].
    split.
    - eapply Forall_impl; [|exact Hxs]. intros u Hu. split.
      + apply (verified_safety verified); exact Hu.
      + apply (verified_selected_checks verified); exact Hu.
    - eapply (verified_exit verified); eauto.
  Qed.

  (* No equality or simulation premise connects the two executions. Each
     quantifier ranges over all legal outputs independently. *)
  Theorem verified_specification_two_modes_semantically_accept sI sM xsI xsM tI tM :
    initial sI -> initial sM ->
    finite_run Inline sI xsI tI -> finite_run Modular sM xsM tM ->
    terminal tI -> terminal tM ->
    observations_hold xsI tI /\ observations_hold xsM tM.
  Proof.
    intros Hi Hm Hri Hrm Hti Htm. split.
    - exact (verified_finite_completed_execution_passes Hi Hri Hti).
    - exact (verified_finite_completed_execution_passes Hm Hrm Htm).
  Qed.

  Theorem verified_specification_completed_verdicts_agree
      sI sM xsI xsM tI tM resultI resultM :
    initial sI -> initial sM ->
    finite_run Inline sI xsI tI -> finite_run Modular sM xsM tM ->
    terminal tI -> terminal tM ->
    completed_classification (observations_hold xsI tI) resultI ->
    completed_classification (observations_hold xsM tM) resultM ->
    resultI = PASS /\ resultM = PASS /\ resultI = resultM.
  Proof.
    intros Hi Hm Hri Hrm Hti Htm Hci Hcm.
    destruct (verified_specification_two_modes_semantically_accept
      Hi Hm Hri Hrm Hti Htm) as [Hvi Hvm].
    assert (Hpi : resultI = PASS) by
      (exact (true_property_conclusively_classified_pass Hvi Hci)).
    assert (Hpm : resultM = PASS) by
      (exact (true_property_conclusively_classified_pass Hvm Hcm)).
    repeat split; congruence.
  Qed.

  (* Even an unfinished prefix cannot encounter an actually false checked
     assertion under these premises. This does not settle an unresolved VC
     emitted from a coarser abstraction, or guarantee that its solver ends. *)
  Theorem verified_specification_excludes_reachable_violation mode s xs t :
    initial s -> finite_run mode s xs t ->
    ~ (~ safe t \/ ~ selected_checks t \/ (terminal t /\ ~ post t)).
  Proof.
    intros Hinitial Hrun.
    assert (Hannot : annotation s) by (apply (verified_entry verified); exact Hinitial).
    destruct (every_sampled_run_preserves_annotations Hrun Hannot) as [_ Ht].
    pose proof (verified_safety verified Ht) as Hsafe.
    pose proof (verified_selected_checks verified Ht) as Hchecks.
    intros [Hbad | [Hbad | [Hterminal Hbad]]]; try contradiction.
    apply Hbad. eapply (verified_exit verified); eauto.
  Qed.
End VerifiedExecution.

(* Loop proof obligations expose why an exit sampled from the invariant
   works even when its values differ from the body execution's final values.
   These are partial-correctness obligations; no termination claim follows. *)
Section VerifiedLoop.
  Context {State : Type}.
  Variables entry invariant guard continuation : State -> Prop.
  Variable body : State -> State -> Prop.
  Hypothesis initiation : forall s, entry s -> invariant s.
  Hypothesis preservation : forall s t,
    invariant s -> guard s -> body s t -> invariant t.
  Hypothesis exit_obligation : forall s,
    invariant s -> ~ guard s -> continuation s.

  Inductive loop_iterations : State -> State -> Prop :=
  | no_iteration : forall s, loop_iterations s s
  | one_more_iteration : forall s u t,
      guard s -> body s u -> loop_iterations u t -> loop_iterations s t.

  Theorem verified_loop_iterations_preserve_invariant s t :
    loop_iterations s t -> invariant s -> invariant t.
  Proof.
    intros Hrun. induction Hrun; intros Hin; [exact Hin|].
    apply IHHrun. eapply preservation; eauto.
  Qed.

  Theorem inline_loop_exit_satisfies_continuation s t :
    entry s -> loop_iterations s t -> ~ guard t -> continuation t.
  Proof.
    intros Hentry Hrun Hexit. apply exit_obligation; [|exact Hexit].
    eapply verified_loop_iterations_preserve_invariant; [exact Hrun|].
    apply initiation; exact Hentry.
  Qed.

  Theorem every_legal_modular_loop_exit_satisfies_continuation t :
    invariant t /\ ~ guard t -> continuation t.
  Proof. intros [Hinv Hexit]. apply exit_obligation; assumption. Qed.

  Theorem verified_loop_modes_allow_independent_exit_values s tI tM :
    entry s -> loop_iterations s tI -> ~ guard tI ->
    invariant tM /\ ~ guard tM -> continuation tI /\ continuation tM.
  Proof.
    intros Hentry Hrun Hexit Hsample. split.
    - exact (inline_loop_exit_satisfies_continuation Hentry Hrun Hexit).
    - exact (every_legal_modular_loop_exit_satisfies_continuation Hsample).
  Qed.
End VerifiedLoop.

(* Observing an assertion proves the incoming state satisfies it. Reusing
   the assertion as a modular boundary additionally requires its framed
   relation to imply the continuation; truth at the incoming state alone
   does not justify forgetting live values. *)
Section VerifiedAssertion.
  Context {State : Type}.
  Variables before asserted continuation : State -> Prop.
  Variable assertion_with_frame : State -> State -> Prop.
  Hypothesis assertion_obligation : forall s, before s -> asserted s.
  Hypothesis assertion_continuation : forall s t,
    before s -> asserted s -> assertion_with_frame s t -> continuation t.

  Theorem verified_assertion_observation_and_resampling s t :
    before s -> assertion_with_frame s t -> asserted s /\ continuation t.
  Proof.
    intros Hbefore Hsample.
    assert (Hassert : asserted s) by (apply assertion_obligation; exact Hbefore).
    split; [exact Hassert|]. eapply assertion_continuation; eauto.
  Qed.
End VerifiedAssertion.

(* A caller proven against r=0 OR r=1 cannot demand r=1. But it CAN
   establish r<=1 for either independent choice; no matching sample is needed. *)
Section DifferentOutputs.
  Definition binary_ensure (_ : unit) (r : nat) : Prop := r = 0 \/ r = 1.
  Definition verified_caller_post (r : nat) : Prop := r <= 1.

  Theorem binary_summary_verifies_continuation s r :
    binary_ensure s r -> verified_caller_post r.
  Proof. intros [H|H]; subst; unfold verified_caller_post; auto. Qed.

  Theorem distinct_legal_samples_both_pass :
    0 <> 1 /\ binary_ensure tt 0 /\ binary_ensure tt 1 /\
    verified_caller_post 0 /\ verified_caller_post 1.
  Proof. unfold binary_ensure, verified_caller_post. repeat split; auto. Qed.
End DifferentOutputs.

Print Assumptions true_property_conclusively_classified_pass.
Print Assumptions every_legal_contract_sample_preserves_continuation.
Print Assumptions legal_boundary_preserves_verified_annotation.
Print Assumptions either_mode_preserves_verified_annotation.
Print Assumptions every_sampled_run_preserves_annotations.
Print Assumptions verified_finite_completed_execution_passes.
Print Assumptions verified_specification_two_modes_semantically_accept.
Print Assumptions verified_specification_completed_verdicts_agree.
Print Assumptions verified_specification_excludes_reachable_violation.
Print Assumptions binary_summary_verifies_continuation.
Print Assumptions distinct_legal_samples_both_pass.

Print Assumptions verified_loop_iterations_preserve_invariant.
Print Assumptions inline_loop_exit_satisfies_continuation.
Print Assumptions every_legal_modular_loop_exit_satisfies_continuation.
Print Assumptions verified_loop_modes_allow_independent_exit_values.
Print Assumptions verified_assertion_observation_and_resampling.


(* A concrete sampled state satisfying its assertion is NOT sufficient to
   validate a universally quantified VC. This separate interface requires
   the complete frozen SOURCE assertion to imply the verified annotation.
   Check identifies the original program point, check kind, and target. *)
Inductive vc_decision := VCValid | VCInvalid | VCPending.

Section FrozenOriginalVCs.
  Context {State Check : Type}.
  Variables verified_annotation original_target : Check -> State -> Prop.
  Hypothesis original_checks_verified : forall point s,
    verified_annotation point s -> original_target point s.

  Record frozen_vc := {
    frozen_check : Check;
    frozen_source : State -> Prop;
    frozen_target : State -> Prop
  }.

  Definition faithful_frozen_vc (vc : frozen_vc) : Prop :=
    (forall s, frozen_source vc s -> verified_annotation (frozen_check vc) s) /\
    frozen_target vc = original_target (frozen_check vc).

  Definition original_vc_valid (vc : frozen_vc) : Prop :=
    forall s, frozen_source vc s -> frozen_target vc s.

  Theorem verified_annotation_implies_original_frozen_vc_valid vc :
    faithful_frozen_vc vc -> original_vc_valid vc.
  Proof.
    intros [Hsource Hsame] s Hs. rewrite Hsame.
    apply original_checks_verified. apply Hsource. exact Hs.
  Qed.

  (* inventory denotes the ENTIRE raw manifest, before solver deduplication or
     display filtering. Forall2 below pairs every original item with a result.
     Faithfulness/coverage of the implementation's exported manifest remains
     an explicit construction interface, not a proved property of C code. *)
  Theorem every_original_inventory_vc_valid inventory :
    Forall faithful_frozen_vc inventory -> Forall original_vc_valid inventory.
  Proof.
    intros H. eapply Forall_impl; [|exact H].
    intros vc Hvc. apply verified_annotation_implies_original_frozen_vc_valid.
    exact Hvc.
  Qed.

  Definition sound_vc_decision (vc : frozen_vc) (decision : vc_decision) : Prop :=
    match decision with
    | VCValid => original_vc_valid vc
    | VCInvalid => ~ original_vc_valid vc
    | VCPending => True
    end.
  Definition decision_complete (decision : vc_decision) : Prop :=
    decision <> VCPending.

  Lemma valid_original_vc_decided_as_valid vc decision :
    original_vc_valid vc -> sound_vc_decision vc decision ->
    decision_complete decision -> decision = VCValid.
  Proof.
    destruct decision; simpl; intros Hv Hd Hcomplete; try reflexivity;
      unfold decision_complete in Hcomplete; contradiction.
  Qed.

  Lemma valid_inventory_all_completed_decisions_valid inventory decisions :
    Forall original_vc_valid inventory ->
    Forall2 sound_vc_decision inventory decisions ->
    Forall decision_complete decisions -> Forall (fun d => d = VCValid) decisions.
  Proof.
    intros Hvalid Hdecisions. revert Hvalid.
    induction Hdecisions; intros Hvalid Hcomplete; [constructor|].
    inversion Hvalid; subst. inversion Hcomplete; subst. constructor.
    - eapply valid_original_vc_decided_as_valid; eauto.
    - apply IHHdecisions; assumption.
  Qed.

  Fixpoint every_vc_marked_valid (decisions : list vc_decision) : bool :=
    match decisions with
    | [] => true
    | VCValid :: rest => every_vc_marked_valid rest
    | _ => false
    end.
  Fixpoint any_vc_marked_invalid (decisions : list vc_decision) : bool :=
    match decisions with
    | [] => false
    | VCInvalid :: _ => true
    | _ :: rest => any_vc_marked_invalid rest
    end.

  (* This aggregate is considered only after execution succeeded. ERROR is a
     separate diagnostic path. A missing entry/coverage/completion certificate
     prevents PASS. These flags represent certificates, not resource budgets. *)
  Definition completed_test_report (entry_sat execution_complete coverage_complete : bool)
      (decisions : list vc_decision) : test_verdict :=
    if entry_sat && execution_complete && coverage_complete then
      if every_vc_marked_valid decisions then PASS
      else if any_vc_marked_invalid decisions then FAIL else UNKNOWN
    else UNKNOWN.

  Lemma all_valid_decisions_compute_true decisions :
    Forall (fun d => d = VCValid) decisions -> every_vc_marked_valid decisions = true.
  Proof.
    intros H. induction H; [reflexivity|]. subst x. simpl. exact IHForall.
  Qed.

  Theorem verified_original_inventory_completed_report_passes inventory decisions
      entry_sat execution_complete coverage_complete :
    Forall faithful_frozen_vc inventory ->
    Forall2 sound_vc_decision inventory decisions ->
    Forall decision_complete decisions ->
    entry_sat = true -> execution_complete = true -> coverage_complete = true ->
    completed_test_report entry_sat execution_complete coverage_complete decisions = PASS.
  Proof.
    intros Hfaithful Hdecisions Hcomplete He Hx Hc. subst.
    assert (Hvalid : Forall original_vc_valid inventory).
    { apply every_original_inventory_vc_valid; exact Hfaithful. }
    assert (Hall : Forall (fun d => d = VCValid) decisions).
    { eapply valid_inventory_all_completed_decisions_valid; eauto. }
    unfold completed_test_report. simpl.
    rewrite (all_valid_decisions_compute_true Hall). reflexivity.
  Qed.

  (* Main report corollary. The two lists, sample values, trace lengths and
     checking costs can differ. Each list must be the full original inventory
     of its own execution; coverage is certified independently in each mode. *)
  Theorem verified_specification_original_vc_reports_agree
      inventoryI inventoryM decisionsI decisionsM
      entryI executionI coverageI entryM executionM coverageM :
    Forall faithful_frozen_vc inventoryI -> Forall faithful_frozen_vc inventoryM ->
    Forall2 sound_vc_decision inventoryI decisionsI ->
    Forall2 sound_vc_decision inventoryM decisionsM ->
    Forall decision_complete decisionsI -> Forall decision_complete decisionsM ->
    entryI = true -> executionI = true -> coverageI = true ->
    entryM = true -> executionM = true -> coverageM = true ->
    completed_test_report entryI executionI coverageI decisionsI = PASS /\
    completed_test_report entryM executionM coverageM decisionsM = PASS /\
    completed_test_report entryI executionI coverageI decisionsI =
    completed_test_report entryM executionM coverageM decisionsM.
  Proof.
    intros Hfi Hfm Hdi Hdm Hci Hcm Hei Hxi Hoi Hem Hxm Hom.
    assert (Hi : completed_test_report entryI executionI coverageI decisionsI = PASS).
    { exact (verified_original_inventory_completed_report_passes Hfi Hdi Hci Hei Hxi Hoi). }
    assert (Hm : completed_test_report entryM executionM coverageM decisionsM = PASS).
    { exact (verified_original_inventory_completed_report_passes Hfm Hdm Hcm Hem Hxm Hom). }
    repeat split; congruence.
  Qed.
End FrozenOriginalVCs.

Print Assumptions verified_annotation_implies_original_frozen_vc_valid.
Print Assumptions every_original_inventory_vc_valid.
Print Assumptions verified_original_inventory_completed_report_passes.
Print Assumptions verified_specification_original_vc_reports_agree.
