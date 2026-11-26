Module FiniteEntryHeap.
From SimpleC.Verification Require Import VCPrelude.
Require Import DLLSupplement.
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
Require Import Goal DLLSupplement.
Import FiniteEntryHeap.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

(* Big-endian words, grouped in the same order as the spatial assertions.
   The outside links are null; the two inside links point back to 4096. *)
Definition interior_left_bytes : list (Z * Z) :=
  ((entry_word 8192 0 0 0 2 ++ entry_word 8196 0 0 0 0) ++
    entry_word 8200 0 0 16 0) ++ [].

Definition interior_right_bytes : list (Z * Z) :=
  ((entry_word 12288 0 0 0 3 ++ entry_word 12296 0 0 0 0) ++
    entry_word 12292 0 0 16 0) ++ [].

Definition interior_entry_bytes : list (Z * Z) :=
  (((entry_word 4096 0 0 0 7 ++ entry_word 4100 0 0 32 0) ++
     entry_word 4104 0 0 48 0) ++ interior_left_bytes) ++
    interior_right_bytes.

(* Only closed address/range checks and the supplied word constructor. *)
Ltac interior_int_store :=
  unfold naive_C_Rules.store_int;
  split;
  [ cbv; intuition discriminate
  | apply entry_word_store; reflexivity ].

Ltac interior_ptr_store :=
  unfold naive_C_Rules.store_ptr;
  split;
  [ cbv; intuition discriminate
  | apply entry_word_store; reflexivity ].

Lemma interior_left_heap :
  DLLLeft 8192 4096 [2]
    (entry_state (entry_mem interior_left_bytes)).
