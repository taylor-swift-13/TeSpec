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
Require Import RootSpec.
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
Lemma proof_of_root_cell_safety_wit_1 : Goal.root_cell_safety_wit_1.
Proof. unfold Goal.root_cell_safety_wit_1.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_2 : Goal.root_cell_safety_wit_2.
Proof. unfold Goal.root_cell_safety_wit_2.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_3 : Goal.root_cell_safety_wit_3.
Proof. unfold Goal.root_cell_safety_wit_3.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_4 : Goal.root_cell_safety_wit_4.
Proof. unfold Goal.root_cell_safety_wit_4.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_5 : Goal.root_cell_safety_wit_5.
Proof. unfold Goal.root_cell_safety_wit_5.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_6 : Goal.root_cell_safety_wit_6.
Proof. unfold Goal.root_cell_safety_wit_6.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_7 : Goal.root_cell_safety_wit_7.
Proof. unfold Goal.root_cell_safety_wit_7.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_8 : Goal.root_cell_safety_wit_8.
Proof. unfold Goal.root_cell_safety_wit_8.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_9 : Goal.root_cell_safety_wit_9.
Proof. unfold Goal.root_cell_safety_wit_9.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_10 : Goal.root_cell_safety_wit_10.
Proof. unfold Goal.root_cell_safety_wit_10.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_11 : Goal.root_cell_safety_wit_11.
Proof. unfold Goal.root_cell_safety_wit_11.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_12 : Goal.root_cell_safety_wit_12.
Proof. unfold Goal.root_cell_safety_wit_12.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_13 : Goal.root_cell_safety_wit_13.
Proof. unfold Goal.root_cell_safety_wit_13.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_14 : Goal.root_cell_safety_wit_14.
Proof. unfold Goal.root_cell_safety_wit_14.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_15 : Goal.root_cell_safety_wit_15.
Proof. unfold Goal.root_cell_safety_wit_15.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_16 : Goal.root_cell_safety_wit_16.
Proof. unfold Goal.root_cell_safety_wit_16.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_17 : Goal.root_cell_safety_wit_17.
Proof. unfold Goal.root_cell_safety_wit_17.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_18 : Goal.root_cell_safety_wit_18.
Proof. unfold Goal.root_cell_safety_wit_18.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_19 : Goal.root_cell_safety_wit_19.
Proof. unfold Goal.root_cell_safety_wit_19.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_20 : Goal.root_cell_safety_wit_20.
Proof. unfold Goal.root_cell_safety_wit_20.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_21 : Goal.root_cell_safety_wit_21.
Proof. unfold Goal.root_cell_safety_wit_21.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_22 : Goal.root_cell_safety_wit_22.
Proof. unfold Goal.root_cell_safety_wit_22.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_23 : Goal.root_cell_safety_wit_23.
Proof. unfold Goal.root_cell_safety_wit_23.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_24 : Goal.root_cell_safety_wit_24.
Proof. unfold Goal.root_cell_safety_wit_24.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_25 : Goal.root_cell_safety_wit_25.
Proof. unfold Goal.root_cell_safety_wit_25.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_26 : Goal.root_cell_safety_wit_26.
Proof. unfold Goal.root_cell_safety_wit_26.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_27 : Goal.root_cell_safety_wit_27.
Proof. unfold Goal.root_cell_safety_wit_27.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_28 : Goal.root_cell_safety_wit_28.
Proof. unfold Goal.root_cell_safety_wit_28.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_29 : Goal.root_cell_safety_wit_29.
Proof. unfold Goal.root_cell_safety_wit_29.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_30 : Goal.root_cell_safety_wit_30.
Proof. unfold Goal.root_cell_safety_wit_30.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_31 : Goal.root_cell_safety_wit_31.
Proof. unfold Goal.root_cell_safety_wit_31.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_32 : Goal.root_cell_safety_wit_32.
Proof. unfold Goal.root_cell_safety_wit_32.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_33 : Goal.root_cell_safety_wit_33.
Proof. unfold Goal.root_cell_safety_wit_33.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_34 : Goal.root_cell_safety_wit_34.
Proof. unfold Goal.root_cell_safety_wit_34.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_35 : Goal.root_cell_safety_wit_35.
Proof. unfold Goal.root_cell_safety_wit_35.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_36 : Goal.root_cell_safety_wit_36.
Proof. unfold Goal.root_cell_safety_wit_36.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_37 : Goal.root_cell_safety_wit_37.
Proof. unfold Goal.root_cell_safety_wit_37.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_38 : Goal.root_cell_safety_wit_38.
Proof. unfold Goal.root_cell_safety_wit_38.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_39 : Goal.root_cell_safety_wit_39.
Proof. unfold Goal.root_cell_safety_wit_39.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_40 : Goal.root_cell_safety_wit_40.
Proof. unfold Goal.root_cell_safety_wit_40.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_41 : Goal.root_cell_safety_wit_41.
Proof. unfold Goal.root_cell_safety_wit_41.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_safety_wit_42 : Goal.root_cell_safety_wit_42.
Proof. unfold Goal.root_cell_safety_wit_42.
intros p m Hm. cbv [naive_C_Rules.andp naive_C_Rules.coq_prop]. vm_compute. repeat split; try reflexivity; discriminate.
Qed.
Lemma proof_of_root_cell_safety_wit_43 : Goal.root_cell_safety_wit_43.
Proof. unfold Goal.root_cell_safety_wit_43.
intros p Hbad. exfalso. lia.
Qed.
Lemma proof_of_root_cell_return_wit_1 : Goal.root_cell_return_wit_1.
Proof. unfold Goal.root_cell_return_wit_1.
right. intros m Hm. split.
- unfold least_root. split; [lia |]. intros k Hk. split; intro H; nia.
- exact (proj2 Hm).
Qed.
Lemma proof_of_root_cell_precondition_wit_1 : Goal.root_cell_precondition_wit_1.
Proof.
  unfold Goal.root_cell_precondition_wit_1. exists 4. intro H.
  apply (H (lift_mem (merge (single_byte_mem 4 0)
    (merge (single_byte_mem 5 0)
      (merge (single_byte_mem 6 0) (single_byte_mem 7 100)))))).
  split; [change ((100 = 100 /\ 0 <= 100) /\ 100 <= 100); lia | ].
  unfold store_int. split.
  - vm_compute. repeat split; try reflexivity; try discriminate.
  - unfold store_4byte. exists 0, 0, 0, 100. split.
    + vm_compute. reflexivity.
    + apply four_bytes_witness.
Qed.
End Proofs.
