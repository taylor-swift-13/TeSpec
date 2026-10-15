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


Theorem primary_quadruple_mem_safety_wit_1 : PrimaryQcpGoal.quadruple_mem_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.quadruple_mem_safety_wit_1.
  intros p_pre v PreH1 PreH2 h Hheap.
  split.
  - change (v + v <= 2147483647). lia.
  - change (-2147483648 <= v + v). lia.
Qed.
Theorem primary_quadruple_mem_safety_wit_2 : PrimaryQcpGoal.quadruple_mem_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.quadruple_mem_safety_wit_2.
  intros p_pre v PreH1 PreH2 h Hheap.
  split.
  - change ((v + v) + (v + v) <= 2147483647). lia.
  - change (-2147483648 <= (v + v) + (v + v)). lia.
Qed.
Theorem primary_quadruple_mem_return_wit_1 : PrimaryQcpGoal.quadruple_mem_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.quadruple_mem_return_wit_1.
  intros p_pre v PreH1 PreH2 h Hheap.
  split.
  - change ((v + v) + (v + v) = 4 * v). ring.
  - exact Hheap.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_quadruple_mem_safety_wit_1 := primary_quadruple_mem_safety_wit_1.
Definition proof_of_quadruple_mem_safety_wit_2 := primary_quadruple_mem_safety_wit_2.
Definition proof_of_quadruple_mem_return_wit_1 := primary_quadruple_mem_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_quadruple_mem_safety_wit_1.
Print Assumptions primary_quadruple_mem_safety_wit_2.
Print Assumptions primary_quadruple_mem_return_wit_1.
