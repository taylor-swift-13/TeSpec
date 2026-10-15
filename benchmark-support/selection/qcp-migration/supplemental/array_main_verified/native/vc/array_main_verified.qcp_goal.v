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

(*----- Function read -----*)

Definition read_return_wit_1 := 
forall (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) ,
  (IntArray.full p_pre n_pre l )
|--
  “ ((Znth i_pre l 0) = (Znth (i_pre) (l) (0))) ”
  &&  (IntArray.full p_pre n_pre l )
.

Definition read_partial_solve_wit_1 := 
forall (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) ,
  (IntArray.full p_pre n_pre l )
|--
  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ”
  &&  (((p_pre + (i_pre * sizeof(INT)))) # Int  |-> (Znth i_pre l 0))
  **  (IntArray.missing_i p_pre i_pre 0 n_pre l )
.

(*----- Function main -----*)

Definition main_safety_wit_1 := 
  TT && emp 
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition main_safety_wit_2 := 
  TT && emp 
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition main_safety_wit_3 := 
  TT && emp 
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_safety_wit_4 := 
  ((( &( "zero" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition main_safety_wit_5 := 
  ((( &( "zero" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_safety_wit_6 := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  ((( &( "first" ) )) # Ptr  |->_)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_safety_wit_7 := 
forall (zero: Z) ,
  ((( &( "one" ) )) # Int  |->_)
  **  ((( &( "first" ) )) # Ptr  |-> ( &( "a" ) ))
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition main_safety_wit_8 := 
forall (zero: Z) ,
  ((( &( "one" ) )) # Int  |->_)
  **  ((( &( "first" ) )) # Ptr  |-> ( &( "a" ) ))
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition main_safety_wit_9 := 
forall (one: Z) (zero: Z) (first: Z) (PreH1 : (one = 1)) ,
  ((( &( "second" ) )) # Ptr  |->_)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_safety_wit_10 := 
forall (one: Z) (zero: Z) (first: Z) (PreH1 : (one = 1)) ,
  ((( &( "second" ) )) # Ptr  |->_)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition main_safety_wit_11 := 
forall (second: Z) (zero: Z) (first: Z) (one: Z) (PreH1 : (second = (( &( "a" ) ) + (1 * sizeof(INT))))) ,
  ((( &( "two" ) )) # Int  |->_)
  **  ((( &( "second" ) )) # Ptr  |-> second)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition main_safety_wit_12 := 
forall (second: Z) (zero: Z) (first: Z) (one: Z) (PreH1 : (second = (( &( "a" ) ) + (1 * sizeof(INT))))) ,
  ((( &( "two" ) )) # Int  |->_)
  **  ((( &( "second" ) )) # Ptr  |-> second)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition main_safety_wit_13 := 
forall (two: Z) (zero: Z) (first: Z) (one: Z) (second: Z) (PreH1 : (two = 2)) ,
  ((( &( "third" ) )) # Ptr  |->_)
  **  ((( &( "two" ) )) # Int  |-> two)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_safety_wit_14 := 
forall (two: Z) (zero: Z) (first: Z) (one: Z) (second: Z) (PreH1 : (two = 2)) ,
  ((( &( "third" ) )) # Ptr  |->_)
  **  ((( &( "two" ) )) # Int  |-> two)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition main_safety_wit_15 := 
forall (third: Z) (zero: Z) (first: Z) (one: Z) (second: Z) (two: Z) (PreH1 : (third = (( &( "a" ) ) + (2 * sizeof(INT))))) ,
  ((( &( "third" ) )) # Ptr  |-> third)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  ((( &( "second" ) )) # Ptr  |-> second)
  **  ((( &( "two" ) )) # Int  |-> two)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_entail_wit_1 := 
(
forall (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) ,
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 0) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) ,
  TT && emp 
|--
  “ (retval = 0) ”
  &&  emp
).

Definition main_entail_wit_1_split_goal_1 := 
forall (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) ,
  (retval = 0)
.

Definition main_entail_wit_2 := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  ((( &( "first" ) )) # Ptr  |-> (( &( "a" ) ) + (0 * sizeof(INT))))
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  ((( &( "first" ) )) # Ptr  |-> ( &( "a" ) ))
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_3 := 
(
forall (retval: Z) (PreH1 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) ,
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 1) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (retval: Z) (PreH1 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) ,
  TT && emp 
|--
  “ (retval = 1) ”
  &&  emp
).

Definition main_entail_wit_3_split_goal_1 := 
forall (retval: Z) (PreH1 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) ,
  (retval = 1)
.

Definition main_entail_wit_4 := 
forall (one: Z) (PreH1 : (one = 1)) ,
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a" ) ) + (1 * sizeof(INT))) = (( &( "a" ) ) + (1 * sizeof(INT)))) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_5 := 
(
forall (second: Z) (retval: Z) (PreH1 : (retval = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (second = (( &( "a" ) ) + (1 * sizeof(INT))))) ,
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 2) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
) \/
(
forall (second: Z) (retval: Z) (PreH1 : (retval = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (second = (( &( "a" ) ) + (1 * sizeof(INT))))) ,
  TT && emp 
|--
  “ (retval = 2) ”
  &&  emp
).

Definition main_entail_wit_5_split_goal_1 := 
forall (second: Z) (retval: Z) (PreH1 : (retval = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (second = (( &( "a" ) ) + (1 * sizeof(INT))))) ,
  (retval = 2)
.

Definition main_entail_wit_6 := 
forall (two: Z) (PreH1 : (two = 2)) ,
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a" ) ) + (2 * sizeof(INT))) = (( &( "a" ) ) + (2 * sizeof(INT)))) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_return_wit_1 := 
forall (third: Z) (PreH1 : (third = (( &( "a" ) ) + (2 * sizeof(INT))))) ,
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
  ((( &( "zero" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition main_partial_solve_wit_1_aux := 
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
forall (zero: Z) ,
  ((( &( "one" ) )) # Int  |->_)
  **  ((( &( "first" ) )) # Ptr  |-> ( &( "a" ) ))
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition main_partial_solve_wit_2_aux := 
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Definition main_partial_solve_wit_3_pure := 
forall (second: Z) (zero: Z) (first: Z) (one: Z) (PreH1 : (second = (( &( "a" ) ) + (1 * sizeof(INT))))) ,
  ((( &( "two" ) )) # Int  |->_)
  **  ((( &( "second" ) )) # Ptr  |-> second)
  **  ((( &( "zero" ) )) # Int  |-> zero)
  **  ((( &( "first" ) )) # Ptr  |-> first)
  **  ((( &( "one" ) )) # Int  |-> one)
  **  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition main_partial_solve_wit_3_aux := 
forall (second: Z) (PreH1 : (second = (( &( "a" ) ) + (1 * sizeof(INT))))) ,
  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (second = (( &( "a" ) ) + (1 * sizeof(INT)))) ”
  &&  (IntArray.full ( &( "a" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_3 := main_partial_solve_wit_3_pure -> main_partial_solve_wit_3_aux.

Module Type VC_Correct.

Axiom proof_of_read_return_wit_1 : read_return_wit_1.
Axiom proof_of_read_partial_solve_wit_1 : read_partial_solve_wit_1.
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
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3_pure : main_partial_solve_wit_3_pure.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.

End VC_Correct.
