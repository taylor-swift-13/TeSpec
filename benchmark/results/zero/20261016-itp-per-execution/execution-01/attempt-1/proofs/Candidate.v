Require Import ConcreteCell ExecutionGoal.
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



Lemma noninit_byte_at : forall p,
  naive_C_Rules.mstore_noninit p (st (single_Noninit_mem p)).
Proof.
  intros p; unfold naive_C_Rules.mstore_noninit, st; cbn.
  split; [sets_unfold; tauto|].
  split; [sets_unfold; tauto|].
  left; reflexivity.
Qed.

Ltac noninit_join :=
  apply st_join;
  unfold mem_join, single_Noninit_mem, uninit_mem, addr_eqb;
  intro x;
  repeat match goal with
  | |- context [Z.eqb ?a ?b] =>
      let E := fresh in destruct (Z.eqb a b) eqn:E;
      [apply Z.eqb_eq in E | apply Z.eqb_neq in E]
  | |- context [Z.leb ?a ?b] =>
      let E := fresh in destruct (Z.leb a b) eqn:E;
      [apply Z.leb_le in E | apply Z.leb_gt in E]
  | |- context [Z.ltb ?a ?b] =>
      let E := fresh in destruct (Z.ltb a b) eqn:E;
      [apply Z.ltb_lt in E | apply Z.ltb_ge in E]
  end;
  try lia; intuition congruence.

Theorem entry_cell : (4100 # Int |->_) (st uninit_mem).
Proof.
  split.
  - vm_compute; repeat split; congruence.
  - exists (st (single_Noninit_mem 4100)),
      (st (fun x => if Z.eqb x 4101 then Noninit else
                    if Z.eqb x 4102 then Noninit else
                    single_Noninit_mem 4103 x)).
    split; [noninit_join|].
    split; [apply noninit_byte_at|].
    exists (st (single_Noninit_mem 4101)),
      (st (fun x => if Z.eqb x 4102 then Noninit else
                    single_Noninit_mem 4103 x)).
    split; [noninit_join|].
    split; [apply noninit_byte_at|].
    exists (st (single_Noninit_mem 4102)),
      (st (single_Noninit_mem 4103)).
    split; [noninit_join|].
    split; apply noninit_byte_at.
Qed.
Theorem exit_cell : ~ (4100 # Int |-> 0) (st uninit_mem).
Proof.
  intros [_ H].
  destruct H as [z1 [z2 [z3 [z4 [_ H]]]]].
  destruct H as [s1 [s2 [HJ [HB HT]]]].
  destruct HB as [v [HE [HM HS]]].
  unfold naive_C_Rules.join, ConAssertion.state_join in HJ.
  destruct HJ as [HJ _].
  specialize (HJ 4100).
  rewrite HM in HJ.
  cbn [st uninit_mem single_byte_mem addr_eqb] in HJ.
  destruct HJ as [[H _] | [[H _] | [[H _] | [H | H]]]];
    try discriminate.
  - destruct H as [n [H _]]; discriminate.
  - destruct H as [n [_ [_ H]]]; discriminate.
Qed.
Theorem refute_zero_return_wit_1_split_goal_spatial : ~ ExecutionGoal.zero_return_wit_1_split_goal_spatial.
Proof.
  intro H; apply exit_cell.
  exact (H 4100 eq_refl (st uninit_mem) entry_cell).
Qed.
Theorem refute_zero_return_wit_1 : ~ ExecutionGoal.zero_return_wit_1.
Proof.
  intros [H | H]; apply exit_cell;
    exact (H 4100 eq_refl (st uninit_mem) entry_cell).
Qed.
Theorem entry_sat : ExecutionGoal.zero_precondition_wit_1.
Proof.
  exists 4100; intro H.
  exact (H (st uninit_mem) (conj eq_refl entry_cell)).
Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_zero_return_wit_1_split_goal_spatial.
Print Assumptions refute_zero_return_wit_1.
Print Assumptions entry_sat.
