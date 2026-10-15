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

(*----- Function depart -----*)

Definition depart_safety_wit_1 := 
forall (s_addr_ModeA: Z) (s_addr_ModeD: Z) (s_addr_W_A: Z) (s_addr_W_D: Z) (s_addr_Runway_Time: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_ModeA = 0)) (PreH2 : (s_addr_ModeD = 1)) (PreH3 : (s_addr_W_A = 1)) (PreH4 : (s_addr_W_D = 2)) (PreH5 : (s_addr_Runway_Time = 1)) (PreH6 : (s_addr_Plane_Counter = 1)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> 0)
  **  ((( &( "s_spec_575" ) )) # Ptr  |-> ( &( "s_spec_575" ) ))
|--
  “ ((s_addr_Plane_Counter + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (s_addr_Plane_Counter + 1 )) ”
.

Definition depart_safety_wit_2 := 
forall (s_addr_ModeA: Z) (s_addr_ModeD: Z) (s_addr_W_A: Z) (s_addr_W_D: Z) (s_addr_Runway_Time: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_ModeA = 0)) (PreH2 : (s_addr_ModeD = 1)) (PreH3 : (s_addr_W_A = 1)) (PreH4 : (s_addr_W_D = 2)) (PreH5 : (s_addr_Runway_Time = 1)) (PreH6 : (s_addr_Plane_Counter = 1)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> 0)
  **  ((( &( "s_spec_575" ) )) # Ptr  |-> ( &( "s_spec_575" ) ))
|--
  TT && emp 
.

Definition depart_safety_wit_3 := 
forall (s_addr_ModeA: Z) (s_addr_ModeD: Z) (s_addr_W_A: Z) (s_addr_W_D: Z) (s_addr_Runway_Time: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_ModeA = 0)) (PreH2 : (s_addr_ModeD = 1)) (PreH3 : (s_addr_W_A = 1)) (PreH4 : (s_addr_W_D = 2)) (PreH5 : (s_addr_Runway_Time = 1)) (PreH6 : (s_addr_Plane_Counter = 1)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> 0)
  **  ((( &( "s_spec_575" ) )) # Ptr  |-> ( &( "s_spec_575" ) ))
|--
  “ ((s_addr_W_D - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (s_addr_W_D - 1 )) ”
.

Definition depart_safety_wit_4 := 
forall (s_addr_ModeA: Z) (s_addr_ModeD: Z) (s_addr_W_A: Z) (s_addr_W_D: Z) (s_addr_Runway_Time: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_ModeA = 0)) (PreH2 : (s_addr_ModeD = 1)) (PreH3 : (s_addr_W_A = 1)) (PreH4 : (s_addr_W_D = 2)) (PreH5 : (s_addr_Runway_Time = 1)) (PreH6 : (s_addr_Plane_Counter = 1)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> 0)
  **  ((( &( "s_spec_575" ) )) # Ptr  |-> ( &( "s_spec_575" ) ))
|--
  TT && emp 
.

Definition depart_safety_wit_5 := 
forall (s_addr_ModeA: Z) (s_addr_ModeD: Z) (s_addr_W_A: Z) (s_addr_W_D: Z) (s_addr_Runway_Time: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_ModeA = 0)) (PreH2 : (s_addr_ModeD = 1)) (PreH3 : (s_addr_W_A = 1)) (PreH4 : (s_addr_W_D = 2)) (PreH5 : (s_addr_Runway_Time = 1)) (PreH6 : (s_addr_Plane_Counter = 1)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> 0)
  **  ((( &( "s_spec_575" ) )) # Ptr  |-> ( &( "s_spec_575" ) ))
|--
  TT && emp 
.

Definition depart_safety_wit_6 := 
forall (PreH1 : False) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> 0)
  **  ((( &( "s_spec_575" ) )) # Ptr  |-> ( &( "s_spec_575" ) ))
|--
  “ False ”
.

Definition depart_return_wit_1 := 
(
forall (s_addr_ModeA_2: Z) (s_addr_ModeD_2: Z) (s_addr_W_A_2: Z) (s_addr_W_D: Z) (s_addr_Runway_Time_2: Z) (s_addr_Plane_Counter: Z) (record_return: Z) (PreH1 : (s_addr_W_A_2 > 0)) (PreH2 : (s_addr_ModeA_2 = 0)) (PreH3 : (s_addr_ModeD_2 = 1)) (PreH4 : (s_addr_W_A_2 = 1)) (PreH5 : (s_addr_W_D = 2)) (PreH6 : (s_addr_Runway_Time_2 = 1)) (PreH7 : (s_addr_Plane_Counter = 1)) (PreH8 : (0 <= s_addr_ModeA_2)) (PreH9 : (s_addr_ModeA_2 <= 1)) (PreH10 : (0 <= s_addr_ModeD_2)) (PreH11 : (s_addr_ModeD_2 <= 1)) (PreH12 : ((s_addr_ModeA_2 + s_addr_ModeD_2 ) <= 1)) (PreH13 : (s_addr_W_A_2 >= 0)) (PreH14 : (s_addr_W_D >= 0)) (PreH15 : (0 <= s_addr_Runway_Time_2)) (PreH16 : (s_addr_Runway_Time_2 <= 5)) (PreH17 : (0 <= s_addr_Plane_Counter)) (PreH18 : (s_addr_Plane_Counter <= 3)) (PreH19 : (s_addr_Plane_Counter <= (3 * (s_addr_ModeA_2 + s_addr_ModeD_2 ) ))) (PreH20 : (s_addr_Runway_Time_2 <= (5 * (s_addr_ModeA_2 + s_addr_ModeD_2 ) ))) (PreH21 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA_2 ) + s_addr_W_D ) ))) (PreH22 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD_2 ) + s_addr_W_A_2 ) ))) (PreH23 : (s_addr_ModeD_2 = 1)) (PreH24 : (s_addr_W_D >= 1)) (PreH25 : (s_addr_Plane_Counter <= 2)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> (s_addr_Plane_Counter + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> s_addr_Runway_Time_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> (s_addr_W_D - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> s_addr_W_A_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> s_addr_ModeD_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> s_addr_ModeA_2)
|--
  EX (s_addr_Runway_Time: Z)  (s_addr_W_A: Z)  (s_addr_ModeD: Z)  (s_addr_ModeA: Z)  (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
  “ (0 <= retval_ModeA) ” 
  &&  “ (retval_ModeA <= 1) ” 
  &&  “ (0 <= retval_ModeD) ” 
  &&  “ (retval_ModeD <= 1) ” 
  &&  “ ((retval_ModeA + retval_ModeD ) <= 1) ” 
  &&  “ (retval_W_A >= 0) ” 
  &&  “ (retval_W_D >= 0) ” 
  &&  “ (0 <= retval_Runway_Time) ” 
  &&  “ (retval_Runway_Time <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter) ” 
  &&  “ (retval_Plane_Counter <= 3) ” 
  &&  “ (retval_Plane_Counter <= (3 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Runway_Time <= (5 * (retval_ModeA + retval_ModeD ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeA ) + retval_W_D ) )) ” 
  &&  “ (retval_Plane_Counter <= (3 * ((1 - retval_ModeD ) + retval_W_A ) )) ” 
  &&  “ (retval_ModeA = s_addr_ModeA) ” 
  &&  “ (retval_ModeD = s_addr_ModeD) ” 
  &&  “ (retval_W_A = s_addr_W_A) ” 
  &&  “ (retval_Runway_Time = s_addr_Runway_Time) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
) \/
(
forall (s_addr_ModeA_2: Z) (s_addr_ModeD_2: Z) (s_addr_W_A_2: Z) (s_addr_W_D: Z) (s_addr_Runway_Time_2: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_W_A_2 > 0)) (PreH2 : (s_addr_ModeA_2 = 0)) (PreH3 : (s_addr_ModeD_2 = 1)) (PreH4 : (s_addr_W_A_2 = 1)) (PreH5 : (s_addr_W_D = 2)) (PreH6 : (s_addr_Runway_Time_2 = 1)) (PreH7 : (s_addr_Plane_Counter = 1)) (PreH8 : (0 <= s_addr_ModeA_2)) (PreH9 : (s_addr_ModeA_2 <= 1)) (PreH10 : (0 <= s_addr_ModeD_2)) (PreH11 : (s_addr_ModeD_2 <= 1)) (PreH12 : ((s_addr_ModeA_2 + s_addr_ModeD_2 ) <= 1)) (PreH13 : (s_addr_W_A_2 >= 0)) (PreH14 : (s_addr_W_D >= 0)) (PreH15 : (0 <= s_addr_Runway_Time_2)) (PreH16 : (s_addr_Runway_Time_2 <= 5)) (PreH17 : (0 <= s_addr_Plane_Counter)) (PreH18 : (s_addr_Plane_Counter <= 3)) (PreH19 : (s_addr_Plane_Counter <= (3 * (s_addr_ModeA_2 + s_addr_ModeD_2 ) ))) (PreH20 : (s_addr_Runway_Time_2 <= (5 * (s_addr_ModeA_2 + s_addr_ModeD_2 ) ))) (PreH21 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA_2 ) + s_addr_W_D ) ))) (PreH22 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD_2 ) + s_addr_W_A_2 ) ))) (PreH23 : (s_addr_ModeD_2 = 1)) (PreH24 : (s_addr_W_D >= 1)) (PreH25 : (s_addr_Plane_Counter <= 2)) ,
  TT && emp 
