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


Theorem primary_transfer_safety_wit_1 : PrimaryQcpGoal.transfer_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.transfer_safety_wit_1.
  intros q_pre p_pre w v PreH1 PreH2 PreH3 PreH4 h H.
  split.
  - change (0 <= 2147483647). lia.
  - change (-2147483648 <= 0). lia.
Qed.
Theorem primary_transfer_return_wit_1 : PrimaryQcpGoal.transfer_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.transfer_return_wit_1.
  left.
  intros q_pre p_pre w v PreH1 PreH2 PreH3 PreH4.
  assert (E : unsigned_last_nbits (v + w) 32 = Z.rem (v + w) 4294967296).
  {
    unfold unsigned_last_nbits.
    change (Z.modulo (v + w) 4294967296 = Z.rem (v + w) 4294967296).
    symmetry.
    apply Z.rem_mod_nonneg; lia.
  }
  rewrite E.
  intros h H. exact H.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_transfer_safety_wit_1 := primary_transfer_safety_wit_1.
Definition proof_of_transfer_return_wit_1 := primary_transfer_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_transfer_safety_wit_1.
Print Assumptions primary_transfer_return_wit_1.
