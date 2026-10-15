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

(*----- Function arrive -----*)

Definition arrive_safety_wit_1 := 
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> 1)
  **  ((( &( "s_spec_523" ) )) # Ptr  |-> ( &( "s_spec_523" ) ))
|--
  TT && emp 
.

Definition arrive_safety_wit_2 := 
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> 1)
  **  ((( &( "s_spec_523" ) )) # Ptr  |-> ( &( "s_spec_523" ) ))
|--
  TT && emp 
.

Definition arrive_safety_wit_3 := 
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> 1)
  **  ((( &( "s_spec_523" ) )) # Ptr  |-> ( &( "s_spec_523" ) ))
|--
  TT && emp 
.

Definition arrive_safety_wit_4 := 
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> 1)
  **  ((( &( "s_spec_523" ) )) # Ptr  |-> ( &( "s_spec_523" ) ))
|--
  TT && emp 
.

Definition arrive_safety_wit_5 := 
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> 1)
  **  ((( &( "s_spec_523" ) )) # Ptr  |-> ( &( "s_spec_523" ) ))
|--
  TT && emp 
.

Definition arrive_safety_wit_6 := 
forall (PreH1 : False) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> 5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> 1)
  **  ((( &( "s_spec_523" ) )) # Ptr  |-> ( &( "s_spec_523" ) ))
|--
  “ False ”
.

Definition arrive_return_wit_1 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (record_return: Z) (PreH1 : (wd0___tespec_entry > 0)) (PreH2 : (a0___tespec_entry = 1)) (PreH3 : (c0___tespec_entry = 2)) (PreH4 : (d0___tespec_entry = 0)) (PreH5 : (t0___tespec_entry = 5)) (PreH6 : (wa0___tespec_entry = 3)) (PreH7 : (wd0___tespec_entry = 2)) (PreH8 : (a0___tespec_entry = 1)) (PreH9 : (d0___tespec_entry = 0)) (PreH10 : (wa0___tespec_entry = 3)) (PreH11 : (wd0___tespec_entry = 2)) (PreH12 : (t0___tespec_entry = 5)) (PreH13 : (c0___tespec_entry = 2)) (PreH14 : (0 <= a0___tespec_entry)) (PreH15 : (a0___tespec_entry <= 1)) (PreH16 : (0 <= d0___tespec_entry)) (PreH17 : (d0___tespec_entry <= 1)) (PreH18 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH19 : (wa0___tespec_entry >= 0)) (PreH20 : (wd0___tespec_entry >= 0)) (PreH21 : (0 <= t0___tespec_entry)) (PreH22 : (t0___tespec_entry <= 5)) (PreH23 : (0 <= c0___tespec_entry)) (PreH24 : (c0___tespec_entry <= 3)) (PreH25 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH26 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH27 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH28 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) (PreH29 : (a0___tespec_entry = 1)) (PreH30 : (wa0___tespec_entry >= 1)) (PreH31 : (c0___tespec_entry <= 2)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> (c0___tespec_entry + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> (wa0___tespec_entry - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0___tespec_entry)
|--
  (EX (retval_W_A: Z) ,
  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= t0___tespec_entry) ” 
  &&  “ (t0___tespec_entry <= 5) ” 
  &&  “ (0 <= c0___tespec_entry) ” 
  &&  “ (c0___tespec_entry <= 3) ” 
  &&  “ (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + retval_W_A ) )) ” 
  &&  “ (wd0___tespec_entry <= 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> c0___tespec_entry))
  ||
  (EX (retval_W_A_2: Z) ,
  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= t0___tespec_entry) ” 
  &&  “ (t0___tespec_entry <= 5) ” 
  &&  “ (0 <= c0___tespec_entry) ” 
  &&  “ (c0___tespec_entry <= 3) ” 
  &&  “ (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + retval_W_A_2 ) )) ” 
  &&  “ (c0___tespec_entry = (c0___tespec_entry + 1 )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> c0___tespec_entry))
  ||
  (EX (retval_Plane_Counter: Z)  (retval_W_A_3: Z) ,
  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (retval_W_A_3 >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= t0___tespec_entry) ” 
  &&  “ (t0___tespec_entry <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - d0___tespec_entry ) + retval_W_A_3 ) )) ” 
  &&  “ (wd0___tespec_entry <> 0) ” 
  &&  “ (wd0___tespec_entry <= 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_2: Z)  (retval_W_A_4: Z) ,
  “ (0 <= a0___tespec_entry) ” 
  &&  “ (a0___tespec_entry <= 1) ” 
  &&  “ (0 <= d0___tespec_entry) ” 
  &&  “ (d0___tespec_entry <= 1) ” 
  &&  “ ((a0___tespec_entry + d0___tespec_entry ) <= 1) ” 
  &&  “ (retval_W_A_4 >= 0) ” 
  &&  “ (wd0___tespec_entry >= 0) ” 
  &&  “ (0 <= t0___tespec_entry) ” 
  &&  “ (t0___tespec_entry <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - d0___tespec_entry ) + retval_W_A_4 ) )) ” 
  &&  “ (wd0___tespec_entry <> 0) ” 
  &&  “ (retval_Plane_Counter_2 = (c0___tespec_entry + 1 )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_2))
.

