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
Require Import swap_array_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_swap_array_return_wit_1 : swap_array_return_wit_1.
Proof.
 unfold swap_array_return_wit_1; intros.
 entailer!.
Qed.

Lemma proof_of_swap_array_partial_solve_wit_1 : swap_array_partial_solve_wit_1.
Proof.
 unfold swap_array_partial_solve_wit_1; intros.
 sep_apply (IntArray.full_split_to_missing_i p_pre i_pre n_pre l 0); try lia.
 simpl.
 entailer!.
Qed.

Lemma proof_of_swap_array_partial_solve_wit_2 : swap_array_partial_solve_wit_2.
Proof.
 unfold swap_array_partial_solve_wit_2; intros.
 sep_apply (IntArray.full_split_to_missing_i p_pre j_pre n_pre l 0); try lia.
 simpl.
 entailer!.
Qed.

Lemma proof_of_swap_array_partial_solve_wit_3 : swap_array_partial_solve_wit_3.
Proof.
 unfold swap_array_partial_solve_wit_3; intros.
 sep_apply (IntArray.full_split_to_missing_i p_pre i_pre n_pre l 0); try lia.
 simpl.
 sep_apply store_int_undef_store_int.
 entailer!.
Qed.

Lemma proof_of_swap_array_partial_solve_wit_4 : swap_array_partial_solve_wit_4.
Proof.
 unfold swap_array_partial_solve_wit_4; intros.
 sep_apply (IntArray.full_split_to_missing_i p_pre j_pre n_pre (replace_Znth i_pre (Znth j_pre l 0) l) 0); try lia.
 simpl.
 sep_apply store_int_undef_store_int.
 entailer!.
Qed.

