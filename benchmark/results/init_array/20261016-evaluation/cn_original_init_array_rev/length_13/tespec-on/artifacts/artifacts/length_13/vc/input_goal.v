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

(*----- Function init_array2 -----*)

Definition init_array2_safety_wit_1 := 
  (CharArray.undef_seg 4096 0 1 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 12)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_2 := 
  (CharArray.undef_seg 4096 0 1 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 12)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_3 := 
  (CharArray.undef_seg 4096 0 2 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 11)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_4 := 
  (CharArray.undef_seg 4096 0 2 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 11)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_5 := 
  (CharArray.undef_seg 4096 0 3 )
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 10)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_6 := 
  (CharArray.undef_seg 4096 0 3 )
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 10)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_7 := 
  (CharArray.undef_seg 4096 0 4 )
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 9)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_8 := 
  (CharArray.undef_seg 4096 0 4 )
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 9)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_9 := 
  (CharArray.undef_seg 4096 0 5 )
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 8)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_10 := 
  (CharArray.undef_seg 4096 0 5 )
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 8)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_11 := 
  (CharArray.undef_seg 4096 0 6 )
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 7)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_12 := 
  (CharArray.undef_seg 4096 0 6 )
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 7)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_13 := 
  (CharArray.undef_seg 4096 0 7 )
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 6)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_14 := 
  (CharArray.undef_seg 4096 0 7 )
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 6)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_15 := 
  (CharArray.undef_seg 4096 0 8 )
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 5)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_16 := 
  (CharArray.undef_seg 4096 0 8 )
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 5)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_17 := 
  (CharArray.undef_seg 4096 0 9 )
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 4)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_18 := 
  (CharArray.undef_seg 4096 0 9 )
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 4)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_19 := 
  (CharArray.undef_seg 4096 0 10 )
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 3)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_20 := 
  (CharArray.undef_seg 4096 0 10 )
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 3)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_21 := 
  (CharArray.undef_seg 4096 0 11 )
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_22 := 
  (CharArray.undef_seg 4096 0 11 )
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_23 := 
  (CharArray.undef_seg 4096 0 12 )
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_24 := 
  (CharArray.undef_seg 4096 0 12 )
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  TT && emp 
.

Definition init_array2_safety_wit_25 := 
  ((( &( "j_spec_383" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
  **  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  TT && emp 
.

Definition init_array2_safety_wit_26 := 
  ((( &( "j_spec_383" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
  **  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  TT && emp 
.

Definition init_array2_safety_wit_27 := 
  ((( &( "j_spec_383" ) )) # UInt  |->_)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
  **  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  TT && emp 
.

Definition init_array2_safety_wit_28 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_383" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
  **  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  “ False ”
.

Definition init_array2_safety_wit_29 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 12 )
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_30 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 11 )
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_31 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 10 )
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 3)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_32 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 9 )
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 4)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_33 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 8 )
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 5)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_34 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 7 )
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 6)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_35 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 6 )
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 7)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_36 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 5 )
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 8)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_37 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 4 )
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 9)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_38 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 3 )
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 10)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_39 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 2 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 11)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_40 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 0 1 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 12)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_safety_wit_41 := 
forall (PreH1 : False) ,
  ((4096) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 13)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 13)
|--
  “ False ”
.

Definition init_array2_entail_wit_1 := 
(
  ((4096) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 0 )
  **  (CharArray.seg 4096 0 13 (repeat_Z (0) (13)) )
) \/
(
  ((4096) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.seg 4096 0 13 (repeat_Z (0) (13)) )
).

Definition init_array2_entail_wit_1_split_goal_spatial := 
  ((4096) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.seg 4096 0 13 (repeat_Z (0) (13)) )
.

Definition init_array2_entail_wit_2 := 
(
  (CharArray.undef_seg 4096 0 1 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 1 )
  **  (CharArray.seg 4096 1 13 (repeat_Z (0) (12)) )
) \/
(
  (CharArray.undef_seg 4096 0 1 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 1 )
  **  (CharArray.seg 4096 1 13 (repeat_Z (0) (12)) )
).

Definition init_array2_entail_wit_2_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 1 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 1 )
  **  (CharArray.seg 4096 1 13 (repeat_Z (0) (12)) )
