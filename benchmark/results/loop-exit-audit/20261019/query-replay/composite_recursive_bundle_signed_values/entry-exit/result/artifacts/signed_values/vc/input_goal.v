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

(*----- Function composite_recursive_bundle -----*)

Definition composite_recursive_bundle_safety_wit_1 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (17) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_2 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (17) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_3 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (17) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_4 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_5 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_6 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_7 := 
  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_8 := 
  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_9 := 
  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_10 := 
  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_11 := 
  ((( &( "delta_spec_597" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_596" ) )) # Ptr  |-> 0)
  **  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_12 := 
  ((( &( "delta_spec_597" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_596" ) )) # Ptr  |-> 0)
  **  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (14) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_13 := 
  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_14 := 
  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_15 := 
  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_16 := 
  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_17 := 
forall (PreH1 : False) ,
  ((( &( "delta_spec_595" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_594" ) )) # Ptr  |-> 40960)
  **  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-1)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  “ False ”
.

Definition composite_recursive_bundle_safety_wit_18 := 
  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_19 := 
  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_20 := 
  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_21 := 
  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_22 := 
forall (PreH1 : False) ,
  ((( &( "delta_spec_593" ) )) # Int  |-> 5)
  **  ((( &( "node_spec_592" ) )) # Ptr  |-> 36864)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-9)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  “ False ”
.

Definition composite_recursive_bundle_safety_wit_23 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (8) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_24 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_25 := 
  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (8) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_26 := 
  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_27 := 
  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_28 := 
  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_29 := 
  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_30 := 
  ((( &( "delta_spec_591" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_590" ) )) # Ptr  |-> 0)
  **  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_31 := 
  ((( &( "delta_spec_591" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_590" ) )) # Ptr  |-> 0)
  **  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-5)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_32 := 
  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_33 := 
  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_34 := 
  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_35 := 
  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_36 := 
forall (PreH1 : False) ,
  ((( &( "delta_spec_589" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_588" ) )) # Ptr  |-> 32768)
  **  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (6) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  “ False ”
.

Definition composite_recursive_bundle_safety_wit_37 := 
  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (8) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_38 := 
  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (8) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_39 := 
  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (8) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_40 := 
  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (8) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  TT && emp 
.

Definition composite_recursive_bundle_safety_wit_41 := 
forall (PreH1 : False) ,
  ((( &( "delta_spec_587" ) )) # Int  |-> (-2))
  **  ((( &( "node_spec_586" ) )) # Ptr  |-> 28672)
  **  ((( &( "bundle_spec_551" ) )) # Ptr  |-> 24576)
  **  ((( &( "single_delta_spec_548" ) )) # Int  |-> (-2))
  **  ((( &( "double_delta_spec_545" ) )) # Int  |-> 5)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (24576 + 0) 2 (cons ((-10)) ((cons (4) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (24576 + 8)) # Ptr  |-> 28672)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (24576 + 12)) # Ptr  |-> 36864)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 0) 2 (cons (8) ((cons ((-101)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (28672 + 0) + 8)) # Int  |-> (-11))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (28672 + 12)) # Ptr  |-> 32768)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 0) 2 (cons ((-3)) ((cons ((-102)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (32768 + 0) + 8)) # Int  |-> (-12))
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (32768 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (36864 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (36864 + 4)) # Ptr  |-> 40960)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 0) 2 (cons ((-6)) ((cons ((-105)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (36864 + 8) + 8)) # Int  |-> (-13))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (40960 + 0)) # Ptr  |-> 36864)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (40960 + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 0) 2 (cons (9) ((cons ((-107)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (40960 + 8) + 8)) # Int  |-> (-14))
|--
  “ False ”
.

Definition composite_recursive_bundle_return_wit_1 := 
forall (double_delta_pre: Z) (single_delta_pre: Z) (bundle_pre: Z) (expected___tespec_entry: Z) (double_second_tag___tespec_entry: Z) (double_first_tag___tespec_entry: Z) (single_second_tag___tespec_entry: Z) (single_first_tag___tespec_entry: Z) (double_second___tespec_entry: (@list Z)) (double_first___tespec_entry: (@list Z)) (single_second___tespec_entry: (@list Z)) (single_first___tespec_entry: (@list Z)) (totals___tespec_entry: (@list Z)) (double_tail___tespec_entry: Z) (double_head___tespec_entry: Z) (single_tail___tespec_entry: Z) (single_head___tespec_entry: Z) (PreH1 : (double_tail___tespec_entry <> 0)) (PreH2 : (double_head___tespec_entry <> 0)) (PreH3 : (single_tail___tespec_entry <> 0)) (PreH4 : (single_head___tespec_entry <> 0)) (PreH5 : (bundle_pre = 24576)) (PreH6 : (single_delta_pre = (-2))) (PreH7 : (double_delta_pre = 5)) (PreH8 : (double_first___tespec_entry = (cons ((-6)) ((cons ((-105)) ((@nil Z))))))) (PreH9 : (double_first_tag___tespec_entry = (-13))) (PreH10 : (double_head___tespec_entry = 36864)) (PreH11 : (double_second___tespec_entry = (cons (9) ((cons ((-107)) ((@nil Z))))))) (PreH12 : (double_second_tag___tespec_entry = (-14))) (PreH13 : (double_tail___tespec_entry = 40960)) (PreH14 : (expected___tespec_entry = 8)) (PreH15 : (single_first___tespec_entry = (cons (8) ((cons ((-101)) ((@nil Z))))))) (PreH16 : (single_first_tag___tespec_entry = (-11))) (PreH17 : (single_head___tespec_entry = 28672)) (PreH18 : (single_second___tespec_entry = (cons ((-3)) ((cons ((-102)) ((@nil Z))))))) (PreH19 : (single_second_tag___tespec_entry = (-12))) (PreH20 : (single_tail___tespec_entry = 32768)) (PreH21 : (totals___tespec_entry = (cons ((-10)) ((cons (4) ((@nil Z))))))) (PreH22 : (single_head___tespec_entry <> 0)) (PreH23 : (single_tail___tespec_entry <> 0)) (PreH24 : (double_head___tespec_entry <> 0)) (PreH25 : (double_tail___tespec_entry <> 0)) (PreH26 : ((Zlength (totals___tespec_entry)) = 2)) (PreH27 : ((Zlength (single_first___tespec_entry)) = 2)) (PreH28 : ((Zlength (single_second___tespec_entry)) = 2)) (PreH29 : ((Zlength (double_first___tespec_entry)) = 2)) (PreH30 : ((Zlength (double_second___tespec_entry)) = 2)) (PreH31 : (expected___tespec_entry = ((((((((Znth (0) (totals___tespec_entry) (0)) + (Znth (1) (totals___tespec_entry) (0)) ) + (Znth (0) (single_first___tespec_entry) (0)) ) + (Znth (0) (single_second___tespec_entry) (0)) ) + (Znth (0) (double_first___tespec_entry) (0)) ) + (Znth (0) (double_second___tespec_entry) (0)) ) + (2 * single_delta_pre ) ) + (2 * double_delta_pre ) ))) ,
  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (bundle_pre + 0) 2 (replace_Znth (1) (((Znth 1 (replace_Znth (0) (((Znth 0 totals___tespec_entry 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_first___tespec_entry 0) + single_delta_pre )) (single_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_second___tespec_entry 0) + single_delta_pre )) (single_second___tespec_entry)) 0) + 0 ) ) )) (totals___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 double_first___tespec_entry 0) + double_delta_pre )) (double_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 double_second___tespec_entry 0) + double_delta_pre )) (double_second___tespec_entry)) 0) + 0 ) ) )) ((replace_Znth (0) (((Znth 0 totals___tespec_entry 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_first___tespec_entry 0) + single_delta_pre )) (single_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_second___tespec_entry 0) + single_delta_pre )) (single_second___tespec_entry)) 0) + 0 ) ) )) (totals___tespec_entry)))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (bundle_pre + 8)) # Ptr  |-> single_head___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (bundle_pre + 12)) # Ptr  |-> double_head___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_head___tespec_entry + 0) + 0) 2 (replace_Znth (0) (((Znth 0 single_first___tespec_entry 0) + single_delta_pre )) (single_first___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_head___tespec_entry + 0) + 8)) # Int  |-> single_first_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (single_head___tespec_entry + 12)) # Ptr  |-> single_tail___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_tail___tespec_entry + 0) + 0) 2 (replace_Znth (0) (((Znth 0 single_second___tespec_entry 0) + single_delta_pre )) (single_second___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_tail___tespec_entry + 0) + 8)) # Int  |-> single_second_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (single_tail___tespec_entry + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (double_head___tespec_entry + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (double_head___tespec_entry + 4)) # Ptr  |-> double_tail___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_head___tespec_entry + 8) + 0) 2 (replace_Znth (0) (((Znth 0 double_first___tespec_entry 0) + double_delta_pre )) (double_first___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_head___tespec_entry + 8) + 8)) # Int  |-> double_first_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (double_tail___tespec_entry + 0)) # Ptr  |-> double_head___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (double_tail___tespec_entry + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_tail___tespec_entry + 8) + 0) 2 (replace_Znth (0) (((Znth 0 double_second___tespec_entry 0) + double_delta_pre )) (double_second___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_tail___tespec_entry + 8) + 8)) # Int  |-> double_second_tag___tespec_entry)
|--
  “ (((Znth 0 (replace_Znth (1) (((Znth 1 (replace_Znth (0) (((Znth 0 totals___tespec_entry 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_first___tespec_entry 0) + single_delta_pre )) (single_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_second___tespec_entry 0) + single_delta_pre )) (single_second___tespec_entry)) 0) + 0 ) ) )) (totals___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 double_first___tespec_entry 0) + double_delta_pre )) (double_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 double_second___tespec_entry 0) + double_delta_pre )) (double_second___tespec_entry)) 0) + 0 ) ) )) ((replace_Znth (0) (((Znth 0 totals___tespec_entry 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_first___tespec_entry 0) + single_delta_pre )) (single_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_second___tespec_entry 0) + single_delta_pre )) (single_second___tespec_entry)) 0) + 0 ) ) )) (totals___tespec_entry)))) 0) + (Znth 1 (replace_Znth (1) (((Znth 1 (replace_Znth (0) (((Znth 0 totals___tespec_entry 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_first___tespec_entry 0) + single_delta_pre )) (single_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_second___tespec_entry 0) + single_delta_pre )) (single_second___tespec_entry)) 0) + 0 ) ) )) (totals___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 double_first___tespec_entry 0) + double_delta_pre )) (double_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 double_second___tespec_entry 0) + double_delta_pre )) (double_second___tespec_entry)) 0) + 0 ) ) )) ((replace_Znth (0) (((Znth 0 totals___tespec_entry 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_first___tespec_entry 0) + single_delta_pre )) (single_first___tespec_entry)) 0) + ((Znth 0 (replace_Znth (0) (((Znth 0 single_second___tespec_entry 0) + single_delta_pre )) (single_second___tespec_entry)) 0) + 0 ) ) )) (totals___tespec_entry)))) 0) ) = expected___tespec_entry) ”
  &&  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (bundle_pre + 0) 2 (cons (((((Znth (0) (totals___tespec_entry) (0)) + (Znth (0) (single_first___tespec_entry) (0)) ) + (Znth (0) (single_second___tespec_entry) (0)) ) + (2 * single_delta_pre ) )) ((cons (((((Znth (1) (totals___tespec_entry) (0)) + (Znth (0) (double_first___tespec_entry) (0)) ) + (Znth (0) (double_second___tespec_entry) (0)) ) + (2 * double_delta_pre ) )) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (bundle_pre + 8)) # Ptr  |-> single_head___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (bundle_pre + 12)) # Ptr  |-> double_head___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_head___tespec_entry + 0) + 0) 2 (cons (((Znth (0) (single_first___tespec_entry) (0)) + single_delta_pre )) ((cons ((Znth (1) (single_first___tespec_entry) (0))) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_head___tespec_entry + 0) + 8)) # Int  |-> single_first_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (single_head___tespec_entry + 12)) # Ptr  |-> single_tail___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_tail___tespec_entry + 0) + 0) 2 (cons (((Znth (0) (single_second___tespec_entry) (0)) + single_delta_pre )) ((cons ((Znth (1) (single_second___tespec_entry) (0))) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_tail___tespec_entry + 0) + 8)) # Int  |-> single_second_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (single_tail___tespec_entry + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (double_head___tespec_entry + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (double_head___tespec_entry + 4)) # Ptr  |-> double_tail___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_head___tespec_entry + 8) + 0) 2 (cons (((Znth (0) (double_first___tespec_entry) (0)) + double_delta_pre )) ((cons ((Znth (1) (double_first___tespec_entry) (0))) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_head___tespec_entry + 8) + 8)) # Int  |-> double_first_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (double_tail___tespec_entry + 0)) # Ptr  |-> double_head___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (double_tail___tespec_entry + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_tail___tespec_entry + 8) + 0) 2 (cons (((Znth (0) (double_second___tespec_entry) (0)) + double_delta_pre )) ((cons ((Znth (1) (double_second___tespec_entry) (0))) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_tail___tespec_entry + 8) + 8)) # Int  |-> double_second_tag___tespec_entry)
.

Definition composite_recursive_bundle_precondition_wit_1 :=
exists (double_delta_pre: Z) ,
exists (single_delta_pre: Z) ,
exists (bundle_pre: Z) ,
exists (expected___tespec_entry: Z) ,
exists (double_second_tag___tespec_entry: Z) ,
exists (double_first_tag___tespec_entry: Z) ,
exists (single_second_tag___tespec_entry: Z) ,
exists (single_first_tag___tespec_entry: Z) ,
exists (double_second___tespec_entry: (@list Z)) ,
exists (double_first___tespec_entry: (@list Z)) ,
exists (single_second___tespec_entry: (@list Z)) ,
exists (single_first___tespec_entry: (@list Z)) ,
exists (totals___tespec_entry: (@list Z)) ,
exists (double_tail___tespec_entry: Z) ,
exists (double_head___tespec_entry: Z) ,
exists (single_tail___tespec_entry: Z) ,
exists (single_head___tespec_entry: Z) ,
~ ((  “ (bundle_pre = 24576) ” 
  &&  “ (single_delta_pre = (-2)) ” 
  &&  “ (double_delta_pre = 5) ” 
  &&  “ (double_first___tespec_entry = (cons ((-6)) ((cons ((-105)) ((@nil Z)))))) ” 
  &&  “ (double_first_tag___tespec_entry = (-13)) ” 
  &&  “ (double_head___tespec_entry = 36864) ” 
  &&  “ (double_second___tespec_entry = (cons (9) ((cons ((-107)) ((@nil Z)))))) ” 
  &&  “ (double_second_tag___tespec_entry = (-14)) ” 
  &&  “ (double_tail___tespec_entry = 40960) ” 
  &&  “ (expected___tespec_entry = 8) ” 
  &&  “ (single_first___tespec_entry = (cons (8) ((cons ((-101)) ((@nil Z)))))) ” 
  &&  “ (single_first_tag___tespec_entry = (-11)) ” 
  &&  “ (single_head___tespec_entry = 28672) ” 
  &&  “ (single_second___tespec_entry = (cons ((-3)) ((cons ((-102)) ((@nil Z)))))) ” 
  &&  “ (single_second_tag___tespec_entry = (-12)) ” 
  &&  “ (single_tail___tespec_entry = 32768) ” 
  &&  “ (totals___tespec_entry = (cons ((-10)) ((cons (4) ((@nil Z)))))) ” 
  &&  “ (single_head___tespec_entry <> 0) ” 
  &&  “ (single_tail___tespec_entry <> 0) ” 
  &&  “ (double_head___tespec_entry <> 0) ” 
  &&  “ (double_tail___tespec_entry <> 0) ” 
  &&  “ ((Zlength (totals___tespec_entry)) = 2) ” 
  &&  “ ((Zlength (single_first___tespec_entry)) = 2) ” 
  &&  “ ((Zlength (single_second___tespec_entry)) = 2) ” 
  &&  “ ((Zlength (double_first___tespec_entry)) = 2) ” 
  &&  “ ((Zlength (double_second___tespec_entry)) = 2) ” 
  &&  “ (expected___tespec_entry = ((((((((Znth (0) (totals___tespec_entry) (0)) + (Znth (1) (totals___tespec_entry) (0)) ) + (Znth (0) (single_first___tespec_entry) (0)) ) + (Znth (0) (single_second___tespec_entry) (0)) ) + (Znth (0) (double_first___tespec_entry) (0)) ) + (Znth (0) (double_second___tespec_entry) (0)) ) + (2 * single_delta_pre ) ) + (2 * double_delta_pre ) )) ”
  &&  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (bundle_pre + 0) 2 totals___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (bundle_pre + 8)) # Ptr  |-> single_head___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (bundle_pre + 12)) # Ptr  |-> double_head___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_head___tespec_entry + 0) + 0) 2 single_first___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_head___tespec_entry + 0) + 8)) # Int  |-> single_first_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (single_head___tespec_entry + 12)) # Ptr  |-> single_tail___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_tail___tespec_entry + 0) + 0) 2 single_second___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=12; align=4 *) (single_tail___tespec_entry + 0) + 8)) # Int  |-> single_second_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (single_tail___tespec_entry + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (double_head___tespec_entry + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (double_head___tespec_entry + 4)) # Ptr  |-> double_tail___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_head___tespec_entry + 8) + 0) 2 double_first___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_head___tespec_entry + 8) + 8)) # Int  |-> double_first_tag___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (double_tail___tespec_entry + 0)) # Ptr  |-> double_head___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (double_tail___tespec_entry + 4)) # Ptr  |-> 0)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_tail___tespec_entry + 8) + 0) 2 double_second___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=8; size=12; align=4 *) (double_tail___tespec_entry + 8) + 8)) # Int  |-> double_second_tag___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_composite_recursive_bundle_safety_wit_1 : composite_recursive_bundle_safety_wit_1.
Axiom proof_of_composite_recursive_bundle_safety_wit_2 : composite_recursive_bundle_safety_wit_2.
Axiom proof_of_composite_recursive_bundle_safety_wit_3 : composite_recursive_bundle_safety_wit_3.
Axiom proof_of_composite_recursive_bundle_safety_wit_4 : composite_recursive_bundle_safety_wit_4.
Axiom proof_of_composite_recursive_bundle_safety_wit_5 : composite_recursive_bundle_safety_wit_5.
Axiom proof_of_composite_recursive_bundle_safety_wit_6 : composite_recursive_bundle_safety_wit_6.
Axiom proof_of_composite_recursive_bundle_safety_wit_7 : composite_recursive_bundle_safety_wit_7.
Axiom proof_of_composite_recursive_bundle_safety_wit_8 : composite_recursive_bundle_safety_wit_8.
Axiom proof_of_composite_recursive_bundle_safety_wit_9 : composite_recursive_bundle_safety_wit_9.
Axiom proof_of_composite_recursive_bundle_safety_wit_10 : composite_recursive_bundle_safety_wit_10.
Axiom proof_of_composite_recursive_bundle_safety_wit_11 : composite_recursive_bundle_safety_wit_11.
Axiom proof_of_composite_recursive_bundle_safety_wit_12 : composite_recursive_bundle_safety_wit_12.
Axiom proof_of_composite_recursive_bundle_safety_wit_13 : composite_recursive_bundle_safety_wit_13.
Axiom proof_of_composite_recursive_bundle_safety_wit_14 : composite_recursive_bundle_safety_wit_14.
Axiom proof_of_composite_recursive_bundle_safety_wit_15 : composite_recursive_bundle_safety_wit_15.
Axiom proof_of_composite_recursive_bundle_safety_wit_16 : composite_recursive_bundle_safety_wit_16.
Axiom proof_of_composite_recursive_bundle_safety_wit_17 : composite_recursive_bundle_safety_wit_17.
Axiom proof_of_composite_recursive_bundle_safety_wit_18 : composite_recursive_bundle_safety_wit_18.
Axiom proof_of_composite_recursive_bundle_safety_wit_19 : composite_recursive_bundle_safety_wit_19.
Axiom proof_of_composite_recursive_bundle_safety_wit_20 : composite_recursive_bundle_safety_wit_20.
Axiom proof_of_composite_recursive_bundle_safety_wit_21 : composite_recursive_bundle_safety_wit_21.
Axiom proof_of_composite_recursive_bundle_safety_wit_22 : composite_recursive_bundle_safety_wit_22.
Axiom proof_of_composite_recursive_bundle_safety_wit_23 : composite_recursive_bundle_safety_wit_23.
Axiom proof_of_composite_recursive_bundle_safety_wit_24 : composite_recursive_bundle_safety_wit_24.
Axiom proof_of_composite_recursive_bundle_safety_wit_25 : composite_recursive_bundle_safety_wit_25.
Axiom proof_of_composite_recursive_bundle_safety_wit_26 : composite_recursive_bundle_safety_wit_26.
Axiom proof_of_composite_recursive_bundle_safety_wit_27 : composite_recursive_bundle_safety_wit_27.
Axiom proof_of_composite_recursive_bundle_safety_wit_28 : composite_recursive_bundle_safety_wit_28.
Axiom proof_of_composite_recursive_bundle_safety_wit_29 : composite_recursive_bundle_safety_wit_29.
Axiom proof_of_composite_recursive_bundle_safety_wit_30 : composite_recursive_bundle_safety_wit_30.
Axiom proof_of_composite_recursive_bundle_safety_wit_31 : composite_recursive_bundle_safety_wit_31.
Axiom proof_of_composite_recursive_bundle_safety_wit_32 : composite_recursive_bundle_safety_wit_32.
Axiom proof_of_composite_recursive_bundle_safety_wit_33 : composite_recursive_bundle_safety_wit_33.
Axiom proof_of_composite_recursive_bundle_safety_wit_34 : composite_recursive_bundle_safety_wit_34.
Axiom proof_of_composite_recursive_bundle_safety_wit_35 : composite_recursive_bundle_safety_wit_35.
Axiom proof_of_composite_recursive_bundle_safety_wit_36 : composite_recursive_bundle_safety_wit_36.
Axiom proof_of_composite_recursive_bundle_safety_wit_37 : composite_recursive_bundle_safety_wit_37.
Axiom proof_of_composite_recursive_bundle_safety_wit_38 : composite_recursive_bundle_safety_wit_38.
Axiom proof_of_composite_recursive_bundle_safety_wit_39 : composite_recursive_bundle_safety_wit_39.
Axiom proof_of_composite_recursive_bundle_safety_wit_40 : composite_recursive_bundle_safety_wit_40.
Axiom proof_of_composite_recursive_bundle_safety_wit_41 : composite_recursive_bundle_safety_wit_41.
Axiom proof_of_composite_recursive_bundle_return_wit_1 : composite_recursive_bundle_return_wit_1.
Axiom proof_of_composite_recursive_bundle_precondition_wit_1 : composite_recursive_bundle_precondition_wit_1.

End VC_Correct.
