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
Require Import slf7_basic_incr_first_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Proof.
  unfold incr_safety_wit_1.
  intros; entailer!.
Qed.

Lemma proof_of_incr_return_wit_1 : incr_return_wit_1.
Proof.
  unfold incr_return_wit_1.
  try right; intros; unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
  entailer!; try (rewrite Z.rem_mod_nonneg by lia); try reflexivity.
  all: try (rewrite <- Z.add_mod by lia; f_equal; ring).
Qed.

Lemma proof_of_incr_first_return_wit_1 : incr_first_return_wit_1.
Proof.
  unfold incr_first_return_wit_1.
  try right; intros; unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
  entailer!; try (rewrite Z.rem_mod_nonneg by lia); try reflexivity.
  all: try (rewrite <- Z.add_mod by lia; f_equal; ring).
Qed.

Lemma proof_of_incr_first_partial_solve_wit_1_pure : incr_first_partial_solve_wit_1_pure.
Proof.
  unfold incr_first_partial_solve_wit_1_pure.
  intros; entailer!.
Qed.

Lemma proof_of_incr_first_partial_solve_wit_1 : incr_first_partial_solve_wit_1.
Proof.
  unfold incr_first_partial_solve_wit_1.
  intros; unfold incr_first_partial_solve_wit_1_aux; intros; entailer!.
Qed.

Lemma proof_of_incr_first__return_wit_1 : incr_first__return_wit_1.
Proof.
  unfold incr_first__return_wit_1.
  try right; intros; unfold unsigned_last_nbits; change (2 ^ 32) with 4294967296.
  entailer!; try (rewrite Z.rem_mod_nonneg by lia); try reflexivity.
  all: try (rewrite <- Z.add_mod by lia; f_equal; ring).
Qed.

Lemma proof_of_incr_first__partial_solve_wit_1_pure : incr_first__partial_solve_wit_1_pure.
Proof.
  unfold incr_first__partial_solve_wit_1_pure.
  intros; entailer!.
Qed.

Lemma proof_of_incr_first__partial_solve_wit_1 : incr_first__partial_solve_wit_1.
Proof.
  unfold incr_first__partial_solve_wit_1.
  intros; unfold incr_first__partial_solve_wit_1_aux; intros; entailer!.
Qed.

