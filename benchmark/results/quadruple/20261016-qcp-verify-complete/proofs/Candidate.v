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


Theorem primary_quadruple_return_wit_1 : PrimaryQcpGoal.quadruple_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.quadruple_return_wit_1.
  left.
  intros n_pre PreH1 PreH2 h H.
  destruct H as [_ Hemp].
  split.
  - change
      (Z.modulo
         (Z.modulo (n_pre + n_pre) 4294967296 +
          Z.modulo (n_pre + n_pre) 4294967296)
         4294967296 = Z.rem (4 * n_pre) 4294967296).
    rewrite Z.rem_mod_nonneg by lia.
    rewrite <- Z.add_mod by lia.
    replace (n_pre + n_pre + (n_pre + n_pre)) with (4 * n_pre) by ring.
    reflexivity.
  - exact Hemp.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_quadruple_return_wit_1 := primary_quadruple_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_quadruple_return_wit_1.
