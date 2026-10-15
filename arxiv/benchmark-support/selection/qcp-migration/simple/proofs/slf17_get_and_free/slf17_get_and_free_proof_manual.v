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
Require Import slf17_get_and_free_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_freeUnsignedInt_return_wit_1 : freeUnsignedInt_return_wit_1.
Proof.
 unfold freeUnsignedInt_return_wit_1.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
 all: try (apply store_uint_undef_store_uint).
 all: try (Exists (n0+1); entailer!; lia).
Qed.

Lemma proof_of_freeUnsignedInt_partial_solve_wit_1_pure : freeUnsignedInt_partial_solve_wit_1_pure.
Proof.
 unfold freeUnsignedInt_partial_solve_wit_1_pure.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
 all: try (apply store_uint_undef_store_uint).
 all: try (Exists (n0+1); entailer!; lia).
Qed.

Lemma proof_of_freeUnsignedInt_partial_solve_wit_1 : freeUnsignedInt_partial_solve_wit_1.
Proof.
 unfold freeUnsignedInt_partial_solve_wit_1.
 intros; unfold freeUnsignedInt_partial_solve_wit_1_aux; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
 all: try (apply store_uint_undef_store_uint).
 all: try (Exists (n0+1); entailer!; lia).
Qed.

Lemma proof_of_get_and_free_return_wit_1 : get_and_free_return_wit_1.
Proof.
 unfold get_and_free_return_wit_1.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
 all: try (apply store_uint_undef_store_uint).
 all: try (Exists (n0+1); entailer!; lia).
Qed.

Lemma proof_of_get_and_free_partial_solve_wit_1 : get_and_free_partial_solve_wit_1.
Proof.
 unfold get_and_free_partial_solve_wit_1.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
 all: try (apply store_uint_undef_store_uint).
 all: try (Exists (n0+1); entailer!; lia).
Qed.

