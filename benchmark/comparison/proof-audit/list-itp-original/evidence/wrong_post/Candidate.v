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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.

Require Import Goal.
Module Proofs.
Definition lift_mem (m : mem) : naive_C_Rules.model :=
  @ConAssertion.mk_Lstate ConAssertion.naive_S m (fun _ => True) (fun _ => False).
Lemma byte_witness : forall p v, store_byte p v (lift_mem (single_byte_mem p v)).
Proof. intros. exists v. repeat split; try apply Byte.eqm_refl; try reflexivity; intros x; destruct x. Qed.
Lemma separated_merge : forall (P Q : naive_C_Rules.expr) m1 m2,
  P (lift_mem m1) -> Q (lift_mem m2) -> disjoint m1 m2 -> (P ** Q) (lift_mem (merge m1 m2)).
Proof.
  intros P Q m1 m2 HP HQ HD. exists (lift_mem m1), (lift_mem m2).
  split; [ | auto ].
  split; [apply disjoint_merge_mem_join; exact HD | ].
  cbv [ConAssertion.TokenSet_join ConAssertion.STS_state_join lift_mem ConAssertion.s_token ConAssertion.s_STS].
  repeat split; try (intros x; destruct x).
  all: tauto.
Qed.
Lemma four_bytes_witness : forall p a b c d,
  (store_byte p a ** (store_byte (p+1) b **
    (store_byte (p+2) c ** store_byte (p+3) d)))
  (lift_mem (merge (single_byte_mem p a)
    (merge (single_byte_mem (p+1) b)
      (merge (single_byte_mem (p+2) c) (single_byte_mem (p+3) d))))).
Proof.
  intros. repeat apply separated_merge; try apply byte_witness;
  unfold disjoint, merge, single_byte_mem, addr_eqb; intro x;
  repeat match goal with
  | |- context [Z.eqb ?x ?y] => destruct (Z.eqb x y) eqn:?;
      try match goal with H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H end
  end; simpl; try exact I; lia.
Qed.
Definition d1 := (merge (single_byte_mem 16 0) (merge (single_byte_mem 17 0) (merge (single_byte_mem 18 0) (single_byte_mem 19 1)))).
Lemma d1_holds : store_int 16 1 (lift_mem d1).
Proof. unfold store_int. split.
- vm_compute. repeat split; try reflexivity; discriminate.
- change (store_4byte 16 1 (lift_mem d1)). unfold store_4byte. exists 0, 0, 0, 1. split; [vm_compute; reflexivity | unfold d1; apply four_bytes_witness].
Qed.
Definition p1 := (merge (single_byte_mem 20 0) (merge (single_byte_mem 21 0) (merge (single_byte_mem 22 0) (single_byte_mem 23 48)))).
Lemma p1_holds : store_ptr 20 48 (lift_mem p1).
Proof. unfold store_ptr. split.
- vm_compute. repeat split; try reflexivity; discriminate.
- change (store_4byte 20 48 (lift_mem p1)). unfold store_4byte. exists 0, 0, 0, 48. split; [vm_compute; reflexivity | unfold p1; apply four_bytes_witness].
Qed.
Definition d2 := (merge (single_byte_mem 48 0) (merge (single_byte_mem 49 0) (merge (single_byte_mem 50 0) (single_byte_mem 51 2)))).
Lemma d2_holds : store_int 48 2 (lift_mem d2).
Proof. unfold store_int. split.
- vm_compute. repeat split; try reflexivity; discriminate.
- change (store_4byte 48 2 (lift_mem d2)). unfold store_4byte. exists 0, 0, 0, 2. split; [vm_compute; reflexivity | unfold d2; apply four_bytes_witness].
Qed.
Definition p2 := (merge (single_byte_mem 52 0) (merge (single_byte_mem 53 0) (merge (single_byte_mem 54 0) (single_byte_mem 55 0)))).
Lemma p2_holds : store_ptr 52 0 (lift_mem p2).
Proof. unfold store_ptr. split.
- vm_compute. repeat split; try reflexivity; discriminate.
- change (store_4byte 52 0 (lift_mem p2)). unfold store_4byte. exists 0, 0, 0, 0. split; [vm_compute; reflexivity | unfold p2; apply four_bytes_witness].
Qed.
Ltac concrete_disjoint :=
  unfold d1, p1, d2, p2, disjoint, merge, single_byte_mem, empty_mem, addr_eqb;
  intro x;
  repeat match goal with
  | |- context [Z.eqb ?x ?a] =>
      let E := fresh "E" in destruct (Z.eqb x a) eqn:E;
      [apply Z.eqb_eq in E; subst x; vm_compute; exact I | ]
  end; exact I.
Lemma proof_of_sample_return_wit_1 : ~ Goal.sample_return_wit_1.
Proof. unfold Goal.sample_return_wit_1. intros [H | H].
- assert ((store_ptr 20 48 ** store_ptr 52 0 ** store_int 48 2 ** store_int 16 1)
    (lift_mem (merge (merge (merge p1 p2) d2) d1))) as HH.
  { repeat apply separated_merge; try apply p1_holds; try apply p2_holds;
      try apply d2_holds; try apply d1_holds; concrete_disjoint. }
  specialize (H 16 48 0 ltac:(lia) eq_refl ltac:(lia) _ HH).
  destruct H as [Hbad _]. discriminate.
- assert ((TT && emp) (@ConAssertion.empty_state ConAssertion.naive_S)) as HH.
  { split; [exact I | apply ConAssertion.empty_state_is_empty]. }
  specialize (H 16 48 0 ltac:(lia) eq_refl ltac:(lia) _ HH).
  destruct H as [[[H1 H2] Hbad] _]. discriminate.
Qed.
End Proofs.
