From Coq Require Import List Arith Bool Lia ZArith.
Import ListNotations.
Set Implicit Arguments.

(* Scalar-cell reference semantics for actual calls. Locations are fresh logical
   cell identities, not numerical C addresses. Arguments have already been
   evaluated and converted to their parameter types. This module isolates
   frame/alias/lifetime obligations; it does not encode C layout or evaluation
   order, dynamic allocation, aggregate copies, or the executor implementation. *)

Inductive value := IntValue (z : Z) | PointerValue (location : nat).
Definition heap := nat -> option value.
Definition environment := nat -> option nat.

Record frame := Frame {
  frame_base : nat;
  caller_environment : environment
}.

Record state := State {
  memory : heap;
  locals : environment;
  fresh : nat;
  stack : list frame
}.

Definition well_allocated s := forall a, fresh s <= a -> memory s a = None.

Definition install (h : heap) (base : nat) (arguments : list value) : heap :=
  fun a => if a <? base then h a else
    match nth_error arguments (a - base) with
    | Some v => Some v
    | None => h a
    end.

Definition parameter_environment base count : environment :=
  fun identifier => if identifier <? count then Some (base + identifier) else None.

Definition enter (s : state) (arguments : list value) : state :=
  State (install (memory s) (fresh s) arguments)
    (parameter_environment (fresh s) (length arguments))
    (fresh s + length arguments)
    (Frame (fresh s) (locals s) :: stack s).

Definition read_local (s : state) identifier :=
  match locals s identifier with
  | Some address => memory s address
  | None => None
  end.

Definition write_cell (s : state) address v :=
  State (fun a => if Nat.eqb a address then Some v else memory s a)
    (locals s) (fresh s) (stack s).

Definition allocate_local (s : state) identifier v :=
  State (fun a => if Nat.eqb a (fresh s) then Some v else memory s a)
    (fun x => if Nat.eqb x identifier then Some (fresh s) else locals s x)
    (S (fresh s)) (stack s).

(* All fresh cells in this fragment are stack cells. A dynamic allocator must
   track allocation ownership separately; it cannot use this interval cleanup. *)
Definition retire (h : heap) base limit : heap :=
  fun a => if (base <=? a) && (a <? limit) then None else h a.

Definition finish (f : frame) (outer : list frame) (s : state) : state :=
  State (retire (memory s) (frame_base f) (fresh s))
    (caller_environment f) (fresh s) outer.

Definition leave (s : state) (return_value : value) : option (state * value) :=
  match stack s with
  | [] => None
  | f :: outer => Some (finish f outer s, return_value)
  end.

Lemma install_parameter h base arguments index v :
  nth_error arguments index = Some v ->
  install h base arguments (base + index) = Some v.
Proof.
  intros H. unfold install.
  assert (Hlt : (base + index <? base) = false) by (apply Nat.ltb_ge; lia).
  rewrite Hlt. replace (base + index - base) with index by lia.
  rewrite H. reflexivity.
Qed.

Lemma install_before h base arguments address :
  address < base -> install h base arguments address = h address.
Proof.
  intros H. unfold install.
  assert (Hlt : (address <? base) = true) by (apply Nat.ltb_lt; exact H).
  rewrite Hlt. reflexivity.
Qed.

Lemma install_after h base arguments address :
  base + length arguments <= address ->
  install h base arguments address = h address.
Proof.
  intros H. unfold install.
  assert (Hlt : (address <? base) = false) by (apply Nat.ltb_ge; lia).
  assert (Hnone : nth_error arguments (address - base) = None).
  { apply nth_error_None. lia. }
  rewrite Hlt, Hnone. reflexivity.
Qed.

Theorem entry_preserves_caller_memory s arguments address :
  address < fresh s -> memory (enter s arguments) address = memory s address.
Proof. apply install_before. Qed.

Theorem entry_copies_argument_values s arguments identifier :
  read_local (enter s arguments) identifier = nth_error arguments identifier.
Proof.
  unfold read_local, enter; simpl. unfold parameter_environment.
  destruct (identifier <? length arguments) eqn:Hlt.
  - apply Nat.ltb_lt in Hlt.
    destruct (nth_error arguments identifier) as [v|] eqn:Hnth.
    + apply install_parameter. exact Hnth.
    + apply nth_error_None in Hnth. lia.
  - apply Nat.ltb_ge in Hlt. symmetry. apply nth_error_None. exact Hlt.
Qed.

Theorem entry_preserves_allocation_invariant s arguments :
  well_allocated s -> well_allocated (enter s arguments).
Proof.
  intros H a Ha. unfold enter in Ha |- *; simpl in *.
  rewrite install_after by exact Ha. apply H. lia.
Qed.

Theorem parameter_slots_are_fresh_and_distinct s (arguments : list value) i j :
  i < length arguments -> j < length arguments -> i <> j ->
  fresh s <= fresh s + i /\ fresh s <= fresh s + j /\
  fresh s + i <> fresh s + j.
Proof. intros. repeat split; lia. Qed.

Theorem passed_pointer_aliases_are_preserved s arguments i j address :
  nth_error arguments i = Some (PointerValue address) ->
  nth_error arguments j = Some (PointerValue address) ->
  read_local (enter s arguments) i = Some (PointerValue address) /\
  read_local (enter s arguments) j = Some (PointerValue address).
Proof. intros Hi Hj. repeat rewrite entry_copies_argument_values. auto. Qed.

Theorem local_allocation_preserves_existing_cells s identifier v address :
  address < fresh s ->
  memory (allocate_local s identifier v) address = memory s address.
