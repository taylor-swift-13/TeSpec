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


Theorem primary_add_safety_wit_1 : PrimaryQcpGoal.add_safety_wit_1.
Proof. Admitted.
Theorem primary_add_safety_wit_2 : PrimaryQcpGoal.add_safety_wit_2.
Proof. Admitted.
Theorem primary_add_safety_wit_3 : PrimaryQcpGoal.add_safety_wit_3.
Proof. Admitted.
Theorem primary_add_safety_wit_4 : PrimaryQcpGoal.add_safety_wit_4.
Proof. Admitted.
Theorem primary_add_safety_wit_5 : PrimaryQcpGoal.add_safety_wit_5.
Proof. Admitted.
Theorem primary_add_safety_wit_6 : PrimaryQcpGoal.add_safety_wit_6.
Proof. Admitted.
Theorem primary_add_safety_wit_7 : PrimaryQcpGoal.add_safety_wit_7.
Proof. Admitted.
Theorem primary_add_safety_wit_8 : PrimaryQcpGoal.add_safety_wit_8.
Proof. Admitted.
Theorem primary_add_safety_wit_9 : PrimaryQcpGoal.add_safety_wit_9.
Proof. Admitted.
Theorem primary_add_safety_wit_10 : PrimaryQcpGoal.add_safety_wit_10.
Proof. Admitted.
Theorem primary_add_safety_wit_11 : PrimaryQcpGoal.add_safety_wit_11.
Proof. Admitted.
Theorem primary_add_return_wit_1 : PrimaryQcpGoal.add_return_wit_1.
Proof. Admitted.
Theorem primary_add_return_wit_2 : PrimaryQcpGoal.add_return_wit_2.
Proof. Admitted.
Theorem primary_add_return_wit_3 : PrimaryQcpGoal.add_return_wit_3.
Proof. Admitted.
Theorem primary_add_partial_solve_wit_1 : PrimaryQcpGoal.add_partial_solve_wit_1.
Proof. Admitted.
Theorem primary_add_partial_solve_wit_2 : PrimaryQcpGoal.add_partial_solve_wit_2.
Proof. Admitted.
Theorem primary_add_partial_solve_wit_3 : PrimaryQcpGoal.add_partial_solve_wit_3.
Proof. Admitted.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_add_safety_wit_1 := primary_add_safety_wit_1.
Definition proof_of_add_safety_wit_2 := primary_add_safety_wit_2.
Definition proof_of_add_safety_wit_3 := primary_add_safety_wit_3.
Definition proof_of_add_safety_wit_4 := primary_add_safety_wit_4.
Definition proof_of_add_safety_wit_5 := primary_add_safety_wit_5.
Definition proof_of_add_safety_wit_6 := primary_add_safety_wit_6.
Definition proof_of_add_safety_wit_7 := primary_add_safety_wit_7.
Definition proof_of_add_safety_wit_8 := primary_add_safety_wit_8.
Definition proof_of_add_safety_wit_9 := primary_add_safety_wit_9.
Definition proof_of_add_safety_wit_10 := primary_add_safety_wit_10.
Definition proof_of_add_safety_wit_11 := primary_add_safety_wit_11.
Definition proof_of_add_return_wit_1 := primary_add_return_wit_1.
Definition proof_of_add_return_wit_2 := primary_add_return_wit_2.
Definition proof_of_add_return_wit_3 := primary_add_return_wit_3.
Definition proof_of_add_partial_solve_wit_1 := primary_add_partial_solve_wit_1.
Definition proof_of_add_partial_solve_wit_2 := primary_add_partial_solve_wit_2.
Definition proof_of_add_partial_solve_wit_3 := primary_add_partial_solve_wit_3.
End PrimaryCertificate.
Print Assumptions primary_add_safety_wit_1.
Print Assumptions primary_add_safety_wit_2.
Print Assumptions primary_add_safety_wit_3.
Print Assumptions primary_add_safety_wit_4.
Print Assumptions primary_add_safety_wit_5.
Print Assumptions primary_add_safety_wit_6.
Print Assumptions primary_add_safety_wit_7.
Print Assumptions primary_add_safety_wit_8.
Print Assumptions primary_add_safety_wit_9.
Print Assumptions primary_add_safety_wit_10.
Print Assumptions primary_add_safety_wit_11.
Print Assumptions primary_add_return_wit_1.
Print Assumptions primary_add_return_wit_2.
Print Assumptions primary_add_return_wit_3.
Print Assumptions primary_add_partial_solve_wit_1.
Print Assumptions primary_add_partial_solve_wit_2.
Print Assumptions primary_add_partial_solve_wit_3.
