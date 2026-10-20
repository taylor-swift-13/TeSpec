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

(*----- Function verify_main -----*)

Definition verify_main_safety_wit_1 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (modular_frame_value_12: Z) (modular_frame_value_13: Z) (PreH1 : (should_be_equal 4104 4104 )) (PreH2 : (should_be_equal 2 2 )) (PreH3 : (should_be_equal 4100 modular_frame_value_11 )) (PreH4 : (should_be_equal 1 modular_frame_value_10 )) (PreH5 : (should_be_equal 4096 modular_frame_value_9 )) (PreH6 : (should_be_equal 0 modular_frame_value_8 )) (PreH7 : (should_be_equal 4096 modular_frame_value_7 )) (PreH8 : (should_be_equal 2 modular_frame_value_12 )) (PreH9 : (should_be_equal 4104 modular_frame_value_13 )) (PreH10 : (should_be_equal 2 2 )) (PreH11 : (should_be_equal 0 0 )) (PreH12 : (should_be_equal 4096 4096 )) (PreH13 : (should_be_equal 1 1 )) (PreH14 : (should_be_equal 4100 4100 )) (PreH15 : (should_be_equal 4100 modular_frame_value_6 )) (PreH16 : (should_be_equal 1 modular_frame_value_5 )) (PreH17 : (should_be_equal 4096 modular_frame_value_4 )) (PreH18 : (should_be_equal 0 modular_frame_value_3 )) (PreH19 : (should_be_equal 4096 modular_frame_value_2 )) (PreH20 : (should_be_equal 2 modular_frame_value )) (PreH21 : (retval_3 = 2)) (PreH22 : (retval_2 = 1)) (PreH23 : (retval = 0)) ,
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> 4100)
  **  ((( &( "two_spec_465" ) )) # Int  |-> 2)
  **  ((( &( "third_spec_492" ) )) # Ptr  |-> 4104)
|--
  TT && emp 
.

Definition verify_main_safety_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (PreH1 : (should_be_equal 2 2 )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 4096 4096 )) (PreH4 : (should_be_equal 1 1 )) (PreH5 : (should_be_equal 4100 4100 )) (PreH6 : (should_be_equal 4100 modular_frame_value_6 )) (PreH7 : (should_be_equal 1 modular_frame_value_5 )) (PreH8 : (should_be_equal 4096 modular_frame_value_4 )) (PreH9 : (should_be_equal 0 modular_frame_value_3 )) (PreH10 : (should_be_equal 4096 modular_frame_value_2 )) (PreH11 : (should_be_equal 2 modular_frame_value )) (PreH12 : (retval_3 = 2)) (PreH13 : (retval_2 = 1)) (PreH14 : (retval = 0)) ,
  ((( &( "third_spec_492" ) )) # Ptr  |->_)
  **  ((( &( "two_spec_465" ) )) # Int  |-> 2)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_3 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : (should_be_equal 4100 4100 )) (PreH2 : (should_be_equal 1 1 )) (PreH3 : (should_be_equal 4096 modular_frame_value_7 )) (PreH4 : (should_be_equal 0 modular_frame_value_6 )) (PreH5 : (should_be_equal 4096 modular_frame_value_5 )) (PreH6 : (should_be_equal 1 modular_frame_value_8 )) (PreH7 : (should_be_equal 4100 modular_frame_value_9 )) (PreH8 : (should_be_equal 1 1 )) (PreH9 : (should_be_equal 0 0 )) (PreH10 : (should_be_equal 4096 4096 )) (PreH11 : (should_be_equal 4096 modular_frame_value_4 )) (PreH12 : (should_be_equal 0 modular_frame_value_3 )) (PreH13 : (should_be_equal 4096 modular_frame_value_2 )) (PreH14 : (should_be_equal 1 modular_frame_value )) (PreH15 : (retval_2 = 1)) (PreH16 : (retval = 0)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_4 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : (should_be_equal 4100 4100 )) (PreH2 : (should_be_equal 1 1 )) (PreH3 : (should_be_equal 4096 modular_frame_value_7 )) (PreH4 : (should_be_equal 0 modular_frame_value_6 )) (PreH5 : (should_be_equal 4096 modular_frame_value_5 )) (PreH6 : (should_be_equal 1 modular_frame_value_8 )) (PreH7 : (should_be_equal 4100 modular_frame_value_9 )) (PreH8 : (should_be_equal 1 1 )) (PreH9 : (should_be_equal 0 0 )) (PreH10 : (should_be_equal 4096 4096 )) (PreH11 : (should_be_equal 4096 modular_frame_value_4 )) (PreH12 : (should_be_equal 0 modular_frame_value_3 )) (PreH13 : (should_be_equal 4096 modular_frame_value_2 )) (PreH14 : (should_be_equal 1 modular_frame_value )) (PreH15 : (retval_2 = 1)) (PreH16 : (retval = 0)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_5 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (PreH1 : (should_be_equal 1 1 )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 4096 4096 )) (PreH4 : (should_be_equal 4096 modular_frame_value_4 )) (PreH5 : (should_be_equal 0 modular_frame_value_3 )) (PreH6 : (should_be_equal 4096 modular_frame_value_2 )) (PreH7 : (should_be_equal 1 modular_frame_value )) (PreH8 : (retval_2 = 1)) (PreH9 : (retval = 0)) ,
  ((( &( "second_spec_447" ) )) # Ptr  |->_)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_6 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (should_be_equal 0 0 )) (PreH2 : (should_be_equal 4096 modular_frame_value_3 )) (PreH3 : (should_be_equal 0 modular_frame_value_4 )) (PreH4 : (should_be_equal 4096 modular_frame_value_5 )) (PreH5 : (should_be_equal 0 0 )) (PreH6 : (should_be_equal 4096 4096 )) (PreH7 : (should_be_equal 4096 modular_frame_value_2 )) (PreH8 : (should_be_equal 0 modular_frame_value )) (PreH9 : (retval = 0)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_7 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (should_be_equal 0 0 )) (PreH2 : (should_be_equal 4096 modular_frame_value_3 )) (PreH3 : (should_be_equal 0 modular_frame_value_4 )) (PreH4 : (should_be_equal 4096 modular_frame_value_5 )) (PreH5 : (should_be_equal 0 0 )) (PreH6 : (should_be_equal 4096 4096 )) (PreH7 : (should_be_equal 4096 modular_frame_value_2 )) (PreH8 : (should_be_equal 0 modular_frame_value )) (PreH9 : (retval = 0)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_8 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_9 := 
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_entail_wit_1 := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (modular_frame_value_12: Z) (modular_frame_value_13: Z) (PreH1 : (2 = 2)) (PreH2 : (should_be_equal retval_3 retval_3 )) (PreH3 : (should_be_equal 0 0 )) (PreH4 : (should_be_equal a_pre a_pre )) (PreH5 : (should_be_equal 1 1 )) (PreH6 : (should_be_equal (a_pre + (1 * sizeof(INT))) (a_pre + (1 * sizeof(INT))) )) (PreH7 : (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_6 )) (PreH8 : (should_be_equal 1 modular_frame_value_5 )) (PreH9 : (should_be_equal a_pre modular_frame_value_4 )) (PreH10 : (should_be_equal 0 modular_frame_value_3 )) (PreH11 : (should_be_equal a_pre modular_frame_value_2 )) (PreH12 : (should_be_equal retval_3 modular_frame_value )) (PreH13 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH14 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH15 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH16 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH17 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH18 : (a_pre = 4096)) (PreH19 : ((INT_MIN) <= retval)) (PreH20 : (retval <= INT_MAX)) (PreH21 : ((INT_MIN) <= retval_2)) (PreH22 : (retval_2 <= INT_MAX)) (PreH23 : ((INT_MIN) <= retval_3)) (PreH24 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2) ” 
  &&  “ (should_be_equal (a_pre + (2 * sizeof(INT))) (a_pre + (2 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 2 2 ) ” 
  &&  “ (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_11 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_10 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_9 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_8 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_7 ) ” 
  &&  “ (should_be_equal 2 modular_frame_value_12 ) ” 
  &&  “ (should_be_equal (a_pre + (2 * sizeof(INT))) modular_frame_value_13 ) ” 
  &&  “ (should_be_equal retval_3 retval_3 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal a_pre a_pre ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal (a_pre + (1 * sizeof(INT))) (a_pre + (1 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_6 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_5 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_2 ) ” 
  &&  “ (should_be_equal retval_3 modular_frame_value ) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_2 := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH3 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH5 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (a_pre = 4096)) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : ((INT_MIN) <= retval_3)) (PreH12 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "two_spec_465" ) )) # Int  |-> retval_3)
|--
  “ (2 = 2) ” 
  &&  “ (should_be_equal retval_3 retval_3 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal a_pre a_pre ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal (a_pre + (1 * sizeof(INT))) (a_pre + (1 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_6 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_5 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_2 ) ” 
  &&  “ (should_be_equal retval_3 modular_frame_value ) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  ((( &( "two_spec_465" ) )) # Int  |-> 2)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_3 := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : (1 = 1)) (PreH2 : (should_be_equal retval_2 retval_2 )) (PreH3 : (should_be_equal 0 0 )) (PreH4 : (should_be_equal a_pre a_pre )) (PreH5 : (should_be_equal a_pre modular_frame_value_4 )) (PreH6 : (should_be_equal 0 modular_frame_value_3 )) (PreH7 : (should_be_equal a_pre modular_frame_value_2 )) (PreH8 : (should_be_equal retval_2 modular_frame_value )) (PreH9 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH10 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH11 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH12 : (a_pre = 4096)) (PreH13 : ((INT_MIN) <= retval)) (PreH14 : (retval <= INT_MAX)) (PreH15 : ((INT_MIN) <= retval_2)) (PreH16 : (retval_2 <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (should_be_equal (a_pre + (1 * sizeof(INT))) (a_pre + (1 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_7 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_6 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_5 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_8 ) ” 
  &&  “ (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_9 ) ” 
  &&  “ (should_be_equal retval_2 retval_2 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal a_pre a_pre ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_2 ) ” 
  &&  “ (should_be_equal retval_2 modular_frame_value ) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_4 := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (a_pre = 4096)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) (PreH7 : ((INT_MIN) <= retval_2)) (PreH8 : (retval_2 <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "one_spec_426" ) )) # Int  |-> retval_2)
|--
  “ (1 = 1) ” 
  &&  “ (should_be_equal retval_2 retval_2 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal a_pre a_pre ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_2 ) ” 
  &&  “ (should_be_equal retval_2 modular_frame_value ) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_5 := 
forall (a_pre: Z) (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (0 = 0)) (PreH2 : (should_be_equal retval retval )) (PreH3 : (should_be_equal a_pre a_pre )) (PreH4 : (should_be_equal a_pre modular_frame_value_2 )) (PreH5 : (should_be_equal retval modular_frame_value )) (PreH6 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : (a_pre = 4096)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_5 ) ” 
  &&  “ (should_be_equal retval retval ) ” 
  &&  “ (should_be_equal a_pre a_pre ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_2 ) ” 
  &&  “ (should_be_equal retval modular_frame_value ) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_6 := 
forall (a_pre: Z) (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = 4096)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> retval)
|--
  “ (0 = 0) ” 
  &&  “ (should_be_equal retval retval ) ” 
  &&  “ (should_be_equal a_pre a_pre ) ” 
  &&  “ (should_be_equal a_pre modular_frame_value_2 ) ” 
  &&  “ (should_be_equal retval modular_frame_value ) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_return_wit_1 := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (modular_frame_value_12: Z) (modular_frame_value_13: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (should_be_equal (a_pre + (2 * sizeof(INT))) (a_pre + (2 * sizeof(INT))) )) (PreH3 : (should_be_equal 2 2 )) (PreH4 : (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_11 )) (PreH5 : (should_be_equal 1 modular_frame_value_10 )) (PreH6 : (should_be_equal a_pre modular_frame_value_9 )) (PreH7 : (should_be_equal 0 modular_frame_value_8 )) (PreH8 : (should_be_equal a_pre modular_frame_value_7 )) (PreH9 : (should_be_equal 2 modular_frame_value_12 )) (PreH10 : (should_be_equal (a_pre + (2 * sizeof(INT))) modular_frame_value_13 )) (PreH11 : (should_be_equal retval_3 retval_3 )) (PreH12 : (should_be_equal 0 0 )) (PreH13 : (should_be_equal a_pre a_pre )) (PreH14 : (should_be_equal 1 1 )) (PreH15 : (should_be_equal (a_pre + (1 * sizeof(INT))) (a_pre + (1 * sizeof(INT))) )) (PreH16 : (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_6 )) (PreH17 : (should_be_equal 1 modular_frame_value_5 )) (PreH18 : (should_be_equal a_pre modular_frame_value_4 )) (PreH19 : (should_be_equal 0 modular_frame_value_3 )) (PreH20 : (should_be_equal a_pre modular_frame_value_2 )) (PreH21 : (should_be_equal retval_3 modular_frame_value )) (PreH22 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH23 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH24 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH25 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH26 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH27 : (a_pre = 4096)) (PreH28 : ((INT_MIN) <= retval)) (PreH29 : (retval <= INT_MAX)) (PreH30 : ((INT_MIN) <= retval_2)) (PreH31 : (retval_2 <= INT_MAX)) (PreH32 : ((INT_MIN) <= retval_3)) (PreH33 : (retval_3 <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1_pure := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (should_be_equal (a_pre + (1 * sizeof(INT))) (a_pre + (1 * sizeof(INT))) )) (PreH3 : (should_be_equal 1 1 )) (PreH4 : (should_be_equal a_pre modular_frame_value_7 )) (PreH5 : (should_be_equal 0 modular_frame_value_6 )) (PreH6 : (should_be_equal a_pre modular_frame_value_5 )) (PreH7 : (should_be_equal 1 modular_frame_value_8 )) (PreH8 : (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_9 )) (PreH9 : (should_be_equal retval_2 retval_2 )) (PreH10 : (should_be_equal 0 0 )) (PreH11 : (should_be_equal a_pre a_pre )) (PreH12 : (should_be_equal a_pre modular_frame_value_4 )) (PreH13 : (should_be_equal 0 modular_frame_value_3 )) (PreH14 : (should_be_equal a_pre modular_frame_value_2 )) (PreH15 : (should_be_equal retval_2 modular_frame_value )) (PreH16 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH17 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH18 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH19 : (a_pre = 4096)) (PreH20 : ((INT_MIN) <= retval)) (PreH21 : (retval <= INT_MAX)) (PreH22 : ((INT_MIN) <= retval_2)) (PreH23 : (retval_2 <= INT_MAX)) ,
  ((( &( "two_spec_465" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> a_pre)
  **  ((( &( "one_spec_426" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_447" ) )) # Ptr  |-> (a_pre + (1 * sizeof(INT))))
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition verify_main_partial_solve_wit_1_aux := 
forall (a_pre: Z) (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (should_be_equal (a_pre + (1 * sizeof(INT))) (a_pre + (1 * sizeof(INT))) )) (PreH3 : (should_be_equal 1 1 )) (PreH4 : (should_be_equal a_pre modular_frame_value_7 )) (PreH5 : (should_be_equal 0 modular_frame_value_6 )) (PreH6 : (should_be_equal a_pre modular_frame_value_5 )) (PreH7 : (should_be_equal 1 modular_frame_value_8 )) (PreH8 : (should_be_equal (a_pre + (1 * sizeof(INT))) modular_frame_value_9 )) (PreH9 : (should_be_equal retval_2 retval_2 )) (PreH10 : (should_be_equal 0 0 )) (PreH11 : (should_be_equal a_pre a_pre )) (PreH12 : (should_be_equal a_pre modular_frame_value_4 )) (PreH13 : (should_be_equal 0 modular_frame_value_3 )) (PreH14 : (should_be_equal a_pre modular_frame_value_2 )) (PreH15 : (should_be_equal retval_2 modular_frame_value )) (PreH16 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH17 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH18 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH19 : (a_pre = 4096)) (PreH20 : ((INT_MIN) <= retval)) (PreH21 : (retval <= INT_MAX)) (PreH22 : ((INT_MIN) <= retval_2)) (PreH23 : (retval_2 <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1 := verify_main_partial_solve_wit_1_pure -> verify_main_partial_solve_wit_1_aux.

Definition verify_main_partial_solve_wit_2_pure := 
forall (a_pre: Z) (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal a_pre modular_frame_value_3 )) (PreH4 : (should_be_equal 0 modular_frame_value_4 )) (PreH5 : (should_be_equal a_pre modular_frame_value_5 )) (PreH6 : (should_be_equal retval retval )) (PreH7 : (should_be_equal a_pre a_pre )) (PreH8 : (should_be_equal a_pre modular_frame_value_2 )) (PreH9 : (should_be_equal retval modular_frame_value )) (PreH10 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH11 : (a_pre = 4096)) (PreH12 : ((INT_MIN) <= retval)) (PreH13 : (retval <= INT_MAX)) ,
  ((( &( "one_spec_426" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_399" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_414" ) )) # Ptr  |-> a_pre)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition verify_main_partial_solve_wit_2_aux := 
forall (a_pre: Z) (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal a_pre modular_frame_value_3 )) (PreH4 : (should_be_equal 0 modular_frame_value_4 )) (PreH5 : (should_be_equal a_pre modular_frame_value_5 )) (PreH6 : (should_be_equal retval retval )) (PreH7 : (should_be_equal a_pre a_pre )) (PreH8 : (should_be_equal a_pre modular_frame_value_2 )) (PreH9 : (should_be_equal retval modular_frame_value )) (PreH10 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH11 : (a_pre = 4096)) (PreH12 : ((INT_MIN) <= retval)) (PreH13 : (retval <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_2 := verify_main_partial_solve_wit_2_pure -> verify_main_partial_solve_wit_2_aux.

Definition verify_main_partial_solve_wit_3_pure := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  ((( &( "zero_spec_399" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition verify_main_partial_solve_wit_3_aux := 
forall (a_pre: Z) (PreH1 : (a_pre = 4096)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_3 := verify_main_partial_solve_wit_3_pure -> verify_main_partial_solve_wit_3_aux.

Definition verify_main_precondition_wit_1 :=
exists (a_pre: Z) ,
~ ((  “ (a_pre = 4096) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_verify_main_safety_wit_1 : verify_main_safety_wit_1.
Axiom proof_of_verify_main_safety_wit_2 : verify_main_safety_wit_2.
Axiom proof_of_verify_main_safety_wit_3 : verify_main_safety_wit_3.
Axiom proof_of_verify_main_safety_wit_4 : verify_main_safety_wit_4.
Axiom proof_of_verify_main_safety_wit_5 : verify_main_safety_wit_5.
Axiom proof_of_verify_main_safety_wit_6 : verify_main_safety_wit_6.
Axiom proof_of_verify_main_safety_wit_7 : verify_main_safety_wit_7.
Axiom proof_of_verify_main_safety_wit_8 : verify_main_safety_wit_8.
Axiom proof_of_verify_main_safety_wit_9 : verify_main_safety_wit_9.
Axiom proof_of_verify_main_entail_wit_1 : verify_main_entail_wit_1.
Axiom proof_of_verify_main_entail_wit_2 : verify_main_entail_wit_2.
Axiom proof_of_verify_main_entail_wit_3 : verify_main_entail_wit_3.
Axiom proof_of_verify_main_entail_wit_4 : verify_main_entail_wit_4.
Axiom proof_of_verify_main_entail_wit_5 : verify_main_entail_wit_5.
Axiom proof_of_verify_main_entail_wit_6 : verify_main_entail_wit_6.
Axiom proof_of_verify_main_return_wit_1 : verify_main_return_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_1_pure : verify_main_partial_solve_wit_1_pure.
Axiom proof_of_verify_main_partial_solve_wit_1 : verify_main_partial_solve_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_2_pure : verify_main_partial_solve_wit_2_pure.
Axiom proof_of_verify_main_partial_solve_wit_2 : verify_main_partial_solve_wit_2.
Axiom proof_of_verify_main_partial_solve_wit_3_pure : verify_main_partial_solve_wit_3_pure.
Axiom proof_of_verify_main_partial_solve_wit_3 : verify_main_partial_solve_wit_3.
Axiom proof_of_verify_main_precondition_wit_1 : verify_main_precondition_wit_1.

End VC_Correct.
