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
Require Import SquareRelation.
Local Open Scope sac.

(*----- Function square_loop -----*)

Definition square_loop_safety_wit_1 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 9)
|--
  “ ((2 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 + 1 )) ”
.

Definition square_loop_safety_wit_2 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 9)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition square_loop_safety_wit_3 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_440" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_439" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ (((4 + (2 * 2 ) ) + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= ((4 + (2 * 2 ) ) + 1 )) ”
.

Definition square_loop_safety_wit_4 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_440" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_439" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ ((4 + (2 * 2 ) ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (4 + (2 * 2 ) )) ”
.

Definition square_loop_safety_wit_5 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_440" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_439" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ ((2 * 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 * 2 )) ”
.

Definition square_loop_safety_wit_6 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_440" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_439" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition square_loop_safety_wit_7 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_440" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_439" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition square_loop_safety_wit_8 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ ((1 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 1 )) ”
.

Definition square_loop_safety_wit_9 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition square_loop_safety_wit_10 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_423" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (((1 + (2 * 1 ) ) + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= ((1 + (2 * 1 ) ) + 1 )) ”
.

Definition square_loop_safety_wit_11 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_423" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ ((1 + (2 * 1 ) ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + (2 * 1 ) )) ”
.

Definition square_loop_safety_wit_12 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_423" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ ((2 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 * 1 )) ”
.

Definition square_loop_safety_wit_13 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_423" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition square_loop_safety_wit_14 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_423" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition square_loop_safety_wit_15 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition square_loop_safety_wit_16 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition square_loop_safety_wit_17 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_406" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_405" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ (((0 + (2 * 0 ) ) + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= ((0 + (2 * 0 ) ) + 1 )) ”
.

Definition square_loop_safety_wit_18 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_406" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_405" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ ((0 + (2 * 0 ) ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + (2 * 0 ) )) ”
.

Definition square_loop_safety_wit_19 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_406" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_405" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ ((2 * 0 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 * 0 )) ”
.

Definition square_loop_safety_wit_20 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_406" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_405" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition square_loop_safety_wit_21 := 
forall (p_pre: Z) ,
  ((( &( "k_spec_406" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_405" ) )) # Ptr  |-> p_pre)
  **  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition square_loop_safety_wit_22 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |->_)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition square_loop_safety_wit_23 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition square_loop_safety_wit_24 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition square_loop_safety_wit_25 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition square_loop_safety_wit_26 := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 9)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition square_loop_entail_wit_1 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 9)
|--
  “ (is_square 9 ) ”
  &&  ((p_pre) # Int  |-> 9)
) \/
(
  TT && emp 
|--
  “ (is_square 9 ) ”
  &&  emp
).

Definition square_loop_entail_wit_1_split_goal_1 := 
  (is_square 9 )
.

Definition square_loop_entail_wit_2 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 9)
|--
  “ (is_square (3 * 3 ) ) ”
  &&  ((p_pre) # Int  |-> (3 * 3 ))
) \/
(
  TT && emp 
|--
  “ (is_square 9 ) ”
  &&  emp
).

Definition square_loop_entail_wit_2_split_goal_1 := 
  (is_square 9 )
.

Definition square_loop_entail_wit_3 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 9)
|--
  EX (v: Z) ,
  “ (is_square v ) ”
  &&  ((p_pre) # Int  |-> v)
) \/
(
  TT && emp 
|--
  “ (is_square 9 ) ”
  &&  emp
).

Definition square_loop_entail_wit_3_split_goal_1 := 
  (is_square 9 )
.

Definition square_loop_entail_wit_4 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 4)
|--
  “ (is_square 4 ) ”
  &&  ((p_pre) # Int  |-> 4)
) \/
(
  TT && emp 
|--
  “ (is_square 4 ) ”
  &&  emp
).

Definition square_loop_entail_wit_4_split_goal_1 := 
  (is_square 4 )
.

Definition square_loop_entail_wit_5 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 4)
|--
  “ (is_square (2 * 2 ) ) ”
  &&  ((p_pre) # Int  |-> (2 * 2 ))
) \/
(
  TT && emp 
|--
  “ (is_square 4 ) ”
  &&  emp
).

