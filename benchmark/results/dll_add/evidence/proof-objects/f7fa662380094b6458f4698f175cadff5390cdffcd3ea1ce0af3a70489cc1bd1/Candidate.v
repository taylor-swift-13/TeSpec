From SimpleC.Verification Require Import VCPrelude.
Require Import DLLSupplement.
Require Import Goal.

Module FiniteEntryHeap.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

(* A finite byte map, with no permissions outside the listed addresses. *)
Fixpoint entry_mem (bs : list (Z * Z)) : mem :=
  match bs with
  | nil => empty_mem
  | (p, b) :: tl =>
      fun x => if Z.eqb x p then value b else entry_mem tl x
  end.

Definition entry_state (m : mem) : naive_C_Rules.model :=
  {| ConAssertion.s_mem := m;
     ConAssertion.s_STS := Sets.full;
     ConAssertion.s_token := Sets.empty |}.

Lemma entry_state_join : forall a b c,
  mem_join a b c ->
  naive_C_Rules.join (entry_state a) (entry_state b) (entry_state c).
Proof.
  intros a b c H.
  unfold naive_C_Rules.join, ConAssertion.state_join, entry_state; cbn.
  split; [exact H |].
  unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join.
  sets_unfold; tauto.
Qed.

Lemma entry_state_emp : emp (entry_state empty_mem).
Proof.
  unfold naive_C_Rules.emp, naive_C_Rules.is_unit,
    ConAssertion.state_empty, entry_state; cbn.
  split; [apply empty_mem_empty |].
  sets_unfold; tauto.
Qed.

Lemma entry_state_byte : forall p b,
  naive_C_Rules.mstore p b (entry_state (single_byte_mem p b)).
Proof.
  intros p b.
  unfold naive_C_Rules.mstore, entry_state.
  exists b; split; [apply Byte.eqm_refl |].
  repeat split; try reflexivity; sets_unfold; tauto.
Qed.

Lemma entry_state_sep : forall (P Q : naive_C_Rules.expr) a b c,
  mem_join a b c -> P (entry_state a) -> Q (entry_state b) ->
  (P ** Q) (entry_state c).
Proof.
  intros P Q a b c Hjoin HP HQ.
  pose proof (entry_state_join a b c Hjoin) as Hstate.
  exists (entry_state a), (entry_state b); tauto.
Qed.

Lemma entry_mem_absent : forall bs x,
  ~ In x (map fst bs) -> entry_mem bs x = Noperm.
Proof.
  induction bs as [| [p b] tl IH]; intros x H.
  - reflexivity.
  - cbn [entry_mem].
    destruct (Z.eqb x p) eqn:E.
    + apply Z.eqb_eq in E; subst x.
      exfalso; apply H; cbn; left; reflexivity.
    + apply IH; intro Hin; apply H; cbn; right; exact Hin.
Qed.

Lemma entry_mem_app_join : forall l r,
  (forall x, In x (map fst l) -> ~ In x (map fst r)) ->
  mem_join (entry_mem l) (entry_mem r) (entry_mem (l ++ r)).
Proof.
  induction l as [| [p b] tl IH]; intros r Hd.
  - apply mem_join_emp1.
  - unfold mem_join; intro x; cbn [entry_mem List.app].
    destruct (Z.eqb x p) eqn:E.
    + apply Z.eqb_eq in E; subst x.
      assert (Hr : entry_mem r p = Noperm).
      { apply entry_mem_absent; apply Hd; cbn; left; reflexivity. }
      rewrite Hr.
      do 4 right; exists b; repeat split; reflexivity.
    + assert (Ht : forall y, In y (map fst tl) -> ~ In y (map fst r)).
      { intros y Hy; apply Hd; cbn; right; exact Hy. }
      exact (IH r Ht x).
Qed.

Lemma entry_mem_sep : forall (P Q : naive_C_Rules.expr) l r,
  (forall x, In x (map fst l) -> ~ In x (map fst r)) ->
  P (entry_state (entry_mem l)) -> Q (entry_state (entry_mem r)) ->
  (P ** Q) (entry_state (entry_mem (l ++ r))).
Proof.
  intros P Q l r Hd HP HQ.
  eapply entry_state_sep; [apply entry_mem_app_join; exact Hd | exact HP | exact HQ].
Qed.

Definition entry_word (p a b c d : Z) : list (Z * Z) :=
  [(p, a); (p + 1, b); (p + 2, c); (p + 3, d)].

Lemma entry_word_store : forall p a b c d v,
  merge_int a b c d v ->
  naive_C_Rules.store_4byte p v
    (entry_state (entry_mem (entry_word p a b c d))).
