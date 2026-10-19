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

(*----- Function composite_recursive_sll -----*)

Definition composite_recursive_sll_safety_wit_1 := 
  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_2 := 
  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_3 := 
  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_4 := 
  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_5 := 
  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_6 := 
  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_7 := 
  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_8 := 
  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_9 := 
  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_10 := 
  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_11 := 
  ((( &( "node_spec_475" ) )) # Ptr  |-> 0)
  **  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_12 := 
  ((( &( "node_spec_475" ) )) # Ptr  |-> 0)
  **  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_13 := 
  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_14 := 
forall (PreH1 : False) ,
  ((( &( "node_spec_474" ) )) # Ptr  |-> 16384)
  **  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  “ False ”
.

Definition composite_recursive_sll_safety_wit_15 := 
  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition composite_recursive_sll_safety_wit_16 := 
forall (PreH1 : False) ,
  ((( &( "node_spec_473" ) )) # Ptr  |-> 12288)
  **  ((( &( "head_spec_450" ) )) # Ptr  |-> 12288)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0)) # Int  |-> (-4))
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 0) + (1 * 4))) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (12288 + 0) + 8)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (12288 + 12)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0)) # Int  |-> 9)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 0) + (1 * 4))) # Int  |-> (-3))
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (16384 + 0) + 8)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (16384 + 12)) # Ptr  |-> 0)
|--
  “ False ”
.

Definition composite_recursive_sll_return_wit_1 := 
forall (head_pre: Z) (expected___tespec_entry: Z) (bb___tespec_entry: Z) (b1___tespec_entry: Z) (b0___tespec_entry: Z) (ab___tespec_entry: Z) (a1___tespec_entry: Z) (a0___tespec_entry: Z) (second___tespec_entry: Z) (PreH1 : (second___tespec_entry <> 0)) (PreH2 : (head_pre <> 0)) (PreH3 : (head_pre = 12288)) (PreH4 : (a0___tespec_entry = (-4))) (PreH5 : (a1___tespec_entry = 7)) (PreH6 : (ab___tespec_entry = 2)) (PreH7 : (b0___tespec_entry = 9)) (PreH8 : (b1___tespec_entry = (-3))) (PreH9 : (bb___tespec_entry = 1)) (PreH10 : (expected___tespec_entry = 12)) (PreH11 : (second___tespec_entry = 16384)) (PreH12 : (second___tespec_entry <> 0)) (PreH13 : (expected___tespec_entry = (((((a0___tespec_entry + a1___tespec_entry ) + ab___tespec_entry ) + b0___tespec_entry ) + b1___tespec_entry ) + bb___tespec_entry ))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 0)) # Int  |-> a0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 0) + (1 * sizeof(INT)))) # Int  |-> a1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 8)) # Int  |-> ab___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (head_pre + 12)) # Ptr  |-> second___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 0)) # Int  |-> b0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 0) + (1 * sizeof(INT)))) # Int  |-> b1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 8)) # Int  |-> bb___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (second___tespec_entry + 12)) # Ptr  |-> 0)
|--
  “ ((((a0___tespec_entry + a1___tespec_entry ) + ab___tespec_entry ) + (((b0___tespec_entry + b1___tespec_entry ) + bb___tespec_entry ) + 0 ) ) = expected___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 0)) # Int  |-> a0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 0) + (1 * sizeof(INT)))) # Int  |-> a1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 8)) # Int  |-> ab___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (head_pre + 12)) # Ptr  |-> second___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 0)) # Int  |-> b0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 0) + (1 * sizeof(INT)))) # Int  |-> b1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 8)) # Int  |-> bb___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (second___tespec_entry + 12)) # Ptr  |-> 0)
.

Definition composite_recursive_sll_precondition_wit_1 :=
exists (head_pre: Z) ,
exists (expected___tespec_entry: Z) ,
exists (bb___tespec_entry: Z) ,
exists (b1___tespec_entry: Z) ,
exists (b0___tespec_entry: Z) ,
exists (ab___tespec_entry: Z) ,
exists (a1___tespec_entry: Z) ,
exists (a0___tespec_entry: Z) ,
exists (second___tespec_entry: Z) ,
~ ((  “ (head_pre = 12288) ” 
  &&  “ (a0___tespec_entry = (-4)) ” 
  &&  “ (a1___tespec_entry = 7) ” 
  &&  “ (ab___tespec_entry = 2) ” 
  &&  “ (b0___tespec_entry = 9) ” 
  &&  “ (b1___tespec_entry = (-3)) ” 
  &&  “ (bb___tespec_entry = 1) ” 
  &&  “ (expected___tespec_entry = 12) ” 
  &&  “ (second___tespec_entry = 16384) ” 
  &&  “ (second___tespec_entry <> 0) ” 
  &&  “ (expected___tespec_entry = (((((a0___tespec_entry + a1___tespec_entry ) + ab___tespec_entry ) + b0___tespec_entry ) + b1___tespec_entry ) + bb___tespec_entry )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 0)) # Int  |-> a0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 0) + (1 * sizeof(INT)))) # Int  |-> a1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (head_pre + 0) + 8)) # Int  |-> ab___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (head_pre + 12)) # Ptr  |-> second___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 0)) # Int  |-> b0___tespec_entry)
  **  ((((* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 0) + (1 * sizeof(INT)))) # Int  |-> b1___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (second___tespec_entry + 0) + 8)) # Int  |-> bb___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (second___tespec_entry + 12)) # Ptr  |-> 0)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_composite_recursive_sll_safety_wit_1 : composite_recursive_sll_safety_wit_1.
Axiom proof_of_composite_recursive_sll_safety_wit_2 : composite_recursive_sll_safety_wit_2.
Axiom proof_of_composite_recursive_sll_safety_wit_3 : composite_recursive_sll_safety_wit_3.
Axiom proof_of_composite_recursive_sll_safety_wit_4 : composite_recursive_sll_safety_wit_4.
Axiom proof_of_composite_recursive_sll_safety_wit_5 : composite_recursive_sll_safety_wit_5.
Axiom proof_of_composite_recursive_sll_safety_wit_6 : composite_recursive_sll_safety_wit_6.
Axiom proof_of_composite_recursive_sll_safety_wit_7 : composite_recursive_sll_safety_wit_7.
Axiom proof_of_composite_recursive_sll_safety_wit_8 : composite_recursive_sll_safety_wit_8.
Axiom proof_of_composite_recursive_sll_safety_wit_9 : composite_recursive_sll_safety_wit_9.
Axiom proof_of_composite_recursive_sll_safety_wit_10 : composite_recursive_sll_safety_wit_10.
Axiom proof_of_composite_recursive_sll_safety_wit_11 : composite_recursive_sll_safety_wit_11.
Axiom proof_of_composite_recursive_sll_safety_wit_12 : composite_recursive_sll_safety_wit_12.
Axiom proof_of_composite_recursive_sll_safety_wit_13 : composite_recursive_sll_safety_wit_13.
Axiom proof_of_composite_recursive_sll_safety_wit_14 : composite_recursive_sll_safety_wit_14.
Axiom proof_of_composite_recursive_sll_safety_wit_15 : composite_recursive_sll_safety_wit_15.
Axiom proof_of_composite_recursive_sll_safety_wit_16 : composite_recursive_sll_safety_wit_16.
Axiom proof_of_composite_recursive_sll_return_wit_1 : composite_recursive_sll_return_wit_1.
Axiom proof_of_composite_recursive_sll_precondition_wit_1 : composite_recursive_sll_precondition_wit_1.

End VC_Correct.