.

Definition init_array2_entail_wit_3 := 
(
  (CharArray.undef_seg 4096 0 2 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 2 )
  **  (CharArray.seg 4096 2 13 (repeat_Z (0) (11)) )
) \/
(
  (CharArray.undef_seg 4096 0 2 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 2 )
  **  (CharArray.seg 4096 2 13 (repeat_Z (0) (11)) )
).

Definition init_array2_entail_wit_3_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 2 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 2 )
  **  (CharArray.seg 4096 2 13 (repeat_Z (0) (11)) )
.

Definition init_array2_entail_wit_4 := 
(
  (CharArray.undef_seg 4096 0 3 )
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 3 )
  **  (CharArray.seg 4096 3 13 (repeat_Z (0) (10)) )
) \/
(
  (CharArray.undef_seg 4096 0 3 )
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 3 )
  **  (CharArray.seg 4096 3 13 (repeat_Z (0) (10)) )
).

Definition init_array2_entail_wit_4_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 3 )
  **  (((4096 + (3 * 1))) # Char  |-> 0)
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 3 )
  **  (CharArray.seg 4096 3 13 (repeat_Z (0) (10)) )
.

Definition init_array2_entail_wit_5 := 
(
  (CharArray.undef_seg 4096 0 4 )
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 4 )
  **  (CharArray.seg 4096 4 13 (repeat_Z (0) (9)) )
) \/
(
  (CharArray.undef_seg 4096 0 4 )
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 4 )
  **  (CharArray.seg 4096 4 13 (repeat_Z (0) (9)) )
).

Definition init_array2_entail_wit_5_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 4 )
  **  (((4096 + (4 * 1))) # Char  |-> 0)
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 4 )
  **  (CharArray.seg 4096 4 13 (repeat_Z (0) (9)) )
.

Definition init_array2_entail_wit_6 := 
(
  (CharArray.undef_seg 4096 0 5 )
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 5 )
  **  (CharArray.seg 4096 5 13 (repeat_Z (0) (8)) )
) \/
(
  (CharArray.undef_seg 4096 0 5 )
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 5 )
  **  (CharArray.seg 4096 5 13 (repeat_Z (0) (8)) )
).

Definition init_array2_entail_wit_6_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 5 )
  **  (((4096 + (5 * 1))) # Char  |-> 0)
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 5 )
  **  (CharArray.seg 4096 5 13 (repeat_Z (0) (8)) )
.

Definition init_array2_entail_wit_7 := 
(
  (CharArray.undef_seg 4096 0 6 )
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 6 )
  **  (CharArray.seg 4096 6 13 (repeat_Z (0) (7)) )
) \/
(
  (CharArray.undef_seg 4096 0 6 )
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 6 )
  **  (CharArray.seg 4096 6 13 (repeat_Z (0) (7)) )
).

Definition init_array2_entail_wit_7_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 6 )
  **  (((4096 + (6 * 1))) # Char  |-> 0)
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 6 )
  **  (CharArray.seg 4096 6 13 (repeat_Z (0) (7)) )
.

Definition init_array2_entail_wit_8 := 
(
  (CharArray.undef_seg 4096 0 7 )
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 7 )
  **  (CharArray.seg 4096 7 13 (repeat_Z (0) (6)) )
) \/
(
  (CharArray.undef_seg 4096 0 7 )
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 7 )
  **  (CharArray.seg 4096 7 13 (repeat_Z (0) (6)) )
).

Definition init_array2_entail_wit_8_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 7 )
  **  (((4096 + (7 * 1))) # Char  |-> 0)
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 7 )
  **  (CharArray.seg 4096 7 13 (repeat_Z (0) (6)) )
.

Definition init_array2_entail_wit_9 := 
(
  (CharArray.undef_seg 4096 0 8 )
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 8 )
  **  (CharArray.seg 4096 8 13 (repeat_Z (0) (5)) )
) \/
(
  (CharArray.undef_seg 4096 0 8 )
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 8 )
  **  (CharArray.seg 4096 8 13 (repeat_Z (0) (5)) )
).

Definition init_array2_entail_wit_9_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 8 )
  **  (((4096 + (8 * 1))) # Char  |-> 0)
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 8 )
  **  (CharArray.seg 4096 8 13 (repeat_Z (0) (5)) )
