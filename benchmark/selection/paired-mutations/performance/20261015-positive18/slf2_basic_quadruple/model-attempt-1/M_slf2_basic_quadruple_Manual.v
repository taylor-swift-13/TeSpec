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
Require Import M_slf2_basic_quadruple_Goal.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_quadruple_return_wit_1_split_goal_1 : quadruple_return_wit_1_split_goal_1.
Proof.
  unfold quadruple_return_wit_1_split_goal_1.
  intros n_pre PreH1 PreH2.
  unfold unsigned_last_nbits.
  change
    (((n_pre + n_pre) mod 4294967296 +
      (n_pre + n_pre) mod 4294967296) mod 4294967296 =
     (4 * n_pre) mod 4294967296).
  rewrite <- Z.add_mod by lia.
  replace (n_pre + n_pre + (n_pre + n_pre)) with (4 * n_pre) by ring.
  reflexivity.
Qed.

Lemma proof_of_quadruple_return_wit_1 : quadruple_return_wit_1.
Proof.
  unfold quadruple_return_wit_1.
  left.
  intros n_pre PreH1 PreH2.
  pose proof
    (proof_of_quadruple_return_wit_1_split_goal_1 n_pre PreH1 PreH2)
    as Hquadruple.
  rewrite Hquadruple.
  entailer!.
Qed.