|--
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time_2)
).

Definition depart_return_wit_1_split_goal_spatial := 
forall (s_addr_ModeA_2: Z) (s_addr_ModeD_2: Z) (s_addr_W_A_2: Z) (s_addr_W_D: Z) (s_addr_Runway_Time_2: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_W_A_2 > 0)) (PreH2 : (s_addr_ModeA_2 = 0)) (PreH3 : (s_addr_ModeD_2 = 1)) (PreH4 : (s_addr_W_A_2 = 1)) (PreH5 : (s_addr_W_D = 2)) (PreH6 : (s_addr_Runway_Time_2 = 1)) (PreH7 : (s_addr_Plane_Counter = 1)) (PreH8 : (0 <= s_addr_ModeA_2)) (PreH9 : (s_addr_ModeA_2 <= 1)) (PreH10 : (0 <= s_addr_ModeD_2)) (PreH11 : (s_addr_ModeD_2 <= 1)) (PreH12 : ((s_addr_ModeA_2 + s_addr_ModeD_2 ) <= 1)) (PreH13 : (s_addr_W_A_2 >= 0)) (PreH14 : (s_addr_W_D >= 0)) (PreH15 : (0 <= s_addr_Runway_Time_2)) (PreH16 : (s_addr_Runway_Time_2 <= 5)) (PreH17 : (0 <= s_addr_Plane_Counter)) (PreH18 : (s_addr_Plane_Counter <= 3)) (PreH19 : (s_addr_Plane_Counter <= (3 * (s_addr_ModeA_2 + s_addr_ModeD_2 ) ))) (PreH20 : (s_addr_Runway_Time_2 <= (5 * (s_addr_ModeA_2 + s_addr_ModeD_2 ) ))) (PreH21 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA_2 ) + s_addr_W_D ) ))) (PreH22 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD_2 ) + s_addr_W_A_2 ) ))) (PreH23 : (s_addr_ModeD_2 = 1)) (PreH24 : (s_addr_W_D >= 1)) (PreH25 : (s_addr_Plane_Counter <= 2)) ,
  TT && emp 