.

Definition init_array2_entail_wit_10 := 
(
  (CharArray.undef_seg 4096 0 9 )
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 9 )
  **  (CharArray.seg 4096 9 13 (repeat_Z (0) (4)) )
) \/
(
  (CharArray.undef_seg 4096 0 9 )
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 9 )
  **  (CharArray.seg 4096 9 13 (repeat_Z (0) (4)) )
).

Definition init_array2_entail_wit_10_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 9 )
  **  (((4096 + (9 * 1))) # Char  |-> 0)
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 9 )
  **  (CharArray.seg 4096 9 13 (repeat_Z (0) (4)) )
.

Definition init_array2_entail_wit_11 := 
(
  (CharArray.undef_seg 4096 0 10 )
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 10 )
  **  (CharArray.seg 4096 10 13 (repeat_Z (0) (3)) )
) \/
(
  (CharArray.undef_seg 4096 0 10 )
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 10 )
  **  (CharArray.seg 4096 10 13 (repeat_Z (0) (3)) )
).

Definition init_array2_entail_wit_11_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 10 )
  **  (((4096 + (10 * 1))) # Char  |-> 0)
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 10 )
  **  (CharArray.seg 4096 10 13 (repeat_Z (0) (3)) )
.

Definition init_array2_entail_wit_12 := 
(
  (CharArray.undef_seg 4096 0 11 )
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 11 )
  **  (CharArray.seg 4096 11 13 (repeat_Z (0) (2)) )
) \/
(
  (CharArray.undef_seg 4096 0 11 )
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 11 )
  **  (CharArray.seg 4096 11 13 (repeat_Z (0) (2)) )
).

Definition init_array2_entail_wit_12_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 11 )
  **  (((4096 + (11 * 1))) # Char  |-> 0)
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 11 )
  **  (CharArray.seg 4096 11 13 (repeat_Z (0) (2)) )
.

Definition init_array2_entail_wit_13 := 
(
  (CharArray.undef_seg 4096 0 12 )
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_seg 4096 0 12 )
  **  (CharArray.seg 4096 12 13 (repeat_Z (0) (1)) )
) \/
(
  (CharArray.undef_seg 4096 0 12 )
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 12 )
  **  (CharArray.seg 4096 12 13 (repeat_Z (0) (1)) )
).