Proof.
  intros H. simpl.
  assert (Hneq : (address =? fresh s) = false) by (apply Nat.eqb_neq; lia).
  rewrite Hneq. reflexivity.
Qed.

Theorem local_allocation_preserves_freshness s identifier v :
  well_allocated s -> well_allocated (allocate_local s identifier v).
Proof.
  intros H address Ha. unfold allocate_local in Ha |- *; simpl in *.
  assert (Hneq : (address =? fresh s) = false) by (apply Nat.eqb_neq; lia).
  rewrite Hneq. apply H. lia.
Qed.

Theorem parameter_assignment_does_not_write_old_referent
    s arguments index address new_value :
  address < fresh s ->
  memory (write_cell (enter s arguments) (fresh s + index) new_value) address =
    memory s address.
Proof.
  intros H. simpl.
  assert (Hneq : (address =? fresh s + index) = false) by (apply Nat.eqb_neq; lia).
  rewrite Hneq. apply install_before. exact H.
Qed.

Lemma retire_before h base limit address :
  address < base -> retire h base limit address = h address.
Proof.
  intros H. unfold retire.
  assert (Hle : (base <=? address) = false) by (apply Nat.leb_gt; lia).
  rewrite Hle. reflexivity.
Qed.

Lemma retire_inside h base limit address :
  base <= address -> address < limit -> retire h base limit address = None.
Proof.
  intros Hbase Hlimit. unfold retire.
  assert (Hle : (base <=? address) = true) by (apply Nat.leb_le; assumption).
  assert (Hlt : (address <? limit) = true) by (apply Nat.ltb_lt; assumption).
  rewrite Hle, Hlt. reflexivity.
Qed.

Theorem return_restores_environment_and_preserves_value s f outer v :
  stack s = f :: outer ->
  leave s v = Some (finish f outer s, v) /\
  locals (finish f outer s) = caller_environment f /\
  stack (finish f outer s) = outer /\
  fresh (finish f outer s) = fresh s.
Proof. intros H. unfold leave. rewrite H. repeat split; reflexivity. Qed.

Theorem return_preserves_shared_updates s f outer address :
  address < frame_base f ->
  memory (finish f outer s) address = memory s address.
Proof. apply retire_before. Qed.

Theorem return_retires_callee_storage s f outer address :
  frame_base f <= address -> address < fresh s ->
  memory (finish f outer s) address = None.
Proof. apply retire_inside. Qed.

Theorem return_preserves_allocation_invariant s f outer :
  well_allocated s -> well_allocated (finish f outer s).
Proof.
  intros H address Ha. unfold finish in Ha |- *; simpl in *.
  unfold retire.
  assert (Hlt : (address <? fresh s) = false) by (apply Nat.ltb_ge; assumption).
  rewrite Hlt. destruct (frame_base f <=? address); simpl; apply H; exact Ha.
Qed.

(* A passed pointer retains its old referent even though its parameter slot is
   fresh. A body write through that pointer survives frame cleanup. *)
Theorem shared_write_survives_call s arguments address written returned :
  address < fresh s ->
  exists after,
    leave (write_cell (enter s arguments) address written) returned =
      Some (after, returned) /\
    memory after address = Some written /\ locals after = locals s.
Proof.
  intros Ha.
  exists (finish (Frame (fresh s) (locals s)) (stack s)
    (write_cell (enter s arguments) address written)).
  split; [reflexivity|]. split; [|reflexivity].
  rewrite return_preserves_shared_updates by (simpl; exact Ha).
  simpl. rewrite Nat.eqb_refl. reflexivity.
Qed.

(* Nested calls may reuse source identifiers. Their parameter slots are fresh,
   and popping the inner frame restores the outer invocation's environment. *)
Theorem nested_return_restores_outer_parameters s outer_args inner_args :
  locals (finish
    (Frame (fresh (enter s outer_args)) (locals (enter s outer_args)))
    (stack (enter s outer_args)) (enter (enter s outer_args) inner_args)) =
  locals (enter s outer_args).
Proof. reflexivity. Qed.

(* Returning an address of a local does not revive that cell: the value can be
   propagated, but a subsequent read finds no live storage in this model. *)
Theorem escaped_local_is_not_revived s arguments index v :
  nth_error arguments index = Some v ->
  let callee := enter s arguments in
  let address := fresh s + index in
  exists after,
    leave callee (PointerValue address) = Some (after, PointerValue address) /\
    memory after address = None.
Proof.
  intros H callee address.
  exists (finish (Frame (fresh s) (locals s)) (stack s) callee).
  split; [reflexivity|]. apply return_retires_callee_storage; simpl.
  - unfold address. lia.
  - unfold address, callee, enter; simpl.
    assert (index < length arguments).
    { apply nth_error_Some. rewrite H. discriminate. }
    lia.
Qed.

Print Assumptions entry_copies_argument_values.
Print Assumptions entry_preserves_caller_memory.
Print Assumptions entry_preserves_allocation_invariant.
Print Assumptions passed_pointer_aliases_are_preserved.
Print Assumptions return_restores_environment_and_preserves_value.
Print Assumptions return_preserves_shared_updates.
Print Assumptions return_retires_callee_storage.
Print Assumptions shared_write_survives_call.
Print Assumptions escaped_local_is_not_revived.
Print Assumptions local_allocation_preserves_existing_cells.
Print Assumptions local_allocation_preserves_freshness.
Print Assumptions parameter_assignment_does_not_write_old_referent.
Print Assumptions nested_return_restores_outer_parameters.
