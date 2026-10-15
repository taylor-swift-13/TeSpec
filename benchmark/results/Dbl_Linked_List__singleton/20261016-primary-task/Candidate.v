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
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.


Theorem primary_singleton_safety_wit_1 : PrimaryQcpGoal.singleton_safety_wit_1.
Proof. Admitted.
Theorem primary_singleton_safety_wit_2 : PrimaryQcpGoal.singleton_safety_wit_2.
Proof. Admitted.
Theorem primary_singleton_return_wit_1 : PrimaryQcpGoal.singleton_return_wit_1.
Proof. Admitted.
Theorem primary_singleton_partial_solve_wit_1 : PrimaryQcpGoal.singleton_partial_solve_wit_1.
Proof. Admitted.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_singleton_safety_wit_1 := primary_singleton_safety_wit_1.
Definition proof_of_singleton_safety_wit_2 := primary_singleton_safety_wit_2.
Definition proof_of_singleton_return_wit_1 := primary_singleton_return_wit_1.
Definition proof_of_singleton_partial_solve_wit_1 := primary_singleton_partial_solve_wit_1.
End PrimaryCertificate.
Print Assumptions primary_singleton_safety_wit_1.
Print Assumptions primary_singleton_safety_wit_2.
Print Assumptions primary_singleton_return_wit_1.
Print Assumptions primary_singleton_partial_solve_wit_1.
