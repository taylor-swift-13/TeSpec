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

(*----- Function reset_Runway_Time -----*)

Definition reset_Runway_Time_safety_wit_1 := 
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 20)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_497" ) ) + 20)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_497" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_497" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_497" ) ) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_497" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_497" ) ) + 0)) # Int  |-> 1)
  **  ((( &( "s_spec_497" ) )) # Ptr  |-> ( &( "s_spec_497" ) ))
|--
  TT && emp 
.

Definition reset_Runway_Time_return_wit_1 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (record_return: Z) (PreH1 : (a0___tespec_entry = 1)) (PreH2 : (c0___tespec_entry = 3)) (PreH3 : (d0___tespec_entry = 0)) (PreH4 : (t0___tespec_entry = 5)) (PreH5 : (wa0___tespec_entry = 2)) (PreH6 : (wd0___tespec_entry = 1)) (PreH7 : (a0___tespec_entry = 1)) (PreH8 : (d0___tespec_entry = 0)) (PreH9 : (wa0___tespec_entry = 2)) (PreH10 : (wd0___tespec_entry = 1)) (PreH11 : (t0___tespec_entry = 5)) (PreH12 : (c0___tespec_entry = 3)) (PreH13 : (0 <= a0___tespec_entry)) (PreH14 : (a0___tespec_entry <= 1)) (PreH15 : (0 <= d0___tespec_entry)) (PreH16 : (d0___tespec_entry <= 1)) (PreH17 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH18 : (wa0___tespec_entry >= 0)) (PreH19 : (wd0___tespec_entry >= 0)) (PreH20 : (0 <= t0___tespec_entry)) (PreH21 : (t0___tespec_entry <= 5)) (PreH22 : (0 <= c0___tespec_entry)) (PreH23 : (c0___tespec_entry <= 3)) (PreH24 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH25 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH26 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH27 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0___tespec_entry)
|--
  EX (retval_Runway_Time: Z) ,
  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (wa0___tespec_entry >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= c0___tespec_entry) ” 
  &&  “ (c0___tespec_entry <= 3) ” 
  &&  “ (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) )) ” 
  &&  “ (retval_Runway_Time = 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> c0___tespec_entry)
.

Definition reset_Runway_Time_partial_solve_wit_1 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (record_return: Z) (PreH1 : (a0___tespec_entry = 1)) (PreH2 : (c0___tespec_entry = 3)) (PreH3 : (d0___tespec_entry = 0)) (PreH4 : (t0___tespec_entry = 5)) (PreH5 : (wa0___tespec_entry = 2)) (PreH6 : (wd0___tespec_entry = 1)) (PreH7 : (a0___tespec_entry = 1)) (PreH8 : (d0___tespec_entry = 0)) (PreH9 : (wa0___tespec_entry = 2)) (PreH10 : (wd0___tespec_entry = 1)) (PreH11 : (t0___tespec_entry = 5)) (PreH12 : (c0___tespec_entry = 3)) (PreH13 : (0 <= a0___tespec_entry)) (PreH14 : (a0___tespec_entry <= 1)) (PreH15 : (0 <= d0___tespec_entry)) (PreH16 : (d0___tespec_entry <= 1)) (PreH17 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH18 : (wa0___tespec_entry >= 0)) (PreH19 : (wd0___tespec_entry >= 0)) (PreH20 : (0 <= t0___tespec_entry)) (PreH21 : (t0___tespec_entry <= 5)) (PreH22 : (0 <= c0___tespec_entry)) (PreH23 : (c0___tespec_entry <= 3)) (PreH24 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH25 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH26 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH27 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) ,
  (UndefStructPredState record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_497" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_497" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_497" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_497" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_497" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_497" ) ) + 0)) # Int  |-> a0___tespec_entry)
