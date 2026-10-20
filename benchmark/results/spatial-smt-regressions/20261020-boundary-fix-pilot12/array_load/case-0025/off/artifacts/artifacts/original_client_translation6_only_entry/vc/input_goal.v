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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (PreH1 : (should_be_equal (( &( "a_spec_395" ) ) + (2 * 4)) (( &( "a_spec_395" ) ) + (2 * 4)) )) (PreH2 : (should_be_equal 2 2 )) (PreH3 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) modular_frame_value_10 )) (PreH4 : (should_be_equal 1 modular_frame_value_9 )) (PreH5 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_8 )) (PreH6 : (should_be_equal 0 modular_frame_value_7 )) (PreH7 : (should_be_equal 2 modular_frame_value_11 )) (PreH8 : (should_be_equal (( &( "a_spec_395" ) ) + (2 * 4)) modular_frame_value_6 )) (PreH9 : (should_be_equal 2 2 )) (PreH10 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) (( &( "a_spec_395" ) ) + (1 * 4)) )) (PreH11 : (should_be_equal 0 0 )) (PreH12 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH13 : (should_be_equal 1 1 )) (PreH14 : (should_be_equal 1 modular_frame_value_4 )) (PreH15 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH16 : (should_be_equal 0 modular_frame_value_2 )) (PreH17 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) modular_frame_value_5 )) (PreH18 : (should_be_equal 2 modular_frame_value )) (PreH19 : (retval_3 = 2)) (PreH20 : (retval_2 = 1)) (PreH21 : (retval = 0)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (2 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "two_spec_452" ) )) # Int  |-> 2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (should_be_equal 2 2 )) (PreH2 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) (( &( "a_spec_395" ) ) + (1 * 4)) )) (PreH3 : (should_be_equal 0 0 )) (PreH4 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH5 : (should_be_equal 1 1 )) (PreH6 : (should_be_equal 1 modular_frame_value_4 )) (PreH7 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH8 : (should_be_equal 0 modular_frame_value_2 )) (PreH9 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) modular_frame_value_5 )) (PreH10 : (should_be_equal 2 modular_frame_value )) (PreH11 : (retval_3 = 2)) (PreH12 : (retval_2 = 1)) (PreH13 : (retval = 0)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_452" ) )) # Int  |-> 2)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_3 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (should_be_equal 2 2 )) (PreH2 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) (( &( "a_spec_395" ) ) + (1 * 4)) )) (PreH3 : (should_be_equal 0 0 )) (PreH4 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH5 : (should_be_equal 1 1 )) (PreH6 : (should_be_equal 1 modular_frame_value_4 )) (PreH7 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH8 : (should_be_equal 0 modular_frame_value_2 )) (PreH9 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) modular_frame_value_5 )) (PreH10 : (should_be_equal 2 modular_frame_value )) (PreH11 : (retval_3 = 2)) (PreH12 : (retval_2 = 1)) (PreH13 : (retval = 0)) ,
  ((( &( "third_spec_476" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_452" ) )) # Int  |-> 2)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_4 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (PreH1 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) (( &( "a_spec_395" ) ) + (1 * 4)) )) (PreH2 : (should_be_equal 1 1 )) (PreH3 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_6 )) (PreH4 : (should_be_equal 0 modular_frame_value_5 )) (PreH5 : (should_be_equal 1 modular_frame_value_7 )) (PreH6 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) modular_frame_value_4 )) (PreH7 : (should_be_equal 1 1 )) (PreH8 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH9 : (should_be_equal 0 0 )) (PreH10 : (should_be_equal 0 modular_frame_value_2 )) (PreH11 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH12 : (should_be_equal 1 modular_frame_value )) (PreH13 : (retval_2 = 1)) (PreH14 : (retval = 0)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_5 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (PreH1 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) (( &( "a_spec_395" ) ) + (1 * 4)) )) (PreH2 : (should_be_equal 1 1 )) (PreH3 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_6 )) (PreH4 : (should_be_equal 0 modular_frame_value_5 )) (PreH5 : (should_be_equal 1 modular_frame_value_7 )) (PreH6 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * 4)) modular_frame_value_4 )) (PreH7 : (should_be_equal 1 1 )) (PreH8 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH9 : (should_be_equal 0 0 )) (PreH10 : (should_be_equal 0 modular_frame_value_2 )) (PreH11 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH12 : (should_be_equal 1 modular_frame_value )) (PreH13 : (retval_2 = 1)) (PreH14 : (retval = 0)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * 4)))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_6 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (should_be_equal 1 1 )) (PreH2 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH3 : (should_be_equal 0 0 )) (PreH4 : (should_be_equal 0 modular_frame_value_2 )) (PreH5 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH6 : (should_be_equal 1 modular_frame_value )) (PreH7 : (retval_2 = 1)) (PreH8 : (retval = 0)) ,
  ((( &( "second_spec_437" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_7 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (should_be_equal 1 1 )) (PreH2 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH3 : (should_be_equal 0 0 )) (PreH4 : (should_be_equal 0 modular_frame_value_2 )) (PreH5 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH6 : (should_be_equal 1 modular_frame_value )) (PreH7 : (retval_2 = 1)) (PreH8 : (retval = 0)) ,
  ((( &( "second_spec_437" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_8 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * 4)) (( &( "a_spec_395" ) ) + (0 * 4)) )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 0 modular_frame_value_3 )) (PreH4 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * 4)) modular_frame_value_2 )) (PreH5 : (should_be_equal 0 0 )) (PreH6 : (should_be_equal 0 modular_frame_value )) (PreH7 : (retval = 0)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_9 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * 4)) (( &( "a_spec_395" ) ) + (0 * 4)) )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 0 modular_frame_value_3 )) (PreH4 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * 4)) modular_frame_value_2 )) (PreH5 : (should_be_equal 0 0 )) (PreH6 : (should_be_equal 0 modular_frame_value )) (PreH7 : (retval = 0)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition main_safety_wit_10 := 
forall (retval: Z) (modular_frame_value: Z) (PreH1 : (should_be_equal 0 0 )) (PreH2 : (should_be_equal 0 modular_frame_value )) (PreH3 : (retval = 0)) ,
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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (PreH1 : (2 = 2)) (PreH2 : (should_be_equal retval_3 retval_3 )) (PreH3 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) )) (PreH4 : (should_be_equal 0 0 )) (PreH5 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH6 : (should_be_equal 1 1 )) (PreH7 : (should_be_equal 1 modular_frame_value_4 )) (PreH8 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH9 : (should_be_equal 0 modular_frame_value_2 )) (PreH10 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_5 )) (PreH11 : (should_be_equal retval_3 modular_frame_value )) (PreH12 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH13 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH14 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH15 : ((INT_MIN) <= retval)) (PreH16 : (retval <= INT_MAX)) (PreH17 : ((INT_MIN) <= retval_2)) (PreH18 : (retval_2 <= INT_MAX)) (PreH19 : ((INT_MIN) <= retval_3)) (PreH20 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a_spec_395" ) ) + (2 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (2 * sizeof(INT)))) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (2 * sizeof(INT))) (( &( "a_spec_395" ) ) + (2 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 2 2 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_10 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_9 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_8 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_7 ) ” 
  &&  “ (should_be_equal 2 modular_frame_value_11 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (2 * sizeof(INT))) modular_frame_value_6 ) ” 
  &&  “ (should_be_equal retval_3 retval_3 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_2 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_5 ) ” 
  &&  “ (should_be_equal retval_3 modular_frame_value ) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : ((INT_MIN) <= retval_2)) (PreH7 : (retval_2 <= INT_MAX)) (PreH8 : ((INT_MIN) <= retval_3)) (PreH9 : (retval_3 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "two_spec_452" ) )) # Int  |-> retval_3)
