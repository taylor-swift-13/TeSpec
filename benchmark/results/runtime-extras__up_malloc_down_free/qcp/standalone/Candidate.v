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

Require Import Primary.
Module Certificate : Primary.VC_Correct.
Lemma proof_of_mkref_return_wit_1 : mkref_return_wit_1.
Proof.
unfold mkref_return_wit_1; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_mkref_partial_solve_wit_1_pure : mkref_partial_solve_wit_1_pure.
Proof.
unfold mkref_partial_solve_wit_1_pure; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_mkref_partial_solve_wit_1 : mkref_partial_solve_wit_1.
Proof.
unfold mkref_partial_solve_wit_1, mkref_partial_solve_wit_1_aux; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_main_safety_wit_1 : main_safety_wit_1.
Proof.
unfold main_safety_wit_1; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_main_safety_wit_2 : main_safety_wit_2.
Proof.
unfold main_safety_wit_2; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_main_return_wit_1 : main_return_wit_1.
Proof.
unfold main_return_wit_1; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Proof.
unfold main_partial_solve_wit_1_pure; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Proof.
unfold main_partial_solve_wit_1, main_partial_solve_wit_1_aux; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Proof.
unfold main_partial_solve_wit_2_pure; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
Lemma proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Proof.
unfold main_partial_solve_wit_2, main_partial_solve_wit_2_aux; intros; subst; first [ solve [entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia; try ring] | solve [right; intros; subst; entailer!; try apply store_uint_undef_store_uint; try reflexivity; try reflexivity; try lia] ].
Qed.
End Certificate.
Print Assumptions Certificate.proof_of_mkref_return_wit_1.
Print Assumptions Certificate.proof_of_mkref_partial_solve_wit_1_pure.
Print Assumptions Certificate.proof_of_mkref_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_main_safety_wit_1.
Print Assumptions Certificate.proof_of_main_safety_wit_2.
Print Assumptions Certificate.proof_of_main_return_wit_1.
Print Assumptions Certificate.proof_of_main_partial_solve_wit_1_pure.
Print Assumptions Certificate.proof_of_main_partial_solve_wit_1.
Print Assumptions Certificate.proof_of_main_partial_solve_wit_2_pure.
Print Assumptions Certificate.proof_of_main_partial_solve_wit_2.
