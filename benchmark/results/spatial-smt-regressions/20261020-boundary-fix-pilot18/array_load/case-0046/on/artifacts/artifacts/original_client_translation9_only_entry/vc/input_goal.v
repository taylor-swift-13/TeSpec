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
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (modular_frame_value_12: Z) (modular_frame_value_13: Z) (PreH1 : (should_be_equal 4104 4104 )) (PreH2 : (should_be_equal 2 2 )) (PreH3 : (should_be_equal 4100 modular_frame_value_11 )) (PreH4 : (should_be_equal 1 modular_frame_value_10 )) (PreH5 : (should_be_equal 4096 modular_frame_value_9 )) (PreH6 : (should_be_equal 0 modular_frame_value_8 )) (PreH7 : (should_be_equal 2 modular_frame_value_12 )) (PreH8 : (should_be_equal 4096 modular_frame_value_7 )) (PreH9 : (should_be_equal 4104 modular_frame_value_13 )) (PreH10 : (should_be_equal 2 2 )) (PreH11 : (should_be_equal 0 0 )) (PreH12 : (should_be_equal 4096 4096 )) (PreH13 : (should_be_equal 1 1 )) (PreH14 : (should_be_equal 4100 4100 )) (PreH15 : (should_be_equal 4100 modular_frame_value_6 )) (PreH16 : (should_be_equal 1 modular_frame_value_5 )) (PreH17 : (should_be_equal 4096 modular_frame_value_4 )) (PreH18 : (should_be_equal 0 modular_frame_value_3 )) (PreH19 : (should_be_equal 4096 modular_frame_value )) (PreH20 : (should_be_equal 2 modular_frame_value_2 )) (PreH21 : (retval_3 = 2)) (PreH22 : (retval_2 = 1)) (PreH23 : (retval = 0)) ,
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
  **  ((( &( "two_spec_467" ) )) # Int  |-> 2)
  **  ((( &( "third_spec_494" ) )) # Ptr  |-> 4104)
|--
  TT && emp 
.

Definition verify_main_safety_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (PreH1 : (should_be_equal 2 2 )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 4096 4096 )) (PreH4 : (should_be_equal 1 1 )) (PreH5 : (should_be_equal 4100 4100 )) (PreH6 : (should_be_equal 4100 modular_frame_value_6 )) (PreH7 : (should_be_equal 1 modular_frame_value_5 )) (PreH8 : (should_be_equal 4096 modular_frame_value_4 )) (PreH9 : (should_be_equal 0 modular_frame_value_3 )) (PreH10 : (should_be_equal 4096 modular_frame_value )) (PreH11 : (should_be_equal 2 modular_frame_value_2 )) (PreH12 : (retval_3 = 2)) (PreH13 : (retval_2 = 1)) (PreH14 : (retval = 0)) ,
  ((( &( "third_spec_494" ) )) # Ptr  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "two_spec_467" ) )) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_3 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : (should_be_equal 4100 4100 )) (PreH2 : (should_be_equal 1 1 )) (PreH3 : (should_be_equal 4096 modular_frame_value_7 )) (PreH4 : (should_be_equal 0 modular_frame_value_6 )) (PreH5 : (should_be_equal 1 modular_frame_value_8 )) (PreH6 : (should_be_equal 4096 modular_frame_value_5 )) (PreH7 : (should_be_equal 4100 modular_frame_value_9 )) (PreH8 : (should_be_equal 1 1 )) (PreH9 : (should_be_equal 0 0 )) (PreH10 : (should_be_equal 4096 4096 )) (PreH11 : (should_be_equal 4096 modular_frame_value_4 )) (PreH12 : (should_be_equal 0 modular_frame_value_3 )) (PreH13 : (should_be_equal 4096 modular_frame_value )) (PreH14 : (should_be_equal 1 modular_frame_value_2 )) (PreH15 : (retval_2 = 1)) (PreH16 : (retval = 0)) ,
  ((( &( "two_spec_467" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_4 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : (should_be_equal 4100 4100 )) (PreH2 : (should_be_equal 1 1 )) (PreH3 : (should_be_equal 4096 modular_frame_value_7 )) (PreH4 : (should_be_equal 0 modular_frame_value_6 )) (PreH5 : (should_be_equal 1 modular_frame_value_8 )) (PreH6 : (should_be_equal 4096 modular_frame_value_5 )) (PreH7 : (should_be_equal 4100 modular_frame_value_9 )) (PreH8 : (should_be_equal 1 1 )) (PreH9 : (should_be_equal 0 0 )) (PreH10 : (should_be_equal 4096 4096 )) (PreH11 : (should_be_equal 4096 modular_frame_value_4 )) (PreH12 : (should_be_equal 0 modular_frame_value_3 )) (PreH13 : (should_be_equal 4096 modular_frame_value )) (PreH14 : (should_be_equal 1 modular_frame_value_2 )) (PreH15 : (retval_2 = 1)) (PreH16 : (retval = 0)) ,
  ((( &( "two_spec_467" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_5 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (PreH1 : (should_be_equal 1 1 )) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 4096 4096 )) (PreH4 : (should_be_equal 4096 modular_frame_value_4 )) (PreH5 : (should_be_equal 0 modular_frame_value_3 )) (PreH6 : (should_be_equal 4096 modular_frame_value )) (PreH7 : (should_be_equal 1 modular_frame_value_2 )) (PreH8 : (retval_2 = 1)) (PreH9 : (retval = 0)) ,
  ((( &( "second_spec_449" ) )) # Ptr  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_6 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (should_be_equal 0 0 )) (PreH2 : (should_be_equal 0 modular_frame_value_4 )) (PreH3 : (should_be_equal 4096 modular_frame_value_3 )) (PreH4 : (should_be_equal 4096 modular_frame_value_5 )) (PreH5 : (should_be_equal 0 0 )) (PreH6 : (should_be_equal 4096 4096 )) (PreH7 : (should_be_equal 4096 modular_frame_value )) (PreH8 : (should_be_equal 0 modular_frame_value_2 )) (PreH9 : (retval = 0)) ,
  ((( &( "one_spec_428" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_7 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (should_be_equal 0 0 )) (PreH2 : (should_be_equal 0 modular_frame_value_4 )) (PreH3 : (should_be_equal 4096 modular_frame_value_3 )) (PreH4 : (should_be_equal 4096 modular_frame_value_5 )) (PreH5 : (should_be_equal 0 0 )) (PreH6 : (should_be_equal 4096 4096 )) (PreH7 : (should_be_equal 4096 modular_frame_value )) (PreH8 : (should_be_equal 0 modular_frame_value_2 )) (PreH9 : (retval = 0)) ,
  ((( &( "one_spec_428" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_8 := 
  ((( &( "zero_spec_401" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_9 := 
  ((( &( "zero_spec_401" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_entail_wit_1 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (modular_frame_value_12: Z) (modular_frame_value_13: Z) (PreH1 : (2 = 2)) (PreH2 : (4100 = (4096 + 4 ))) (PreH3 : (should_be_equal retval_3 retval_3 )) (PreH4 : (should_be_equal 0 0 )) (PreH5 : (should_be_equal 4096 4096 )) (PreH6 : (should_be_equal 1 1 )) (PreH7 : (should_be_equal 4100 4100 )) (PreH8 : (should_be_equal 4100 modular_frame_value_6 )) (PreH9 : (should_be_equal 1 modular_frame_value_5 )) (PreH10 : (should_be_equal 4096 modular_frame_value_4 )) (PreH11 : (should_be_equal 0 modular_frame_value_3 )) (PreH12 : (should_be_equal 4096 modular_frame_value )) (PreH13 : (should_be_equal retval_3 modular_frame_value_2 )) (PreH14 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH15 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH16 : (4100 = (4096 + 4 ))) (PreH17 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH18 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH19 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH20 : ((INT_MIN) <= retval)) (PreH21 : (retval <= INT_MAX)) (PreH22 : ((INT_MIN) <= retval_2)) (PreH23 : (retval_2 <= INT_MAX)) (PreH24 : ((INT_MIN) <= retval_3)) (PreH25 : (retval_3 <= INT_MAX)) ,
  ((( &( "third_spec_494" ) )) # Ptr  |-> (4096 + (2 * sizeof(INT))))
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2) ” 
  &&  “ (4100 = (4096 + 4 )) ” 
  &&  “ (4104 = (4096 + 8 )) ” 
  &&  “ (should_be_equal (4096 + (2 * sizeof(INT))) (4096 + (2 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 2 2 ) ” 
  &&  “ (should_be_equal 4100 modular_frame_value_11 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_10 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_9 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_8 ) ” 
  &&  “ (should_be_equal 2 modular_frame_value_12 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_7 ) ” 
  &&  “ (should_be_equal (4096 + (2 * sizeof(INT))) modular_frame_value_13 ) ” 
  &&  “ (4100 = (4096 + 4 )) ” 
  &&  “ (should_be_equal retval_3 retval_3 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 4096 4096 ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal 4100 4100 ) ” 
  &&  “ (should_be_equal 4100 modular_frame_value_6 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_5 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value ) ” 
  &&  “ (should_be_equal retval_3 modular_frame_value_2 ) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (4100 = (4096 + 4 )) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "third_spec_494" ) )) # Ptr  |-> 4104)
.

Definition verify_main_entail_wit_2 := 
forall (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (PreH1 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH3 : (4100 = (4096 + 4 ))) (PreH4 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH6 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) (PreH9 : ((INT_MIN) <= retval_2)) (PreH10 : (retval_2 <= INT_MAX)) (PreH11 : ((INT_MIN) <= retval_3)) (PreH12 : (retval_3 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "two_spec_467" ) )) # Int  |-> retval_3)
|--
  “ (2 = 2) ” 
  &&  “ (4100 = (4096 + 4 )) ” 
  &&  “ (should_be_equal retval_3 retval_3 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 4096 4096 ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal 4100 4100 ) ” 
  &&  “ (should_be_equal 4100 modular_frame_value_6 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_5 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value ) ” 
  &&  “ (should_be_equal retval_3 modular_frame_value_2 ) ” 
  &&  “ (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (4100 = (4096 + 4 )) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_3) ” 
  &&  “ (retval_3 <= INT_MAX) ”
  &&  ((( &( "two_spec_467" ) )) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_3 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : (1 = 1)) (PreH2 : (should_be_equal retval_2 retval_2 )) (PreH3 : (should_be_equal 0 0 )) (PreH4 : (should_be_equal 4096 4096 )) (PreH5 : (should_be_equal 4096 modular_frame_value_4 )) (PreH6 : (should_be_equal 0 modular_frame_value_3 )) (PreH7 : (should_be_equal 4096 modular_frame_value )) (PreH8 : (should_be_equal retval_2 modular_frame_value_2 )) (PreH9 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH10 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH11 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH12 : ((INT_MIN) <= retval)) (PreH13 : (retval <= INT_MAX)) (PreH14 : ((INT_MIN) <= retval_2)) (PreH15 : (retval_2 <= INT_MAX)) ,
  ((( &( "second_spec_449" ) )) # Ptr  |-> (4096 + (1 * sizeof(INT))))
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (4100 = (4096 + 4 )) ” 
  &&  “ (should_be_equal (4096 + (1 * sizeof(INT))) (4096 + (1 * sizeof(INT))) ) ” 
  &&  “ (should_be_equal 1 1 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_7 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_6 ) ” 
  &&  “ (should_be_equal 1 modular_frame_value_8 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_5 ) ” 
  &&  “ (should_be_equal (4096 + (1 * sizeof(INT))) modular_frame_value_9 ) ” 
  &&  “ (should_be_equal retval_2 retval_2 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 4096 4096 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value ) ” 
  &&  “ (should_be_equal retval_2 modular_frame_value_2 ) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
.

Definition verify_main_entail_wit_4 := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (PreH1 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH3 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) (PreH6 : ((INT_MIN) <= retval_2)) (PreH7 : (retval_2 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "one_spec_428" ) )) # Int  |-> retval_2)
|--
  “ (1 = 1) ” 
  &&  “ (should_be_equal retval_2 retval_2 ) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 4096 4096 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value ) ” 
  &&  “ (should_be_equal retval_2 modular_frame_value_2 ) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_5 := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : (0 = 0)) (PreH2 : (should_be_equal retval retval )) (PreH3 : (should_be_equal 4096 4096 )) (PreH4 : (should_be_equal 4096 modular_frame_value )) (PreH5 : (should_be_equal retval modular_frame_value_2 )) (PreH6 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : ((INT_MIN) <= retval)) (PreH8 : (retval <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (should_be_equal 0 0 ) ” 
  &&  “ (should_be_equal 0 modular_frame_value_4 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_3 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value_5 ) ” 
  &&  “ (should_be_equal retval retval ) ” 
  &&  “ (should_be_equal 4096 4096 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value ) ” 
  &&  “ (should_be_equal retval modular_frame_value_2 ) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_6 := 
forall (a_pre: Z) (a0___tespec_entry: Z) (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = 4096)) (PreH3 : (a0___tespec_entry = 4096)) (PreH4 : (a_pre = a0___tespec_entry)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> retval)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
|--
  “ (0 = 0) ” 
  &&  “ (should_be_equal retval retval ) ” 
  &&  “ (should_be_equal 4096 4096 ) ” 
  &&  “ (should_be_equal 4096 modular_frame_value ) ” 
  &&  “ (should_be_equal retval modular_frame_value_2 ) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_return_wit_1 := 
forall (a0___tespec_entry: Z) (retval: Z) (retval_2: Z) (retval_3: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (modular_frame_value_10: Z) (modular_frame_value_11: Z) (modular_frame_value_12: Z) (modular_frame_value_13: Z) (PreH1 : ((Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 2)) (PreH2 : (4100 = (4096 + 4 ))) (PreH3 : (4104 = (4096 + 8 ))) (PreH4 : (should_be_equal (4096 + (2 * sizeof(INT))) (4096 + (2 * sizeof(INT))) )) (PreH5 : (should_be_equal 2 2 )) (PreH6 : (should_be_equal 4100 modular_frame_value_11 )) (PreH7 : (should_be_equal 1 modular_frame_value_10 )) (PreH8 : (should_be_equal 4096 modular_frame_value_9 )) (PreH9 : (should_be_equal 0 modular_frame_value_8 )) (PreH10 : (should_be_equal 2 modular_frame_value_12 )) (PreH11 : (should_be_equal 4096 modular_frame_value_7 )) (PreH12 : (should_be_equal (4096 + (2 * sizeof(INT))) modular_frame_value_13 )) (PreH13 : (4100 = (4096 + 4 ))) (PreH14 : (should_be_equal retval_3 retval_3 )) (PreH15 : (should_be_equal 0 0 )) (PreH16 : (should_be_equal 4096 4096 )) (PreH17 : (should_be_equal 1 1 )) (PreH18 : (should_be_equal 4100 4100 )) (PreH19 : (should_be_equal 4100 modular_frame_value_6 )) (PreH20 : (should_be_equal 1 modular_frame_value_5 )) (PreH21 : (should_be_equal 4096 modular_frame_value_4 )) (PreH22 : (should_be_equal 0 modular_frame_value_3 )) (PreH23 : (should_be_equal 4096 modular_frame_value )) (PreH24 : (should_be_equal retval_3 modular_frame_value_2 )) (PreH25 : (retval_3 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH26 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH27 : (4100 = (4096 + 4 ))) (PreH28 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH29 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH30 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH31 : ((INT_MIN) <= retval)) (PreH32 : (retval <= INT_MAX)) (PreH33 : ((INT_MIN) <= retval_2)) (PreH34 : (retval_2 <= INT_MAX)) (PreH35 : ((INT_MIN) <= retval_3)) (PreH36 : (retval_3 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ”
  &&  (IntArray.full a0___tespec_entry 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1_pure := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (4100 = (4096 + 4 ))) (PreH3 : (should_be_equal (4096 + (1 * sizeof(INT))) (4096 + (1 * sizeof(INT))) )) (PreH4 : (should_be_equal 1 1 )) (PreH5 : (should_be_equal 4096 modular_frame_value_7 )) (PreH6 : (should_be_equal 0 modular_frame_value_6 )) (PreH7 : (should_be_equal 1 modular_frame_value_8 )) (PreH8 : (should_be_equal 4096 modular_frame_value_5 )) (PreH9 : (should_be_equal (4096 + (1 * sizeof(INT))) modular_frame_value_9 )) (PreH10 : (should_be_equal retval_2 retval_2 )) (PreH11 : (should_be_equal 0 0 )) (PreH12 : (should_be_equal 4096 4096 )) (PreH13 : (should_be_equal 4096 modular_frame_value_4 )) (PreH14 : (should_be_equal 0 modular_frame_value_3 )) (PreH15 : (should_be_equal 4096 modular_frame_value )) (PreH16 : (should_be_equal retval_2 modular_frame_value_2 )) (PreH17 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH18 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH19 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH20 : ((INT_MIN) <= retval)) (PreH21 : (retval <= INT_MAX)) (PreH22 : ((INT_MIN) <= retval_2)) (PreH23 : (retval_2 <= INT_MAX)) ,
  ((( &( "two_spec_467" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition verify_main_partial_solve_wit_1_aux := 
forall (retval: Z) (retval_2: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (modular_frame_value_6: Z) (modular_frame_value_7: Z) (modular_frame_value_8: Z) (modular_frame_value_9: Z) (PreH1 : ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1)) (PreH2 : (4100 = (4096 + 4 ))) (PreH3 : (should_be_equal (4096 + (1 * sizeof(INT))) (4096 + (1 * sizeof(INT))) )) (PreH4 : (should_be_equal 1 1 )) (PreH5 : (should_be_equal 4096 modular_frame_value_7 )) (PreH6 : (should_be_equal 0 modular_frame_value_6 )) (PreH7 : (should_be_equal 1 modular_frame_value_8 )) (PreH8 : (should_be_equal 4096 modular_frame_value_5 )) (PreH9 : (should_be_equal (4096 + (1 * sizeof(INT))) modular_frame_value_9 )) (PreH10 : (should_be_equal retval_2 retval_2 )) (PreH11 : (should_be_equal 0 0 )) (PreH12 : (should_be_equal 4096 4096 )) (PreH13 : (should_be_equal 4096 modular_frame_value_4 )) (PreH14 : (should_be_equal 0 modular_frame_value_3 )) (PreH15 : (should_be_equal 4096 modular_frame_value )) (PreH16 : (should_be_equal retval_2 modular_frame_value_2 )) (PreH17 : (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH18 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH19 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH20 : ((INT_MIN) <= retval)) (PreH21 : (retval <= INT_MAX)) (PreH22 : ((INT_MIN) <= retval_2)) (PreH23 : (retval_2 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ ((Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 1) ” 
  &&  “ (4100 = (4096 + 4 )) ” 
  &&  “ (retval_2 = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1 := verify_main_partial_solve_wit_1_pure -> verify_main_partial_solve_wit_1_aux.

Definition verify_main_partial_solve_wit_2_pure := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 0 modular_frame_value_4 )) (PreH4 : (should_be_equal 4096 modular_frame_value_3 )) (PreH5 : (should_be_equal 4096 modular_frame_value_5 )) (PreH6 : (should_be_equal retval retval )) (PreH7 : (should_be_equal 4096 4096 )) (PreH8 : (should_be_equal 4096 modular_frame_value )) (PreH9 : (should_be_equal retval modular_frame_value_2 )) (PreH10 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH11 : ((INT_MIN) <= retval)) (PreH12 : (retval <= INT_MAX)) ,
  ((( &( "one_spec_428" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition verify_main_partial_solve_wit_2_aux := 
forall (retval: Z) (modular_frame_value: Z) (modular_frame_value_2: Z) (modular_frame_value_3: Z) (modular_frame_value_4: Z) (modular_frame_value_5: Z) (PreH1 : ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0)) (PreH2 : (should_be_equal 0 0 )) (PreH3 : (should_be_equal 0 modular_frame_value_4 )) (PreH4 : (should_be_equal 4096 modular_frame_value_3 )) (PreH5 : (should_be_equal 4096 modular_frame_value_5 )) (PreH6 : (should_be_equal retval retval )) (PreH7 : (should_be_equal 4096 4096 )) (PreH8 : (should_be_equal 4096 modular_frame_value )) (PreH9 : (should_be_equal retval modular_frame_value_2 )) (PreH10 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH11 : ((INT_MIN) <= retval)) (PreH12 : (retval <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ ((Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)) = 0) ” 
  &&  “ (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_2 := verify_main_partial_solve_wit_2_pure -> verify_main_partial_solve_wit_2_aux.

Definition verify_main_partial_solve_wit_3_pure := 
forall (a_pre: Z) (a0___tespec_entry: Z) (PreH1 : (a_pre = 4096)) (PreH2 : (a0___tespec_entry = 4096)) (PreH3 : (a_pre = a0___tespec_entry)) ,
  ((( &( "zero_spec_401" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition verify_main_partial_solve_wit_3_aux := 
forall (a_pre: Z) (a0___tespec_entry: Z) (PreH1 : (a_pre = 4096)) (PreH2 : (a0___tespec_entry = 4096)) (PreH3 : (a_pre = a0___tespec_entry)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ (a0___tespec_entry = 4096) ” 
  &&  “ (a_pre = a0___tespec_entry) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_3 := verify_main_partial_solve_wit_3_pure -> verify_main_partial_solve_wit_3_aux.

Definition verify_main_precondition_wit_1 :=
exists (a_pre: Z) ,
exists (a0___tespec_entry: Z) ,
~ ((  “ (a_pre = 4096) ” 
  &&  “ (a0___tespec_entry = 4096) ” 
  &&  “ (a_pre = a0___tespec_entry) ”
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