Definition square_loop_entail_wit_5_split_goal_1 := 
  (is_square 4 )
.

Definition square_loop_entail_wit_6 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 4)
|--
  EX (v: Z) ,
  “ (is_square v ) ”
  &&  ((p_pre) # Int  |-> v)
) \/
(
  TT && emp 
|--
  “ (is_square 4 ) ”
  &&  emp
).

Definition square_loop_entail_wit_6_split_goal_1 := 
  (is_square 4 )
.

Definition square_loop_entail_wit_7 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 1)
|--
  “ (is_square 1 ) ”
  &&  ((p_pre) # Int  |-> 1)
) \/
(
  TT && emp 
|--
  “ (is_square 1 ) ”
  &&  emp
).

Definition square_loop_entail_wit_7_split_goal_1 := 
  (is_square 1 )
.

Definition square_loop_entail_wit_8 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 1)
|--
  “ (is_square (1 * 1 ) ) ”
  &&  ((p_pre) # Int  |-> (1 * 1 ))
) \/
(
  TT && emp 
|--
  “ (is_square 1 ) ”
  &&  emp
).

Definition square_loop_entail_wit_8_split_goal_1 := 
  (is_square 1 )
.

Definition square_loop_entail_wit_9 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 1)
|--
  EX (v: Z) ,
  “ (is_square v ) ”
  &&  ((p_pre) # Int  |-> v)
) \/
(
  TT && emp 
|--
  “ (is_square 1 ) ”
  &&  emp
).

Definition square_loop_entail_wit_9_split_goal_1 := 
  (is_square 1 )
.

Definition square_loop_entail_wit_10 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 0)
|--
  “ (is_square 0 ) ”
  &&  ((p_pre) # Int  |-> 0)
) \/
(
  TT && emp 
|--
  “ (is_square 0 ) ”
  &&  emp
).

Definition square_loop_entail_wit_10_split_goal_1 := 
  (is_square 0 )
.

Definition square_loop_return_wit_1 := 
(
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 9)
|--
  “ (9 = 9) ” 
  &&  “ (is_square 9 ) ”
  &&  ((p_pre) # Int  |-> 9)
) \/
(
  TT && emp 
|--
  “ (is_square 9 ) ”
  &&  emp
).

Definition square_loop_return_wit_1_split_goal_1 := 
  (is_square 9 )
.

Definition square_loop_partial_solve_wit_1_pure := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 4)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 10) ” 
  &&  “ ((2 * 2 ) = (2 * 2 )) ”
.

Definition square_loop_partial_solve_wit_1_aux := 
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 4)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 10) ” 
  &&  “ ((2 * 2 ) = (2 * 2 )) ”
  &&  ((p_pre) # Int  |-> (2 * 2 ))
.

Definition square_loop_partial_solve_wit_1 := square_loop_partial_solve_wit_1_pure -> square_loop_partial_solve_wit_1_aux.

Definition square_loop_partial_solve_wit_2_pure := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 1)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 10) ” 
  &&  “ ((1 * 1 ) = (1 * 1 )) ”
.

