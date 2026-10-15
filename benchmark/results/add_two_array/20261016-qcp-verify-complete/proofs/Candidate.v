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


Theorem primary_array_read_two_return_wit_1 : PrimaryQcpGoal.array_read_two_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.array_read_two_return_wit_1.
  left.
  intros.
  assert (Hsum :
    unsigned_last_nbits (Znth i_pre l 0 + Znth j_pre l 0) 32 =
    Z.rem (Znth i_pre l 0 + Znth j_pre l 0) 4294967296).
  {
    unfold unsigned_last_nbits.
    change (Z.modulo (Znth i_pre l 0 + Znth j_pre l 0) 4294967296 =
            Z.rem (Znth i_pre l 0 + Znth j_pre l 0) 4294967296).
    symmetry.
    apply Z.rem_mod_nonneg; lia.
  }
  entailer!.
Qed.
Theorem primary_array_read_two_partial_solve_wit_1 : PrimaryQcpGoal.array_read_two_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.array_read_two_partial_solve_wit_1.
  intros.
  sep_apply (UIntArray.full_split_to_missing_i p_pre i_pre n_pre l 0);
    entailer!.
Qed.
Theorem primary_array_read_two_partial_solve_wit_2 : PrimaryQcpGoal.array_read_two_partial_solve_wit_2.
Proof.
  unfold PrimaryQcpGoal.array_read_two_partial_solve_wit_2.
  intros.
  sep_apply (UIntArray.full_split_to_missing_i p_pre j_pre n_pre l 0);
    entailer!.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_array_read_two_return_wit_1 := primary_array_read_two_return_wit_1.
Definition proof_of_array_read_two_partial_solve_wit_1 := primary_array_read_two_partial_solve_wit_1.
Definition proof_of_array_read_two_partial_solve_wit_2 := primary_array_read_two_partial_solve_wit_2.
End PrimaryCertificate.
Print Assumptions primary_array_read_two_return_wit_1.
Print Assumptions primary_array_read_two_partial_solve_wit_1.
Print Assumptions primary_array_read_two_partial_solve_wit_2.
