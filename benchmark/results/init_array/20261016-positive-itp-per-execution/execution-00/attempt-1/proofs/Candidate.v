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


Theorem resolved_init_array2_entail_wit_1_split_goal_1 : ExecutionGoal.init_array2_entail_wit_1_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_1.
  unfold repeat_Z.
  reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1.
  right.
  intros h H.
  split.
  - exact resolved_init_array2_entail_wit_1_split_goal_1.
  - exact (proj2 H).
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_1.