Definition init_array2_entail_wit_13_split_goal_spatial := 
  (CharArray.undef_seg 4096 0 12 )
  **  (((4096 + (12 * 1))) # Char  |-> 0)
|--
  (CharArray.undef_full 4096 12 )
  **  (CharArray.seg 4096 12 13 (repeat_Z (0) (1)) )
.

Definition init_array2_entail_wit_14 := 
(
  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  (CharArray.undef_seg 4096 0 13 )
  **  (CharArray.seg 4096 13 13 (repeat_Z (0) (0)) )
) \/
(
  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
  &&  (CharArray.undef_full 4096 13 )
).

Definition init_array2_entail_wit_14_split_goal_1 := 
  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
.

Definition init_array2_entail_wit_14_split_goal_spatial := 
  (((4096 + (12 * 1))) # Char  |->_)
  **  (((4096 + (11 * 1))) # Char  |->_)
  **  (((4096 + (10 * 1))) # Char  |->_)
  **  (((4096 + (9 * 1))) # Char  |->_)
  **  (((4096 + (8 * 1))) # Char  |->_)
  **  (((4096 + (7 * 1))) # Char  |->_)
  **  (((4096 + (6 * 1))) # Char  |->_)
  **  (((4096 + (5 * 1))) # Char  |->_)
  **  (((4096 + (4 * 1))) # Char  |->_)
  **  (((4096 + (3 * 1))) # Char  |->_)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  (CharArray.undef_full 4096 13 )
.

Definition init_array2_return_wit_1 := 
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH9 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH10 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH11 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH12 : (((0 + 1 ) + 1 ) < n_pre)) (PreH13 : ((0 + 1 ) < n_pre)) (PreH14 : (0 < n_pre)) (PreH15 : (p_pre = 4096)) (PreH16 : (n_pre = 13)) (PreH17 : (0 <= n_pre)) (PreH18 : (n_pre <= UINT_MAX)) (PreH19 : (0 < n_pre)) ,
  (((p_pre + ((n_pre - (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
) \/
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH9 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH10 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH11 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH12 : (((0 + 1 ) + 1 ) < n_pre)) (PreH13 : ((0 + 1 ) < n_pre)) (PreH14 : (0 < n_pre)) (PreH15 : (p_pre = 4096)) (PreH16 : (n_pre = 13)) (PreH17 : (0 <= n_pre)) (PreH18 : (n_pre <= UINT_MAX)) (PreH19 : (0 < n_pre)) ,
  (((p_pre + ((n_pre - (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
).

Definition init_array2_partial_solve_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH9 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH10 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH11 : (((0 + 1 ) + 1 ) < n_pre)) (PreH12 : ((0 + 1 ) < n_pre)) (PreH13 : (0 < n_pre)) (PreH14 : (p_pre = 4096)) (PreH15 : (n_pre = 13)) (PreH16 : (0 <= n_pre)) (PreH17 : (n_pre <= UINT_MAX)) (PreH18 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_2 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH9 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH10 : (((0 + 1 ) + 1 ) < n_pre)) (PreH11 : ((0 + 1 ) < n_pre)) (PreH12 : (0 < n_pre)) (PreH13 : (p_pre = 4096)) (PreH14 : (n_pre = 13)) (PreH15 : (0 <= n_pre)) (PreH16 : (n_pre <= UINT_MAX)) (PreH17 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - ((((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_3 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH9 : (((0 + 1 ) + 1 ) < n_pre)) (PreH10 : ((0 + 1 ) < n_pre)) (PreH11 : (0 < n_pre)) (PreH12 : (p_pre = 4096)) (PreH13 : (n_pre = 13)) (PreH14 : (0 <= n_pre)) (PreH15 : (n_pre <= UINT_MAX)) (PreH16 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_4 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH8 : (((0 + 1 ) + 1 ) < n_pre)) (PreH9 : ((0 + 1 ) < n_pre)) (PreH10 : (0 < n_pre)) (PreH11 : (p_pre = 4096)) (PreH12 : (n_pre = 13)) (PreH13 : (0 <= n_pre)) (PreH14 : (n_pre <= UINT_MAX)) (PreH15 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - ((((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_5 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : (((0 + 1 ) + 1 ) < n_pre)) (PreH8 : ((0 + 1 ) < n_pre)) (PreH9 : (0 < n_pre)) (PreH10 : (p_pre = 4096)) (PreH11 : (n_pre = 13)) (PreH12 : (0 <= n_pre)) (PreH13 : (n_pre <= UINT_MAX)) (PreH14 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_6 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : (((0 + 1 ) + 1 ) < n_pre)) (PreH7 : ((0 + 1 ) < n_pre)) (PreH8 : (0 < n_pre)) (PreH9 : (p_pre = 4096)) (PreH10 : (n_pre = 13)) (PreH11 : (0 <= n_pre)) (PreH12 : (n_pre <= UINT_MAX)) (PreH13 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_7 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : (((0 + 1 ) + 1 ) < n_pre)) (PreH6 : ((0 + 1 ) < n_pre)) (PreH7 : (0 < n_pre)) (PreH8 : (p_pre = 4096)) (PreH9 : (n_pre = 13)) (PreH10 : (0 <= n_pre)) (PreH11 : (n_pre <= UINT_MAX)) (PreH12 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_8 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : (((0 + 1 ) + 1 ) < n_pre)) (PreH5 : ((0 + 1 ) < n_pre)) (PreH6 : (0 < n_pre)) (PreH7 : (p_pre = 4096)) (PreH8 : (n_pre = 13)) (PreH9 : (0 <= n_pre)) (PreH10 : (n_pre <= UINT_MAX)) (PreH11 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_9 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : (((0 + 1 ) + 1 ) < n_pre)) (PreH4 : ((0 + 1 ) < n_pre)) (PreH5 : (0 < n_pre)) (PreH6 : (p_pre = 4096)) (PreH7 : (n_pre = 13)) (PreH8 : (0 <= n_pre)) (PreH9 : (n_pre <= UINT_MAX)) (PreH10 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_10 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH2 : (((0 + 1 ) + 1 ) < n_pre)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : (0 < n_pre)) (PreH5 : (p_pre = 4096)) (PreH6 : (n_pre = 13)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre <= UINT_MAX)) (PreH9 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (((0 + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ ((((0 + 1 ) + 1 ) + 1 ) < n_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - ((((0 + 1 ) + 1 ) + 1 ) + 1 ) ) 0 (n_pre - (((0 + 1 ) + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_11 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (((0 + 1 ) + 1 ) < n_pre)) (PreH2 : ((0 + 1 ) < n_pre)) (PreH3 : (0 < n_pre)) (PreH4 : (p_pre = 4096)) (PreH5 : (n_pre = 13)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre <= UINT_MAX)) (PreH8 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - ((0 + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (((0 + 1 ) + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (((0 + 1 ) + 1 ) + 1 ) ) 0 (n_pre - ((0 + 1 ) + 1 ) ) )
  **  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_12 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (p_pre = 4096)) (PreH4 : (n_pre = 13)) (PreH5 : (0 <= n_pre)) (PreH6 : (n_pre <= UINT_MAX)) (PreH7 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (0 + 1 ) ) )
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - ((0 + 1 ) + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - ((0 + 1 ) + 1 ) ) 0 (n_pre - (0 + 1 ) ) )
  **  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_13 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (p_pre = 4096)) (PreH3 : (n_pre = 13)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.undef_full p_pre n_pre )
|--
  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (0 + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (0 + 1 ) ) 0 n_pre )
.

Definition init_array2_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (p_pre: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 13) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (CharArray.undef_full p_pre n_pre )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_init_array2_safety_wit_1 : init_array2_safety_wit_1.
Axiom proof_of_init_array2_safety_wit_2 : init_array2_safety_wit_2.
Axiom proof_of_init_array2_safety_wit_3 : init_array2_safety_wit_3.
Axiom proof_of_init_array2_safety_wit_4 : init_array2_safety_wit_4.
Axiom proof_of_init_array2_safety_wit_5 : init_array2_safety_wit_5.
Axiom proof_of_init_array2_safety_wit_6 : init_array2_safety_wit_6.
Axiom proof_of_init_array2_safety_wit_7 : init_array2_safety_wit_7.
Axiom proof_of_init_array2_safety_wit_8 : init_array2_safety_wit_8.
Axiom proof_of_init_array2_safety_wit_9 : init_array2_safety_wit_9.
Axiom proof_of_init_array2_safety_wit_10 : init_array2_safety_wit_10.
Axiom proof_of_init_array2_safety_wit_11 : init_array2_safety_wit_11.
Axiom proof_of_init_array2_safety_wit_12 : init_array2_safety_wit_12.
Axiom proof_of_init_array2_safety_wit_13 : init_array2_safety_wit_13.
Axiom proof_of_init_array2_safety_wit_14 : init_array2_safety_wit_14.
Axiom proof_of_init_array2_safety_wit_15 : init_array2_safety_wit_15.
Axiom proof_of_init_array2_safety_wit_16 : init_array2_safety_wit_16.
Axiom proof_of_init_array2_safety_wit_17 : init_array2_safety_wit_17.
Axiom proof_of_init_array2_safety_wit_18 : init_array2_safety_wit_18.
Axiom proof_of_init_array2_safety_wit_19 : init_array2_safety_wit_19.
Axiom proof_of_init_array2_safety_wit_20 : init_array2_safety_wit_20.
Axiom proof_of_init_array2_safety_wit_21 : init_array2_safety_wit_21.
Axiom proof_of_init_array2_safety_wit_22 : init_array2_safety_wit_22.
Axiom proof_of_init_array2_safety_wit_23 : init_array2_safety_wit_23.
Axiom proof_of_init_array2_safety_wit_24 : init_array2_safety_wit_24.
Axiom proof_of_init_array2_safety_wit_25 : init_array2_safety_wit_25.
Axiom proof_of_init_array2_safety_wit_26 : init_array2_safety_wit_26.
Axiom proof_of_init_array2_safety_wit_27 : init_array2_safety_wit_27.
Axiom proof_of_init_array2_safety_wit_28 : init_array2_safety_wit_28.
Axiom proof_of_init_array2_safety_wit_29 : init_array2_safety_wit_29.
Axiom proof_of_init_array2_safety_wit_30 : init_array2_safety_wit_30.
Axiom proof_of_init_array2_safety_wit_31 : init_array2_safety_wit_31.
Axiom proof_of_init_array2_safety_wit_32 : init_array2_safety_wit_32.
Axiom proof_of_init_array2_safety_wit_33 : init_array2_safety_wit_33.
Axiom proof_of_init_array2_safety_wit_34 : init_array2_safety_wit_34.
Axiom proof_of_init_array2_safety_wit_35 : init_array2_safety_wit_35.
Axiom proof_of_init_array2_safety_wit_36 : init_array2_safety_wit_36.
Axiom proof_of_init_array2_safety_wit_37 : init_array2_safety_wit_37.
Axiom proof_of_init_array2_safety_wit_38 : init_array2_safety_wit_38.
Axiom proof_of_init_array2_safety_wit_39 : init_array2_safety_wit_39.
Axiom proof_of_init_array2_safety_wit_40 : init_array2_safety_wit_40.
Axiom proof_of_init_array2_safety_wit_41 : init_array2_safety_wit_41.
Axiom proof_of_init_array2_entail_wit_1 : init_array2_entail_wit_1.
Axiom proof_of_init_array2_entail_wit_2 : init_array2_entail_wit_2.
Axiom proof_of_init_array2_entail_wit_3 : init_array2_entail_wit_3.
Axiom proof_of_init_array2_entail_wit_4 : init_array2_entail_wit_4.
Axiom proof_of_init_array2_entail_wit_5 : init_array2_entail_wit_5.
Axiom proof_of_init_array2_entail_wit_6 : init_array2_entail_wit_6.
Axiom proof_of_init_array2_entail_wit_7 : init_array2_entail_wit_7.
Axiom proof_of_init_array2_entail_wit_8 : init_array2_entail_wit_8.
Axiom proof_of_init_array2_entail_wit_9 : init_array2_entail_wit_9.
Axiom proof_of_init_array2_entail_wit_10 : init_array2_entail_wit_10.
Axiom proof_of_init_array2_entail_wit_11 : init_array2_entail_wit_11.
Axiom proof_of_init_array2_entail_wit_12 : init_array2_entail_wit_12.
Axiom proof_of_init_array2_entail_wit_13 : init_array2_entail_wit_13.
Axiom proof_of_init_array2_entail_wit_14 : init_array2_entail_wit_14.
Axiom proof_of_init_array2_return_wit_1 : init_array2_return_wit_1.
Axiom proof_of_init_array2_partial_solve_wit_1 : init_array2_partial_solve_wit_1.
Axiom proof_of_init_array2_partial_solve_wit_2 : init_array2_partial_solve_wit_2.
Axiom proof_of_init_array2_partial_solve_wit_3 : init_array2_partial_solve_wit_3.
Axiom proof_of_init_array2_partial_solve_wit_4 : init_array2_partial_solve_wit_4.
Axiom proof_of_init_array2_partial_solve_wit_5 : init_array2_partial_solve_wit_5.
Axiom proof_of_init_array2_partial_solve_wit_6 : init_array2_partial_solve_wit_6.
Axiom proof_of_init_array2_partial_solve_wit_7 : init_array2_partial_solve_wit_7.
Axiom proof_of_init_array2_partial_solve_wit_8 : init_array2_partial_solve_wit_8.
Axiom proof_of_init_array2_partial_solve_wit_9 : init_array2_partial_solve_wit_9.
Axiom proof_of_init_array2_partial_solve_wit_10 : init_array2_partial_solve_wit_10.
Axiom proof_of_init_array2_partial_solve_wit_11 : init_array2_partial_solve_wit_11.
Axiom proof_of_init_array2_partial_solve_wit_12 : init_array2_partial_solve_wit_12.
Axiom proof_of_init_array2_partial_solve_wit_13 : init_array2_partial_solve_wit_13.
Axiom proof_of_init_array2_precondition_wit_1 : init_array2_precondition_wit_1.

End VC_Correct.
