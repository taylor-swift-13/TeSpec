From SimpleC.Verification Require Import VCPrelude.
Require Import ExecutionGoal DLLSupplement.
From Coq Require Import ZArith List Bool Lia.
From SimpleC.SL Require Import Mem.
Require Import SetsClass.SetsClass.
Import ListNotations SetsNotation.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(* Finite byte heaps, with the same STS and token components as a byte store. *)
Fixpoint finite_memory (bs : list (Z * Z)) : mem :=
  match bs with
  | [] => empty_mem
  | (p, b) :: tl =>
      fun x => if addr_eqb x p then value b else finite_memory tl x
  end.

Definition finite_state (m : mem) : naive_C_Rules.model :=
  {| ConAssertion.s_mem := m;
     ConAssertion.s_STS := Sets.full;
     ConAssertion.s_token := Sets.empty |}.

Definition bytes_disjointb (xs ys : list (Z * Z)) : bool :=
  forallb
    (fun ab => forallb (fun cd => negb (Z.eqb (fst ab) (fst cd))) ys)
    xs.

Lemma finite_memory_present : forall bs p,
  finite_memory bs p <> Noperm -> exists b, In (p, b) bs.
Proof.
  induction bs as [| [a b] tl IH]; intros p H.
  - exfalso. apply H. reflexivity.
  - cbn [finite_memory] in H.
    destruct (addr_eqb p a) eqn:E.
    + apply addr_eqb_eq in E. subst a.
      exists b. left. reflexivity.
    + destruct (IH p H) as [c Hc]. exists c. right. exact Hc.
Qed.

Lemma finite_memory_app : forall xs ys p,
  finite_memory (xs ++ ys) p =
  match finite_memory xs p with
  | Noperm => finite_memory ys p
  | v => v
  end.
Proof.
  induction xs as [| [a b] tl IH]; intros ys p.
  - reflexivity.
  - cbn [List.app finite_memory].
    destruct (addr_eqb p a); [reflexivity | apply IH].
Qed.

Lemma bytes_disjointb_sound : forall xs ys,
  bytes_disjointb xs ys = true ->
  forall p b c, In (p, b) xs -> In (p, c) ys -> False.
Proof.
  unfold bytes_disjointb.
  intros xs ys H p b c Hx Hy.
  rewrite forallb_forall in H. specialize (H (p, b) Hx).
  rewrite forallb_forall in H. specialize (H (p, c) Hy).
  cbn in H. rewrite Z.eqb_refl in H. discriminate.
Qed.

Lemma finite_memory_join : forall xs ys,
  bytes_disjointb xs ys = true ->
  mem_join (finite_memory xs) (finite_memory ys)
           (finite_memory (xs ++ ys)).
Proof.
  intros xs ys Hd.
  assert (Hdis : forall p,
    finite_memory xs p <> Noperm ->
    finite_memory ys p <> Noperm -> False).
  {
    intros p Hx Hy.
    destruct (finite_memory_present xs p Hx) as [b Hb].
    destruct (finite_memory_present ys p Hy) as [c Hc].
    exact (bytes_disjointb_sound xs ys Hd p b c Hb Hc).
  }
  unfold mem_join. intro p. rewrite finite_memory_app.
  destruct (finite_memory xs p) eqn:Hx;
    destruct (finite_memory ys p) eqn:Hy;
    cbn; try solve [eauto 8].
  all: exfalso; apply (Hdis p); congruence.
Qed.

Lemma finite_state_join : forall a b c,
  mem_join a b c ->
  naive_C_Rules.join (finite_state a) (finite_state b) (finite_state c).
Proof.
  intros a b c H.
  unfold naive_C_Rules.join, ConAssertion.state_join, finite_state.
  cbn. split; [exact H |].
  unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join.
  sets_unfold. tauto.
Qed.

Lemma finite_sep : forall (P Q : Assertion) xs ys,
  bytes_disjointb xs ys = true ->
  P (finite_state (finite_memory xs)) ->
  Q (finite_state (finite_memory ys)) ->
  (P ** Q) (finite_state (finite_memory (xs ++ ys))).
Proof.
  intros P Q xs ys Hd HP HQ.
  assert (HJ : naive_C_Rules.join
    (finite_state (finite_memory xs))
    (finite_state (finite_memory ys))
    (finite_state (finite_memory (xs ++ ys)))).
  { apply finite_state_join. apply finite_memory_join. exact Hd. }
  unfold naive_C_Rules.sepcon.
  exists (finite_state (finite_memory xs)),
         (finite_state (finite_memory ys)).
  tauto.
Qed.

Lemma finite_byte : forall p b,
  naive_C_Rules.store_byte p b
    (finite_state (finite_memory [(p, b)])).
Proof.
  intros p b.
  unfold naive_C_Rules.store_byte, naive_C_Rules.mstore, finite_state.
  exists b. split; [apply Byte.eqm_refl |].
  repeat split; try reflexivity; sets_unfold; tauto.
Qed.

Lemma finite_emp : emp (finite_state (finite_memory [])).
Proof.
  unfold naive_C_Rules.emp, naive_C_Rules.is_unit,
         ConAssertion.state_empty, finite_state.
  cbn. split; [apply empty_mem_empty |].
  sets_unfold. tauto.
Qed.

(* Big-endian four-byte words. The merge relation is the runtime relation. *)
Definition word_bytes (p b0 b1 b2 b3 : Z) : list (Z * Z) :=
  [(p, b0); (p + 1, b1); (p + 2, b2); (p + 3, b3)].

Ltac distinct_word_bytes :=
  unfold bytes_disjointb;
  cbn [forallb fst];
  repeat rewrite Bool.andb_true_iff;
  repeat split;
  try reflexivity;
  apply Bool.negb_true_iff;
  apply Z.eqb_neq; lia.

