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


Require Import Goal.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Coq.ZArith.ZArith Coq.micromega.Psatz.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.
Lemma proof_of_bump_safety_wit_1 : Goal.bump_safety_wit_1.
Proof. unfold Goal.bump_safety_wit_1. intros. entailer!. Qed.
Lemma proof_of_bump_safety_wit_2 : Goal.bump_safety_wit_2.
Proof. unfold Goal.bump_safety_wit_2. intros. entailer!. Qed.
Lemma proof_of_bump_return_wit_1 : Goal.bump_return_wit_1.
Proof. unfold Goal.bump_return_wit_1. intros. entailer!. Qed.
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
Lemma proof_of_bump_precondition_wit_1 : Goal.bump_precondition_wit_1.
Proof.
  unfold Goal.bump_precondition_wit_1. exists 4. intro H.
  apply (H (lift_mem (merge (single_byte_mem 4 0)
    (merge (single_byte_mem 5 0)
      (merge (single_byte_mem 6 0) (single_byte_mem 7 3)))))).
  split; [change ((3 = 3 /\ 0 <= 3) /\ 3 < 100); lia | ].
  unfold store_int. split.
  - vm_compute. repeat split; try reflexivity; try discriminate.
  - unfold store_4byte. exists 0, 0, 0, 3. split.
    + vm_compute. reflexivity.
    + apply four_bytes_witness.
Qed.
End Proofs.

Print Assumptions Proofs.proof_of_bump_safety_wit_1.
Print Assumptions Proofs.proof_of_bump_safety_wit_2.
Print Assumptions Proofs.proof_of_bump_return_wit_1.
Print Assumptions Proofs.proof_of_bump_precondition_wit_1.
