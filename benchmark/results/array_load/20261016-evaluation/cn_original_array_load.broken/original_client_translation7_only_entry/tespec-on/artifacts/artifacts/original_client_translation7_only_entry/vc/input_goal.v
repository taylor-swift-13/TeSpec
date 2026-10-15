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
  ((( &( "third_spec_447" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (2 * 4)))
  **  ((( &( "two_spec_434" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_2 := 
  ((( &( "third_spec_447" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_434" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_3 := 
  ((( &( "third_spec_447" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_434" ) )) # Int  |-> 2)
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_4 := 
  ((( &( "two_spec_434" ) )) # Int  |->_)
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_5 := 
  ((( &( "two_spec_434" ) )) # Int  |->_)
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_6 := 
  ((( &( "two_spec_434" ) )) # Int  |->_)
  **  ((( &( "second_spec_429" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_7 := 
  ((( &( "second_spec_429" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_8 := 
  ((( &( "second_spec_429" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_416" ) )) # Int  |-> 1)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_9 := 
  ((( &( "one_spec_416" ) )) # Int  |->_)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_10 := 
  ((( &( "one_spec_416" ) )) # Int  |->_)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_11 := 
  ((( &( "one_spec_416" ) )) # Int  |->_)
  **  ((( &( "first_spec_411" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_12 := 
  ((( &( "first_spec_411" ) )) # Ptr  |->_)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_13 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_14 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_15 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_16 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_17 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_safety_wit_18 := 
  TT && emp 
|--
  TT && emp 
.

Definition main_entail_wit_1 := 
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_395" ) ) + (2 * 4))) # Int  |-> 2)
) \/
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_395" ) ) + (2 * 4))) # Int  |-> 2)
).

Definition main_entail_wit_1_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_395" ) ) + (2 * 4))) # Int  |-> 2)
.

Definition main_entail_wit_2 := 
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (two: Z) ,
  “ (two = 2) ”
  &&  emp
) \/
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
).

Definition main_entail_wit_2_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_entail_wit_3 := 
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_395" ) ) + (1 * 4))) # Int  |-> 1)
) \/
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_395" ) ) + (1 * 4))) # Int  |-> 1)
).

Definition main_entail_wit_3_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  (((( &( "a_spec_395" ) ) + (1 * 4))) # Int  |-> 1)
.

Definition main_entail_wit_4 := 
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (one: Z) ,
  “ (one = 1) ”
  &&  emp
) \/
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
).

Definition main_entail_wit_4_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_entail_wit_5 := 
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  ((( &( "a_spec_395" ) )) # Int  |-> 0)
) \/
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  ((( &( "a_spec_395" ) )) # Int  |-> 0)
).

Definition main_entail_wit_5_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  ((( &( "a_spec_395" ) )) # Int  |-> 0)
.

Definition main_entail_wit_6 := 
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (zero: Z) ,
  “ (zero = 0) ”
  &&  emp
) \/
(
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
).

Definition main_entail_wit_6_split_goal_spatial := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_return_wit_1 := 
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

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
Axiom proof_of_main_safety_wit_16 : main_safety_wit_16.
Axiom proof_of_main_safety_wit_17 : main_safety_wit_17.
Axiom proof_of_main_safety_wit_18 : main_safety_wit_18.
Axiom proof_of_main_entail_wit_1 : main_entail_wit_1.
Axiom proof_of_main_entail_wit_2 : main_entail_wit_2.
Axiom proof_of_main_entail_wit_3 : main_entail_wit_3.
Axiom proof_of_main_entail_wit_4 : main_entail_wit_4.
Axiom proof_of_main_entail_wit_5 : main_entail_wit_5.
Axiom proof_of_main_entail_wit_6 : main_entail_wit_6.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
