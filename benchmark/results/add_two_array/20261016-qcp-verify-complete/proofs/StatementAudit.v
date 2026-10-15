Require Import PrimaryQcpGoal.
From SimpleC.SL Require Import Mem SeparationLogic.
Import naive_C_Rules.
Print Assumptions PrimaryQcpGoal.array_read_two_return_wit_1.
Print Assumptions PrimaryQcpGoal.array_read_two_partial_solve_wit_1.
Print Assumptions PrimaryQcpGoal.array_read_two_partial_solve_wit_2.
Goal True. idtac "RUNTIME_HELPER". exact I. Qed.
Print Assumptions UIntArray.full_split_to_missing_i.
