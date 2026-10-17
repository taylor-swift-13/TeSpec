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


Theorem resolved_main_entail_wit_1_split_goal_spatial : ExecutionGoal.main_entail_wit_1_split_goal_spatial.
Proof.
  unfold ExecutionGoal.main_entail_wit_1_split_goal_spatial.
  exact (IntArray.full_split_to_missing_i
    (&("a_spec_395")) 2 3 (0 :: 1 :: 2 :: nil) 0 ltac:(lia)).
Qed.
Theorem resolved_main_entail_wit_1 : ExecutionGoal.main_entail_wit_1.
Proof.
  unfold ExecutionGoal.main_entail_wit_1.
  left; exact resolved_main_entail_wit_1_split_goal_spatial.
Qed.
Theorem resolved_main_entail_wit_4_split_goal_spatial : ExecutionGoal.main_entail_wit_4_split_goal_spatial.
Proof.
  unfold ExecutionGoal.main_entail_wit_4_split_goal_spatial.
  exact (IntArray.full_split_to_missing_i
    (&("a_spec_395")) 1 3 (0 :: 1 :: 2 :: nil) 0 ltac:(lia)).
Qed.
Theorem resolved_main_entail_wit_4 : ExecutionGoal.main_entail_wit_4.
Proof.
  unfold ExecutionGoal.main_entail_wit_4.
  left; exact resolved_main_entail_wit_4_split_goal_spatial.
Qed.
Theorem resolved_main_entail_wit_7_split_goal_spatial : ExecutionGoal.main_entail_wit_7_split_goal_spatial.
Proof.
  unfold ExecutionGoal.main_entail_wit_7_split_goal_spatial.
  pose proof (IntArray.full_split_to_missing_i
    (&("a_spec_395")) 0 3 (0 :: 1 :: 2 :: nil) 0 ltac:(lia)) as H.
  change (IntArray.full (&("a_spec_395")) 3 (0 :: 1 :: 2 :: nil)
    |-- (((&("a_spec_395")) + (0 * 4)) # Int |-> 0)
    ** IntArray.missing_i (&("a_spec_395")) 0 0 3
         (0 :: 1 :: 2 :: nil)) in H.
  rewrite Z.add_0_r in H.
  exact H.
Qed.
Theorem resolved_main_entail_wit_7 : ExecutionGoal.main_entail_wit_7.
Proof.
  unfold ExecutionGoal.main_entail_wit_7.
  left; exact resolved_main_entail_wit_7_split_goal_spatial.
Qed.
Print Assumptions resolved_main_entail_wit_1_split_goal_spatial.
Print Assumptions resolved_main_entail_wit_1.
Print Assumptions resolved_main_entail_wit_4_split_goal_spatial.
Print Assumptions resolved_main_entail_wit_4.
Print Assumptions resolved_main_entail_wit_7_split_goal_spatial.
Print Assumptions resolved_main_entail_wit_7.