|--
  “ (2 = 2) ” 
  &&  “ (should_be_equal retval_3 retval_3 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_2 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_5 ) ” 
  &&  “ (should_be_equal retval_3 modular_frame_value ) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  ((( &( "two_spec_452" ) )) # Int  |-> 2)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_3 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (PreH1 : (1 = 1)) (PreH2 : (should_be_equal retval_2 retval_2 )) (PreH3 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH4 : (should_be_equal 0 0 )) (PreH5 : (should_be_equal 0 modular_frame_value_2 )) (PreH6 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH7 : (should_be_equal retval_2 modular_frame_value )) (PreH8 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH9 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH10 : ((INT_MIN) <= retval)) (PreH11 : (retval <= INT_MAX)) (PreH12 : ((INT_MIN) <= retval_2)) (PreH13 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((( &( "a_spec_395" ) ) + (1 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (1 * sizeof(INT)))) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_6 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_5 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_7 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_4 ) ” 
  &&  “ (should_be_equal retval_2 retval_2 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_2 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 ) ” 
  &&  “ (should_be_equal retval_2 modular_frame_value ) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_4 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) (PreH5 : ((INT_MIN) <= retval_2)) (PreH6 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "one_spec_419" ) )) # Int  |-> retval_2)
|--
  “ (1 = 1) ” 
  &&  “ (should_be_equal retval_2 retval_2 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_2 ) ” 
  &&  “ (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 ) ” 
  &&  “ (should_be_equal retval_2 modular_frame_value ) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_5 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (0 = 0)) (PreH2 : (should_be_equal retval retval )) (PreH3 : (should_be_equal retval modular_frame_value )) (PreH4 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  ((( &( "first_spec_410" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (0 * sizeof(INT))))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (should_be_equal (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) modular_frame_value_2 ) ” 
  &&  “ (should_be_equal retval retval ) ” 
  &&  “ (should_be_equal retval modular_frame_value ) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_entail_wit_6 := 
forall (retval: Z) (modular_frame_value: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((INT_MIN) <= retval)) (PreH3 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_398" ) )) # Int  |-> retval)
|--
  “ (0 = 0) ” 
  &&  “ (should_be_equal retval retval ) ” 
  &&  “ (should_be_equal retval modular_frame_value ) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_return_wit_1 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (PreH1 : ((( &( "a_spec_395" ) ) + (2 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (2 * sizeof(INT))))) (PreH2 : (should_be_equal (( &( "a_spec_395" ) ) + (2 * sizeof(INT))) (( &( "a_spec_395" ) ) + (2 * sizeof(INT))) )) (PreH3 : (should_be_equal 2 2 )) (PreH4 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_10 )) (PreH5 : (should_be_equal 1 modular_frame_value_9 )) (PreH6 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_8 )) (PreH7 : (should_be_equal 0 modular_frame_value_7 )) (PreH8 : (should_be_equal 2 modular_frame_value_11 )) (PreH9 : (should_be_equal (( &( "a_spec_395" ) ) + (2 * sizeof(INT))) modular_frame_value_6 )) (PreH10 : (should_be_equal retval_3 retval_3 )) (PreH11 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) )) (PreH12 : (should_be_equal 0 0 )) (PreH13 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH14 : (should_be_equal 1 1 )) (PreH15 : (should_be_equal 1 modular_frame_value_4 )) (PreH16 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH17 : (should_be_equal 0 modular_frame_value_2 )) (PreH18 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_5 )) (PreH19 : (should_be_equal retval_3 modular_frame_value )) (PreH20 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH21 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH22 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH23 : ((INT_MIN) <= retval)) (PreH24 : (retval <= INT_MAX)) (PreH25 : ((INT_MIN) <= retval_2)) (PreH26 : (retval_2 <= INT_MAX)) (PreH27 : ((INT_MIN) <= retval_3)) (PreH28 : (retval_3 <= INT_MAX)) ,
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (PreH1 : ((( &( "a_spec_395" ) ) + (1 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH2 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) )) (PreH3 : (should_be_equal 1 1 )) (PreH4 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_6 )) (PreH5 : (should_be_equal 0 modular_frame_value_5 )) (PreH6 : (should_be_equal 1 modular_frame_value_7 )) (PreH7 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_4 )) (PreH8 : (should_be_equal retval_2 retval_2 )) (PreH9 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH10 : (should_be_equal 0 0 )) (PreH11 : (should_be_equal 0 modular_frame_value_2 )) (PreH12 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH13 : (should_be_equal retval_2 modular_frame_value )) (PreH14 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH15 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH16 : ((INT_MIN) <= retval)) (PreH17 : (retval <= INT_MAX)) (PreH18 : ((INT_MIN) <= retval_2)) (PreH19 : (retval_2 <= INT_MAX)) ,
  ((( &( "two_spec_452" ) )) # Int  |->_)
  **  ((( &( "second_spec_437" ) )) # Ptr  |-> (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "one_spec_419" ) )) # Int  |-> 1)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition main_partial_solve_wit_1_aux := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (PreH1 : ((( &( "a_spec_395" ) ) + (1 * sizeof(INT))) = (( &( "a_spec_395" ) ) + (1 * sizeof(INT))))) (PreH2 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) )) (PreH3 : (should_be_equal 1 1 )) (PreH4 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_6 )) (PreH5 : (should_be_equal 0 modular_frame_value_5 )) (PreH6 : (should_be_equal 1 modular_frame_value_7 )) (PreH7 : (should_be_equal (( &( "a_spec_395" ) ) + (1 * sizeof(INT))) modular_frame_value_4 )) (PreH8 : (should_be_equal retval_2 retval_2 )) (PreH9 : (should_be_equal ( &( "a_spec_395" ) ) ( &( "a_spec_395" ) ) )) (PreH10 : (should_be_equal 0 0 )) (PreH11 : (should_be_equal 0 modular_frame_value_2 )) (PreH12 : (should_be_equal ( &( "a_spec_395" ) ) modular_frame_value_3 )) (PreH13 : (should_be_equal retval_2 modular_frame_value )) (PreH14 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH15 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH16 : ((INT_MIN) <= retval)) (PreH17 : (retval <= INT_MAX)) (PreH18 : ((INT_MIN) <= retval_2)) (PreH19 : (retval_2 <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 0 modular_frame_value_3 )) (PreH4 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) modular_frame_value_2 )) (PreH5 : (should_be_equal retval retval )) (PreH6 : (should_be_equal retval modular_frame_value )) (PreH7 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) ,
  ((( &( "one_spec_419" ) )) # Int  |->_)
  **  ((( &( "first_spec_410" ) )) # Ptr  |-> ( &( "a_spec_395" ) ))
  **  ((( &( "zero_spec_398" ) )) # Int  |-> 0)
  **  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition main_partial_solve_wit_2_aux := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (PreH1 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 0 modular_frame_value_3 )) (PreH4 : (should_be_equal (( &( "a_spec_395" ) ) + (0 * sizeof(INT))) modular_frame_value_2 )) (PreH5 : (should_be_equal retval retval )) (PreH6 : (should_be_equal retval modular_frame_value )) (PreH7 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) ,
  (IntArray.full ( &( "a_spec_395" ) ) 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
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
