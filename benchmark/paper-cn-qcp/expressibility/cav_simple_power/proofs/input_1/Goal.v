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
Require Import p076_is_simple_power.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function p076_is_simple_power -----*)

Definition p076_is_simple_power_safety_wit_1 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 8)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_2 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 8)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ ((2 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_3 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 8)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_4 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 4)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ ((4 * 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (4 * 2 )) ”
.

Definition p076_is_simple_power_safety_wit_5 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 4)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ ((1 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_6 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 4)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_7 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 2)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ ((2 * 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 * 2 )) ”
.

Definition p076_is_simple_power_safety_wit_8 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 2)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_9 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 2)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_10 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ ((1 * 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 2 )) ”
.

Definition p076_is_simple_power_safety_wit_11 := 
  ((( &( "count_spec_387" ) )) # Int  |->_)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition p076_is_simple_power_safety_wit_12 := 
  ((( &( "p_spec_384" ) )) # Int  |->_)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_13 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_14 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 2)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_15 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 4)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_16 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 8)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 8)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 2)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_return_wit_1 := 
(
  TT && emp 
|--
  “ (is_simple_power_spec 8 2 1 ) ”
  &&  emp
) \/
(
  TT && emp 
|--
  “ (is_simple_power_spec 8 2 1 ) ”
  &&  emp
).

Definition p076_is_simple_power_return_wit_1_split_goal_1 := 
  (is_simple_power_spec 8 2 1 )
.

Definition p076_is_simple_power_precondition_wit_1 :=
~ ((  “ (8 = 8) ” 
  &&  “ (2 = 2) ” 
  &&  “ (1 <= 8) ” 
  &&  “ (8 <= INT_MAX) ” 
  &&  “ (1 <= 2) ” 
  &&  “ (2 <= INT_MAX) ” 
  &&  “ ((8 * 2 ) <= INT_MAX) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_p076_is_simple_power_safety_wit_1 : p076_is_simple_power_safety_wit_1.
Axiom proof_of_p076_is_simple_power_safety_wit_2 : p076_is_simple_power_safety_wit_2.
Axiom proof_of_p076_is_simple_power_safety_wit_3 : p076_is_simple_power_safety_wit_3.
Axiom proof_of_p076_is_simple_power_safety_wit_4 : p076_is_simple_power_safety_wit_4.
Axiom proof_of_p076_is_simple_power_safety_wit_5 : p076_is_simple_power_safety_wit_5.
Axiom proof_of_p076_is_simple_power_safety_wit_6 : p076_is_simple_power_safety_wit_6.
Axiom proof_of_p076_is_simple_power_safety_wit_7 : p076_is_simple_power_safety_wit_7.
Axiom proof_of_p076_is_simple_power_safety_wit_8 : p076_is_simple_power_safety_wit_8.
Axiom proof_of_p076_is_simple_power_safety_wit_9 : p076_is_simple_power_safety_wit_9.
Axiom proof_of_p076_is_simple_power_safety_wit_10 : p076_is_simple_power_safety_wit_10.
Axiom proof_of_p076_is_simple_power_safety_wit_11 : p076_is_simple_power_safety_wit_11.
Axiom proof_of_p076_is_simple_power_safety_wit_12 : p076_is_simple_power_safety_wit_12.
Axiom proof_of_p076_is_simple_power_safety_wit_13 : p076_is_simple_power_safety_wit_13.
Axiom proof_of_p076_is_simple_power_safety_wit_14 : p076_is_simple_power_safety_wit_14.
Axiom proof_of_p076_is_simple_power_safety_wit_15 : p076_is_simple_power_safety_wit_15.
Axiom proof_of_p076_is_simple_power_safety_wit_16 : p076_is_simple_power_safety_wit_16.
Axiom proof_of_p076_is_simple_power_return_wit_1 : p076_is_simple_power_return_wit_1.
Axiom proof_of_p076_is_simple_power_precondition_wit_1 : p076_is_simple_power_precondition_wit_1.

End VC_Correct.
