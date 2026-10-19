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

(*----- Function closed_struct_array -----*)

Definition closed_struct_array_safety_wit_1 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 40)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (22) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_2 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (22) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_3 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (22) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_4 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (22) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_5 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (22) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_6 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_7 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_8 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_9 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_10 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_11 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_12 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_13 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_14 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_15 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_16 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_17 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_18 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_19 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |->_)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_20 := 
  ((( &( "total_spec_469" ) )) # Int  |->_)
  **  ((( &( "index_spec_466" ) )) # Int  |->_)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_21 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 0)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 0)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_22 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_23 := 
forall (PreH1 : False) ,
  ((( &( "total_spec_469" ) )) # Int  |-> 13)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 1)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (8) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  “ False ”
.

Definition closed_struct_array_safety_wit_24 := 
  ((( &( "total_spec_469" ) )) # Int  |-> 40)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 2)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (22) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  TT && emp 
.

Definition closed_struct_array_safety_wit_25 := 
forall (PreH1 : False) ,
  ((( &( "total_spec_469" ) )) # Int  |-> 40)
  **  ((( &( "index_spec_466" ) )) # Int  |-> 2)
  **  ((( &( "matrix_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "delta_spec_444" ) )) # Int  |-> 3)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 0) 2 (cons (1) ((cons (12) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + 8)) # Int  |-> 7)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 0) 2 (cons (5) ((cons (22) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (4096 + 0) + (1 * 12)) + 8)) # Int  |-> 11)
|--
  “ False ”
.

Definition closed_struct_array_return_wit_1 := 
forall (delta_pre: Z) (matrix_pre: Z) (expected___tespec_entry: Z) (weight1___tespec_entry: Z) (weight0___tespec_entry: Z) (row1___tespec_entry: (@list Z)) (row0___tespec_entry: (@list Z)) (PreH1 : (((0 + 1 ) + 1 ) >= 2)) (PreH2 : ((0 + 1 ) < 2)) (PreH3 : (matrix_pre = 4096)) (PreH4 : (delta_pre = 3)) (PreH5 : (expected___tespec_entry = 40)) (PreH6 : (row0___tespec_entry = (cons (1) ((cons (2) ((@nil Z))))))) (PreH7 : (row1___tespec_entry = (cons (5) ((cons (8) ((@nil Z))))))) (PreH8 : (weight0___tespec_entry = 7)) (PreH9 : (weight1___tespec_entry = 11)) (PreH10 : ((Zlength (row0___tespec_entry)) = 2)) (PreH11 : ((Zlength (row1___tespec_entry)) = 2)) (PreH12 : (expected___tespec_entry = (((((((Znth (0) (row0___tespec_entry) (0)) + (Znth (1) (row0___tespec_entry) (0)) ) + (Znth (0) (row1___tespec_entry) (0)) ) + (Znth (1) (row1___tespec_entry) (0)) ) + (2 * delta_pre ) ) + weight0___tespec_entry ) + weight1___tespec_entry ))) ,
  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + 0) 2 (replace_Znth (1) ((((Znth 1 row0___tespec_entry 0) + delta_pre ) + weight0___tespec_entry )) (row0___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + 8)) # Int  |-> weight0___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + (1 * sizeof( "matrix_leaf" ))) + 0) 2 (replace_Znth (1) ((((Znth 1 row1___tespec_entry 0) + delta_pre ) + weight1___tespec_entry )) (row1___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + (1 * sizeof( "matrix_leaf" ))) + 8)) # Int  |-> weight1___tespec_entry)
|--
  “ (((((0 + (Znth 0 (replace_Znth (1) ((((Znth 1 row0___tespec_entry 0) + delta_pre ) + weight0___tespec_entry )) (row0___tespec_entry)) 0) ) + (Znth 1 (replace_Znth (1) ((((Znth 1 row0___tespec_entry 0) + delta_pre ) + weight0___tespec_entry )) (row0___tespec_entry)) 0) ) + (Znth 0 (replace_Znth (1) ((((Znth 1 row1___tespec_entry 0) + delta_pre ) + weight1___tespec_entry )) (row1___tespec_entry)) 0) ) + (Znth 1 (replace_Znth (1) ((((Znth 1 row1___tespec_entry 0) + delta_pre ) + weight1___tespec_entry )) (row1___tespec_entry)) 0) ) = expected___tespec_entry) ”
  &&  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + 0) 2 (cons ((Znth (0) (row0___tespec_entry) (0))) ((cons ((((Znth (1) (row0___tespec_entry) (0)) + delta_pre ) + weight0___tespec_entry )) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + 8)) # Int  |-> weight0___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + (1 * sizeof( "matrix_leaf" ))) + 0) 2 (cons ((Znth (0) (row1___tespec_entry) (0))) ((cons ((((Znth (1) (row1___tespec_entry) (0)) + delta_pre ) + weight1___tespec_entry )) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + (1 * sizeof( "matrix_leaf" ))) + 8)) # Int  |-> weight1___tespec_entry)
.

Definition closed_struct_array_precondition_wit_1 :=
exists (delta_pre: Z) ,
exists (matrix_pre: Z) ,
exists (expected___tespec_entry: Z) ,
exists (weight1___tespec_entry: Z) ,
exists (weight0___tespec_entry: Z) ,
exists (row1___tespec_entry: (@list Z)) ,
exists (row0___tespec_entry: (@list Z)) ,
~ ((  “ (matrix_pre = 4096) ” 
  &&  “ (delta_pre = 3) ” 
  &&  “ (expected___tespec_entry = 40) ” 
  &&  “ (row0___tespec_entry = (cons (1) ((cons (2) ((@nil Z)))))) ” 
  &&  “ (row1___tespec_entry = (cons (5) ((cons (8) ((@nil Z)))))) ” 
  &&  “ (weight0___tespec_entry = 7) ” 
  &&  “ (weight1___tespec_entry = 11) ” 
  &&  “ ((Zlength (row0___tespec_entry)) = 2) ” 
  &&  “ ((Zlength (row1___tespec_entry)) = 2) ” 
  &&  “ (expected___tespec_entry = (((((((Znth (0) (row0___tespec_entry) (0)) + (Znth (1) (row0___tespec_entry) (0)) ) + (Znth (0) (row1___tespec_entry) (0)) ) + (Znth (1) (row1___tespec_entry) (0)) ) + (2 * delta_pre ) ) + weight0___tespec_entry ) + weight1___tespec_entry )) ”
  &&  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + 0) 2 row0___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) ((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + 8)) # Int  |-> weight0___tespec_entry)
  **  (IntArray.full (* tespec-target-field-address-v1: bits=32; offset=0; size=8; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + (1 * sizeof( "matrix_leaf" ))) + 0) 2 row1___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (((* tespec-target-field-address-v1: bits=32; offset=0; size=24; align=4 *) (matrix_pre + 0) + (1 * sizeof( "matrix_leaf" ))) + 8)) # Int  |-> weight1___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_closed_struct_array_safety_wit_1 : closed_struct_array_safety_wit_1.
Axiom proof_of_closed_struct_array_safety_wit_2 : closed_struct_array_safety_wit_2.
Axiom proof_of_closed_struct_array_safety_wit_3 : closed_struct_array_safety_wit_3.
Axiom proof_of_closed_struct_array_safety_wit_4 : closed_struct_array_safety_wit_4.
Axiom proof_of_closed_struct_array_safety_wit_5 : closed_struct_array_safety_wit_5.
Axiom proof_of_closed_struct_array_safety_wit_6 : closed_struct_array_safety_wit_6.
Axiom proof_of_closed_struct_array_safety_wit_7 : closed_struct_array_safety_wit_7.
Axiom proof_of_closed_struct_array_safety_wit_8 : closed_struct_array_safety_wit_8.
Axiom proof_of_closed_struct_array_safety_wit_9 : closed_struct_array_safety_wit_9.
Axiom proof_of_closed_struct_array_safety_wit_10 : closed_struct_array_safety_wit_10.
Axiom proof_of_closed_struct_array_safety_wit_11 : closed_struct_array_safety_wit_11.
Axiom proof_of_closed_struct_array_safety_wit_12 : closed_struct_array_safety_wit_12.
Axiom proof_of_closed_struct_array_safety_wit_13 : closed_struct_array_safety_wit_13.
Axiom proof_of_closed_struct_array_safety_wit_14 : closed_struct_array_safety_wit_14.
Axiom proof_of_closed_struct_array_safety_wit_15 : closed_struct_array_safety_wit_15.
Axiom proof_of_closed_struct_array_safety_wit_16 : closed_struct_array_safety_wit_16.
Axiom proof_of_closed_struct_array_safety_wit_17 : closed_struct_array_safety_wit_17.
Axiom proof_of_closed_struct_array_safety_wit_18 : closed_struct_array_safety_wit_18.
Axiom proof_of_closed_struct_array_safety_wit_19 : closed_struct_array_safety_wit_19.
Axiom proof_of_closed_struct_array_safety_wit_20 : closed_struct_array_safety_wit_20.
Axiom proof_of_closed_struct_array_safety_wit_21 : closed_struct_array_safety_wit_21.
Axiom proof_of_closed_struct_array_safety_wit_22 : closed_struct_array_safety_wit_22.
Axiom proof_of_closed_struct_array_safety_wit_23 : closed_struct_array_safety_wit_23.
Axiom proof_of_closed_struct_array_safety_wit_24 : closed_struct_array_safety_wit_24.
Axiom proof_of_closed_struct_array_safety_wit_25 : closed_struct_array_safety_wit_25.
Axiom proof_of_closed_struct_array_return_wit_1 : closed_struct_array_return_wit_1.
Axiom proof_of_closed_struct_array_precondition_wit_1 : closed_struct_array_precondition_wit_1.

End VC_Correct.
