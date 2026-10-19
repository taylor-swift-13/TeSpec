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

(*----- Function composite_loop_dll -----*)

Definition composite_loop_dll_safety_wit_1 := 
  ((( &( "total_spec_481" ) )) # Int  |-> 3)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 32768)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 4)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_2 := 
  ((( &( "total_spec_481" ) )) # Int  |-> 3)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 32768)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 4)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_3 := 
  ((( &( "node_spec_483" ) )) # Ptr  |-> 32768)
  **  ((( &( "total_spec_481" ) )) # Int  |-> 3)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 32768)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_4 := 
  ((( &( "node_spec_483" ) )) # Ptr  |-> 32768)
  **  ((( &( "total_spec_481" ) )) # Int  |-> 3)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 32768)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_5 := 
  ((( &( "node_spec_483" ) )) # Ptr  |-> 32768)
  **  ((( &( "total_spec_481" ) )) # Int  |-> 3)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 32768)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_6 := 
  ((( &( "total_spec_481" ) )) # Int  |-> 0)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_7 := 
  ((( &( "total_spec_481" ) )) # Int  |-> 0)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_8 := 
  ((( &( "node_spec_482" ) )) # Ptr  |-> 28672)
  **  ((( &( "total_spec_481" ) )) # Int  |-> 0)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> (-5))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_9 := 
  ((( &( "node_spec_482" ) )) # Ptr  |-> 28672)
  **  ((( &( "total_spec_481" ) )) # Int  |-> 0)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> (-5))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_10 := 
  ((( &( "node_spec_482" ) )) # Ptr  |-> 28672)
  **  ((( &( "total_spec_481" ) )) # Int  |-> 0)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> (-5))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_11 := 
  ((( &( "total_spec_481" ) )) # Int  |->_)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> (-5))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_12 := 
  ((( &( "total_spec_481" ) )) # Int  |-> 0)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> (-5))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_13 := 
forall (PreH1 : False) ,
  ((( &( "total_spec_481" ) )) # Int  |-> 0)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 28672)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> (-5))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  “ False ”
.

Definition composite_loop_dll_safety_wit_14 := 
  ((( &( "total_spec_481" ) )) # Int  |-> 3)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 32768)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_safety_wit_15 := 
forall (PreH1 : False) ,
  ((( &( "total_spec_481" ) )) # Int  |-> 3)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 32768)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 7)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  “ False ”
.

Definition composite_loop_dll_safety_wit_16 := 
  ((( &( "total_spec_481" ) )) # Int  |-> 7)
  **  ((( &( "cursor_spec_478" ) )) # Ptr  |-> 0)
  **  ((( &( "head_spec_453" ) )) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (28672 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (28672 + 4)) # Ptr  |-> 32768)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0)) # Int  |-> 3)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 0) + (1 * 4))) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (28672 + 8) + 8)) # Int  |-> 8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (32768 + 0)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (32768 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0)) # Int  |-> 4)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 0) + (1 * 4))) # Int  |-> (-2))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (32768 + 8) + 8)) # Int  |-> (-3))
|--
  TT && emp 
.

Definition composite_loop_dll_return_wit_1 := 
forall (head_pre: Z) (expected___tespec_entry: Z) (td___tespec_entry: Z) (t1___tespec_entry: Z) (t0___tespec_entry: Z) (hd___tespec_entry: Z) (h1___tespec_entry: Z) (h0___tespec_entry: Z) (tail___tespec_entry: Z) (PreH1 : (tail___tespec_entry <> 0)) (PreH2 : (head_pre <> 0)) (PreH3 : (head_pre = 28672)) (PreH4 : (expected___tespec_entry = 7)) (PreH5 : (h0___tespec_entry = (-5))) (PreH6 : (h1___tespec_entry = 4)) (PreH7 : (hd___tespec_entry = 8)) (PreH8 : (t0___tespec_entry = 7)) (PreH9 : (t1___tespec_entry = (-2))) (PreH10 : (tail___tespec_entry = 32768)) (PreH11 : (td___tespec_entry = (-3))) (PreH12 : (tail___tespec_entry <> 0)) (PreH13 : (expected___tespec_entry = (((h0___tespec_entry + hd___tespec_entry ) + t0___tespec_entry ) + td___tespec_entry ))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (head_pre + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (head_pre + 4)) # Ptr  |-> tail___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 0)) # Int  |-> (h0___tespec_entry + hd___tespec_entry ))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 0) + (1 * sizeof(INT)))) # Int  |-> h1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 8)) # Int  |-> hd___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (tail___tespec_entry + 0)) # Ptr  |-> head_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (tail___tespec_entry + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 0)) # Int  |-> (t0___tespec_entry + td___tespec_entry ))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 0) + (1 * sizeof(INT)))) # Int  |-> t1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 8)) # Int  |-> td___tespec_entry)
|--
  “ (((0 + (h0___tespec_entry + hd___tespec_entry ) ) + (t0___tespec_entry + td___tespec_entry ) ) = expected___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (head_pre + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (head_pre + 4)) # Ptr  |-> tail___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 0)) # Int  |-> (h0___tespec_entry + hd___tespec_entry ))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 0) + (1 * sizeof(INT)))) # Int  |-> h1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 8)) # Int  |-> hd___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (tail___tespec_entry + 0)) # Ptr  |-> head_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (tail___tespec_entry + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 0)) # Int  |-> (t0___tespec_entry + td___tespec_entry ))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 0) + (1 * sizeof(INT)))) # Int  |-> t1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 8)) # Int  |-> td___tespec_entry)
.

Definition composite_loop_dll_precondition_wit_1 :=
exists (head_pre: Z) ,
exists (expected___tespec_entry: Z) ,
exists (td___tespec_entry: Z) ,
exists (t1___tespec_entry: Z) ,
exists (t0___tespec_entry: Z) ,
exists (hd___tespec_entry: Z) ,
exists (h1___tespec_entry: Z) ,
exists (h0___tespec_entry: Z) ,
exists (tail___tespec_entry: Z) ,
~ ((  “ (head_pre = 28672) ” 
  &&  “ (expected___tespec_entry = 7) ” 
  &&  “ (h0___tespec_entry = (-5)) ” 
  &&  “ (h1___tespec_entry = 4) ” 
  &&  “ (hd___tespec_entry = 8) ” 
  &&  “ (t0___tespec_entry = 7) ” 
  &&  “ (t1___tespec_entry = (-2)) ” 
  &&  “ (tail___tespec_entry = 32768) ” 
  &&  “ (td___tespec_entry = (-3)) ” 
  &&  “ (tail___tespec_entry <> 0) ” 
  &&  “ (expected___tespec_entry = (((h0___tespec_entry + hd___tespec_entry ) + t0___tespec_entry ) + td___tespec_entry )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (head_pre + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (head_pre + 4)) # Ptr  |-> tail___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 0)) # Int  |-> h0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 0) + (1 * sizeof(INT)))) # Int  |-> h1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (head_pre + 8) + 8)) # Int  |-> hd___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (tail___tespec_entry + 0)) # Ptr  |-> head_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (tail___tespec_entry + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 0)) # Int  |-> t0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 0) + (1 * sizeof(INT)))) # Int  |-> t1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (tail___tespec_entry + 8) + 8)) # Int  |-> td___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_composite_loop_dll_safety_wit_1 : composite_loop_dll_safety_wit_1.
Axiom proof_of_composite_loop_dll_safety_wit_2 : composite_loop_dll_safety_wit_2.
Axiom proof_of_composite_loop_dll_safety_wit_3 : composite_loop_dll_safety_wit_3.
Axiom proof_of_composite_loop_dll_safety_wit_4 : composite_loop_dll_safety_wit_4.
Axiom proof_of_composite_loop_dll_safety_wit_5 : composite_loop_dll_safety_wit_5.
Axiom proof_of_composite_loop_dll_safety_wit_6 : composite_loop_dll_safety_wit_6.
Axiom proof_of_composite_loop_dll_safety_wit_7 : composite_loop_dll_safety_wit_7.
Axiom proof_of_composite_loop_dll_safety_wit_8 : composite_loop_dll_safety_wit_8.
Axiom proof_of_composite_loop_dll_safety_wit_9 : composite_loop_dll_safety_wit_9.
Axiom proof_of_composite_loop_dll_safety_wit_10 : composite_loop_dll_safety_wit_10.
Axiom proof_of_composite_loop_dll_safety_wit_11 : composite_loop_dll_safety_wit_11.
Axiom proof_of_composite_loop_dll_safety_wit_12 : composite_loop_dll_safety_wit_12.
Axiom proof_of_composite_loop_dll_safety_wit_13 : composite_loop_dll_safety_wit_13.
Axiom proof_of_composite_loop_dll_safety_wit_14 : composite_loop_dll_safety_wit_14.
Axiom proof_of_composite_loop_dll_safety_wit_15 : composite_loop_dll_safety_wit_15.
Axiom proof_of_composite_loop_dll_safety_wit_16 : composite_loop_dll_safety_wit_16.
Axiom proof_of_composite_loop_dll_return_wit_1 : composite_loop_dll_return_wit_1.
Axiom proof_of_composite_loop_dll_precondition_wit_1 : composite_loop_dll_precondition_wit_1.

End VC_Correct.
