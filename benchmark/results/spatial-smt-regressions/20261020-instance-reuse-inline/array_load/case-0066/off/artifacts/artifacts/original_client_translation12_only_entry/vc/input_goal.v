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

(*----- Function main -----*)

Definition main_safety_wit_1 := 
  ((( &( "third_spec_457" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (2 * 4)))
  **  ((( &( "two_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_436" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (1 * 4)))
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_2 := 
  ((( &( "third_spec_457" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_436" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (1 * 4)))
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_3 := 
  ((( &( "third_spec_457" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_436" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (1 * 4)))
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_4 := 
  ((( &( "two_spec_441" ) )) # Int  |->_)
  **  ((( &( "second_spec_436" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (1 * 4)))
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_5 := 
  ((( &( "two_spec_441" ) )) # Int  |->_)
  **  ((( &( "second_spec_436" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (1 * 4)))
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_6 := 
  ((( &( "second_spec_436" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_7 := 
  ((( &( "second_spec_436" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_8 := 
  ((( &( "one_spec_420" ) )) # Int  |->_)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_9 := 
  ((( &( "one_spec_420" ) )) # Int  |->_)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_10 := 
  ((( &( "first_spec_415" ) )) # Ptr  |->_)
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_11 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_12 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_13 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_14 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_15 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_entail_wit_1 := 
(
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_396" ) ) + (2 * 4))) # Int  |-> 2)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 2 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_396" ) ) + (2 * 4))) # Int  |-> 2)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 2 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
).

Definition main_entail_wit_1_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_396" ) ) + (2 * 4))) # Int  |-> 2)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 2 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_2 := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (two: Z) ,
  “ (two = 2) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_3 := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (l2: (@list Z))  (retval: Z) ,
  “ (retval = 2) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 l2 )
.

Definition main_entail_wit_4 := 
(
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_396" ) ) + (1 * 4))) # Int  |-> 1)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 1 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_396" ) ) + (1 * 4))) # Int  |-> 1)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 1 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
).

Definition main_entail_wit_4_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_396" ) ) + (1 * 4))) # Int  |-> 1)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 1 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_5 := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (one: Z) ,
  “ (one = 1) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_6 := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (l2: (@list Z))  (retval: Z) ,
  “ (retval = 1) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 l2 )
.

Definition main_entail_wit_7 := 
(
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  ((( &( "a_spec_396" ) )) # Int  |-> 0)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 0 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  ((( &( "a_spec_396" ) )) # Int  |-> 0)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 0 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
).

Definition main_entail_wit_7_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  ((( &( "a_spec_396" ) )) # Int  |-> 0)
  **  (IntArray.missing_i ( &( "a_spec_396" ) ) 0 0 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_8 := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (zero: Z) ,
  “ (zero = 0) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_9 := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (l2: (@list Z))  (retval: Z) ,
  “ (retval = 0) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 l2 )
.

Definition main_return_wit_1 := 
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
  ((( &( "two_spec_441" ) )) # Int  |->_)
  **  ((( &( "second_spec_436" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (1 * sizeof(INT))))
  **  ((( &( "one_spec_420" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * sizeof(INT))))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition main_partial_solve_wit_1_aux := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
  ((( &( "one_spec_420" ) )) # Int  |->_)
  **  ((( &( "first_spec_415" ) )) # Ptr  |-> (( &( "a_spec_396" ) ) + (0 * sizeof(INT))))
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition main_partial_solve_wit_2_aux := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Definition main_partial_solve_wit_3_pure := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition main_partial_solve_wit_3_aux := 
  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
  &&  (IntArray.full ( &( "a_spec_396" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_3 := main_partial_solve_wit_3_pure -> main_partial_solve_wit_3_aux.

Definition main_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_safety_wit_2 : main_safety_wit_2.
Axiom proof_of_main_safety_wit_3 : main_safety_wit_3.
Axiom proof_of_main_safety_wit_4 : main_safety_wit_4.
Axiom proof_of_main_safety_wit_5 : main_safety_wit_5.
Axiom proof_of_main_safety_wit_6 : main_safety_wit_6.
Axiom proof_of_main_safety_wit_7 : main_safety_wit_7.
Axiom proof_of_main_safety_wit_8 : main_safety_wit_8.
Axiom proof_of_main_safety_wit_9 : main_safety_wit_9.
Axiom proof_of_main_safety_wit_10 : main_safety_wit_10.
Axiom proof_of_main_safety_wit_11 : main_safety_wit_11.
Axiom proof_of_main_safety_wit_12 : main_safety_wit_12.
Axiom proof_of_main_safety_wit_13 : main_safety_wit_13.
Axiom proof_of_main_safety_wit_14 : main_safety_wit_14.
Axiom proof_of_main_safety_wit_15 : main_safety_wit_15.
Axiom proof_of_main_entail_wit_1 : main_entail_wit_1.
Axiom proof_of_main_entail_wit_2 : main_entail_wit_2.
Axiom proof_of_main_entail_wit_3 : main_entail_wit_3.
Axiom proof_of_main_entail_wit_4 : main_entail_wit_4.
Axiom proof_of_main_entail_wit_5 : main_entail_wit_5.
Axiom proof_of_main_entail_wit_6 : main_entail_wit_6.
Axiom proof_of_main_entail_wit_7 : main_entail_wit_7.
Axiom proof_of_main_entail_wit_8 : main_entail_wit_8.
Axiom proof_of_main_entail_wit_9 : main_entail_wit_9.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3_pure : main_partial_solve_wit_3_pure.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
