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


Theorem primary_incr_safety_wit_1 : PrimaryQcpGoal.incr_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.incr_safety_wit_1.
  intros p v Hv Hmax h Hheap.
  split.
  - change (1 <= 2147483647). lia.
  - change (-2147483648 <= 1). lia.
Qed.
Theorem primary_incr_return_wit_1 : PrimaryQcpGoal.incr_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.incr_return_wit_1.
  left. intros p v Hv Hmax.
  assert (Heq : unsigned_last_nbits (v + 1) 32 = Z.rem (v + 1) 4294967296).
  { unfold unsigned_last_nbits.
    change (Z.modulo (v + 1) 4294967296 = Z.rem (v + 1) 4294967296).
    symmetry. apply Z.rem_mod_nonneg; lia. }
  rewrite Heq. intros h Hheap. exact Hheap.
Qed.
Theorem primary_incr_two_return_wit_1 : PrimaryQcpGoal.incr_two_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.incr_two_return_wit_1.
  intros q p w v Hv Hvmax Hw Hwmax h Hheap.
  destruct Hheap as (h1 & h2 & Hj & Hq & Hp).
  exists h2, h1. split.
  - destruct Hj as (Hm & Ht & Hs).
    split.
    + apply Mem.mem_join_comm. exact Hm.
    + split.
      * destruct Ht as [Hu Hd].
        unfold ConAssertion.TokenSet_join.
        sets_unfold in Hu. sets_unfold in Hd. sets_unfold.
        split; intro x; specialize (Hu x); specialize (Hd x); tauto.
      * unfold ConAssertion.STS_state_join in Hs.
        unfold ConAssertion.STS_state_join.
        sets_unfold in Hs. sets_unfold.
        intro x. specialize (Hs x). tauto.
  - split; assumption.
Qed.
Theorem primary_incr_two_partial_solve_wit_1_pure : PrimaryQcpGoal.incr_two_partial_solve_wit_1_pure.
Proof.
  unfold PrimaryQcpGoal.incr_two_partial_solve_wit_1_pure.
  intros q p w v Hv Hvmax Hw Hwmax h Hheap.
  split; assumption.
Qed.
Theorem primary_incr_two_partial_solve_wit_1 : PrimaryQcpGoal.incr_two_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.incr_two_partial_solve_wit_1,
    PrimaryQcpGoal.incr_two_partial_solve_wit_1_aux.
  intros Hpure q p w v Hv Hvmax Hw Hwmax h Hheap.
  repeat first [assumption | split].
Qed.
Theorem primary_incr_two_partial_solve_wit_2_pure : PrimaryQcpGoal.incr_two_partial_solve_wit_2_pure.
Proof.
  unfold PrimaryQcpGoal.incr_two_partial_solve_wit_2_pure.
  intros q p w v Hv Hvmax Hw Hwmax h Hheap.
  split; assumption.
Qed.
Theorem primary_incr_two_partial_solve_wit_2 : PrimaryQcpGoal.incr_two_partial_solve_wit_2.
Proof.
  unfold PrimaryQcpGoal.incr_two_partial_solve_wit_2,
    PrimaryQcpGoal.incr_two_partial_solve_wit_2_aux.
  intros Hpure q p w v Hv Hvmax Hw Hwmax h Hheap.
  assert (Hswap : (((q) # UInt |-> w) **
    ((p) # UInt |-> ((v + 1) % 4294967296))) h).
  { destruct Hheap as (h1 & h2 & Hj & Hp & Hq).
    exists h2, h1. split.
    - destruct Hj as (Hm & Ht & Hs).
      split.
      + apply Mem.mem_join_comm. exact Hm.
      + split.
        * destruct Ht as [Hu Hd].
          unfold ConAssertion.TokenSet_join.
          sets_unfold in Hu. sets_unfold in Hd. sets_unfold.
          split; intro x; specialize (Hu x); specialize (Hd x); tauto.
        * unfold ConAssertion.STS_state_join in Hs.
          unfold ConAssertion.STS_state_join.
          sets_unfold in Hs. sets_unfold.
          intro x. specialize (Hs x). tauto.
    - split; assumption. }
  repeat first [assumption | split].
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_incr_safety_wit_1 := primary_incr_safety_wit_1.
Definition proof_of_incr_return_wit_1 := primary_incr_return_wit_1.
Definition proof_of_incr_two_return_wit_1 := primary_incr_two_return_wit_1.
Definition proof_of_incr_two_partial_solve_wit_1_pure := primary_incr_two_partial_solve_wit_1_pure.
Definition proof_of_incr_two_partial_solve_wit_1 := primary_incr_two_partial_solve_wit_1.
Definition proof_of_incr_two_partial_solve_wit_2_pure := primary_incr_two_partial_solve_wit_2_pure.
Definition proof_of_incr_two_partial_solve_wit_2 := primary_incr_two_partial_solve_wit_2.
End PrimaryCertificate.
Print Assumptions primary_incr_safety_wit_1.
Print Assumptions primary_incr_return_wit_1.
Print Assumptions primary_incr_two_return_wit_1.
Print Assumptions primary_incr_two_partial_solve_wit_1_pure.
Print Assumptions primary_incr_two_partial_solve_wit_1.
Print Assumptions primary_incr_two_partial_solve_wit_2_pure.
Print Assumptions primary_incr_two_partial_solve_wit_2.