|--
  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (wa0___tespec_entry = 2) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 2) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (wa0___tespec_entry >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= t0___tespec_entry) ” 
  &&  “ (t0___tespec_entry <= 5) ” 
  &&  “ (0 <= c0___tespec_entry) ” 
  &&  “ (c0___tespec_entry <= 3) ” 
  &&  “ (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_497" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_497" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_497" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_497" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_497" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_497" ) ) + 0)) # Int  |-> a0___tespec_entry)
.

Definition reset_Runway_Time_partial_solve_wit_2 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (PreH1 : (a0___tespec_entry = 1)) (PreH2 : (c0___tespec_entry = 3)) (PreH3 : (d0___tespec_entry = 0)) (PreH4 : (t0___tespec_entry = 5)) (PreH5 : (wa0___tespec_entry = 2)) (PreH6 : (wd0___tespec_entry = 1)) (PreH7 : (a0___tespec_entry = 1)) (PreH8 : (d0___tespec_entry = 0)) (PreH9 : (wa0___tespec_entry = 2)) (PreH10 : (wd0___tespec_entry = 1)) (PreH11 : (t0___tespec_entry = 5)) (PreH12 : (c0___tespec_entry = 3)) (PreH13 : (0 <= a0___tespec_entry)) (PreH14 : (a0___tespec_entry <= 1)) (PreH15 : (0 <= d0___tespec_entry)) (PreH16 : (d0___tespec_entry <= 1)) (PreH17 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH18 : (wa0___tespec_entry >= 0)) (PreH19 : (wd0___tespec_entry >= 0)) (PreH20 : (0 <= t0___tespec_entry)) (PreH21 : (t0___tespec_entry <= 5)) (PreH22 : (0 <= c0___tespec_entry)) (PreH23 : (c0___tespec_entry <= 3)) (PreH24 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH25 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH26 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH27 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) ,
  (UndefStructPredState ( &( "temp_spec_754" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_497" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_497" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_497" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_497" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_497" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_497" ) ) + 20)) # Int  |-> c0___tespec_entry)
|--
  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (wa0___tespec_entry = 2) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 2) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (wa0___tespec_entry >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= t0___tespec_entry) ” 
  &&  “ (t0___tespec_entry <= 5) ” 
  &&  “ (0 <= c0___tespec_entry) ” 
  &&  “ (c0___tespec_entry <= 3) ” 
  &&  “ (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_497" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_497" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_497" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_497" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_497" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_754" ) ) + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_497" ) ) + 0)) # Int  |-> a0___tespec_entry)
.

Definition reset_Runway_Time_precondition_wit_1 :=
exists (c0___tespec_entry: Z) ,
exists (t0___tespec_entry: Z) ,
exists (wd0___tespec_entry: Z) ,
exists (wa0___tespec_entry: Z) ,
exists (d0___tespec_entry: Z) ,
exists (a0___tespec_entry: Z) ,
~ ((  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (wa0___tespec_entry = 2) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 2) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (wa0___tespec_entry >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= t0___tespec_entry) ” 
  &&  “ (t0___tespec_entry <= 5) ” 
  &&  “ (0 <= c0___tespec_entry) ” 
  &&  “ (c0___tespec_entry <= 3) ” 
  &&  “ (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_497" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_497" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_497" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_497" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_497" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_497" ) ) + 20)) # Int  |-> c0___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_reset_Runway_Time_safety_wit_1 : reset_Runway_Time_safety_wit_1.
Axiom proof_of_reset_Runway_Time_return_wit_1 : reset_Runway_Time_return_wit_1.
Axiom proof_of_reset_Runway_Time_partial_solve_wit_1 : reset_Runway_Time_partial_solve_wit_1.
Axiom proof_of_reset_Runway_Time_partial_solve_wit_2 : reset_Runway_Time_partial_solve_wit_2.
Axiom proof_of_reset_Runway_Time_precondition_wit_1 : reset_Runway_Time_precondition_wit_1.

End VC_Correct.
