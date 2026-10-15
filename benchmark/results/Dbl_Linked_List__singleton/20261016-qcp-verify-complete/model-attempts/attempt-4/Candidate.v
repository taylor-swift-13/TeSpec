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
Proof.
  unfold PrimaryQcpGoal.singleton_safety_wit_1.
  intros element_pre e retval PreH1 PreH2 h Hheap.
  split.
  - change (0 <= 2147483647)%Z. lia.
  - change (-2147483648 <= 0)%Z. lia.
Qed.
Theorem primary_singleton_safety_wit_2 : PrimaryQcpGoal.singleton_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.singleton_safety_wit_2.
  intros element_pre e retval PreH1 PreH2 h Hheap.
  split.
  - change (0 <= 2147483647)%Z. lia.
  - change (-2147483648 <= 0)%Z. lia.
Qed.
Theorem primary_singleton_return_wit_1 : PrimaryQcpGoal.singleton_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.singleton_return_wit_1.
  intros element_pre e retval PreH1 PreH2.
  subst element_pre.
  unfold Dll.
  intros h Hheap.
  right.
  split; [exact PreH1 |].
  exists 0, 0.
  cbn [DLLLeft DLLRight].
  assert (Happend : forall P : Assertion,
      P |-- P ** (“ 0 = 0 ” && emp)).
  {
    intros P hp HP.
    assert (HU : (P ** emp) hp).
    {
      apply (derivable1_sepcon_emp_r P).
      exact HP.
    }
    destruct HU as (h1 & h2 & Hjoin & HP1 & Hemp).
    exists h1, h2.
    split; [exact Hjoin |].
    split; [exact HP1 |].
    split; [reflexivity | exact Hemp].
  }
  apply Happend.
  apply Happend.
  exact Hheap.
Qed.
Theorem primary_singleton_partial_solve_wit_1 : PrimaryQcpGoal.singleton_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.singleton_partial_solve_wit_1.
  intros element_pre e PreH1 h [_ Hemp].
  split.
  - change (element_pre = e). exact PreH1.
  - exact Hemp.
Qed.
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


