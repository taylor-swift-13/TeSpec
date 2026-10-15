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


Theorem primary_swap_return_wit_1 : PrimaryQcpGoal.swap_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.swap_return_wit_1.
  intros q_pre p_pre w v.
  intros h H.
  exact H.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_swap_return_wit_1 := primary_swap_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_swap_return_wit_1.