|--
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time_2)
.

Definition depart_partial_solve_wit_1 := 
forall (s_addr_ModeA: Z) (s_addr_ModeD: Z) (s_addr_W_A: Z) (s_addr_W_D: Z) (s_addr_Runway_Time: Z) (s_addr_Plane_Counter: Z) (record_return: Z) (PreH1 : (s_addr_W_A > 0)) (PreH2 : (s_addr_ModeA = 0)) (PreH3 : (s_addr_ModeD = 1)) (PreH4 : (s_addr_W_A = 1)) (PreH5 : (s_addr_W_D = 2)) (PreH6 : (s_addr_Runway_Time = 1)) (PreH7 : (s_addr_Plane_Counter = 1)) (PreH8 : (0 <= s_addr_ModeA)) (PreH9 : (s_addr_ModeA <= 1)) (PreH10 : (0 <= s_addr_ModeD)) (PreH11 : (s_addr_ModeD <= 1)) (PreH12 : ((s_addr_ModeA + s_addr_ModeD ) <= 1)) (PreH13 : (s_addr_W_A >= 0)) (PreH14 : (s_addr_W_D >= 0)) (PreH15 : (0 <= s_addr_Runway_Time)) (PreH16 : (s_addr_Runway_Time <= 5)) (PreH17 : (0 <= s_addr_Plane_Counter)) (PreH18 : (s_addr_Plane_Counter <= 3)) (PreH19 : (s_addr_Plane_Counter <= (3 * (s_addr_ModeA + s_addr_ModeD ) ))) (PreH20 : (s_addr_Runway_Time <= (5 * (s_addr_ModeA + s_addr_ModeD ) ))) (PreH21 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA ) + s_addr_W_D ) ))) (PreH22 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD ) + s_addr_W_A ) ))) (PreH23 : (s_addr_ModeD = 1)) (PreH24 : (s_addr_W_D >= 1)) (PreH25 : (s_addr_Plane_Counter <= 2)) ,
  (UndefStructPredState record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> (s_addr_Plane_Counter + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> s_addr_Plane_Counter)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> (s_addr_W_D - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> s_addr_W_D)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> s_addr_ModeA)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA)
