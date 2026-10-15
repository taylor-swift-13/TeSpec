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


Lemma constructive_sepcon_comm : forall P Q, P ** Q |-- Q ** P.
Proof.
  intros P Q h [h1 [h2 [Hjoin [HP HQ]]]].
  exists h2, h1.
  split; [| split; assumption].
  change (ConAssertion.state_join h2 h1 h).
  change (ConAssertion.state_join h1 h2 h) in Hjoin.
  unfold ConAssertion.state_join in *.
  destruct Hjoin as [Hmem [Htoken Hsts]].
  split.
  - exact (mem_join_comm Hmem).
  - split.
    + unfold ConAssertion.TokenSet_join in *.
      sets_unfold in *.
      firstorder.
    + unfold ConAssertion.STS_state_join in *.
      sets_unfold in *.
      firstorder.
Qed.

Theorem primary_abs_mem_safety_wit_1 : PrimaryQcpGoal.abs_mem_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.abs_mem_safety_wit_1.
  intros p v Hv.
  intros h Hheap.
  split.
  - change (0 <= 2147483647).
    lia.
  - change (-2147483648 <= 0).
    lia.
Qed.
Theorem primary_abs_mem_safety_wit_2 : PrimaryQcpGoal.abs_mem_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.abs_mem_safety_wit_2.
  intros p v Hneg Hv.
  intros h Hheap.
  change (v <> INT_MIN).
  lia.
Qed.
Theorem primary_abs_mem_return_wit_1 : PrimaryQcpGoal.abs_mem_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.abs_mem_return_wit_1.
  intros p v Hneg Hv.
  intros h Hheap.
  repeat first [assumption | reflexivity | split].
Qed.
Theorem primary_abs_mem_return_wit_2 : PrimaryQcpGoal.abs_mem_return_wit_2.
Proof.
  unfold PrimaryQcpGoal.abs_mem_return_wit_2.
  intros p v Hnonneg Hv.
  intros h Hheap.
  repeat first [assumption | reflexivity | split].
Qed.
Theorem primary_abs_y_return_wit_1 : PrimaryQcpGoal.abs_y_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.abs_y_return_wit_1.
  intros p y x retval Hneg Hret Hy.
  intros h Hheap.
  pose proof (constructive_sepcon_comm
    ((&((p) # "tuple" ->ₛ "y")) # Int |-> y)
    ((&((p) # "tuple" ->ₛ "x")) # Int |-> x)
    h Hheap) as Hswap.
  repeat first [assumption | split].
Qed.
Theorem primary_abs_y_return_wit_2 : PrimaryQcpGoal.abs_y_return_wit_2.
Proof.
  unfold PrimaryQcpGoal.abs_y_return_wit_2.
  intros p y x retval Hnonneg Hret Hy.
  intros h Hheap.
  pose proof (constructive_sepcon_comm
    ((&((p) # "tuple" ->ₛ "y")) # Int |-> y)
    ((&((p) # "tuple" ->ₛ "x")) # Int |-> x)
    h Hheap) as Hswap.
  repeat first [assumption | split].
Qed.
Theorem primary_abs_y_partial_solve_wit_1_pure : PrimaryQcpGoal.abs_y_partial_solve_wit_1_pure.
Proof.
  unfold PrimaryQcpGoal.abs_y_partial_solve_wit_1_pure.
  intros p y x Hy.
  intros h Hheap.
  exact Hy.
Qed.
Theorem primary_abs_y_partial_solve_wit_1 : PrimaryQcpGoal.abs_y_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.abs_y_partial_solve_wit_1.
  intros Hpure.
  unfold PrimaryQcpGoal.abs_y_partial_solve_wit_1_aux.
  intros p y x Hy.
  intros h Hheap.
  pose proof (constructive_sepcon_comm
    ((&((p) # "tuple" ->ₛ "x")) # Int |-> x)
    ((&((p) # "tuple" ->ₛ "y")) # Int |-> y)
    h Hheap) as Hswap.
  repeat first [assumption | split].
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_abs_mem_safety_wit_1 := primary_abs_mem_safety_wit_1.
Definition proof_of_abs_mem_safety_wit_2 := primary_abs_mem_safety_wit_2.
Definition proof_of_abs_mem_return_wit_1 := primary_abs_mem_return_wit_1.
Definition proof_of_abs_mem_return_wit_2 := primary_abs_mem_return_wit_2.
Definition proof_of_abs_y_return_wit_1 := primary_abs_y_return_wit_1.
Definition proof_of_abs_y_return_wit_2 := primary_abs_y_return_wit_2.
Definition proof_of_abs_y_partial_solve_wit_1_pure := primary_abs_y_partial_solve_wit_1_pure.
Definition proof_of_abs_y_partial_solve_wit_1 := primary_abs_y_partial_solve_wit_1.
End PrimaryCertificate.
Print Assumptions primary_abs_mem_safety_wit_1.
Print Assumptions primary_abs_mem_safety_wit_2.
Print Assumptions primary_abs_mem_return_wit_1.
Print Assumptions primary_abs_mem_return_wit_2.
Print Assumptions primary_abs_y_return_wit_1.
Print Assumptions primary_abs_y_return_wit_2.
Print Assumptions primary_abs_y_partial_solve_wit_1_pure.
Print Assumptions primary_abs_y_partial_solve_wit_1.
