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

(*----- Function tick -----*)

Definition tick_safety_wit_1 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_2 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_3 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_4 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_5 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_6 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_7 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  TT && emp 
.

Definition tick_safety_wit_8 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  TT && emp 
.

Definition tick_safety_wit_9 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  “ False ”
.

Definition tick_safety_wit_10 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  TT && emp 
.

Definition tick_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  “ False ”
.

Definition tick_safety_wit_12 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  TT && emp 
.

Definition tick_safety_wit_13 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  “ False ”
.

Definition tick_safety_wit_14 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  TT && emp 
.

Definition tick_safety_wit_15 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  “ False ”
.

Definition tick_safety_wit_16 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  TT && emp 
.

Definition tick_safety_wit_17 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 3)
|--
  “ False ”
.

Definition tick_safety_wit_18 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_19 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_20 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_21 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_22 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_23 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_safety_wit_24 := 
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  TT && emp 
.

Definition tick_safety_wit_25 := 
forall (PreH1 : False) ,
  ((( &( "s_spec_619" ) )) # Ptr  |-> ( &( "s_spec_619" ) ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  “ False ”
.

Definition tick_return_wit_1 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (record_return: Z) (PreH1 : (wa0___tespec_entry <= 0)) (PreH2 : (wd0___tespec_entry > 0)) (PreH3 : (d0___tespec_entry = 0)) (PreH4 : (a0___tespec_entry <> 0)) (PreH5 : (a0___tespec_entry = 1)) (PreH6 : (d0___tespec_entry <> 1)) (PreH7 : (wa0___tespec_entry <= 0)) (PreH8 : (a0___tespec_entry = 1)) (PreH9 : (t0___tespec_entry <= 0)) (PreH10 : (a0___tespec_entry = 1)) (PreH11 : (c0___tespec_entry = 3)) (PreH12 : (d0___tespec_entry = 0)) (PreH13 : (t0___tespec_entry = 0)) (PreH14 : (wa0___tespec_entry = 0)) (PreH15 : (wd0___tespec_entry = 1)) (PreH16 : (a0___tespec_entry = 1)) (PreH17 : (d0___tespec_entry = 0)) (PreH18 : (wa0___tespec_entry = 0)) (PreH19 : (wd0___tespec_entry = 1)) (PreH20 : (t0___tespec_entry = 0)) (PreH21 : (c0___tespec_entry = 3)) (PreH22 : (0 <= a0___tespec_entry)) (PreH23 : (a0___tespec_entry <= 1)) (PreH24 : (0 <= d0___tespec_entry)) (PreH25 : (d0___tespec_entry <= 1)) (PreH26 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH27 : (wa0___tespec_entry >= 0)) (PreH28 : (wd0___tespec_entry >= 0)) (PreH29 : (0 <= t0___tespec_entry)) (PreH30 : (t0___tespec_entry <= 5)) (PreH31 : (0 <= c0___tespec_entry)) (PreH32 : (c0___tespec_entry <= 3)) (PreH33 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH34 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH35 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH36 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) (PreH37 : (c0___tespec_entry < INT_MAX)) (PreH38 : (wa0___tespec_entry < INT_MAX)) (PreH39 : (wd0___tespec_entry < INT_MAX)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> (t0___tespec_entry + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> (wd0___tespec_entry - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> 0)
|--
  (EX (retval_Plane_Counter: Z)  (retval_Runway_Time: Z)  (retval_W_D: Z)  (retval_W_A: Z)  (retval_ModeD: Z)  (retval_ModeA: Z) ,
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
  &&  “ (retval_ModeA = 1) ” 
  &&  “ (wd0___tespec_entry <= 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter))
  ||
  (EX (retval_Plane_Counter_2: Z)  (retval_Runway_Time_2: Z)  (retval_W_D_2: Z)  (retval_W_A_2: Z)  (retval_ModeD_2: Z)  (retval_ModeA_2: Z) ,
  “ (0 <= retval_ModeA_2) ” 
  &&  “ (retval_ModeA_2 <= 1) ” 
  &&  “ (0 <= retval_ModeD_2) ” 
  &&  “ (retval_ModeD_2 <= 1) ” 
  &&  “ ((retval_ModeA_2 + retval_ModeD_2 ) <= 1) ” 
  &&  “ (retval_W_A_2 >= 0) ” 
  &&  “ (retval_W_D_2 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_2) ” 
  &&  “ (retval_Runway_Time_2 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_2) ” 
  &&  “ (retval_Plane_Counter_2 <= 3) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Runway_Time_2 <= (5 * (retval_ModeA_2 + retval_ModeD_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeA_2 ) + retval_W_D_2 ) )) ” 
  &&  “ (retval_Plane_Counter_2 <= (3 * ((1 - retval_ModeD_2 ) + retval_W_A_2 ) )) ” 
  &&  “ (retval_ModeA_2 = 1) ” 
  &&  “ (wa0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_2))
  ||
  (EX (retval_Plane_Counter_3: Z)  (retval_Runway_Time_3: Z)  (retval_W_D_3: Z)  (retval_W_A_3: Z)  (retval_ModeD_3: Z)  (retval_ModeA_3: Z) ,
  “ (0 <= retval_ModeA_3) ” 
  &&  “ (retval_ModeA_3 <= 1) ” 
  &&  “ (0 <= retval_ModeD_3) ” 
  &&  “ (retval_ModeD_3 <= 1) ” 
  &&  “ ((retval_ModeA_3 + retval_ModeD_3 ) <= 1) ” 
  &&  “ (retval_W_A_3 >= 0) ” 
  &&  “ (retval_W_D_3 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_3) ” 
  &&  “ (retval_Runway_Time_3 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_3) ” 
  &&  “ (retval_Plane_Counter_3 <= 3) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * (retval_ModeA_3 + retval_ModeD_3 ) )) ” 
  &&  “ (retval_Runway_Time_3 <= (5 * (retval_ModeA_3 + retval_ModeD_3 ) )) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * ((1 - retval_ModeA_3 ) + retval_W_D_3 ) )) ” 
  &&  “ (retval_Plane_Counter_3 <= (3 * ((1 - retval_ModeD_3 ) + retval_W_A_3 ) )) ” 
  &&  “ (retval_ModeA_3 = 1) ” 
  &&  “ (t0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_3))
  ||
  (EX (retval_Plane_Counter_4: Z)  (retval_Runway_Time_4: Z)  (retval_W_D_4: Z)  (retval_W_A_4: Z)  (retval_ModeD_4: Z)  (retval_ModeA_4: Z) ,
  “ (0 <= retval_ModeA_4) ” 
  &&  “ (retval_ModeA_4 <= 1) ” 
  &&  “ (0 <= retval_ModeD_4) ” 
  &&  “ (retval_ModeD_4 <= 1) ” 
  &&  “ ((retval_ModeA_4 + retval_ModeD_4 ) <= 1) ” 
  &&  “ (retval_W_A_4 >= 0) ” 
  &&  “ (retval_W_D_4 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_4) ” 
  &&  “ (retval_Runway_Time_4 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_4) ” 
  &&  “ (retval_Plane_Counter_4 <= 3) ” 
  &&  “ (retval_Plane_Counter_4 <= (3 * (retval_ModeA_4 + retval_ModeD_4 ) )) ” 
  &&  “ (retval_Runway_Time_4 <= (5 * (retval_ModeA_4 + retval_ModeD_4 ) )) ” 
  &&  “ (retval_Plane_Counter_4 <= (3 * ((1 - retval_ModeA_4 ) + retval_W_D_4 ) )) ” 
  &&  “ (retval_Plane_Counter_4 <= (3 * ((1 - retval_ModeD_4 ) + retval_W_A_4 ) )) ” 
  &&  “ (retval_ModeA_4 = 1) ” 
  &&  “ (retval_ModeD_4 = 1) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_4))
  ||
  (EX (retval_Plane_Counter_5: Z)  (retval_Runway_Time_5: Z)  (retval_W_D_5: Z)  (retval_W_A_5: Z)  (retval_ModeD_5: Z)  (retval_ModeA_5: Z) ,
  “ (0 <= retval_ModeA_5) ” 
  &&  “ (retval_ModeA_5 <= 1) ” 
  &&  “ (0 <= retval_ModeD_5) ” 
  &&  “ (retval_ModeD_5 <= 1) ” 
  &&  “ ((retval_ModeA_5 + retval_ModeD_5 ) <= 1) ” 
  &&  “ (retval_W_A_5 >= 0) ” 
  &&  “ (retval_W_D_5 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_5) ” 
  &&  “ (retval_Runway_Time_5 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_5) ” 
  &&  “ (retval_Plane_Counter_5 <= 3) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * (retval_ModeA_5 + retval_ModeD_5 ) )) ” 
  &&  “ (retval_Runway_Time_5 <= (5 * (retval_ModeA_5 + retval_ModeD_5 ) )) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * ((1 - retval_ModeA_5 ) + retval_W_D_5 ) )) ” 
  &&  “ (retval_Plane_Counter_5 <= (3 * ((1 - retval_ModeD_5 ) + retval_W_A_5 ) )) ” 
  &&  “ (t0___tespec_entry <> 0) ” 
  &&  “ (wd0___tespec_entry <= 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_5))
  ||
  (EX (retval_Plane_Counter_6: Z)  (retval_Runway_Time_6: Z)  (retval_W_D_6: Z)  (retval_W_A_6: Z)  (retval_ModeD_6: Z)  (retval_ModeA_6: Z) ,
  “ (0 <= retval_ModeA_6) ” 
  &&  “ (retval_ModeA_6 <= 1) ” 
  &&  “ (0 <= retval_ModeD_6) ” 
  &&  “ (retval_ModeD_6 <= 1) ” 
  &&  “ ((retval_ModeA_6 + retval_ModeD_6 ) <= 1) ” 
  &&  “ (retval_W_A_6 >= 0) ” 
  &&  “ (retval_W_D_6 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_6) ” 
  &&  “ (retval_Runway_Time_6 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_6) ” 
  &&  “ (retval_Plane_Counter_6 <= 3) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * (retval_ModeA_6 + retval_ModeD_6 ) )) ” 
  &&  “ (retval_Runway_Time_6 <= (5 * (retval_ModeA_6 + retval_ModeD_6 ) )) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * ((1 - retval_ModeA_6 ) + retval_W_D_6 ) )) ” 
  &&  “ (retval_Plane_Counter_6 <= (3 * ((1 - retval_ModeD_6 ) + retval_W_A_6 ) )) ” 
  &&  “ (t0___tespec_entry <> 0) ” 
  &&  “ (wa0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_6))
  ||
  (EX (retval_Plane_Counter_7: Z)  (retval_Runway_Time_7: Z)  (retval_W_D_7: Z)  (retval_W_A_7: Z)  (retval_ModeD_7: Z)  (retval_ModeA_7: Z) ,
  “ (0 <= retval_ModeA_7) ” 
  &&  “ (retval_ModeA_7 <= 1) ” 
  &&  “ (0 <= retval_ModeD_7) ” 
  &&  “ (retval_ModeD_7 <= 1) ” 
  &&  “ ((retval_ModeA_7 + retval_ModeD_7 ) <= 1) ” 
  &&  “ (retval_W_A_7 >= 0) ” 
  &&  “ (retval_W_D_7 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_7) ” 
  &&  “ (retval_Runway_Time_7 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_7) ” 
  &&  “ (retval_Plane_Counter_7 <= 3) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * (retval_ModeA_7 + retval_ModeD_7 ) )) ” 
  &&  “ (retval_Runway_Time_7 <= (5 * (retval_ModeA_7 + retval_ModeD_7 ) )) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * ((1 - retval_ModeA_7 ) + retval_W_D_7 ) )) ” 
  &&  “ (retval_Plane_Counter_7 <= (3 * ((1 - retval_ModeD_7 ) + retval_W_A_7 ) )) ” 
  &&  “ (t0___tespec_entry <> 0) ” 
  &&  “ (t0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_7))
  ||
  (EX (retval_Plane_Counter_8: Z)  (retval_Runway_Time_8: Z)  (retval_W_D_8: Z)  (retval_W_A_8: Z)  (retval_ModeD_8: Z)  (retval_ModeA_8: Z) ,
  “ (0 <= retval_ModeA_8) ” 
  &&  “ (retval_ModeA_8 <= 1) ” 
  &&  “ (0 <= retval_ModeD_8) ” 
  &&  “ (retval_ModeD_8 <= 1) ” 
  &&  “ ((retval_ModeA_8 + retval_ModeD_8 ) <= 1) ” 
  &&  “ (retval_W_A_8 >= 0) ” 
  &&  “ (retval_W_D_8 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_8) ” 
  &&  “ (retval_Runway_Time_8 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_8) ” 
  &&  “ (retval_Plane_Counter_8 <= 3) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * (retval_ModeA_8 + retval_ModeD_8 ) )) ” 
  &&  “ (retval_Runway_Time_8 <= (5 * (retval_ModeA_8 + retval_ModeD_8 ) )) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * ((1 - retval_ModeA_8 ) + retval_W_D_8 ) )) ” 
  &&  “ (retval_Plane_Counter_8 <= (3 * ((1 - retval_ModeD_8 ) + retval_W_A_8 ) )) ” 
  &&  “ (t0___tespec_entry <> 0) ” 
  &&  “ (retval_ModeD_8 = 1) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_8))
  ||
  (EX (retval_Plane_Counter_9: Z)  (retval_Runway_Time_9: Z)  (retval_W_D_9: Z)  (retval_W_A_9: Z)  (retval_ModeD_9: Z)  (retval_ModeA_9: Z) ,
  “ (0 <= retval_ModeA_9) ” 
  &&  “ (retval_ModeA_9 <= 1) ” 
  &&  “ (0 <= retval_ModeD_9) ” 
  &&  “ (retval_ModeD_9 <= 1) ” 
  &&  “ ((retval_ModeA_9 + retval_ModeD_9 ) <= 1) ” 
  &&  “ (retval_W_A_9 >= 0) ” 
  &&  “ (retval_W_D_9 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_9) ” 
  &&  “ (retval_Runway_Time_9 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_9) ” 
  &&  “ (retval_Plane_Counter_9 <= 3) ” 
  &&  “ (retval_Plane_Counter_9 <= (3 * (retval_ModeA_9 + retval_ModeD_9 ) )) ” 
  &&  “ (retval_Runway_Time_9 <= (5 * (retval_ModeA_9 + retval_ModeD_9 ) )) ” 
  &&  “ (retval_Plane_Counter_9 <= (3 * ((1 - retval_ModeA_9 ) + retval_W_D_9 ) )) ” 
  &&  “ (retval_Plane_Counter_9 <= (3 * ((1 - retval_ModeD_9 ) + retval_W_A_9 ) )) ” 
  &&  “ (wd0___tespec_entry <> 0) ” 
  &&  “ (wd0___tespec_entry <= 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_9)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_9)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_9)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_9)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_9)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_9))
  ||
  (EX (retval_Plane_Counter_10: Z)  (retval_Runway_Time_10: Z)  (retval_W_D_10: Z)  (retval_W_A_10: Z)  (retval_ModeD_10: Z)  (retval_ModeA_10: Z) ,
  “ (0 <= retval_ModeA_10) ” 
  &&  “ (retval_ModeA_10 <= 1) ” 
  &&  “ (0 <= retval_ModeD_10) ” 
  &&  “ (retval_ModeD_10 <= 1) ” 
  &&  “ ((retval_ModeA_10 + retval_ModeD_10 ) <= 1) ” 
  &&  “ (retval_W_A_10 >= 0) ” 
  &&  “ (retval_W_D_10 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_10) ” 
  &&  “ (retval_Runway_Time_10 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_10) ” 
  &&  “ (retval_Plane_Counter_10 <= 3) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Runway_Time_10 <= (5 * (retval_ModeA_10 + retval_ModeD_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeA_10 ) + retval_W_D_10 ) )) ” 
  &&  “ (retval_Plane_Counter_10 <= (3 * ((1 - retval_ModeD_10 ) + retval_W_A_10 ) )) ” 
  &&  “ (wd0___tespec_entry <> 0) ” 
  &&  “ (wa0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_10))
  ||
  (EX (retval_Plane_Counter_11: Z)  (retval_Runway_Time_11: Z)  (retval_W_D_11: Z)  (retval_W_A_11: Z)  (retval_ModeD_11: Z)  (retval_ModeA_11: Z) ,
  “ (0 <= retval_ModeA_11) ” 
  &&  “ (retval_ModeA_11 <= 1) ” 
  &&  “ (0 <= retval_ModeD_11) ” 
  &&  “ (retval_ModeD_11 <= 1) ” 
  &&  “ ((retval_ModeA_11 + retval_ModeD_11 ) <= 1) ” 
  &&  “ (retval_W_A_11 >= 0) ” 
  &&  “ (retval_W_D_11 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_11) ” 
  &&  “ (retval_Runway_Time_11 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_11) ” 
  &&  “ (retval_Plane_Counter_11 <= 3) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * (retval_ModeA_11 + retval_ModeD_11 ) )) ” 
  &&  “ (retval_Runway_Time_11 <= (5 * (retval_ModeA_11 + retval_ModeD_11 ) )) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * ((1 - retval_ModeA_11 ) + retval_W_D_11 ) )) ” 
  &&  “ (retval_Plane_Counter_11 <= (3 * ((1 - retval_ModeD_11 ) + retval_W_A_11 ) )) ” 
  &&  “ (wd0___tespec_entry <> 0) ” 
  &&  “ (t0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_11)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_11)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_11)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_11)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_11)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_11))
  ||
  (EX (retval_Plane_Counter_12: Z)  (retval_Runway_Time_12: Z)  (retval_W_D_12: Z)  (retval_W_A_12: Z)  (retval_ModeD_12: Z)  (retval_ModeA_12: Z) ,
  “ (0 <= retval_ModeA_12) ” 
  &&  “ (retval_ModeA_12 <= 1) ” 
  &&  “ (0 <= retval_ModeD_12) ” 
  &&  “ (retval_ModeD_12 <= 1) ” 
  &&  “ ((retval_ModeA_12 + retval_ModeD_12 ) <= 1) ” 
  &&  “ (retval_W_A_12 >= 0) ” 
  &&  “ (retval_W_D_12 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_12) ” 
  &&  “ (retval_Runway_Time_12 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_12) ” 
  &&  “ (retval_Plane_Counter_12 <= 3) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Runway_Time_12 <= (5 * (retval_ModeA_12 + retval_ModeD_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeA_12 ) + retval_W_D_12 ) )) ” 
  &&  “ (retval_Plane_Counter_12 <= (3 * ((1 - retval_ModeD_12 ) + retval_W_A_12 ) )) ” 
  &&  “ (wd0___tespec_entry <> 0) ” 
  &&  “ (retval_ModeD_12 = 1) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_12)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_12)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_12)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_12)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_12)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_12))
  ||
  (EX (retval_Plane_Counter_13: Z)  (retval_Runway_Time_13: Z)  (retval_W_D_13: Z)  (retval_W_A_13: Z)  (retval_ModeD_13: Z)  (retval_ModeA_13: Z) ,
  “ (0 <= retval_ModeA_13) ” 
  &&  “ (retval_ModeA_13 <= 1) ” 
  &&  “ (0 <= retval_ModeD_13) ” 
  &&  “ (retval_ModeD_13 <= 1) ” 
  &&  “ ((retval_ModeA_13 + retval_ModeD_13 ) <= 1) ” 
  &&  “ (retval_W_A_13 >= 0) ” 
  &&  “ (retval_W_D_13 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_13) ” 
  &&  “ (retval_Runway_Time_13 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_13) ” 
  &&  “ (retval_Plane_Counter_13 <= 3) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Runway_Time_13 <= (5 * (retval_ModeA_13 + retval_ModeD_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeA_13 ) + retval_W_D_13 ) )) ” 
  &&  “ (retval_Plane_Counter_13 <= (3 * ((1 - retval_ModeD_13 ) + retval_W_A_13 ) )) ” 
  &&  “ (wa0___tespec_entry <= 0) ” 
  &&  “ (wd0___tespec_entry <= 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_13)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_13)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_13)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_13)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_13)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_13))
  ||
  (EX (retval_Plane_Counter_14: Z)  (retval_Runway_Time_14: Z)  (retval_W_D_14: Z)  (retval_W_A_14: Z)  (retval_ModeD_14: Z)  (retval_ModeA_14: Z) ,
  “ (0 <= retval_ModeA_14) ” 
  &&  “ (retval_ModeA_14 <= 1) ” 
  &&  “ (0 <= retval_ModeD_14) ” 
  &&  “ (retval_ModeD_14 <= 1) ” 
  &&  “ ((retval_ModeA_14 + retval_ModeD_14 ) <= 1) ” 
  &&  “ (retval_W_A_14 >= 0) ” 
  &&  “ (retval_W_D_14 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_14) ” 
  &&  “ (retval_Runway_Time_14 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_14) ” 
  &&  “ (retval_Plane_Counter_14 <= 3) ” 
  &&  “ (retval_Plane_Counter_14 <= (3 * (retval_ModeA_14 + retval_ModeD_14 ) )) ” 
  &&  “ (retval_Runway_Time_14 <= (5 * (retval_ModeA_14 + retval_ModeD_14 ) )) ” 
  &&  “ (retval_Plane_Counter_14 <= (3 * ((1 - retval_ModeA_14 ) + retval_W_D_14 ) )) ” 
  &&  “ (retval_Plane_Counter_14 <= (3 * ((1 - retval_ModeD_14 ) + retval_W_A_14 ) )) ” 
  &&  “ (wa0___tespec_entry <= 0) ” 
  &&  “ (wa0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_14)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_14)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_14)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_14)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_14)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_14))
  ||
  (EX (retval_Plane_Counter_15: Z)  (retval_Runway_Time_15: Z)  (retval_W_D_15: Z)  (retval_W_A_15: Z)  (retval_ModeD_15: Z)  (retval_ModeA_15: Z) ,
  “ (0 <= retval_ModeA_15) ” 
  &&  “ (retval_ModeA_15 <= 1) ” 
  &&  “ (0 <= retval_ModeD_15) ” 
  &&  “ (retval_ModeD_15 <= 1) ” 
  &&  “ ((retval_ModeA_15 + retval_ModeD_15 ) <= 1) ” 
  &&  “ (retval_W_A_15 >= 0) ” 
  &&  “ (retval_W_D_15 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_15) ” 
  &&  “ (retval_Runway_Time_15 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_15) ” 
  &&  “ (retval_Plane_Counter_15 <= 3) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * (retval_ModeA_15 + retval_ModeD_15 ) )) ” 
  &&  “ (retval_Runway_Time_15 <= (5 * (retval_ModeA_15 + retval_ModeD_15 ) )) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * ((1 - retval_ModeA_15 ) + retval_W_D_15 ) )) ” 
  &&  “ (retval_Plane_Counter_15 <= (3 * ((1 - retval_ModeD_15 ) + retval_W_A_15 ) )) ” 
  &&  “ (wa0___tespec_entry <= 0) ” 
  &&  “ (t0___tespec_entry <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_15)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_15)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_15)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_15)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_15)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_15))
  ||
  (EX (retval_Plane_Counter_16: Z)  (retval_Runway_Time_16: Z)  (retval_W_D_16: Z)  (retval_W_A_16: Z)  (retval_ModeD_16: Z)  (retval_ModeA_16: Z) ,
  “ (0 <= retval_ModeA_16) ” 
  &&  “ (retval_ModeA_16 <= 1) ” 
  &&  “ (0 <= retval_ModeD_16) ” 
  &&  “ (retval_ModeD_16 <= 1) ” 
  &&  “ ((retval_ModeA_16 + retval_ModeD_16 ) <= 1) ” 
  &&  “ (retval_W_A_16 >= 0) ” 
  &&  “ (retval_W_D_16 >= 0) ” 
  &&  “ (0 <= retval_Runway_Time_16) ” 
  &&  “ (retval_Runway_Time_16 <= 5) ” 
  &&  “ (0 <= retval_Plane_Counter_16) ” 
  &&  “ (retval_Plane_Counter_16 <= 3) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Runway_Time_16 <= (5 * (retval_ModeA_16 + retval_ModeD_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeA_16 ) + retval_W_D_16 ) )) ” 
  &&  “ (retval_Plane_Counter_16 <= (3 * ((1 - retval_ModeD_16 ) + retval_W_A_16 ) )) ” 
  &&  “ (wa0___tespec_entry <= 0) ” 
  &&  “ (retval_ModeD_16 = 1) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |-> retval_ModeA_16)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |-> retval_ModeD_16)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |-> retval_W_A_16)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |-> retval_W_D_16)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |-> retval_Runway_Time_16)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |-> retval_Plane_Counter_16))