Lemma finite_word : forall p b0 b1 b2 b3 v,
  merge_int b0 b1 b2 b3 v ->
  naive_C_Rules.store_4byte p v
    (finite_state (finite_memory (word_bytes p b0 b1 b2 b3))).
Proof.
  intros p b0 b1 b2 b3 v Hmerge.
  unfold naive_C_Rules.store_4byte.
  exists b0, b1, b2, b3. split; [exact Hmerge |].
  unfold word_bytes.
  eapply finite_sep with
    (xs := [(p, b0)]) (ys := [(p + 1, b1); (p + 2, b2); (p + 3, b3)]).
  - distinct_word_bytes.
  - apply finite_byte.
  - eapply finite_sep with
      (xs := [(p + 1, b1)]) (ys := [(p + 2, b2); (p + 3, b3)]).
    + distinct_word_bytes.
    + apply finite_byte.
    + eapply finite_sep with
        (xs := [(p + 2, b2)]) (ys := [(p + 3, b3)]).
      * distinct_word_bytes.
      * apply finite_byte.
      * apply finite_byte.
Qed.

Lemma finite_int : forall p b0 b1 b2 b3 v,
  (isvalidptr_int p /\ v <= Int.max_signed /\ v >= Int.min_signed) ->
  merge_int b0 b1 b2 b3 v ->
  (p # Int |-> v)
    (finite_state (finite_memory (word_bytes p b0 b1 b2 b3))).
Proof.
  intros p b0 b1 b2 b3 v Hvalid Hmerge.
  unfold naive_C_Rules.store_int. split; [exact Hvalid |].
  apply finite_word. exact Hmerge.
Qed.

Lemma finite_ptr : forall p b0 b1 b2 b3 v,
  (isvalidptr p /\ v >= 0 /\ v <= Int.max_unsigned) ->
  merge_int b0 b1 b2 b3 v ->
  (p # Ptr |-> v)
    (finite_state (finite_memory (word_bytes p b0 b1 b2 b3))).
Proof.
  intros p b0 b1 b2 b3 v Hvalid Hmerge.
  unfold naive_C_Rules.store_ptr. split; [exact Hvalid |].
  apply finite_word. exact Hmerge.
Qed.

(* The actual entry: 4096 = {10, NULL, 12288},
   12288 = {20, 4096, NULL}. The list order follows the assertions. *)
Definition entry_data := word_bytes 4096 0 0 0 10.
Definition entry_prev := word_bytes 4100 0 0 0 0.
Definition entry_next := word_bytes 4104 0 0 48 0.
Definition successor_data := word_bytes 12288 0 0 0 20.
Definition successor_next := word_bytes 12296 0 0 0 0.
Definition successor_prev := word_bytes 12292 0 0 16 0.

Definition current_bytes := ((entry_data ++ entry_prev) ++ entry_next) ++ [].
Definition successor_bytes :=
  ((successor_data ++ successor_next) ++ successor_prev) ++ [].
Definition entry_bytes := current_bytes ++ successor_bytes.

Ltac concrete_int :=
  apply finite_int; [cbv; intuition congruence | reflexivity].
Ltac concrete_ptr :=
  apply finite_ptr; [cbv; intuition congruence | reflexivity].

Lemma successor_heap :
  DLLRight 12288 4096 [20]
    (finite_state (finite_memory successor_bytes)).
Proof.
  cbn [DLLRight]. split; [discriminate |]. exists 0.
  unfold successor_bytes.
  eapply finite_sep with
    (xs := (successor_data ++ successor_next) ++ successor_prev) (ys := []).
  - reflexivity.
  - eapply finite_sep with
      (xs := successor_data ++ successor_next) (ys := successor_prev).
    + reflexivity.
    + eapply finite_sep with (xs := successor_data) (ys := successor_next).
      * reflexivity.
      * unfold successor_data. concrete_int.
      * unfold successor_next. concrete_ptr.
    + unfold successor_prev. concrete_ptr.
  - split; [reflexivity | apply finite_emp].
Qed.

Lemma entry_heap :
  ((4096 + 0) # Int |-> 10 **
   (4096 + 4) # Ptr |-> 0 **
   (4096 + 8) # Ptr |-> 12288 **
   DLLLeft 0 4096 [] ** DLLRight 12288 4096 [20])
    (finite_state (finite_memory entry_bytes)).
Proof.
  unfold entry_bytes.
  eapply finite_sep with (xs := current_bytes) (ys := successor_bytes).
  - reflexivity.
  - unfold current_bytes.
    eapply finite_sep with
      (xs := (entry_data ++ entry_prev) ++ entry_next) (ys := []).
    + reflexivity.
    + eapply finite_sep with (xs := entry_data ++ entry_prev) (ys := entry_next).
      * reflexivity.
      * eapply finite_sep with (xs := entry_data) (ys := entry_prev).
        -- reflexivity.
        -- unfold entry_data. concrete_int.
        -- unfold entry_prev. concrete_ptr.
      * unfold entry_next. concrete_ptr.
    + cbn [DLLLeft]. split; [reflexivity | apply finite_emp].
  - exact successor_heap.
Qed.

Theorem resolved_add_precondition_wit_1 : ExecutionGoal.add_precondition_wit_1.
Proof.
  unfold ExecutionGoal.add_precondition_wit_1.
  exists [20], [], 12288, 0, 10, 7, 7, 4096.
  intro Hfalse.
  apply (Hfalse (finite_state (finite_memory entry_bytes))).
  left.
  repeat first [exact entry_heap | reflexivity | discriminate | split].
Qed.
Print Assumptions resolved_add_precondition_wit_1.
