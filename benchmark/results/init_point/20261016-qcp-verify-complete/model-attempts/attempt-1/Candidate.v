Require Import PrimaryQcpGoal.
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


Theorem primary_zero_safety_wit_1 : PrimaryQcpGoal.zero_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.zero_safety_wit_1.
  intros p_pre h H.
  change (0 <= 2147483647 /\ -2147483648 <= 0).
  lia.
Qed.
Theorem primary_zero_return_wit_1 : PrimaryQcpGoal.zero_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.zero_return_wit_1.
  intros p_pre h H. exact H.
Qed.
Theorem primary_init_point_return_wit_1 : PrimaryQcpGoal.init_point_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.init_point_return_wit_1.
  intros p_pre h H.
  hnf in H |- *.
  firstorder congruence.
Qed.
Theorem primary_init_point_partial_solve_wit_1 : PrimaryQcpGoal.init_point_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.init_point_partial_solve_wit_1.
  intros p_pre h H. exact H.
Qed.
Theorem primary_init_point_partial_solve_wit_2 : PrimaryQcpGoal.init_point_partial_solve_wit_2.
Proof.
  unfold PrimaryQcpGoal.init_point_partial_solve_wit_2.
  intros p_pre h H.
  hnf in H |- *.
  firstorder congruence.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_zero_safety_wit_1 := primary_zero_safety_wit_1.
Definition proof_of_zero_return_wit_1 := primary_zero_return_wit_1.
Definition proof_of_init_point_return_wit_1 := primary_init_point_return_wit_1.
Definition proof_of_init_point_partial_solve_wit_1 := primary_init_point_partial_solve_wit_1.
Definition proof_of_init_point_partial_solve_wit_2 := primary_init_point_partial_solve_wit_2.
End PrimaryCertificate.
Print Assumptions primary_zero_safety_wit_1.
Print Assumptions primary_zero_return_wit_1.
Print Assumptions primary_init_point_return_wit_1.
Print Assumptions primary_init_point_partial_solve_wit_1.
Print Assumptions primary_init_point_partial_solve_wit_2.
