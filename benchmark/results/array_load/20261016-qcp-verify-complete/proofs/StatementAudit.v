Require Import PrimaryQcpGoal.
From SimpleC.SL Require Import Mem SeparationLogic.
Import naive_C_Rules.
Print Assumptions PrimaryQcpGoal.read_return_wit_1.
Print Assumptions PrimaryQcpGoal.read_partial_solve_wit_1.
Goal True. idtac "RUNTIME_HELPER". exact I. Qed.
Print Assumptions IntArray.full_split_to_missing_i.