Proof.
  intros p a b c d v Hmerge.
  unfold naive_C_Rules.store_4byte.
  exists a, b, c, d; split; [exact Hmerge |].
  eapply entry_mem_sep with
    (l := [(p, a)]) (r := [(p + 1, b); (p + 2, c); (p + 3, d)]).
  - cbn; intros x Hin Hout.
    destruct Hin as [Hin | []]; subst x.
    destruct Hout as [Hout | [Hout | [Hout | []]]]; lia.
  - apply entry_state_byte.
  - eapply entry_mem_sep with
      (l := [(p + 1, b)]) (r := [(p + 2, c); (p + 3, d)]).
    + cbn; intros x Hin Hout.
      destruct Hin as [Hin | []]; subst x.
      destruct Hout as [Hout | [Hout | []]]; lia.
    + apply entry_state_byte.
    + eapply entry_mem_sep with (l := [(p + 2, c)]) (r := [(p + 3, d)]).
      * cbn; intros x Hin Hout.
        destruct Hin as [Hin | []]; subst x.
        destruct Hout as [Hout | []]; lia.
      * apply entry_state_byte.
      * apply entry_state_byte.
Qed.


End FiniteEntryHeap.

From SimpleC.Verification Require Import VCPrelude.
Import FiniteEntryHeap.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

(* The current node and its single predecessor, in big-endian byte order. *)
Definition candidate_current_bytes : list (Z * Z) :=
  (entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0) ++
  entry_word 4104 0 0 0 0.

Definition candidate_previous_bytes : list (Z * Z) :=
  (entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0) ++
  entry_word 8200 0 0 16 0.

Definition candidate_entry_bytes : list (Z * Z) :=
  candidate_current_bytes ++ candidate_previous_bytes.

Ltac candidate_disjoint :=
  cbn; intuition lia.

Ltac candidate_store :=
  lazymatch goal with
  | |- naive_C_Rules.store_int _ _ _ =>
      unfold naive_C_Rules.store_int
  | |- naive_C_Rules.store_ptr _ _ _ =>
      unfold naive_C_Rules.store_ptr
  end;
  split;
  [ cbv; intuition discriminate
  | apply entry_word_store; reflexivity ].

Lemma candidate_current_heap :
  ((4096 + 0) # Int |-> 10 **
   (4096 + 4) # Ptr |-> 8192 **
   (4096 + 8) # Ptr |-> 0)
    (entry_state (entry_mem candidate_current_bytes)).
Proof.
  eapply entry_mem_sep with
    (l := entry_word 4096 0 0 0 10 ++ entry_word 4100 0 0 32 0)
    (r := entry_word 4104 0 0 0 0).
  - candidate_disjoint.
  - eapply entry_mem_sep with
      (l := entry_word 4096 0 0 0 10)
      (r := entry_word 4100 0 0 32 0).
    + candidate_disjoint.
    + candidate_store.
    + candidate_store.
  - candidate_store.
Qed.

Lemma candidate_previous_heap :
  DLLLeft 8192 4096 [30]
    (entry_state (entry_mem candidate_previous_bytes)).
Proof.
  split; [unfold naive_C_Rules.coq_prop; lia |].
  exists 0.
  eapply entry_mem_sep with (l := candidate_previous_bytes) (r := []).
  - candidate_disjoint.
  - eapply entry_mem_sep with
      (l := entry_word 8192 0 0 0 30 ++ entry_word 8196 0 0 0 0)
      (r := entry_word 8200 0 0 16 0).
    + candidate_disjoint.
    + eapply entry_mem_sep with
        (l := entry_word 8192 0 0 0 30)
        (r := entry_word 8196 0 0 0 0).
      * candidate_disjoint.
      * candidate_store.
      * candidate_store.
    + candidate_store.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Lemma candidate_entry_heap :
  ((4096 + 0) # Int |-> 10 **
   (4096 + 4) # Ptr |-> 8192 **
   (4096 + 8) # Ptr |-> 0 **
   DLLLeft 8192 4096 [30] **
   DLLRight 0 4096 [])
    (entry_state (entry_mem candidate_entry_bytes)).
Proof.
  eapply entry_mem_sep with (l := candidate_entry_bytes) (r := []).
  - candidate_disjoint.
  - eapply entry_mem_sep with
      (l := candidate_current_bytes) (r := candidate_previous_bytes).
    + candidate_disjoint.
    + exact candidate_current_heap.
    + exact candidate_previous_heap.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Theorem resolved_add_precondition_wit_1 : Goal.add_precondition_wit_1.
Proof.
  unfold Goal.add_precondition_wit_1.
  exists [], [30], 0, 8192, 10, 7, 7, 4096.
  intro Hfalse.
  apply (Hfalse (entry_state (entry_mem candidate_entry_bytes))).
  left.
  repeat apply conj; try reflexivity; try discriminate;
    try (change (4096 <> 0); lia); exact candidate_entry_heap.
Qed.
Print Assumptions resolved_add_precondition_wit_1.

Module Proofs.
Definition proof_of_add_precondition_wit_1 : Goal.add_precondition_wit_1 := resolved_add_precondition_wit_1.
End Proofs.