Definition square_loop_partial_solve_wit_2_aux := 
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 1)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 10) ” 
  &&  “ ((1 * 1 ) = (1 * 1 )) ”
  &&  ((p_pre) # Int  |-> (1 * 1 ))
.

Definition square_loop_partial_solve_wit_2 := square_loop_partial_solve_wit_2_pure -> square_loop_partial_solve_wit_2_aux.

Definition square_loop_partial_solve_wit_3_pure := 
forall (p_pre: Z) ,
  ((( &( "i_spec_393" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 0)
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 10) ” 
  &&  “ ((0 * 0 ) = (0 * 0 )) ”
.

Definition square_loop_partial_solve_wit_3_aux := 
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 0)
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 10) ” 
  &&  “ ((0 * 0 ) = (0 * 0 )) ”
  &&  ((p_pre) # Int  |-> (0 * 0 ))
.

Definition square_loop_partial_solve_wit_3 := square_loop_partial_solve_wit_3_pure -> square_loop_partial_solve_wit_3_aux.

Definition square_loop_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (0 = 0) ” 
  &&  “ (0 = 0) ”
  &&  ((p_pre) # Int  |-> 0)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_square_loop_safety_wit_1 : square_loop_safety_wit_1.
Axiom proof_of_square_loop_safety_wit_2 : square_loop_safety_wit_2.
Axiom proof_of_square_loop_safety_wit_3 : square_loop_safety_wit_3.
Axiom proof_of_square_loop_safety_wit_4 : square_loop_safety_wit_4.
Axiom proof_of_square_loop_safety_wit_5 : square_loop_safety_wit_5.
Axiom proof_of_square_loop_safety_wit_6 : square_loop_safety_wit_6.
Axiom proof_of_square_loop_safety_wit_7 : square_loop_safety_wit_7.
Axiom proof_of_square_loop_safety_wit_8 : square_loop_safety_wit_8.
Axiom proof_of_square_loop_safety_wit_9 : square_loop_safety_wit_9.
Axiom proof_of_square_loop_safety_wit_10 : square_loop_safety_wit_10.
Axiom proof_of_square_loop_safety_wit_11 : square_loop_safety_wit_11.
Axiom proof_of_square_loop_safety_wit_12 : square_loop_safety_wit_12.
Axiom proof_of_square_loop_safety_wit_13 : square_loop_safety_wit_13.
Axiom proof_of_square_loop_safety_wit_14 : square_loop_safety_wit_14.
Axiom proof_of_square_loop_safety_wit_15 : square_loop_safety_wit_15.
Axiom proof_of_square_loop_safety_wit_16 : square_loop_safety_wit_16.
Axiom proof_of_square_loop_safety_wit_17 : square_loop_safety_wit_17.
Axiom proof_of_square_loop_safety_wit_18 : square_loop_safety_wit_18.
Axiom proof_of_square_loop_safety_wit_19 : square_loop_safety_wit_19.
Axiom proof_of_square_loop_safety_wit_20 : square_loop_safety_wit_20.
Axiom proof_of_square_loop_safety_wit_21 : square_loop_safety_wit_21.
Axiom proof_of_square_loop_safety_wit_22 : square_loop_safety_wit_22.
Axiom proof_of_square_loop_safety_wit_23 : square_loop_safety_wit_23.
Axiom proof_of_square_loop_safety_wit_24 : square_loop_safety_wit_24.
Axiom proof_of_square_loop_safety_wit_25 : square_loop_safety_wit_25.
Axiom proof_of_square_loop_safety_wit_26 : square_loop_safety_wit_26.
Axiom proof_of_square_loop_entail_wit_1 : square_loop_entail_wit_1.
Axiom proof_of_square_loop_entail_wit_2 : square_loop_entail_wit_2.
Axiom proof_of_square_loop_entail_wit_3 : square_loop_entail_wit_3.
Axiom proof_of_square_loop_entail_wit_4 : square_loop_entail_wit_4.
Axiom proof_of_square_loop_entail_wit_5 : square_loop_entail_wit_5.
Axiom proof_of_square_loop_entail_wit_6 : square_loop_entail_wit_6.
Axiom proof_of_square_loop_entail_wit_7 : square_loop_entail_wit_7.
Axiom proof_of_square_loop_entail_wit_8 : square_loop_entail_wit_8.
Axiom proof_of_square_loop_entail_wit_9 : square_loop_entail_wit_9.
Axiom proof_of_square_loop_entail_wit_10 : square_loop_entail_wit_10.
Axiom proof_of_square_loop_return_wit_1 : square_loop_return_wit_1.
Axiom proof_of_square_loop_partial_solve_wit_1_pure : square_loop_partial_solve_wit_1_pure.
Axiom proof_of_square_loop_partial_solve_wit_1 : square_loop_partial_solve_wit_1.
Axiom proof_of_square_loop_partial_solve_wit_2_pure : square_loop_partial_solve_wit_2_pure.
Axiom proof_of_square_loop_partial_solve_wit_2 : square_loop_partial_solve_wit_2.
Axiom proof_of_square_loop_partial_solve_wit_3_pure : square_loop_partial_solve_wit_3_pure.
Axiom proof_of_square_loop_partial_solve_wit_3 : square_loop_partial_solve_wit_3.
Axiom proof_of_square_loop_precondition_wit_1 : square_loop_precondition_wit_1.

End VC_Correct.
