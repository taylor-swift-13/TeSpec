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


Theorem primary_val_rand_safety_wit_1 : PrimaryQcpGoal.val_rand_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.val_rand_safety_wit_1.
  intros n_pre n0 retval H1 H2 H3 H4 H5 H6 h Hheap.
  change (n_pre <> 0). lia.
Qed.
Theorem primary_val_rand_return_wit_1 : PrimaryQcpGoal.val_rand_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.val_rand_return_wit_1.
  left. intros n_pre n0 retval H1 H2 H3 H4 H5 H6 h Hheap.
  assert (Hb : 0 <= Z.rem retval n_pre < n0).
  { rewrite Z.rem_mod_nonneg by lia.
    subst n_pre. apply Z.mod_pos_bound. lia. }
  change ((0 <= Z.rem retval n_pre /\ Z.rem retval n_pre < n0) /\ emp h).
  split.
  - split; lia.
  - exact (proj2 Hheap).
Qed.
Theorem primary_val_rand_partial_solve_wit_1 : PrimaryQcpGoal.val_rand_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.val_rand_partial_solve_wit_1.
  intros n_pre n0 H1 H2 H3 H4 h Hheap.
  change ((((0 <= n0 /\ n0 <= 4294967295) /\ n_pre = n0) /\ n0 > 0) /\ emp h).
  split.
  - repeat split; assumption.
  - exact (proj2 Hheap).
Qed.
Theorem primary_two_dice_safety_wit_1 : PrimaryQcpGoal.two_dice_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.two_dice_safety_wit_1.
  intros h Hheap.
  change (6 <= 2147483647 /\ -2147483648 <= 6).
  split; lia.
Qed.
Theorem primary_two_dice_safety_wit_2 : PrimaryQcpGoal.two_dice_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.two_dice_safety_wit_2.
  intros retval H1 H2 h Hheap.
  change (6 <= 2147483647 /\ -2147483648 <= 6).
  split; lia.
Qed.
Theorem primary_two_dice_safety_wit_3 : PrimaryQcpGoal.two_dice_safety_wit_3.
Proof.
  unfold PrimaryQcpGoal.two_dice_safety_wit_3.
  intros retval retval_2 H1 H2 H3 H4 h Hheap.
  change (2 <= 2147483647 /\ -2147483648 <= 2).
  split; lia.
Qed.
Theorem primary_two_dice_return_wit_1 : PrimaryQcpGoal.two_dice_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.two_dice_return_wit_1.
  intros retval retval_2 H1 H2 H3 H4 h Hheap.
  change ((2 <= retval + retval_2 + 2 /\ retval + retval_2 + 2 <= 12) /\ emp h).
  split.
  - split; lia.
  - exact (proj2 Hheap).
Qed.
Theorem primary_two_dice_partial_solve_wit_1_pure : PrimaryQcpGoal.two_dice_partial_solve_wit_1_pure.
Proof.
  unfold PrimaryQcpGoal.two_dice_partial_solve_wit_1_pure.
  intros h Hheap.
  change (((0 <= 6 /\ 6 <= 4294967295) /\ 6 = 6) /\ 6 > 0).
  repeat split; lia.
Qed.
Theorem primary_two_dice_partial_solve_wit_1 : PrimaryQcpGoal.two_dice_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.two_dice_partial_solve_wit_1,
    PrimaryQcpGoal.two_dice_partial_solve_wit_1_aux.
  intros Hpure h Hheap.
  change ((((0 <= 6 /\ 6 <= 4294967295) /\ 6 = 6) /\ 6 > 0) /\ emp h).
  split.
  - repeat split; lia.
  - exact (proj2 Hheap).
Qed.
Theorem primary_two_dice_partial_solve_wit_2_pure : PrimaryQcpGoal.two_dice_partial_solve_wit_2_pure.
Proof.
  unfold PrimaryQcpGoal.two_dice_partial_solve_wit_2_pure.
  intros retval H1 H2 h Hheap.
  change (((0 <= 6 /\ 6 <= 4294967295) /\ 6 = 6) /\ 6 > 0).
  repeat split; lia.
Qed.
Theorem primary_two_dice_partial_solve_wit_2 : PrimaryQcpGoal.two_dice_partial_solve_wit_2.
Proof.
  unfold PrimaryQcpGoal.two_dice_partial_solve_wit_2,
    PrimaryQcpGoal.two_dice_partial_solve_wit_2_aux.
  intros Hpure retval H1 H2 h Hheap.
  change ((((((0 <= 6 /\ 6 <= 4294967295) /\ 6 = 6) /\ 6 > 0) /\
    0 <= retval) /\ retval < 6) /\ emp h).
  split.
  - repeat split; lia.
  - exact (proj2 Hheap).
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_val_rand_safety_wit_1 := primary_val_rand_safety_wit_1.
Definition proof_of_val_rand_return_wit_1 := primary_val_rand_return_wit_1.
Definition proof_of_val_rand_partial_solve_wit_1 := primary_val_rand_partial_solve_wit_1.
Definition proof_of_two_dice_safety_wit_1 := primary_two_dice_safety_wit_1.
Definition proof_of_two_dice_safety_wit_2 := primary_two_dice_safety_wit_2.
Definition proof_of_two_dice_safety_wit_3 := primary_two_dice_safety_wit_3.
Definition proof_of_two_dice_return_wit_1 := primary_two_dice_return_wit_1.
Definition proof_of_two_dice_partial_solve_wit_1_pure := primary_two_dice_partial_solve_wit_1_pure.
Definition proof_of_two_dice_partial_solve_wit_1 := primary_two_dice_partial_solve_wit_1.
Definition proof_of_two_dice_partial_solve_wit_2_pure := primary_two_dice_partial_solve_wit_2_pure.
Definition proof_of_two_dice_partial_solve_wit_2 := primary_two_dice_partial_solve_wit_2.
End PrimaryCertificate.
Print Assumptions primary_val_rand_safety_wit_1.
Print Assumptions primary_val_rand_return_wit_1.
Print Assumptions primary_val_rand_partial_solve_wit_1.
Print Assumptions primary_two_dice_safety_wit_1.
Print Assumptions primary_two_dice_safety_wit_2.
Print Assumptions primary_two_dice_safety_wit_3.
Print Assumptions primary_two_dice_return_wit_1.
Print Assumptions primary_two_dice_partial_solve_wit_1_pure.
Print Assumptions primary_two_dice_partial_solve_wit_1.
Print Assumptions primary_two_dice_partial_solve_wit_2_pure.
Print Assumptions primary_two_dice_partial_solve_wit_2.
