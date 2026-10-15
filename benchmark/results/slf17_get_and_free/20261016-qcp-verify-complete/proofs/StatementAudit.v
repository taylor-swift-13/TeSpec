Require Import PrimaryQcpGoal.
From SimpleC.SL Require Import Mem SeparationLogic.
Import naive_C_Rules.
Print Assumptions PrimaryQcpGoal.freeUnsignedInt_return_wit_1.
Print Assumptions PrimaryQcpGoal.freeUnsignedInt_partial_solve_wit_1_pure.
Print Assumptions PrimaryQcpGoal.freeUnsignedInt_partial_solve_wit_1.
Print Assumptions PrimaryQcpGoal.get_and_free_return_wit_1.
Print Assumptions PrimaryQcpGoal.get_and_free_partial_solve_wit_1.
Goal True. idtac "RUNTIME_HELPER". exact I. Qed.
Print Assumptions store_uint_undef_store_uint.
