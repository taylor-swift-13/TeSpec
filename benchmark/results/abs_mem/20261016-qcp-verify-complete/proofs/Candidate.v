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


Theorem primary_abs_mem_safety_wit_1 : PrimaryQcpGoal.abs_mem_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.abs_mem_safety_wit_1.
  intros p_pre v PreH1 h Hh.
  change (0 <= 2147483647 /\ -2147483648 <= 0).
  lia.
Qed.
Theorem primary_abs_mem_safety_wit_2 : PrimaryQcpGoal.abs_mem_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.abs_mem_safety_wit_2.
  intros p_pre v PreH1 PreH2 h Hh.
  change (v <> INT_MIN).
  lia.
Qed.
Theorem primary_abs_mem_return_wit_1 : PrimaryQcpGoal.abs_mem_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.abs_mem_return_wit_1.
  intros p_pre v PreH1 PreH2 h Hh.
  repeat first [assumption | reflexivity | split].
Qed.
Theorem primary_abs_mem_return_wit_2 : PrimaryQcpGoal.abs_mem_return_wit_2.
Proof.
  unfold PrimaryQcpGoal.abs_mem_return_wit_2.
  intros p_pre v PreH1 PreH2 h Hh.
  repeat first [assumption | reflexivity | split].
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_abs_mem_safety_wit_1 := primary_abs_mem_safety_wit_1.
Definition proof_of_abs_mem_safety_wit_2 := primary_abs_mem_safety_wit_2.
Definition proof_of_abs_mem_return_wit_1 := primary_abs_mem_return_wit_1.
Definition proof_of_abs_mem_return_wit_2 := primary_abs_mem_return_wit_2.
End PrimaryCertificate.
Print Assumptions primary_abs_mem_safety_wit_1.
Print Assumptions primary_abs_mem_safety_wit_2.
Print Assumptions primary_abs_mem_return_wit_1.
Print Assumptions primary_abs_mem_return_wit_2.
