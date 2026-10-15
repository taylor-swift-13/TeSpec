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


Theorem primary_refUnsignedInt_return_wit_1 : PrimaryQcpGoal.refUnsignedInt_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.refUnsignedInt_return_wit_1.
  intros v_pre v0 retval PreH1 PreH2 PreH3 PreH4.
  subst v_pre.
  intros h H.
  exact H.
Qed.
Theorem primary_refUnsignedInt_partial_solve_wit_1 : PrimaryQcpGoal.refUnsignedInt_partial_solve_wit_1.
Proof.
  unfold PrimaryQcpGoal.refUnsignedInt_partial_solve_wit_1.
  intros v_pre v0 PreH1 PreH2 PreH3.
  intros h [_ Hemp].
  split.
  - repeat split; assumption.
  - exact Hemp.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_refUnsignedInt_return_wit_1 := primary_refUnsignedInt_return_wit_1.
Definition proof_of_refUnsignedInt_partial_solve_wit_1 := primary_refUnsignedInt_partial_solve_wit_1.
End PrimaryCertificate.
Print Assumptions primary_refUnsignedInt_return_wit_1.
Print Assumptions primary_refUnsignedInt_partial_solve_wit_1.