Definition arrive_partial_solve_wit_1 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (record_return: Z) (PreH1 : (wd0___tespec_entry > 0)) (PreH2 : (a0___tespec_entry = 1)) (PreH3 : (c0___tespec_entry = 2)) (PreH4 : (d0___tespec_entry = 0)) (PreH5 : (t0___tespec_entry = 5)) (PreH6 : (wa0___tespec_entry = 3)) (PreH7 : (wd0___tespec_entry = 2)) (PreH8 : (a0___tespec_entry = 1)) (PreH9 : (d0___tespec_entry = 0)) (PreH10 : (wa0___tespec_entry = 3)) (PreH11 : (wd0___tespec_entry = 2)) (PreH12 : (t0___tespec_entry = 5)) (PreH13 : (c0___tespec_entry = 2)) (PreH14 : (0 <= a0___tespec_entry)) (PreH15 : (a0___tespec_entry <= 1)) (PreH16 : (0 <= d0___tespec_entry)) (PreH17 : (d0___tespec_entry <= 1)) (PreH18 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH19 : (wa0___tespec_entry >= 0)) (PreH20 : (wd0___tespec_entry >= 0)) (PreH21 : (0 <= t0___tespec_entry)) (PreH22 : (t0___tespec_entry <= 5)) (PreH23 : (0 <= c0___tespec_entry)) (PreH24 : (c0___tespec_entry <= 3)) (PreH25 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH26 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH27 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH28 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) (PreH29 : (a0___tespec_entry = 1)) (PreH30 : (wa0___tespec_entry >= 1)) (PreH31 : (c0___tespec_entry <= 2)) ,
  (UndefStructPredState record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> (c0___tespec_entry + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> (wa0___tespec_entry - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> a0___tespec_entry)
|--
  “ (wd0___tespec_entry > 0) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 2) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (wa0___tespec_entry = 3) ” 
  &&  “ (wd0___tespec_entry = 2) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 3) ” 
  &&  “ (wd0___tespec_entry = 2) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (c0___tespec_entry = 2) ” 
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
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (wa0___tespec_entry >= 1) ” 
  &&  “ (c0___tespec_entry <= 2) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |-> (c0___tespec_entry + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |-> (wa0___tespec_entry - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> a0___tespec_entry)
.

Definition arrive_partial_solve_wit_2 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (PreH1 : (a0___tespec_entry = 1)) (PreH2 : (c0___tespec_entry = 2)) (PreH3 : (d0___tespec_entry = 0)) (PreH4 : (t0___tespec_entry = 5)) (PreH5 : (wa0___tespec_entry = 3)) (PreH6 : (wd0___tespec_entry = 2)) (PreH7 : (a0___tespec_entry = 1)) (PreH8 : (d0___tespec_entry = 0)) (PreH9 : (wa0___tespec_entry = 3)) (PreH10 : (wd0___tespec_entry = 2)) (PreH11 : (t0___tespec_entry = 5)) (PreH12 : (c0___tespec_entry = 2)) (PreH13 : (0 <= a0___tespec_entry)) (PreH14 : (a0___tespec_entry <= 1)) (PreH15 : (0 <= d0___tespec_entry)) (PreH16 : (d0___tespec_entry <= 1)) (PreH17 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH18 : (wa0___tespec_entry >= 0)) (PreH19 : (wd0___tespec_entry >= 0)) (PreH20 : (0 <= t0___tespec_entry)) (PreH21 : (t0___tespec_entry <= 5)) (PreH22 : (0 <= c0___tespec_entry)) (PreH23 : (c0___tespec_entry <= 3)) (PreH24 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH25 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH26 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH27 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) (PreH28 : (a0___tespec_entry = 1)) (PreH29 : (wa0___tespec_entry >= 1)) (PreH30 : (c0___tespec_entry <= 2)) ,
  (UndefStructPredState ( &( "temp_spec_772" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> c0___tespec_entry)
|--
  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 2) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (wa0___tespec_entry = 3) ” 
  &&  “ (wd0___tespec_entry = 2) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 3) ” 
  &&  “ (wd0___tespec_entry = 2) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (c0___tespec_entry = 2) ” 
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
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (wa0___tespec_entry >= 1) ” 
  &&  “ (c0___tespec_entry <= 2) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> c0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_772" ) ) + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> a0___tespec_entry)
.

Definition arrive_precondition_wit_1 :=
exists (c0___tespec_entry: Z) ,
exists (t0___tespec_entry: Z) ,
exists (wd0___tespec_entry: Z) ,
exists (wa0___tespec_entry: Z) ,
exists (d0___tespec_entry: Z) ,
exists (a0___tespec_entry: Z) ,
~ ((  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 2) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (wa0___tespec_entry = 3) ” 
  &&  “ (wd0___tespec_entry = 2) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 3) ” 
  &&  “ (wd0___tespec_entry = 2) ” 
  &&  “ (t0___tespec_entry = 5) ” 
  &&  “ (c0___tespec_entry = 2) ” 
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
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (wa0___tespec_entry >= 1) ” 
  &&  “ (c0___tespec_entry <= 2) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_523" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_523" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_523" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_523" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_523" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_523" ) ) + 20)) # Int  |-> c0___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_arrive_safety_wit_1 : arrive_safety_wit_1.
Axiom proof_of_arrive_safety_wit_2 : arrive_safety_wit_2.
Axiom proof_of_arrive_safety_wit_3 : arrive_safety_wit_3.
Axiom proof_of_arrive_safety_wit_4 : arrive_safety_wit_4.
Axiom proof_of_arrive_safety_wit_5 : arrive_safety_wit_5.
Axiom proof_of_arrive_safety_wit_6 : arrive_safety_wit_6.
Axiom proof_of_arrive_return_wit_1 : arrive_return_wit_1.
Axiom proof_of_arrive_partial_solve_wit_1 : arrive_partial_solve_wit_1.
Axiom proof_of_arrive_partial_solve_wit_2 : arrive_partial_solve_wit_2.
Axiom proof_of_arrive_precondition_wit_1 : arrive_precondition_wit_1.

End VC_Correct.
