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


Theorem primary_swap_array_return_wit_1 : PrimaryQcpGoal.swap_array_return_wit_1.
Proof.
  intros j i n p l Hi Hin Hj Hjn Hij h H.
  exact H.
Qed.
Theorem primary_swap_array_partial_solve_wit_1 : PrimaryQcpGoal.swap_array_partial_solve_wit_1.
Proof.
  intros j i n p l Hi Hin Hj Hjn Hij h H.
  split.
  { repeat split; assumption. }
  exact (IntArray.full_split_to_missing_i p i n l 0
           (conj Hi Hin) h H).
Qed.
Theorem primary_swap_array_partial_solve_wit_2 : PrimaryQcpGoal.swap_array_partial_solve_wit_2.
Proof.
  intros j i n p l Hi Hin Hj Hjn Hij h H.
  split.
  { repeat split; assumption. }
  exact (IntArray.full_split_to_missing_i p j n l 0
           (conj Hj Hjn) h H).
Qed.
Theorem primary_swap_array_partial_solve_wit_3 : PrimaryQcpGoal.swap_array_partial_solve_wit_3.
Proof.
  intros j i n p l Hi Hin Hj Hjn Hij h H.
  split.
  { repeat split; assumption. }
  pose proof (IntArray.full_split_to_missing_i p i n l 0
                (conj Hi Hin) h H) as Hsplit.
  destruct Hsplit as (h1 & h2 & Hjoin & Hcell & Hframe).
  exists h1, h2.
  split; [exact Hjoin |].
  split; [| exact Hframe].
  exact (store_int_undef_store_int (p + i * sizeof(INT))
           (Znth i l 0) h1 Hcell).
Qed.
Theorem primary_swap_array_partial_solve_wit_4 : PrimaryQcpGoal.swap_array_partial_solve_wit_4.
Proof.
  intros j i n p l Hi Hin Hj Hjn Hij h H.
  split.
  { repeat split; assumption. }
  pose proof (IntArray.full_split_to_missing_i p j n
                (replace_Znth i (Znth j l 0) l) 0
                (conj Hj Hjn) h H) as Hsplit.
  destruct Hsplit as (h1 & h2 & Hjoin & Hcell & Hframe).
  exists h1, h2.
  split; [exact Hjoin |].
  split; [| exact Hframe].
  exact (store_int_undef_store_int (p + j * sizeof(INT))
           (Znth j (replace_Znth i (Znth j l 0) l) 0) h1 Hcell).
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_swap_array_return_wit_1 := primary_swap_array_return_wit_1.
Definition proof_of_swap_array_partial_solve_wit_1 := primary_swap_array_partial_solve_wit_1.
Definition proof_of_swap_array_partial_solve_wit_2 := primary_swap_array_partial_solve_wit_2.
Definition proof_of_swap_array_partial_solve_wit_3 := primary_swap_array_partial_solve_wit_3.
Definition proof_of_swap_array_partial_solve_wit_4 := primary_swap_array_partial_solve_wit_4.
End PrimaryCertificate.
Print Assumptions primary_swap_array_return_wit_1.
Print Assumptions primary_swap_array_partial_solve_wit_1.
Print Assumptions primary_swap_array_partial_solve_wit_2.
Print Assumptions primary_swap_array_partial_solve_wit_3.
Print Assumptions primary_swap_array_partial_solve_wit_4.

Print Assumptions IntArray.full_split_to_missing_i.
Print Assumptions store_int_undef_store_int.
