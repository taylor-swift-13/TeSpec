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


Theorem primary_example_let_safety_wit_1 : PrimaryQcpGoal.example_let_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.example_let_safety_wit_1.
  intros n_pre PreH1 PreH2.
  hnf; intros h H.
  split; lia.
Qed.
Theorem primary_example_let_safety_wit_2 : PrimaryQcpGoal.example_let_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.example_let_safety_wit_2.
  intros n_pre PreH1 PreH2.
  hnf; intros h H.
  split; lia.
Qed.
Theorem primary_example_let_return_wit_1 : PrimaryQcpGoal.example_let_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.example_let_return_wit_1.
  left; intros n_pre PreH1 PreH2.
  assert (Hmod :
    Z.modulo
      (Z.modulo (n_pre + 1) 4294967296 +
       Z.modulo (n_pre - 1) 4294967296) 4294967296 =
    Z.rem (2 * n_pre) 4294967296).
  {
    rewrite Z.rem_mod_nonneg by lia.
    rewrite <- Z.add_mod by lia.
    replace (n_pre + 1 + (n_pre - 1)) with (2 * n_pre) by ring.
    reflexivity.
  }
  hnf; intros h H.
  split.
  - change (Z.modulo (Z.modulo (n_pre + 1) 4294967296 +
                       Z.modulo (n_pre - 1) 4294967296) 4294967296 =
            Z.rem (2 * n_pre) 4294967296).
    exact Hmod.
  - exact (proj2 H).
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_example_let_safety_wit_1 := primary_example_let_safety_wit_1.
Definition proof_of_example_let_safety_wit_2 := primary_example_let_safety_wit_2.
Definition proof_of_example_let_return_wit_1 := primary_example_let_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_example_let_safety_wit_1.
Print Assumptions primary_example_let_safety_wit_2.
Print Assumptions primary_example_let_return_wit_1.
