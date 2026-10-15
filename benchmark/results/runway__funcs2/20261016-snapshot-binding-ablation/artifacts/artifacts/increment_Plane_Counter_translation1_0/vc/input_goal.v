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

(*----- Function increment_Plane_Counter -----*)

Definition increment_Plane_Counter_safety_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 20)) # Int  |-> c0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_419" ) ) + 20)) # Int  |-> c0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_419" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_419" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_419" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_419" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 0)) # Int  |-> a0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_419" ) ) + 0)) # Int  |-> a0)
  **  ((( &( "s_spec_419" ) )) # Ptr  |-> ( &( "s_spec_419" ) ))
|--
  “ ((c0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (c0 + 1 )) ”
.

Definition increment_Plane_Counter_safety_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 20)) # Int  |-> c0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_419" ) ) + 20)) # Int  |-> c0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_419" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_419" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_419" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_419" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 0)) # Int  |-> a0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_419" ) ) + 0)) # Int  |-> a0)
  **  ((( &( "s_spec_419" ) )) # Ptr  |-> ( &( "s_spec_419" ) ))
|--
  TT && emp 
.

Definition increment_Plane_Counter_return_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> (c0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0)
|--
  EX (retval_Plane_Counter: Z) ,
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (retval_Plane_Counter = (c0 + 1 )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter)
.

Definition increment_Plane_Counter_partial_solve_wit_1 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (record_return: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  (UndefStructPredState record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 20)) # Int  |-> (c0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_419" ) ) + 20)) # Int  |-> c0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_419" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_419" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_419" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_419" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 0)) # Int  |-> a0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_419" ) ) + 0)) # Int  |-> a0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 <= 2) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (wd0 >= a0) ” 
  &&  “ (wa0 >= d0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 20)) # Int  |-> (c0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 0)) # Int  |-> a0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_419" ) ) + 20)) # Int  |-> c0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_419" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_419" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_419" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_419" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_419" ) ) + 0)) # Int  |-> a0)
.

Definition increment_Plane_Counter_partial_solve_wit_2 := 
forall (c0: Z) (t0: Z) (wd0: Z) (wa0: Z) (d0: Z) (a0: Z) (PreH1 : (0 <= a0)) (PreH2 : (a0 <= 1)) (PreH3 : (0 <= d0)) (PreH4 : (d0 <= 1)) (PreH5 : ((a0 + d0 ) <= 1)) (PreH6 : (wa0 >= 0)) (PreH7 : (wd0 >= 0)) (PreH8 : (0 <= t0)) (PreH9 : (t0 <= 5)) (PreH10 : (0 <= c0)) (PreH11 : (c0 <= 3)) (PreH12 : (c0 <= (3 * (a0 + d0 ) ))) (PreH13 : (t0 <= (5 * (a0 + d0 ) ))) (PreH14 : (c0 <= (3 * ((1 - a0 ) + wd0 ) ))) (PreH15 : (c0 <= (3 * ((1 - d0 ) + wa0 ) ))) (PreH16 : (c0 <= 2)) (PreH17 : ((a0 + d0 ) = 1)) (PreH18 : (wd0 >= a0)) (PreH19 : (wa0 >= d0)) ,
  (UndefStructPredState ( &( "temp_spec_735" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_419" ) ) + 0)) # Int  |-> a0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_419" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_419" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_419" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_419" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_419" ) ) + 20)) # Int  |-> c0)
|--
  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 <= 2) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (wd0 >= a0) ” 
  &&  “ (wa0 >= d0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_419" ) ) + 20)) # Int  |-> c0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_419" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_419" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_419" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_419" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_735" ) ) + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_419" ) ) + 0)) # Int  |-> a0)
.

Definition increment_Plane_Counter_precondition_wit_1 :=
exists (c0: Z) ,
exists (t0: Z) ,
exists (wd0: Z) ,
exists (wa0: Z) ,
exists (d0: Z) ,
exists (a0: Z) ,
~ ((  “ (0 <= a0) ” 
  &&  “ (a0 <= 1) ” 
  &&  “ (0 <= d0) ” 
  &&  “ (d0 <= 1) ” 
  &&  “ ((a0 + d0 ) <= 1) ” 
  &&  “ (wa0 >= 0) ” 
  &&  “ (wd0 >= 0) ” 
  &&  “ (0 <= t0) ” 
  &&  “ (t0 <= 5) ” 
  &&  “ (0 <= c0) ” 
  &&  “ (c0 <= 3) ” 
  &&  “ (c0 <= (3 * (a0 + d0 ) )) ” 
  &&  “ (t0 <= (5 * (a0 + d0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - a0 ) + wd0 ) )) ” 
  &&  “ (c0 <= (3 * ((1 - d0 ) + wa0 ) )) ” 
  &&  “ (c0 <= 2) ” 
  &&  “ ((a0 + d0 ) = 1) ” 
  &&  “ (wd0 >= a0) ” 
  &&  “ (wa0 >= d0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_419" ) ) + 0)) # Int  |-> a0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_419" ) ) + 4)) # Int  |-> d0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_419" ) ) + 8)) # Int  |-> wa0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_419" ) ) + 12)) # Int  |-> wd0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_419" ) ) + 16)) # Int  |-> t0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_419" ) ) + 20)) # Int  |-> c0)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_increment_Plane_Counter_safety_wit_1 : increment_Plane_Counter_safety_wit_1.
Axiom proof_of_increment_Plane_Counter_safety_wit_2 : increment_Plane_Counter_safety_wit_2.
Axiom proof_of_increment_Plane_Counter_return_wit_1 : increment_Plane_Counter_return_wit_1.
Axiom proof_of_increment_Plane_Counter_partial_solve_wit_1 : increment_Plane_Counter_partial_solve_wit_1.
Axiom proof_of_increment_Plane_Counter_partial_solve_wit_2 : increment_Plane_Counter_partial_solve_wit_2.
Axiom proof_of_increment_Plane_Counter_precondition_wit_1 : increment_Plane_Counter_precondition_wit_1.

End VC_Correct.
