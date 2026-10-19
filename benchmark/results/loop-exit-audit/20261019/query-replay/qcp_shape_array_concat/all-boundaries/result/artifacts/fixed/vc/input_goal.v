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
Require Import SimpleC.EE.QCP_demos_human.sll_shape_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function array_concat -----*)

Definition array_concat_safety_wit_1 := 
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 4 4 )
  **  (((4096 + (3 * 4))) # Int  |-> x_4)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 1)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
|--
  TT && emp 
.

Definition array_concat_safety_wit_2 := 
forall (x: Z) (x_2: Z) (x_3: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 3 4 )
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 1)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
|--
  TT && emp 
.

Definition array_concat_safety_wit_3 := 
forall (x: Z) (x_2: Z) (x_3: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 3 4 )
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 0)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
|--
  TT && emp 
.

Definition array_concat_safety_wit_4 := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 2 4 )
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 0)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  TT && emp 
.

Definition array_concat_safety_wit_5 := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 2 4 )
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 2)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  TT && emp 
.

Definition array_concat_safety_wit_6 := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 2 4 )
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 1)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  TT && emp 
.

Definition array_concat_safety_wit_7 := 
forall (x: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  ((4096) # Int  |-> x)
  **  (IntArray.undef_seg 4096 1 4 )
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 0)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  TT && emp 
.

Definition array_concat_safety_wit_8 := 
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  ((( &( "i_spec_553" ) )) # Int  |->_)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
  **  (((4096 + (3 * 4))) # Int  |->_)
  **  (((4096 + (2 * 4))) # Int  |->_)
  **  (((4096 + (1 * 4))) # Int  |->_)
  **  ((4096) # Int  |->_)
|--
  TT && emp 
.

Definition array_concat_safety_wit_9 := 
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  ((( &( "i_spec_553" ) )) # Int  |-> 0)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
  **  (((4096 + (3 * 4))) # Int  |->_)
  **  (((4096 + (2 * 4))) # Int  |->_)
  **  (((4096 + (1 * 4))) # Int  |->_)
  **  ((4096) # Int  |->_)
|--
  “ False ”
.

Definition array_concat_safety_wit_10 := 
forall (x: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  ((4096) # Int  |-> x)
  **  (IntArray.undef_seg 4096 1 4 )
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 1)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  “ False ”
.

Definition array_concat_safety_wit_11 := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  (IntArray.undef_seg 4096 2 4 )
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 2)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  “ False ”
.

Definition array_concat_safety_wit_12 := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  (IntArray.undef_seg 4096 2 4 )
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 0)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  “ False ”
.

Definition array_concat_safety_wit_13 := 
forall (x: Z) (x_2: Z) (x_3: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  (IntArray.undef_seg 4096 3 4 )
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 1)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
|--
  “ False ”
.

Definition array_concat_safety_wit_14 := 
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  (IntArray.undef_seg 4096 4 4 )
  **  (((4096 + (3 * 4))) # Int  |-> x_4)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 2)
  **  ((( &( "ret_spec_447" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_444" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_441" ) )) # Int  |-> 2)
  **  ((( &( "b_spec_438" ) )) # Ptr  |-> 12288)
  **  ((( &( "m_spec_435" ) )) # Int  |-> 2)
|--
  “ False ”
.

Definition array_concat_entail_wit_1 := 
(
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 4 4 )
  **  (((4096 + (3 * 4))) # Int  |-> x_4)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
|--
  (IntArray.seg_shape 4096 0 4 )
  **  (IntArray.undef_seg 4096 4 4 )
) \/
(
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (x <= INT_MAX)) (PreH2 : (array_value_3 <= INT_MAX)) (PreH3 : (array_value_4 <= INT_MAX)) (PreH4 : (x_2 <= INT_MAX)) (PreH5 : (x_3 <= INT_MAX)) (PreH6 : (array_value <= INT_MAX)) (PreH7 : (array_value_2 <= INT_MAX)) (PreH8 : (x_4 <= INT_MAX)) (PreH9 : (x >= INT_MIN)) (PreH10 : (array_value_3 >= INT_MIN)) (PreH11 : (array_value_4 >= INT_MIN)) (PreH12 : (x_2 >= INT_MIN)) (PreH13 : (x_3 >= INT_MIN)) (PreH14 : (array_value >= INT_MIN)) (PreH15 : (array_value_2 >= INT_MIN)) (PreH16 : (x_4 >= INT_MIN)) ,
  (((4096 + (3 * 4))) # Int  |-> x_4)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
|--
  (IntArray.seg_shape 4096 0 4 )
).

Definition array_concat_entail_wit_1_split_goal_spatial := 
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (x <= INT_MAX)) (PreH2 : (array_value_3 <= INT_MAX)) (PreH3 : (array_value_4 <= INT_MAX)) (PreH4 : (x_2 <= INT_MAX)) (PreH5 : (x_3 <= INT_MAX)) (PreH6 : (array_value <= INT_MAX)) (PreH7 : (array_value_2 <= INT_MAX)) (PreH8 : (x_4 <= INT_MAX)) (PreH9 : (x >= INT_MIN)) (PreH10 : (array_value_3 >= INT_MIN)) (PreH11 : (array_value_4 >= INT_MIN)) (PreH12 : (x_2 >= INT_MIN)) (PreH13 : (x_3 >= INT_MIN)) (PreH14 : (array_value >= INT_MIN)) (PreH15 : (array_value_2 >= INT_MIN)) (PreH16 : (x_4 >= INT_MIN)) ,
  (((4096 + (3 * 4))) # Int  |-> x_4)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
|--
  (IntArray.seg_shape 4096 0 4 )
.

Definition array_concat_entail_wit_2 := 
(
forall (x: Z) (x_2: Z) (x_3: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 3 4 )
  **  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
|--
  (IntArray.seg_shape 4096 0 3 )
  **  (IntArray.undef_seg 4096 3 4 )
) \/
(
forall (x: Z) (x_2: Z) (x_3: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (x <= INT_MAX)) (PreH2 : (array_value_3 <= INT_MAX)) (PreH3 : (array_value_4 <= INT_MAX)) (PreH4 : (x_2 <= INT_MAX)) (PreH5 : (array_value <= INT_MAX)) (PreH6 : (array_value_2 <= INT_MAX)) (PreH7 : (x_3 <= INT_MAX)) (PreH8 : (x >= INT_MIN)) (PreH9 : (array_value_3 >= INT_MIN)) (PreH10 : (array_value_4 >= INT_MIN)) (PreH11 : (x_2 >= INT_MIN)) (PreH12 : (array_value >= INT_MIN)) (PreH13 : (array_value_2 >= INT_MIN)) (PreH14 : (x_3 >= INT_MIN)) ,
  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
|--
  (IntArray.seg_shape 4096 0 3 )
).

Definition array_concat_entail_wit_2_split_goal_spatial := 
forall (x: Z) (x_2: Z) (x_3: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (x <= INT_MAX)) (PreH2 : (array_value_3 <= INT_MAX)) (PreH3 : (array_value_4 <= INT_MAX)) (PreH4 : (x_2 <= INT_MAX)) (PreH5 : (array_value <= INT_MAX)) (PreH6 : (array_value_2 <= INT_MAX)) (PreH7 : (x_3 <= INT_MAX)) (PreH8 : (x >= INT_MIN)) (PreH9 : (array_value_3 >= INT_MIN)) (PreH10 : (array_value_4 >= INT_MIN)) (PreH11 : (x_2 >= INT_MIN)) (PreH12 : (array_value >= INT_MIN)) (PreH13 : (array_value_2 >= INT_MIN)) (PreH14 : (x_3 >= INT_MIN)) ,
  (((4096 + (2 * 4))) # Int  |-> x_3)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_2)
  **  ((12288) # Int  |-> array_value)
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_4)
  **  ((8192) # Int  |-> array_value_3)
  **  ((4096) # Int  |-> x)
|--
  (IntArray.seg_shape 4096 0 3 )
.

Definition array_concat_entail_wit_3 := 
(
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 2 4 )
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 2 )
  **  (IntArray.undef_seg 4096 2 4 )
) \/
(
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (x <= INT_MAX)) (PreH4 : (array_value <= INT_MAX)) (PreH5 : (array_value_2 <= INT_MAX)) (PreH6 : (x_2 <= INT_MAX)) (PreH7 : (array_value_3 >= INT_MIN)) (PreH8 : (array_value_4 >= INT_MIN)) (PreH9 : (x >= INT_MIN)) (PreH10 : (array_value >= INT_MIN)) (PreH11 : (array_value_2 >= INT_MIN)) (PreH12 : (x_2 >= INT_MIN)) ,
  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 2 )
).

Definition array_concat_entail_wit_3_split_goal_spatial := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (x <= INT_MAX)) (PreH4 : (array_value <= INT_MAX)) (PreH5 : (array_value_2 <= INT_MAX)) (PreH6 : (x_2 <= INT_MAX)) (PreH7 : (array_value_3 >= INT_MIN)) (PreH8 : (array_value_4 >= INT_MIN)) (PreH9 : (x >= INT_MIN)) (PreH10 : (array_value >= INT_MIN)) (PreH11 : (array_value_2 >= INT_MIN)) (PreH12 : (x_2 >= INT_MIN)) ,
  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 2 )
.

Definition array_concat_entail_wit_4 := 
(
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (IntArray.undef_seg 4096 2 4 )
  **  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 2 )
  **  (IntArray.undef_seg 4096 2 4 )
) \/
(
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (x <= INT_MAX)) (PreH4 : (array_value <= INT_MAX)) (PreH5 : (array_value_2 <= INT_MAX)) (PreH6 : (x_2 <= INT_MAX)) (PreH7 : (array_value_3 >= INT_MIN)) (PreH8 : (array_value_4 >= INT_MIN)) (PreH9 : (x >= INT_MIN)) (PreH10 : (array_value >= INT_MIN)) (PreH11 : (array_value_2 >= INT_MIN)) (PreH12 : (x_2 >= INT_MIN)) ,
  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 2 )
).

Definition array_concat_entail_wit_4_split_goal_spatial := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (x <= INT_MAX)) (PreH4 : (array_value <= INT_MAX)) (PreH5 : (array_value_2 <= INT_MAX)) (PreH6 : (x_2 <= INT_MAX)) (PreH7 : (array_value_3 >= INT_MIN)) (PreH8 : (array_value_4 >= INT_MIN)) (PreH9 : (x >= INT_MIN)) (PreH10 : (array_value >= INT_MIN)) (PreH11 : (array_value_2 >= INT_MIN)) (PreH12 : (x_2 >= INT_MIN)) ,
  (((4096 + (1 * 4))) # Int  |-> x_2)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  ((4096) # Int  |-> x)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 2 )
.

Definition array_concat_entail_wit_5 := 
(
forall (x: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  ((4096) # Int  |-> x)
  **  (IntArray.undef_seg 4096 1 4 )
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 1 )
  **  (IntArray.undef_seg 4096 1 4 )
) \/
(
forall (x: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (array_value <= INT_MAX)) (PreH4 : (array_value_2 <= INT_MAX)) (PreH5 : (x <= INT_MAX)) (PreH6 : (array_value_3 >= INT_MIN)) (PreH7 : (array_value_4 >= INT_MIN)) (PreH8 : (array_value >= INT_MIN)) (PreH9 : (array_value_2 >= INT_MIN)) (PreH10 : (x >= INT_MIN)) ,
  ((4096) # Int  |-> x)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 1 )
).

Definition array_concat_entail_wit_5_split_goal_spatial := 
forall (x: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (array_value <= INT_MAX)) (PreH4 : (array_value_2 <= INT_MAX)) (PreH5 : (x <= INT_MAX)) (PreH6 : (array_value_3 >= INT_MIN)) (PreH7 : (array_value_4 >= INT_MIN)) (PreH8 : (array_value >= INT_MIN)) (PreH9 : (array_value_2 >= INT_MIN)) (PreH10 : (x >= INT_MIN)) ,
  ((4096) # Int  |-> x)
  **  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
|--
  (IntArray.seg_shape 4096 0 1 )
.

Definition array_concat_entail_wit_6 := 
(
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
  **  (((4096 + (3 * 4))) # Int  |->_)
  **  (((4096 + (2 * 4))) # Int  |->_)
  **  (((4096 + (1 * 4))) # Int  |->_)
  **  ((4096) # Int  |->_)
|--
  (IntArray.undef_seg 4096 0 4 )
) \/
(
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (array_value <= INT_MAX)) (PreH4 : (array_value_2 <= INT_MAX)) (PreH5 : (array_value_3 >= INT_MIN)) (PreH6 : (array_value_4 >= INT_MIN)) (PreH7 : (array_value >= INT_MIN)) (PreH8 : (array_value_2 >= INT_MIN)) ,
  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
  **  (((4096 + (3 * 4))) # Int  |->_)
  **  (((4096 + (2 * 4))) # Int  |->_)
  **  (((4096 + (1 * 4))) # Int  |->_)
  **  ((4096) # Int  |->_)
|--
  (IntArray.undef_seg 4096 0 4 )
).

Definition array_concat_entail_wit_6_split_goal_spatial := 
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= INT_MAX)) (PreH2 : (array_value_4 <= INT_MAX)) (PreH3 : (array_value <= INT_MAX)) (PreH4 : (array_value_2 <= INT_MAX)) (PreH5 : (array_value_3 >= INT_MIN)) (PreH6 : (array_value_4 >= INT_MIN)) (PreH7 : (array_value >= INT_MIN)) (PreH8 : (array_value_2 >= INT_MIN)) ,
  (((8192 + (1 * 4))) # Int  |-> array_value_2)
  **  ((8192) # Int  |-> array_value)
  **  (((12288 + (1 * 4))) # Int  |-> array_value_4)
  **  ((12288) # Int  |-> array_value_3)
  **  (((4096 + (3 * 4))) # Int  |->_)
  **  (((4096 + (2 * 4))) # Int  |->_)
  **  (((4096 + (1 * 4))) # Int  |->_)
  **  ((4096) # Int  |->_)
|--
  (IntArray.undef_seg 4096 0 4 )
.

Definition array_concat_return_wit_1 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (PreH1 : (((0 + 1 ) + 1 ) >= m_pre)) (PreH2 : ((0 + 1 ) < m_pre)) (PreH3 : (0 < m_pre)) (PreH4 : (((0 + 1 ) + 1 ) >= n_pre)) (PreH5 : ((0 + 1 ) < n_pre)) (PreH6 : (0 < n_pre)) (PreH7 : (ret_pre = 4096)) (PreH8 : (a_pre = 8192)) (PreH9 : (n_pre = 2)) (PreH10 : (b_pre = 12288)) (PreH11 : (m_pre = 2)) (PreH12 : (0 <= n_pre)) (PreH13 : (0 <= m_pre)) (PreH14 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.undef_seg ret_pre (((1 + 1 ) + 1 ) + 1 ) (n_pre + m_pre ) )
  **  (((ret_pre + ((n_pre + (0 + 1 ) ) * sizeof(INT)))) # Int  |-> x_4)
  **  (IntArray.full_shape b_pre m_pre )
  **  (((ret_pre + ((n_pre + 0 ) * sizeof(INT)))) # Int  |-> x_3)
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
|--
  (IntArray.full_shape a_pre n_pre )
  **  (IntArray.full_shape b_pre m_pre )
  **  (IntArray.full_shape ret_pre (n_pre + m_pre ) )
.

Definition array_concat_partial_solve_wit_1 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (x_3: Z) (PreH1 : ((0 + 1 ) < m_pre)) (PreH2 : (0 < m_pre)) (PreH3 : (((0 + 1 ) + 1 ) >= n_pre)) (PreH4 : ((0 + 1 ) < n_pre)) (PreH5 : (0 < n_pre)) (PreH6 : (ret_pre = 4096)) (PreH7 : (a_pre = 8192)) (PreH8 : (n_pre = 2)) (PreH9 : (b_pre = 12288)) (PreH10 : (m_pre = 2)) (PreH11 : (0 <= n_pre)) (PreH12 : (0 <= m_pre)) (PreH13 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.undef_seg ret_pre ((1 + 1 ) + 1 ) (n_pre + m_pre ) )
  **  (((ret_pre + ((n_pre + 0 ) * sizeof(INT)))) # Int  |-> x_3)
  **  (IntArray.full_shape b_pre m_pre )
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
|--
  EX (x_4: Z) ,
  “ ((0 + 1 ) < m_pre) ” 
  &&  “ (0 < m_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) >= n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((b_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_4)
  **  (IntArray.missing_i_shape b_pre (0 + 1 ) 0 m_pre )
  **  (IntArray.undef_seg ret_pre ((1 + 1 ) + 1 ) (n_pre + m_pre ) )
  **  (((ret_pre + ((n_pre + 0 ) * sizeof(INT)))) # Int  |-> x_3)
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
.

Definition array_concat_partial_solve_wit_2 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (x_3: Z) (PreH1 : ((0 + 1 ) < m_pre)) (PreH2 : (0 < m_pre)) (PreH3 : (((0 + 1 ) + 1 ) >= n_pre)) (PreH4 : ((0 + 1 ) < n_pre)) (PreH5 : (0 < n_pre)) (PreH6 : (ret_pre = 4096)) (PreH7 : (a_pre = 8192)) (PreH8 : (n_pre = 2)) (PreH9 : (b_pre = 12288)) (PreH10 : (m_pre = 2)) (PreH11 : (0 <= n_pre)) (PreH12 : (0 <= m_pre)) (PreH13 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.full_shape b_pre m_pre )
  **  (IntArray.undef_seg ret_pre ((1 + 1 ) + 1 ) (n_pre + m_pre ) )
  **  (((ret_pre + ((n_pre + 0 ) * sizeof(INT)))) # Int  |-> x_3)
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
|--
  “ ((0 + 1 ) < m_pre) ” 
  &&  “ (0 < m_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) >= n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((ret_pre + ((n_pre + (0 + 1 ) ) * sizeof(INT)))) # Int  |->_)
  **  (IntArray.undef_missing_i ret_pre (n_pre + (0 + 1 ) ) ((1 + 1 ) + 1 ) (n_pre + m_pre ) )
  **  (IntArray.full_shape b_pre m_pre )
  **  (((ret_pre + ((n_pre + 0 ) * sizeof(INT)))) # Int  |-> x_3)
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
.

Definition array_concat_partial_solve_wit_3 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (PreH1 : (0 < m_pre)) (PreH2 : (((0 + 1 ) + 1 ) >= n_pre)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : (0 < n_pre)) (PreH5 : (ret_pre = 4096)) (PreH6 : (a_pre = 8192)) (PreH7 : (n_pre = 2)) (PreH8 : (b_pre = 12288)) (PreH9 : (m_pre = 2)) (PreH10 : (0 <= n_pre)) (PreH11 : (0 <= m_pre)) (PreH12 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.undef_seg ret_pre (1 + 1 ) (n_pre + m_pre ) )
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
  **  (IntArray.full_shape b_pre m_pre )
|--
  EX (x_3: Z) ,
  “ (0 < m_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) >= n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((b_pre + (0 * sizeof(INT)))) # Int  |-> x_3)
  **  (IntArray.missing_i_shape b_pre 0 0 m_pre )
  **  (IntArray.undef_seg ret_pre (1 + 1 ) (n_pre + m_pre ) )
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
.

Definition array_concat_partial_solve_wit_4 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (PreH1 : (0 < m_pre)) (PreH2 : (((0 + 1 ) + 1 ) >= n_pre)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : (0 < n_pre)) (PreH5 : (ret_pre = 4096)) (PreH6 : (a_pre = 8192)) (PreH7 : (n_pre = 2)) (PreH8 : (b_pre = 12288)) (PreH9 : (m_pre = 2)) (PreH10 : (0 <= n_pre)) (PreH11 : (0 <= m_pre)) (PreH12 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.full_shape b_pre m_pre )
  **  (IntArray.undef_seg ret_pre (1 + 1 ) (n_pre + m_pre ) )
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
|--
  “ (0 < m_pre) ” 
  &&  “ (((0 + 1 ) + 1 ) >= n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((ret_pre + ((n_pre + 0 ) * sizeof(INT)))) # Int  |->_)
  **  (IntArray.undef_missing_i ret_pre (n_pre + 0 ) (1 + 1 ) (n_pre + m_pre ) )
  **  (IntArray.full_shape b_pre m_pre )
  **  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
.

Definition array_concat_partial_solve_wit_5 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (ret_pre = 4096)) (PreH4 : (a_pre = 8192)) (PreH5 : (n_pre = 2)) (PreH6 : (b_pre = 12288)) (PreH7 : (m_pre = 2)) (PreH8 : (0 <= n_pre)) (PreH9 : (0 <= m_pre)) (PreH10 : ((n_pre + m_pre ) < INT_MAX)) ,
  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
  **  (IntArray.undef_seg ret_pre 1 (n_pre + m_pre ) )
  **  (IntArray.full_shape a_pre n_pre )
  **  (IntArray.full_shape b_pre m_pre )
|--
  EX (x_2: Z) ,
  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((a_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |-> x_2)
  **  (IntArray.missing_i_shape a_pre (0 + 1 ) 0 n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
  **  (IntArray.undef_seg ret_pre 1 (n_pre + m_pre ) )
  **  (IntArray.full_shape b_pre m_pre )
.

Definition array_concat_partial_solve_wit_6 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (ret_pre = 4096)) (PreH4 : (a_pre = 8192)) (PreH5 : (n_pre = 2)) (PreH6 : (b_pre = 12288)) (PreH7 : (m_pre = 2)) (PreH8 : (0 <= n_pre)) (PreH9 : (0 <= m_pre)) (PreH10 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
  **  (IntArray.undef_seg ret_pre 1 (n_pre + m_pre ) )
  **  (IntArray.full_shape b_pre m_pre )
|--
  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((ret_pre + ((0 + 1 ) * sizeof(INT)))) # Int  |->_)
  **  (IntArray.undef_missing_i ret_pre (0 + 1 ) 1 (n_pre + m_pre ) )
  **  (IntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(INT)))) # Int  |-> x)
  **  (IntArray.full_shape b_pre m_pre )
.

Definition array_concat_partial_solve_wit_7 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (ret_pre = 4096)) (PreH3 : (a_pre = 8192)) (PreH4 : (n_pre = 2)) (PreH5 : (b_pre = 12288)) (PreH6 : (m_pre = 2)) (PreH7 : (0 <= n_pre)) (PreH8 : (0 <= m_pre)) (PreH9 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.full_shape a_pre n_pre )
  **  (IntArray.full_shape b_pre m_pre )
  **  (IntArray.undef_full ret_pre (n_pre + m_pre ) )
|--
  EX (x: Z) ,
  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((a_pre + (0 * sizeof(INT)))) # Int  |-> x)
  **  (IntArray.missing_i_shape a_pre 0 0 n_pre )
  **  (IntArray.full_shape b_pre m_pre )
  **  (IntArray.undef_full ret_pre (n_pre + m_pre ) )
.

Definition array_concat_partial_solve_wit_8 := 
forall (m_pre: Z) (b_pre: Z) (n_pre: Z) (a_pre: Z) (ret_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (ret_pre = 4096)) (PreH3 : (a_pre = 8192)) (PreH4 : (n_pre = 2)) (PreH5 : (b_pre = 12288)) (PreH6 : (m_pre = 2)) (PreH7 : (0 <= n_pre)) (PreH8 : (0 <= m_pre)) (PreH9 : ((n_pre + m_pre ) < INT_MAX)) ,
  (IntArray.full_shape a_pre n_pre )
  **  (IntArray.full_shape b_pre m_pre )
  **  (IntArray.undef_full ret_pre (n_pre + m_pre ) )
|--
  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (((ret_pre + (0 * sizeof(INT)))) # Int  |->_)
  **  (IntArray.undef_seg ret_pre 1 (n_pre + m_pre ) )
  **  (IntArray.full_shape a_pre n_pre )
  **  (IntArray.full_shape b_pre m_pre )
.

Definition array_concat_precondition_wit_1 :=
exists (m_pre: Z) ,
exists (b_pre: Z) ,
exists (n_pre: Z) ,
exists (a_pre: Z) ,
exists (ret_pre: Z) ,
~ ((  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (m_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= m_pre) ” 
  &&  “ ((n_pre + m_pre ) < INT_MAX) ”
  &&  (IntArray.full_shape a_pre n_pre )
  **  (IntArray.full_shape b_pre m_pre )
  **  (IntArray.undef_full ret_pre (n_pre + m_pre ) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_array_concat_safety_wit_1 : array_concat_safety_wit_1.
Axiom proof_of_array_concat_safety_wit_2 : array_concat_safety_wit_2.
Axiom proof_of_array_concat_safety_wit_3 : array_concat_safety_wit_3.
Axiom proof_of_array_concat_safety_wit_4 : array_concat_safety_wit_4.
Axiom proof_of_array_concat_safety_wit_5 : array_concat_safety_wit_5.
Axiom proof_of_array_concat_safety_wit_6 : array_concat_safety_wit_6.
Axiom proof_of_array_concat_safety_wit_7 : array_concat_safety_wit_7.
Axiom proof_of_array_concat_safety_wit_8 : array_concat_safety_wit_8.
Axiom proof_of_array_concat_safety_wit_9 : array_concat_safety_wit_9.
Axiom proof_of_array_concat_safety_wit_10 : array_concat_safety_wit_10.
Axiom proof_of_array_concat_safety_wit_11 : array_concat_safety_wit_11.
Axiom proof_of_array_concat_safety_wit_12 : array_concat_safety_wit_12.
Axiom proof_of_array_concat_safety_wit_13 : array_concat_safety_wit_13.
Axiom proof_of_array_concat_safety_wit_14 : array_concat_safety_wit_14.
Axiom proof_of_array_concat_entail_wit_1 : array_concat_entail_wit_1.
Axiom proof_of_array_concat_entail_wit_2 : array_concat_entail_wit_2.
Axiom proof_of_array_concat_entail_wit_3 : array_concat_entail_wit_3.
Axiom proof_of_array_concat_entail_wit_4 : array_concat_entail_wit_4.
Axiom proof_of_array_concat_entail_wit_5 : array_concat_entail_wit_5.
Axiom proof_of_array_concat_entail_wit_6 : array_concat_entail_wit_6.
Axiom proof_of_array_concat_return_wit_1 : array_concat_return_wit_1.
Axiom proof_of_array_concat_partial_solve_wit_1 : array_concat_partial_solve_wit_1.
Axiom proof_of_array_concat_partial_solve_wit_2 : array_concat_partial_solve_wit_2.
Axiom proof_of_array_concat_partial_solve_wit_3 : array_concat_partial_solve_wit_3.
Axiom proof_of_array_concat_partial_solve_wit_4 : array_concat_partial_solve_wit_4.
Axiom proof_of_array_concat_partial_solve_wit_5 : array_concat_partial_solve_wit_5.
Axiom proof_of_array_concat_partial_solve_wit_6 : array_concat_partial_solve_wit_6.
Axiom proof_of_array_concat_partial_solve_wit_7 : array_concat_partial_solve_wit_7.
Axiom proof_of_array_concat_partial_solve_wit_8 : array_concat_partial_solve_wit_8.
Axiom proof_of_array_concat_precondition_wit_1 : array_concat_precondition_wit_1.

End VC_Correct.