|--
  “ (s_addr_W_A > 0) ” 
  &&  “ (s_addr_ModeA = 0) ” 
  &&  “ (s_addr_ModeD = 1) ” 
  &&  “ (s_addr_W_A = 1) ” 
  &&  “ (s_addr_W_D = 2) ” 
  &&  “ (s_addr_Runway_Time = 1) ” 
  &&  “ (s_addr_Plane_Counter = 1) ” 
  &&  “ (0 <= s_addr_ModeA) ” 
  &&  “ (s_addr_ModeA <= 1) ” 
  &&  “ (0 <= s_addr_ModeD) ” 
  &&  “ (s_addr_ModeD <= 1) ” 
  &&  “ ((s_addr_ModeA + s_addr_ModeD ) <= 1) ” 
  &&  “ (s_addr_W_A >= 0) ” 
  &&  “ (s_addr_W_D >= 0) ” 
  &&  “ (0 <= s_addr_Runway_Time) ” 
  &&  “ (s_addr_Runway_Time <= 5) ” 
  &&  “ (0 <= s_addr_Plane_Counter) ” 
  &&  “ (s_addr_Plane_Counter <= 3) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * (s_addr_ModeA + s_addr_ModeD ) )) ” 
  &&  “ (s_addr_Runway_Time <= (5 * (s_addr_ModeA + s_addr_ModeD ) )) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA ) + s_addr_W_D ) )) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD ) + s_addr_W_A ) )) ” 
  &&  “ (s_addr_ModeD = 1) ” 
  &&  “ (s_addr_W_D >= 1) ” 
  &&  “ (s_addr_Plane_Counter <= 2) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |-> (s_addr_Plane_Counter + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |-> (s_addr_W_D - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |-> s_addr_ModeA)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> s_addr_Plane_Counter)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> s_addr_W_D)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA)
.

Definition depart_partial_solve_wit_2 := 
forall (s_addr_ModeA: Z) (s_addr_ModeD: Z) (s_addr_W_A: Z) (s_addr_W_D: Z) (s_addr_Runway_Time: Z) (s_addr_Plane_Counter: Z) (PreH1 : (s_addr_ModeA = 0)) (PreH2 : (s_addr_ModeD = 1)) (PreH3 : (s_addr_W_A = 1)) (PreH4 : (s_addr_W_D = 2)) (PreH5 : (s_addr_Runway_Time = 1)) (PreH6 : (s_addr_Plane_Counter = 1)) (PreH7 : (0 <= s_addr_ModeA)) (PreH8 : (s_addr_ModeA <= 1)) (PreH9 : (0 <= s_addr_ModeD)) (PreH10 : (s_addr_ModeD <= 1)) (PreH11 : ((s_addr_ModeA + s_addr_ModeD ) <= 1)) (PreH12 : (s_addr_W_A >= 0)) (PreH13 : (s_addr_W_D >= 0)) (PreH14 : (0 <= s_addr_Runway_Time)) (PreH15 : (s_addr_Runway_Time <= 5)) (PreH16 : (0 <= s_addr_Plane_Counter)) (PreH17 : (s_addr_Plane_Counter <= 3)) (PreH18 : (s_addr_Plane_Counter <= (3 * (s_addr_ModeA + s_addr_ModeD ) ))) (PreH19 : (s_addr_Runway_Time <= (5 * (s_addr_ModeA + s_addr_ModeD ) ))) (PreH20 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA ) + s_addr_W_D ) ))) (PreH21 : (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD ) + s_addr_W_A ) ))) (PreH22 : (s_addr_ModeD = 1)) (PreH23 : (s_addr_W_D >= 1)) (PreH24 : (s_addr_Plane_Counter <= 2)) ,
  (UndefStructPredState ( &( "temp_spec_756" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> s_addr_W_D)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> s_addr_Plane_Counter)
|--
  “ (s_addr_ModeA = 0) ” 
  &&  “ (s_addr_ModeD = 1) ” 
  &&  “ (s_addr_W_A = 1) ” 
  &&  “ (s_addr_W_D = 2) ” 
  &&  “ (s_addr_Runway_Time = 1) ” 
  &&  “ (s_addr_Plane_Counter = 1) ” 
  &&  “ (0 <= s_addr_ModeA) ” 
  &&  “ (s_addr_ModeA <= 1) ” 
  &&  “ (0 <= s_addr_ModeD) ” 
  &&  “ (s_addr_ModeD <= 1) ” 
  &&  “ ((s_addr_ModeA + s_addr_ModeD ) <= 1) ” 
  &&  “ (s_addr_W_A >= 0) ” 
  &&  “ (s_addr_W_D >= 0) ” 
  &&  “ (0 <= s_addr_Runway_Time) ” 
  &&  “ (s_addr_Runway_Time <= 5) ” 
  &&  “ (0 <= s_addr_Plane_Counter) ” 
  &&  “ (s_addr_Plane_Counter <= 3) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * (s_addr_ModeA + s_addr_ModeD ) )) ” 
  &&  “ (s_addr_Runway_Time <= (5 * (s_addr_ModeA + s_addr_ModeD ) )) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA ) + s_addr_W_D ) )) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD ) + s_addr_W_A ) )) ” 
  &&  “ (s_addr_ModeD = 1) ” 
  &&  “ (s_addr_W_D >= 1) ” 
  &&  “ (s_addr_Plane_Counter <= 2) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> s_addr_Plane_Counter)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> s_addr_W_D)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "temp_spec_756" ) ) + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA)
