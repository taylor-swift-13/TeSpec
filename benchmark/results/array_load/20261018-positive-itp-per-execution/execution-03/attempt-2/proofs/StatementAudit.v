Require Import ExecutionGoal.
Print Assumptions ExecutionGoal.main_entail_wit_1_split_goal_spatial.
Print Assumptions ExecutionGoal.main_entail_wit_1.
Print Assumptions ExecutionGoal.main_entail_wit_4_split_goal_spatial.
Print Assumptions ExecutionGoal.main_entail_wit_4.
Print Assumptions ExecutionGoal.main_entail_wit_7_split_goal_spatial.
Print Assumptions ExecutionGoal.main_entail_wit_7.
From SimpleC.SL Require Import Mem SeparationLogic.
Import naive_C_Rules.
Goal True. idtac "POSITIVE_RUNTIME_HELPER". exact I. Qed.
Print Assumptions join_assoc.