Proof.
  change (8192 <> 0 /\ exists q : Z,
    ((8192 + 0) # Int |-> 2 **
     (8192 + 4) # Ptr |-> q **
     (8192 + 8) # Ptr |-> 4096 ** DLLLeft q 8192 [])
      (entry_state (entry_mem interior_left_bytes))).
  split; [lia |].
  exists 0.
  unfold interior_left_bytes.
  eapply entry_mem_sep with
    (l := (entry_word 8192 0 0 0 2 ++ entry_word 8196 0 0 0 0) ++
          entry_word 8200 0 0 16 0) (r := []).
  - cbn; intuition lia.
  - eapply entry_mem_sep with
      (l := entry_word 8192 0 0 0 2 ++ entry_word 8196 0 0 0 0)
      (r := entry_word 8200 0 0 16 0).
    + cbn; intuition lia.
    + eapply entry_mem_sep with
        (l := entry_word 8192 0 0 0 2)
        (r := entry_word 8196 0 0 0 0).
      * cbn; intuition lia.
      * interior_int_store.
      * interior_ptr_store.
    + interior_ptr_store.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Lemma interior_right_heap :
  DLLRight 12288 4096 [3]
    (entry_state (entry_mem interior_right_bytes)).
Proof.
  change (12288 <> 0 /\ exists q : Z,
    ((12288 + 0) # Int |-> 3 **
     (12288 + 8) # Ptr |-> q **
     (12288 + 4) # Ptr |-> 4096 ** DLLRight q 12288 [])
      (entry_state (entry_mem interior_right_bytes))).
  split; [lia |].
  exists 0.
  unfold interior_right_bytes.
  eapply entry_mem_sep with
    (l := (entry_word 12288 0 0 0 3 ++ entry_word 12296 0 0 0 0) ++
          entry_word 12292 0 0 16 0) (r := []).
  - cbn; intuition lia.
  - eapply entry_mem_sep with
      (l := entry_word 12288 0 0 0 3 ++ entry_word 12296 0 0 0 0)
      (r := entry_word 12292 0 0 16 0).
    + cbn; intuition lia.
    + eapply entry_mem_sep with
        (l := entry_word 12288 0 0 0 3)
        (r := entry_word 12296 0 0 0 0).
      * cbn; intuition lia.
      * interior_int_store.
      * interior_ptr_store.
    + interior_ptr_store.
  - change (0 = 0 /\ emp (entry_state empty_mem)).
    split; [reflexivity | apply entry_state_emp].
Qed.

Lemma interior_entry_heap :
  ((4096 + 0) # Int |-> 7 **
   (4096 + 4) # Ptr |-> 8192 **
   (4096 + 8) # Ptr |-> 12288 **
   DLLLeft 8192 4096 [2] ** DLLRight 12288 4096 [3])
    (entry_state (entry_mem interior_entry_bytes)).
Proof.
  unfold interior_entry_bytes.
  eapply entry_mem_sep with
    (l := ((entry_word 4096 0 0 0 7 ++ entry_word 4100 0 0 32 0) ++
            entry_word 4104 0 0 48 0) ++ interior_left_bytes)
    (r := interior_right_bytes).
  - cbn; intuition lia.
  - eapply entry_mem_sep with
      (l := (entry_word 4096 0 0 0 7 ++ entry_word 4100 0 0 32 0) ++
            entry_word 4104 0 0 48 0)
      (r := interior_left_bytes).
    + cbn; intuition lia.
    + eapply entry_mem_sep with
        (l := entry_word 4096 0 0 0 7 ++ entry_word 4100 0 0 32 0)
        (r := entry_word 4104 0 0 48 0).
      * cbn; intuition lia.
      * eapply entry_mem_sep with
          (l := entry_word 4096 0 0 0 7)
          (r := entry_word 4100 0 0 32 0).
        -- cbn; intuition lia.
        -- interior_int_store.
        -- interior_ptr_store.
      * interior_ptr_store.
    + exact interior_left_heap.
  - exact interior_right_heap.
Qed.

Theorem resolved_remove_precondition_wit_1 : Goal.remove_precondition_wit_1.
Proof.
  unfold Goal.remove_precondition_wit_1.
  exists [3], [2], 12288, 8192, 7, 4096.
  intro Hfalse.
  apply (Hfalse (entry_state (entry_mem interior_entry_bytes))).
  repeat first [exact interior_entry_heap | reflexivity | split | lia].
  unfold naive_C_Rules.coq_prop; lia.
Qed.


From SimpleC.Verification Require Import VCPrelude.
Require Import DLLSupplement GeneratedLayout Goal.
Import naive_C_Rules.
Import ConAssertion SetsNotation ListNotations.
Local Open Scope sets.
Local Open Scope sac.
Local Open Scope Z_scope.
Local Open Scope list_scope.
  Lemma reassociate_join : (forall mx my mz mxy mxyz : naive_C_Rules.model, join mx my mxy -> join mxy mz mxyz -> exists myz : model, join my mz myz /\ join mx myz mxyz).
  Proof.
    intros.
    unfold naive_C_Rules.join , state_join, TokenSet_join, STS_state_join in *.
    destruct H as [? [[? ?] ?]].
    destruct H0 as [? [[? ?] ?]].
    destruct (mem_join_assoc2 H H0) as [yz [Myz Mxyz]].
    exists (mk_Lstate yz (s_STS my ∩ s_STS mz) (s_token my ∪ s_token mz)).
    simpl. 
    split ; (split ; [ | split ]).
    - exact Myz.
    - split ; try reflexivity.
      revert H1 H2 H4 H5.
      sets_unfold ; intros.
      split ; try tauto.
    - reflexivity.
    - exact Mxyz.
    - split.
      + rewrite H4. rewrite H1.
        rewrite Sets_union_assoc. reflexivity.
      + rewrite Sets_intersect_union_distr_l.
        rewrite H2. rewrite Sets_empty_union.
        revert H1 H2 H4 H5.
        sets_unfold ; intros.
        split ; try tauto.
    - rewrite H6. rewrite H3.
      rewrite Sets_intersect_assoc. reflexivity.
  Qed.
Lemma ret_id (P:expr) : P |-- P. Proof. intros s x; exact x. Qed.
Lemma ret_trans (A B C:expr) : (A |-- B) -> (B |-- C) -> (A |-- C).
Proof. intros a b m h; apply b, a, h. Qed.
Lemma ret_map (A B C D:expr) : (A |-- C) -> (B |-- D) -> (A**B |-- C**D).
Proof. intros f g m (a&b&j&ha&hb). exists a,b. split; [assumption|split; [apply f|apply g]; assumption]. Qed.
Lemma ret_swap (A B:expr) : A**B |-- B**A.
Proof. intros m (a&b&j&ha&hb). exists b,a; split; [apply naive_C_Rules.join_comm; assumption | tauto]. Qed.
Lemma ret_assoc (A B C:expr) : (A**B)**C |-- A**(B**C).
Proof. intros m (ab&c&j&[a [b [k [ha hb]]]]&hc).
 destruct (reassociate_join a b c ab m k j) as [bc [l r]].
 exists a,bc; split; [exact r|split; [exact ha|exists b,c;tauto]]. Qed.
Lemma ret_unassoc (A B C:expr) : A**(B**C) |-- (A**B)**C.
Proof. intros m (a&bc&j&ha&[b [c [k [hb hc]]]]).
 destruct (reassociate_join c b a bc m (naive_C_Rules.join_comm _ _ _ k) (naive_C_Rules.join_comm _ _ _ j)) as [ba [l r]].
 exists ba,c; split; [apply naive_C_Rules.join_comm; exact r|split; [exists a,b; split; [apply naive_C_Rules.join_comm; exact l|tauto]|exact hc]]. Qed.
Lemma ret_bubble (A B C:expr) : A**(B**C) |-- B**(A**C).
Proof. eapply ret_trans; [apply ret_unassoc|]. eapply ret_trans; [apply ret_map; [apply ret_swap|apply ret_id]|apply ret_assoc]. Qed.
Lemma ret_add_emp (A E:expr) (emptyE:forall m, emp m -> E m) : A |-- A ** E.
Proof. intros m h. destruct (naive_C_Rules.unit_join m) as [u [e j]]. exists m,u; split; [exact j|split; [exact h|apply emptyE, e]]. Qed.
Lemma ret_fold (n p q v:Z) ll lr (N:n <> 0) :
 (((n+0) # Int |-> v) ** ((n+4) # Ptr |-> p) ** ((n+8) # Ptr |-> q) ** DLLLeft p n ll ** DLLRight q n lr) |-- Dll n ll v lr.
Proof. intros m h; right; split; [exact N|exists p,q; exact h]. Qed.
Lemma ret_fold_left (n curr prev v:Z) tl (N:n <> 0) :
 (((n+0) # Int |-> v) ** ((n+4) # Ptr |-> prev) ** ((n+8) # Ptr |-> curr) ** DLLLeft prev n tl) |-- DLLLeft n curr (v::tl).
Proof. intros m h; split; [exact N|exists prev; exact h]. Qed.
Ltac ret_lift lemma :=
 first [exact lemma | apply ret_map; [ret_lift lemma|apply ret_id] | apply ret_map; [apply ret_id|ret_lift lemma]].
Ltac ret_pull a :=
 lazymatch goal with
 | |- (a ** _) |-- _ => apply ret_id
 | |- (_ ** a) |-- _ => apply ret_swap
 | |- (?x ** ?y) |-- _ => eapply ret_trans; [apply ret_map; [apply ret_id|ret_pull a]|apply ret_bubble]
 end.
Ltac ret_arrange :=
 lazymatch goal with
 | |- ?a |-- ?a => apply ret_id
 | |- ((?a ** ?b) ** ?c) |-- _ => eapply ret_trans; [apply ret_assoc|ret_arrange]
 | |- _ |-- ((?a ** ?b) ** ?c) => eapply ret_trans; [|apply ret_unassoc];ret_arrange
 | |- _ |-- (?a ** ?b) => eapply ret_trans; [ret_pull a | apply ret_map; [apply ret_id|ret_arrange]]
 end.

Module Proofs.

Definition proof_of_remove_precondition_wit_1 : Goal.remove_precondition_wit_1 := resolved_remove_precondition_wit_1.

Lemma proof_of_remove_return_wit_1 : Goal.remove_return_wit_1.
Proof.
 unfold Goal.remove_return_wit_1. intros; subst.
 repeat match goal with H : cons _ _ = cons _ _ |- _ => inversion H; clear H; subst end.
 intros m h. left; right; exists 3,12288; split; [repeat split; unfold naive_C_Rules.coq_prop; lia|].
 revert m h; cbn [dll_tail].
 eapply ret_trans; [|ret_lift (ret_fold 12288 8192 q_2 3 [2] [] ltac:(lia))].
 eapply ret_trans; [| ret_lift (ret_fold_left 8192 12288 q 2 [] ltac:(lia))].
 
 ret_arrange.
Qed.
End Proofs.
