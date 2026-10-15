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
Require Import M_slf1_basic_example_let_Goal.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Lemma proof_of_example_let_return_wit_1_split_goal_1 : example_let_return_wit_1_split_goal_1.
Proof.
  unfold example_let_return_wit_1_split_goal_1.
  intros n_pre PreH1 PreH2.
  unfold unsigned_last_nbits.
  change (Z.modulo
            (Z.modulo (n_pre + 1) 4294967296 +
             Z.modulo (n_pre - 1) 4294967296) 4294967296 =
          Z.rem (2 * n_pre) 4294967296).
  rewrite Z.rem_mod_nonneg by lia.
  rewrite <- Z.add_mod by lia.
  f_equal.
  ring.
Qed.

Lemma proof_of_example_let_return_wit_1 : example_let_return_wit_1.
Proof.
  unfold example_let_return_wit_1.
  left.
  intros n_pre PreH1 PreH2.
  pose proof (proof_of_example_let_return_wit_1_split_goal_1
                n_pre PreH1 PreH2) as Hresult.
  entailer!.
Qed.

