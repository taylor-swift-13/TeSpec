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


Theorem primary_add_safety_wit_1 : PrimaryQcpGoal.add_safety_wit_1.
Proof.
  intros y_pre x_pre PreH1 PreH2 h H.
  split; assumption.
Qed.
Theorem primary_add_return_wit_1 : PrimaryQcpGoal.add_return_wit_1.
Proof.
  intros y_pre x_pre PreH1 PreH2 h H.
  split.
  - reflexivity.
  - exact (proj2 H).
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_add_safety_wit_1 := primary_add_safety_wit_1.
Definition proof_of_add_return_wit_1 := primary_add_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_add_safety_wit_1.
Print Assumptions primary_add_return_wit_1.