.

Definition tick_partial_solve_wit_1 := 
forall (c0___tespec_entry: Z) (t0___tespec_entry: Z) (wd0___tespec_entry: Z) (wa0___tespec_entry: Z) (d0___tespec_entry: Z) (a0___tespec_entry: Z) (record_return: Z) (PreH1 : (wa0___tespec_entry <= 0)) (PreH2 : (wd0___tespec_entry > 0)) (PreH3 : (d0___tespec_entry = 0)) (PreH4 : (a0___tespec_entry <> 0)) (PreH5 : (a0___tespec_entry = 1)) (PreH6 : (d0___tespec_entry <> 1)) (PreH7 : (wa0___tespec_entry <= 0)) (PreH8 : (a0___tespec_entry = 1)) (PreH9 : (t0___tespec_entry <= 0)) (PreH10 : (a0___tespec_entry = 1)) (PreH11 : (c0___tespec_entry = 3)) (PreH12 : (d0___tespec_entry = 0)) (PreH13 : (t0___tespec_entry = 0)) (PreH14 : (wa0___tespec_entry = 0)) (PreH15 : (wd0___tespec_entry = 1)) (PreH16 : (a0___tespec_entry = 1)) (PreH17 : (d0___tespec_entry = 0)) (PreH18 : (wa0___tespec_entry = 0)) (PreH19 : (wd0___tespec_entry = 1)) (PreH20 : (t0___tespec_entry = 0)) (PreH21 : (c0___tespec_entry = 3)) (PreH22 : (0 <= a0___tespec_entry)) (PreH23 : (a0___tespec_entry <= 1)) (PreH24 : (0 <= d0___tespec_entry)) (PreH25 : (d0___tespec_entry <= 1)) (PreH26 : ((a0___tespec_entry + d0___tespec_entry ) <= 1)) (PreH27 : (wa0___tespec_entry >= 0)) (PreH28 : (wd0___tespec_entry >= 0)) (PreH29 : (0 <= t0___tespec_entry)) (PreH30 : (t0___tespec_entry <= 5)) (PreH31 : (0 <= c0___tespec_entry)) (PreH32 : (c0___tespec_entry <= 3)) (PreH33 : (c0___tespec_entry <= (3 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH34 : (t0___tespec_entry <= (5 * (a0___tespec_entry + d0___tespec_entry ) ))) (PreH35 : (c0___tespec_entry <= (3 * ((1 - a0___tespec_entry ) + wd0___tespec_entry ) ))) (PreH36 : (c0___tespec_entry <= (3 * ((1 - d0___tespec_entry ) + wa0___tespec_entry ) ))) (PreH37 : (c0___tespec_entry < INT_MAX)) (PreH38 : (wa0___tespec_entry < INT_MAX)) (PreH39 : (wd0___tespec_entry < INT_MAX)) ,
  (UndefStructPredState record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> (wd0___tespec_entry - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> (t0___tespec_entry + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
|--
  “ (wa0___tespec_entry <= 0) ” 
  &&  “ (wd0___tespec_entry > 0) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (a0___tespec_entry <> 0) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry <> 1) ” 
  &&  “ (wa0___tespec_entry <= 0) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (t0___tespec_entry <= 0) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 0) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 0) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (t0___tespec_entry = 0) ” 
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
  &&  “ (c0___tespec_entry < INT_MAX) ” 
  &&  “ (wa0___tespec_entry < INT_MAX) ” 
  &&  “ (wd0___tespec_entry < INT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (record_return + 20)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (record_return + 16)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> (t0___tespec_entry + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (record_return + 12)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> (wd0___tespec_entry - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (record_return + 8)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> 0)
.

Definition tick_precondition_wit_1 :=
exists (c0___tespec_entry: Z) ,
exists (t0___tespec_entry: Z) ,
exists (wd0___tespec_entry: Z) ,
exists (wa0___tespec_entry: Z) ,
exists (d0___tespec_entry: Z) ,
exists (a0___tespec_entry: Z) ,
~ ((  “ (a0___tespec_entry = 1) ” 
  &&  “ (c0___tespec_entry = 3) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (t0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 0) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (a0___tespec_entry = 1) ” 
  &&  “ (d0___tespec_entry = 0) ” 
  &&  “ (wa0___tespec_entry = 0) ” 
  &&  “ (wd0___tespec_entry = 1) ” 
  &&  “ (t0___tespec_entry = 0) ” 
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
  &&  “ (c0___tespec_entry < INT_MAX) ” 
  &&  “ (wa0___tespec_entry < INT_MAX) ” 
  &&  “ (wd0___tespec_entry < INT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "s_spec_619" ) ) + 0)) # Int  |-> a0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "s_spec_619" ) ) + 4)) # Int  |-> d0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (( &( "s_spec_619" ) ) + 8)) # Int  |-> wa0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (( &( "s_spec_619" ) ) + 12)) # Int  |-> wd0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=16; size=4; align=4 *) (( &( "s_spec_619" ) ) + 16)) # Int  |-> t0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=20; size=4; align=4 *) (( &( "s_spec_619" ) ) + 20)) # Int  |-> c0___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_tick_safety_wit_1 : tick_safety_wit_1.
Axiom proof_of_tick_safety_wit_2 : tick_safety_wit_2.
Axiom proof_of_tick_safety_wit_3 : tick_safety_wit_3.
Axiom proof_of_tick_safety_wit_4 : tick_safety_wit_4.
Axiom proof_of_tick_safety_wit_5 : tick_safety_wit_5.
Axiom proof_of_tick_safety_wit_6 : tick_safety_wit_6.
Axiom proof_of_tick_safety_wit_7 : tick_safety_wit_7.
Axiom proof_of_tick_safety_wit_8 : tick_safety_wit_8.
Axiom proof_of_tick_safety_wit_9 : tick_safety_wit_9.
Axiom proof_of_tick_safety_wit_10 : tick_safety_wit_10.
Axiom proof_of_tick_safety_wit_11 : tick_safety_wit_11.
Axiom proof_of_tick_safety_wit_12 : tick_safety_wit_12.
Axiom proof_of_tick_safety_wit_13 : tick_safety_wit_13.
Axiom proof_of_tick_safety_wit_14 : tick_safety_wit_14.
Axiom proof_of_tick_safety_wit_15 : tick_safety_wit_15.
Axiom proof_of_tick_safety_wit_16 : tick_safety_wit_16.
Axiom proof_of_tick_safety_wit_17 : tick_safety_wit_17.
Axiom proof_of_tick_safety_wit_18 : tick_safety_wit_18.
Axiom proof_of_tick_safety_wit_19 : tick_safety_wit_19.
Axiom proof_of_tick_safety_wit_20 : tick_safety_wit_20.
Axiom proof_of_tick_safety_wit_21 : tick_safety_wit_21.
Axiom proof_of_tick_safety_wit_22 : tick_safety_wit_22.
Axiom proof_of_tick_safety_wit_23 : tick_safety_wit_23.
Axiom proof_of_tick_safety_wit_24 : tick_safety_wit_24.
Axiom proof_of_tick_safety_wit_25 : tick_safety_wit_25.
Axiom proof_of_tick_return_wit_1 : tick_return_wit_1.
Axiom proof_of_tick_partial_solve_wit_1 : tick_partial_solve_wit_1.
Axiom proof_of_tick_precondition_wit_1 : tick_precondition_wit_1.

End VC_Correct.
