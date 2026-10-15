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


Theorem resolved_init_array2_entail_wit_1_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1_split_goal_spatial.
  intros h H.
  change ((store_char 4096 0 **
    ( “ (1 = 1) ” && “ ((@nil Z) = nil) ” && emp)) h).
  destruct (unit_join h) as [u [Hu Hjoin]].
  exists h, u.
  split; [exact Hjoin |].
  split; [exact H |].
  change (emp u) in Hu.
  unfold andp, coq_prop.
  intuition reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_1 : ExecutionGoal.init_array2_entail_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_1.
  right. exact resolved_init_array2_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_1 : ExecutionGoal.init_array2_entail_wit_2_split_goal_1.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_1.
  intros h H.
  change (repeat_Z 0 0 = @nil Z).
  reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_2_split_goal_spatial : ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2_split_goal_spatial.
  intros h H.
  change ((undef_store_char 4096 ** ( “ (1 = 1) ” && emp)) h).
  destruct (unit_join h) as [u [Hu Hjoin]].
  exists h, u.
  split; [exact Hjoin |].
  split; [exact H |].
  change (emp u) in Hu.
  unfold andp, coq_prop.
  intuition reflexivity.
Qed.
Theorem resolved_init_array2_entail_wit_2 : ExecutionGoal.init_array2_entail_wit_2.
Proof.
  unfold ExecutionGoal.init_array2_entail_wit_2.
  right. intros h H.
  split.
  - exact (resolved_init_array2_entail_wit_2_split_goal_1 h H).
  - exact (resolved_init_array2_entail_wit_2_split_goal_spatial h H).
Qed.
Theorem resolved_init_array2_return_wit_1 : ExecutionGoal.init_array2_return_wit_1.
Proof.
  unfold ExecutionGoal.init_array2_return_wit_1.
  left.
  intros n_pre p_pre PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7.
  subst n_pre; subst p_pre.
  intros h H.
  exists (0 :: nil).
  change (CharArray.seg 4096 0 1 (repeat_Z 0 1) h).
  apply (resolved_init_array2_entail_wit_1_split_goal_spatial h).
  exact H.
Qed.
Print Assumptions resolved_init_array2_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_1.
Print Assumptions resolved_init_array2_entail_wit_2_split_goal_spatial.
Print Assumptions resolved_init_array2_entail_wit_2.
Print Assumptions resolved_init_array2_return_wit_1.
