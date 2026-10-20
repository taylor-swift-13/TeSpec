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
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (retval_3: Z) (two: Z) (third: Z) (zero_2: Z) (first: Z) (one_2: Z) (second_2: Z) (two_2: Z) (PreH1 : (third = (( &( "a_spec_395" ) ) + (2 * 4)))) (PreH2 : (two = 2)) (PreH3 : (retval_3 = 2)) (PreH4 : (second = (( &( "a_spec_395" ) ) + (1 * 4)))) (PreH5 : (one = 1)) (PreH6 : (retval_2 = 1)) (PreH7 : (zero = 0)) (PreH8 : (retval = 0)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |-> third)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  ((( &( "one_spec_419" ) )) # Int  |-> one_2)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> second_2)
  **  ((( &( "two_spec_452" ) )) # Int  |-> two_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_2 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (retval_3: Z) (two: Z) (zero_2: Z) (first: Z) (one_2: Z) (second_2: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (second = (( &( "a_spec_395" ) ) + (1 * 4)))) (PreH4 : (one = 1)) (PreH5 : (retval_2 = 1)) (PreH6 : (zero = 0)) (PreH7 : (retval = 0)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_452" ) )) # Int  |-> 2)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  ((( &( "one_spec_419" ) )) # Int  |-> one_2)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> second_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_3 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (retval_3: Z) (two: Z) (zero_2: Z) (first: Z) (one_2: Z) (second_2: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = 2)) (PreH3 : (second = (( &( "a_spec_395" ) ) + (1 * 4)))) (PreH4 : (one = 1)) (PreH5 : (retval_2 = 1)) (PreH6 : (zero = 0)) (PreH7 : (retval = 0)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_452" ) )) # Int  |-> 2)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  ((( &( "one_spec_419" ) )) # Int  |-> one_2)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> second_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_4 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (zero_2: Z) (first: Z) (one_2: Z) (PreH1 : (second = (( &( "a_spec_395" ) ) + (1 * 4)))) (PreH2 : (one = 1)) (PreH3 : (retval_2 = 1)) (PreH4 : (zero = 0)) (PreH5 : (retval = 0)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> second)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  ((( &( "one_spec_419" ) )) # Int  |-> one_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_5 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (zero_2: Z) (first: Z) (one_2: Z) (PreH1 : (second = (( &( "a_spec_395" ) ) + (1 * 4)))) (PreH2 : (one = 1)) (PreH3 : (retval_2 = 1)) (PreH4 : (zero = 0)) (PreH5 : (retval = 0)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> second)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  ((( &( "one_spec_419" ) )) # Int  |-> one_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_6 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (zero_2: Z) (first: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "second_spec_437" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_7 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (zero_2: Z) (first: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = 1)) (PreH3 : (zero = 0)) (PreH4 : (retval = 0)) ,
  ((( &( "second_spec_437" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_8 := 
forall (retval: Z) (zero: Z) (zero_2: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_9 := 
forall (retval: Z) (zero: Z) (zero_2: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_10 := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = 0)) ,
  ((( &( "first_spec_410" ) )) # Ptr  |->_)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_11 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_12 := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
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
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (retval_3: Z) (two: Z) (PreH1 : (two = 2)) (PreH2 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH4 : (one = 1)) (PreH5 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (zero = 0)) (PreH7 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : ((INT_MIN) <= retval_2)) (PreH11 : (retval_2 <= INT_MAX)) (PreH12 : ((INT_MIN) <= retval_3)) (PreH13 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a_spec_395" ) ) + (2 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (2 * sizeof(INT)))) ” 
  &&  “ (two = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT)))) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_2 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (retval_3: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH3 : (one = 1)) (PreH4 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (zero = 0)) (PreH6 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : ((INT_MIN) <= retval_3)) (PreH12 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval_3 = 2) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT)))) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_3 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (zero = 0)) (PreH4 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a_spec_395" ) ) + (1 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (1 * sizeof(INT)))) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_4 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (zero = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : ((INT_MIN) <= retval_2)) (PreH7 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval_2 = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_5 := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * sizeof(INT))))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_6 := 
forall (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((INT_MIN) <= retval)) (PreH3 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (retval = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_return_wit_1 := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (retval_3: Z) (two: Z) (third: Z) (PreH1 : (third = (( &( "a_spec_395" ) ) + (2 * sizeof(INT))))) (PreH2 : (two = 2)) (PreH3 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH5 : (one = 1)) (PreH6 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : (zero = 0)) (PreH8 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH9 : ((INT_MIN) <= retval)) (PreH10 : (retval <= INT_MAX)) (PreH11 : ((INT_MIN) <= retval_2)) (PreH12 : (retval_2 <= INT_MAX)) (PreH13 : ((INT_MIN) <= retval_3)) (PreH14 : (retval_3 <= INT_MAX)) ,
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (zero_2: Z) (first: Z) (one_2: Z) (PreH1 : (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH2 : (one = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (zero = 0)) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> second)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> first)
  **  ((( &( "one_spec_419" ) )) # Int  |-> one_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition main_partial_solve_wit_1_aux := 
forall (retval: Z) (zero: Z) (retval_2: Z) (one: Z) (second: Z) (PreH1 : (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH2 : (one = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (zero = 0)) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (second = (( &( "a_spec_395" ) ) + (1 * sizeof(INT)))) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
forall (retval: Z) (zero: Z) (zero_2: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> zero_2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition main_partial_solve_wit_2_aux := 
forall (retval: Z) (zero: Z) (PreH1 : (zero = 0)) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ (zero = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Definition main_partial_solve_wit_3_pure := 
  ((( &( "zero_spec_398" ) )) # Int  |->_)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition main_partial_solve_wit_3_aux := 
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
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
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3_pure : main_partial_solve_wit_3_pure.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
