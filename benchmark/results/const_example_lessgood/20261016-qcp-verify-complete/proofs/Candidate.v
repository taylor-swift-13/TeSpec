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


Theorem primary_main_safety_wit_1 : PrimaryQcpGoal.main_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.main_safety_wit_1.
  intros h H.
  split.
  - change (0 <= 2147483647). lia.
  - change (-2147483648 <= 0). lia.
Qed.
Theorem primary_main_entail_wit_1 : PrimaryQcpGoal.main_entail_wit_1.
Proof.
  unfold PrimaryQcpGoal.main_entail_wit_1.
  intros h H.
  exact H.
Qed.
Theorem primary_main_return_wit_1 : PrimaryQcpGoal.main_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.main_return_wit_1.
  intros h H.
  destruct H as [_ Hemp].
  split.
  - change (0 = 0). reflexivity.
  - exact Hemp.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_main_safety_wit_1 := primary_main_safety_wit_1.
Definition proof_of_main_entail_wit_1 := primary_main_entail_wit_1.
Definition proof_of_main_return_wit_1 := primary_main_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_main_safety_wit_1.
Print Assumptions primary_main_entail_wit_1.
Print Assumptions primary_main_return_wit_1.