.

Definition depart_precondition_wit_1 :=
~ ((  EX (s_addr_Plane_Counter: Z)  (s_addr_Runway_Time: Z)  (s_addr_W_D: Z)  (s_addr_W_A: Z)  (s_addr_ModeD: Z)  (s_addr_ModeA: Z) ,
  “ (s_addr_ModeA = 0) ” 
  &&  “ (s_addr_ModeD = 1) ” 
  &&  “ (s_addr_W_A = 1) ” 
  &&  “ (s_addr_W_D = 2) ” 
  &&  “ (s_addr_Runway_Time = 1) ” 
  &&  “ (s_addr_Plane_Counter = 1) ” 
  &&  “ (0 <= s_addr_ModeA) ” 
  &&  “ (s_addr_ModeA <= 1) ” 
  &&  “ (0 <= s_addr_ModeD) ” 
  &&  “ (s_addr_ModeD <= 1) ” 
  &&  “ ((s_addr_ModeA + s_addr_ModeD ) <= 1) ” 
  &&  “ (s_addr_W_A >= 0) ” 
  &&  “ (s_addr_W_D >= 0) ” 
  &&  “ (0 <= s_addr_Runway_Time) ” 
  &&  “ (s_addr_Runway_Time <= 5) ” 
  &&  “ (0 <= s_addr_Plane_Counter) ” 
  &&  “ (s_addr_Plane_Counter <= 3) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * (s_addr_ModeA + s_addr_ModeD ) )) ” 
  &&  “ (s_addr_Runway_Time <= (5 * (s_addr_ModeA + s_addr_ModeD ) )) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeA ) + s_addr_W_D ) )) ” 
  &&  “ (s_addr_Plane_Counter <= (3 * ((1 - s_addr_ModeD ) + s_addr_W_A ) )) ” 
  &&  “ (s_addr_ModeD = 1) ” 
  &&  “ (s_addr_W_D >= 1) ” 
  &&  “ (s_addr_Plane_Counter <= 2) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_575" ) ) + 0)) # Int  |-> s_addr_ModeA)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_575" ) ) + 4)) # Int  |-> s_addr_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_575" ) ) + 8)) # Int  |-> s_addr_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_575" ) ) + 12)) # Int  |-> s_addr_W_D)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_575" ) ) + 16)) # Int  |-> s_addr_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_575" ) ) + 20)) # Int  |-> s_addr_Plane_Counter)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_depart_safety_wit_1 : depart_safety_wit_1.
Axiom proof_of_depart_safety_wit_2 : depart_safety_wit_2.
Axiom proof_of_depart_safety_wit_3 : depart_safety_wit_3.
Axiom proof_of_depart_safety_wit_4 : depart_safety_wit_4.
Axiom proof_of_depart_safety_wit_5 : depart_safety_wit_5.
Axiom proof_of_depart_safety_wit_6 : depart_safety_wit_6.
Axiom proof_of_depart_return_wit_1 : depart_return_wit_1.
Axiom proof_of_depart_partial_solve_wit_1 : depart_partial_solve_wit_1.
Axiom proof_of_depart_partial_solve_wit_2 : depart_partial_solve_wit_2.
Axiom proof_of_depart_precondition_wit_1 : depart_precondition_wit_1.

End VC_Correct.
