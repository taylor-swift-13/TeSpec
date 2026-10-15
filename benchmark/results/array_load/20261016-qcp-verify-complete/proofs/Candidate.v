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


Theorem primary_read_return_wit_1 : PrimaryQcpGoal.read_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.read_return_wit_1.
  intros i n p l Hi Hin h Hfull.
  split; [reflexivity | exact Hfull].
Qed.
Theorem primary_read_partial_solve_wit_1 : PrimaryQcpGoal.read_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.read_partial_solve_wit_1.
  intros i n p l Hi Hin.
  pose proof (IntArray.full_split_to_missing_i p i n l 0
    ltac:(lia)) as Hsplit.
  intros h Hfull.
  change ((0 <= i /\ i < n) /\
    ((((p + (i * sizeof(INT)))) # Int |-> (Znth i l 0)) **
      (IntArray.missing_i p i 0 n l)) h).
  split.
  - split; assumption.
  - exact (Hsplit h Hfull).
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_read_return_wit_1 := primary_read_return_wit_1.
Definition proof_of_read_partial_solve_wit_1 := primary_read_partial_solve_wit_1.
End PrimaryCertificate.
Print Assumptions IntArray.full_split_to_missing_i.
Print Assumptions primary_read_return_wit_1.
Print Assumptions primary_read_partial_solve_wit_1.
