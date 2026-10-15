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
Require Import slf_ref_greater_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_refUnsignedInt_return_wit_1 : refUnsignedInt_return_wit_1.
Proof.
 unfold refUnsignedInt_return_wit_1.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
Qed.

Lemma proof_of_refUnsignedInt_partial_solve_wit_1 : refUnsignedInt_partial_solve_wit_1.
Proof.
 unfold refUnsignedInt_partial_solve_wit_1.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
Qed.

Lemma proof_of_ref_greater_abstract_safety_wit_1 : ref_greater_abstract_safety_wit_1.
Proof.
 unfold ref_greater_abstract_safety_wit_1.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
Qed.

Lemma proof_of_ref_greater_abstract_return_wit_1 : ref_greater_abstract_return_wit_1.
Proof.
 unfold ref_greater_abstract_return_wit_1.
 intros; Exists (v+1); entailer!.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
Qed.

Lemma proof_of_ref_greater_abstract_partial_solve_wit_1 : ref_greater_abstract_partial_solve_wit_1.
Proof.
 unfold ref_greater_abstract_partial_solve_wit_1.
 try right; intros; subst; entailer!; try lia.
 all: unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
 all: try (rewrite !Z.rem_mod_nonneg by (try lia; match goal with |- context[Z.rem ?x ?m] => pose proof (Z.rem_nonneg x m ltac:(lia) ltac:(lia)); lia end)).
 all: repeat rewrite Z.add_mod_idemp_l by lia.
 all: repeat rewrite Z.add_mod_idemp_r by lia.
 all: try match goal with |- context[Z.modulo ?x ?m] => pose proof (Z.mod_pos_bound x m ltac:(lia)); lia end.
 all: try reflexivity; try (f_equal; ring).
Qed.

