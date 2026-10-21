Require Import ExecutionGoal.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Classes.RelationClasses.
Require Import Coq.Classes.Morphisms.
Require Import Coq.micromega.Psatz.
Require Import Coq.Sorting.Permutation.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.


Definition lifted_parent (array_addr zero_addr : Z) : Prop :=
(
forall (l2: (@list Z)) (retval: Z) (PreH1 : ((INT_MIN) <= retval)) (PreH2 : (retval <= INT_MAX)) ,
  (IntArray.full array_addr 3 l2 )
  **  ((zero_addr) # Int  |-> retval)
|--
  “ (0 = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((zero_addr) # Int  |-> 0)
  **  (IntArray.full array_addr 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (l2: (@list Z)) (retval: Z) (PreH1 : ((INT_MIN) <= retval)) (PreH2 : (retval <= INT_MAX)) ,
  TT && emp 
|--
  “ (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) ” 
  &&  “ (retval = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  emp
).

Definition main_entail_wit_6_split_goal_1 := 
forall (l2: (@list Z)) (retval: Z) (PreH1 : ((INT_MIN) <= retval)) (PreH2 : (retval <= INT_MAX)) ,
  (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))))
.

Definition legal_layout (a z : Z) : Prop :=
  0 < a /\ a + 11 <= 4294967295 /\ a mod 4 = 0 /\
  0 < z /\ z + 3 <= 4294967295 /\ z mod 4 = 0 /\
  (a + 12 <= z \/ z + 4 <= a).

(* Concrete byte heaps; the integer representation is big endian. *)
Definition cm_state (m : mem) : naive_C_Rules.model :=
  {| ConAssertion.s_mem := m; ConAssertion.s_STS := Sets.full;
     ConAssertion.s_token := Sets.empty |}.
Fixpoint cm_bytes (bs : list (Z * Z)) : mem :=
  match bs with
  | nil => empty_mem
  | (p,v) :: tl => fun x => if Z.eqb x p then value v else cm_bytes tl x
  end.
Definition cm_word (p v : Z) :=
  cm_bytes ((p,0)::(p+1,0)::(p+2,0)::(p+3,v)::nil).
Definition cm_union (a b : mem) : mem :=
  fun x => match a x with Noperm => b x | v => v end.
Definition cm_tail := cm_word 4104 2.
Definition cm_lasttwo := cm_union (cm_word 4100 1) cm_tail.
Definition cm_array := cm_union (cm_word 4096 0) cm_lasttwo.
Definition cm_heap := cm_union cm_array (cm_word 8192 1).

Lemma cm_state_join : forall a b c, mem_join a b c ->
  naive_C_Rules.join (cm_state a) (cm_state b) (cm_state c).
Proof.
  intros; unfold naive_C_Rules.join, ConAssertion.state_join, cm_state;
  cbn; split; [assumption|].
  unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join;
  sets_unfold; tauto.
Qed.

(* Only finitely many address tests are split; inconsistent branches close
   immediately by linear arithmetic. *)
Ltac cm_join :=
  unfold mem_join, cm_heap, cm_array, cm_lasttwo, cm_tail, cm_union,
    cm_word, single_byte_mem, addr_eqb, empty_mem;
  intro x; cbn [cm_bytes];
  repeat match goal with
  | |- context [Z.eqb ?a ?b] =>
      let E := fresh "E" in destruct (Z.eqb a b) eqn:E;
      [apply Z.eqb_eq in E | apply Z.eqb_neq in E]; try lia
  end;
  first [left; repeat split; reflexivity |
    right; right; right; left; eexists; repeat split; reflexivity |
    right; right; right; right; eexists; repeat split; reflexivity].

Lemma cm_byte : forall p v,
  naive_C_Rules.mstore p v (cm_state (single_byte_mem p v)).
Proof.
  intros; unfold naive_C_Rules.mstore, cm_state;
  exists v; split; [apply Byte.eqm_refl|].
  repeat split; try reflexivity; sets_unfold; tauto.
Qed.

Lemma cm_word_at : forall p v,
  isvalidptr_int p /\ v <= Int.max_signed /\ v >= Int.min_signed ->
  merge_int 0 0 0 v v ->
  (p # Int |-> v) (cm_state (cm_word p v)).
Proof.
  intros p v Hv Hmerge.
  unfold store_int, naive_C_Rules.andp, naive_C_Rules.coq_prop.
  split; [exact Hv|].
  unfold store_4byte, naive_C_Rules.exp, naive_C_Rules.andp,
    naive_C_Rules.coq_prop.
  exists 0, 0, 0, v; split; [exact Hmerge|].
  unfold naive_C_Rules.sepcon.
  exists (cm_state (single_byte_mem p 0)),
    (cm_state (cm_bytes ((p+1,0)::(p+2,0)::(p+3,v)::nil))).
  split; [apply cm_state_join; cm_join|].
  split; [apply cm_byte|].
  exists (cm_state (single_byte_mem (p+1) 0)),
    (cm_state (cm_bytes ((p+2,0)::(p+3,v)::nil))).
  split; [apply cm_state_join; cm_join|].
  split; [apply cm_byte|].
  exists (cm_state (single_byte_mem (p+2) 0)),
    (cm_state (single_byte_mem (p+3) v)).
  split; [apply cm_state_join; cm_join|].
  split; apply cm_byte.
Qed.


Lemma cm_array_at : IntArray.full 4096 3 (0::1::2::nil)
  (cm_state cm_array).
Proof.
  change (((4096 # Int |-> 0) ** ((4100 # Int |-> 1) **
    ((4104 # Int |-> 2) **
      ((“ (3 = 3) ” && “ ((@nil Z) = nil) ”) && emp))))
    (cm_state cm_array)).
  unfold naive_C_Rules.sepcon.
  exists (cm_state (cm_word 4096 0)), (cm_state cm_lasttwo).
  split; [apply cm_state_join; cm_join|].
  split; [apply cm_word_at; vm_compute; intuition congruence|].
  exists (cm_state (cm_word 4100 1)), (cm_state cm_tail).
  split; [apply cm_state_join; cm_join|].
  split; [apply cm_word_at; vm_compute; intuition congruence|].
  exists (cm_state (cm_word 4104 2)), (cm_state empty_mem).
  split; [apply cm_state_join; apply mem_join_emp2|].
  split; [apply cm_word_at; vm_compute; intuition congruence|].
  split; [split; reflexivity|].
  apply ConAssertion.empty_state_is_empty.
Qed.

Lemma cm_antecedent :
  (IntArray.full 4096 3 (0::1::2::nil) ** (8192 # Int |-> 1))
    (cm_state cm_heap).
Proof.
  exists (cm_state cm_array), (cm_state (cm_word 8192 1)).
  split; [apply cm_state_join; cm_join|].
  split; [apply cm_array_at|].
  apply cm_word_at; vm_compute; intuition congruence.
Qed.

Lemma cm_incl_trans : forall a b c,
  mem_incl a b -> mem_incl b c -> mem_incl a c.
Proof.
  unfold mem_incl; intros a b c Hab Hbc p Hp.
  rewrite (Hbc p); [apply Hab; exact Hp|].
  rewrite (Hab p Hp); exact Hp.
Qed.
Lemma cm_incl_refl : forall a, mem_incl a a.
Proof. unfold mem_incl; auto. Qed.
Lemma cm_incl_left : forall a b c,
  naive_C_Rules.join a b c ->
  mem_incl (ConAssertion.s_mem a) (ConAssertion.s_mem c).
Proof.
  intros a b c H; apply mem_join_incl_l with (m2 := ConAssertion.s_mem b).
  exact (proj1 H).
Qed.
Lemma cm_incl_right : forall a b c,
  naive_C_Rules.join a b c ->
  mem_incl (ConAssertion.s_mem b) (ConAssertion.s_mem c).
Proof.
  intros a b c H; apply mem_join_incl_r with (m1 := ConAssertion.s_mem a).
  exact (proj1 H).
Qed.

Lemma cm_byte_mod : forall s m p v b,
  mem_incl (ConAssertion.s_mem s) m ->
  naive_C_Rules.mstore p v s -> m p = value b ->
  v mod 256 = b mod 256.
Proof.
  intros s m p v b Hi [w [He [Hm Hrest]]] Hr.
  assert (Hw : ConAssertion.s_mem s p = value w).
  { rewrite Hm; apply single_mem_get_eq. }
  assert (Hmw : m p = value w).
  { rewrite <- Hw; apply Hi; rewrite Hw; discriminate. }
  rewrite Hr in Hmw; inversion Hmw; subst w.
  apply Byte.eqm_samerepr in He.
  apply (f_equal Byte.unsigned) in He.
  rewrite !Byte.unsigned_repr_eq in He.
  exact He.
Qed.

Lemma cm_zero_impossible : forall s,
  mem_incl (ConAssertion.s_mem s) cm_heap ->
  (8192 # Int |-> 0) s -> False.
Proof.
  intros s Hi [_ H].
  destruct H as [v0 [v1 [v2 [v3 [HM H]]]]].
  destruct H as [s0 [t1 [J0 [B0 H]]]].
  destruct H as [s1 [t2 [J1 [B1 H]]]].
  destruct H as [s2 [s3 [J2 [B2 B3]]]].
  assert (I0 : mem_incl (ConAssertion.s_mem s0) cm_heap).
  { eapply cm_incl_trans; [eapply cm_incl_left; exact J0|exact Hi]. }
  assert (IT1 : mem_incl (ConAssertion.s_mem t1) cm_heap).
  { eapply cm_incl_trans; [eapply cm_incl_right; exact J0|exact Hi]. }
  assert (I1 : mem_incl (ConAssertion.s_mem s1) cm_heap).
  { eapply cm_incl_trans; [eapply cm_incl_left; exact J1|exact IT1]. }
  assert (IT2 : mem_incl (ConAssertion.s_mem t2) cm_heap).
  { eapply cm_incl_trans; [eapply cm_incl_right; exact J1|exact IT1]. }
  assert (I2 : mem_incl (ConAssertion.s_mem s2) cm_heap).
  { eapply cm_incl_trans; [eapply cm_incl_left; exact J2|exact IT2]. }
  assert (I3 : mem_incl (ConAssertion.s_mem s3) cm_heap).
  { eapply cm_incl_trans; [eapply cm_incl_right; exact J2|exact IT2]. }
  pose proof (cm_byte_mod s0 cm_heap 8192 v0 0 I0 B0 eq_refl) as E0.
  pose proof (cm_byte_mod s1 cm_heap 8193 v1 0 I1 B1 eq_refl) as E1.
  pose proof (cm_byte_mod s2 cm_heap 8194 v2 0 I2 B2 eq_refl) as E2.
  pose proof (cm_byte_mod s3 cm_heap 8195 v3 1 I3 B3 eq_refl) as E3.
  change (0 = v0 mod 256 * 16777216 + v1 mod 256 * 65536 +
    v2 mod 256 * 256 + v3 mod 256) in HM.
  rewrite E0, E1, E2, E3 in HM; discriminate.
Qed.
Theorem original_parent_link : ExecutionGoal.main_entail_wit_6 = lifted_parent (&("a_spec_396")) (&("zero_spec_399")).
Proof. reflexivity. Qed.
Theorem layout_ok : legal_layout 4096 8192.
Proof. unfold legal_layout; vm_compute; intuition congruence. Qed.
Theorem concrete_parent_refuted : ~ lifted_parent 4096 8192.
Proof.
  assert (Hmin : INT_MIN <= 1) by (vm_compute; intuition congruence).
  assert (Hmax : 1 <= INT_MAX) by (vm_compute; intuition congruence).
  unfold lifted_parent; intros [HS | HP].
  - pose proof (HS (0::1::2::nil) 1 Hmin Hmax
      (cm_state cm_heap) cm_antecedent) as HC.
    destruct HC as [_ HC].
    destruct HC as [sz [sa [J [HZ HA]]]].
    eapply cm_zero_impossible; [|exact HZ].
    eapply cm_incl_left; exact J.
  - assert (HE : (TT && emp) ConAssertion.empty_state).
    { split; [exact I|apply ConAssertion.empty_state_is_empty]. }
    pose proof (HP nil 1 Hmin Hmax ConAssertion.empty_state HE) as HC.
    destruct HC as [[[[HL HR] Hlo] Hhi] Hemp].
    discriminate HL.
Qed.
Theorem universal_legal_parent_refuted : ~ (forall a z, legal_layout a z -> lifted_parent a z).
Proof.
  intro H; apply concrete_parent_refuted; apply H; exact layout_ok.
Qed.
Print Assumptions original_parent_link.
Print Assumptions layout_ok.
Print Assumptions concrete_parent_refuted.
Print Assumptions universal_legal_parent_refuted.




