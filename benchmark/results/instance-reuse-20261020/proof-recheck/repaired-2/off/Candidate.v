Require Import ExecutionGoal.
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


Definition empty_state : naive_C_Rules.model := {| ConAssertion.s_mem := Mem.empty_mem; ConAssertion.s_STS := Sets.full; ConAssertion.s_token := Sets.empty |}.
Theorem entry_sat : ExecutionGoal.main_precondition_wit_1.
Proof.
  unfold ExecutionGoal.main_precondition_wit_1.
  intro H.
  apply (H empty_state).
  repeat split; simpl; intros; try reflexivity; tauto.
Qed.
Theorem resolved_main_entail_wit_5 : ExecutionGoal.main_entail_wit_5.
Proof.
  unfold ExecutionGoal.main_entail_wit_5.
  right.
  intros; apply derivable1_refl.
Qed.
Print Assumptions entry_sat.
Print Assumptions resolved_main_entail_wit_5.
