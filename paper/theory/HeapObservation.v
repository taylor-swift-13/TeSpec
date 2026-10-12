From Coq Require Import Bool.
Set Implicit Arguments.

(* Scalar-cell observation semantics. The mask identifies precisely the
   unmentioned live stack cells admitted by the observation interface.
   Proving that frontend metadata constructs that mask is a separate
   implementation-refinement obligation. No execution heap is modified. *)
Section HeapObservations.
Context {Cell : Type}.
Definition heap := nat -> option Cell.
Definition assertion := heap -> Prop.
Definition heap_eq (h k : heap) := forall a, h a = k a.
Definition respects (A : assertion) :=
  forall h k, heap_eq h k -> (A h <-> A k).
Definition stack_part (mask : nat -> bool) (h : heap) : heap :=
  fun a => if mask a then h a else None.
Definition visible_part (mask : nat -> bool) (h : heap) : heap :=
  fun a => if mask a then None else h a.
Definition disjoint (h k : heap) :=
  forall a v w, h a = Some v -> k a = Some w -> False.
Definition join (h k whole : heap) :=
  forall a, whole a = match h a with Some v => Some v | None => k a end.
Definition sep (A F : assertion) : assertion :=
  fun h => exists hu hf, disjoint hu hf /\ join hu hf h /\ A hu /\ F hf.
Definition exact (frame : heap) : assertion := fun h => heap_eq h frame.
Definition empty : assertion := fun h => forall a, h a = None.

Theorem stack_partition mask h :
  disjoint (visible_part mask h) (stack_part mask h) /\
  join (visible_part mask h) (stack_part mask h) h.
Proof.
  split.
  - intros a v w. unfold visible_part, stack_part.
    destruct (mask a); intros H K; discriminate.
  - intros a. unfold visible_part, stack_part.
    destruct (mask a); [reflexivity | destruct (h a); reflexivity].
Qed.

Theorem exact_stack_split_unique mask h hu hf :
  disjoint hu hf -> join hu hf h -> exact (stack_part mask h) hf ->
  heap_eq hu (visible_part mask h).
Proof.
  intros Hd Hj Hf a. specialize (Hj a). specialize (Hf a).
  unfold stack_part in Hf. unfold visible_part.
  destruct (mask a) eqn:Hmask.
  - destruct (hu a) eqn:Hu; [|reflexivity].
    simpl in Hj. exfalso. eapply Hd; [exact Hu |].
    rewrite Hf. exact Hj.
  - rewrite Hf in Hj. destruct (hu a); simpl in Hj; symmetry; exact Hj.
Qed.

Theorem lifted_observation_characterization mask h A :
  respects A ->
  (sep A (exact (stack_part mask h)) h <-> A (visible_part mask h)).
Proof.
  intros HA. split.
  - intros [hu [hf [Hd [Hj [Huser Hframe]]]]].
    apply (proj1 (HA hu (visible_part mask h)
      (exact_stack_split_unique Hd Hj Hframe))). exact Huser.
  - intros Huser. exists (visible_part mask h), (stack_part mask h).
    destruct (stack_partition mask h) as [Hd Hj].
    split; [exact Hd|]. split; [exact Hj|]. split; [exact Huser|].
    intros a; reflexivity.
Qed.

Theorem observation_keeps_stack_cell mask h A a v :
  mask a = true -> h a = Some v ->
  sep A (exact (stack_part mask h)) h ->
  exists hu hf, disjoint hu hf /\ join hu hf h /\ A hu /\
    exact (stack_part mask h) hf /\ hf a = Some v.
Proof.
  intros Hmask Hv [hu [hf [Hd [Hj [Hu Hf]]]]].
  exists hu, hf. split; [exact Hd|]. split; [exact Hj|].
  split; [exact Hu|]. split; [exact Hf|].
  rewrite (Hf a). unfold stack_part. rewrite Hmask. exact Hv.
Qed.

Theorem observation_keeps_visible_cell mask h A a v :
  mask a = false -> h a = Some v ->
  sep A (exact (stack_part mask h)) h ->
  exists hu hf, disjoint hu hf /\ join hu hf h /\ A hu /\ hu a = Some v.
Proof.
  intros Hmask Hv [hu [hf [Hd [Hj [Hu Hf]]]]].
  exists hu, hf. split; [exact Hd|]. split; [exact Hj|]. split; [exact Hu|].
  rewrite (exact_stack_split_unique Hd Hj Hf a).
  unfold visible_part. rewrite Hmask. exact Hv.
Qed.

Theorem empty_respects : respects empty.
Proof.
  intros h k Heq. split; intros H a.
  - rewrite <- (Heq a). apply H.
  - rewrite (Heq a). apply H.
Qed.

Theorem unmentioned_user_cell_cannot_be_discarded mask h a v :
  mask a = false -> h a = Some v ->
  ~ sep empty (exact (stack_part mask h)) h.
Proof.
  intros Hmask Hv Hobs.
  apply (proj1 (lifted_observation_characterization mask h empty_respects)) in Hobs.
  specialize (Hobs a). unfold visible_part in Hobs.
  rewrite Hmask, Hv in Hobs. discriminate.
Qed.

(* Resolve existential values before constructing the corresponding frame:
   the set of described addresses can depend on the chosen witness. *)
Theorem existential_observation_characterization {W : Type}
    (A : W -> assertion) (mask : W -> nat -> bool) h :
  (forall w, respects (A w)) ->
  ((exists w, sep (A w) (exact (stack_part (mask w) h)) h) <->
   exists w, A w (visible_part (mask w) h)).
Proof.
  intros HA. split; intros [w Hw]; exists w.
  - apply (proj1 (lifted_observation_characterization (mask w) h (HA w))).
    exact Hw.
  - apply (proj2 (lifted_observation_characterization (mask w) h (HA w))).
    exact Hw.
Qed.

Theorem selected_observation_witness_sound {W : Type}
    (A : W -> assertion) (mask : W -> nat -> bool) h w :
  (forall v, respects (A v)) ->
  sep (A w) (exact (stack_part (mask w) h)) h ->
  exists v, A v (visible_part (mask v) h).
Proof.
  intros HA Hw.
  apply (proj1 (existential_observation_characterization A mask h HA)).
  exists w; exact Hw.
Qed.

End HeapObservations.

Print Assumptions stack_partition.
Print Assumptions exact_stack_split_unique.
Print Assumptions lifted_observation_characterization.
Print Assumptions observation_keeps_stack_cell.
Print Assumptions observation_keeps_visible_cell.
Print Assumptions empty_respects.
Print Assumptions unmentioned_user_cell_cannot_be_discarded.
Print Assumptions existential_observation_characterization.
Print Assumptions selected_observation_witness_sound.
