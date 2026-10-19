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

(*----- Function array_vector_sum -----*)

Definition array_vector_sum_safety_wit_1 := 
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (UIntArray.undef_seg 4096 2 2 )
  **  (((4096 + (1 * 4))) # UInt  |-> (unsigned_last_nbits ((x_3 + x_4 )) (32)))
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
  **  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  ((( &( "i_spec_553" ) )) # Int  |-> 1)
  **  ((( &( "ret_spec_476" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_473" ) )) # Ptr  |-> 8192)
  **  ((( &( "b_spec_470" ) )) # Ptr  |-> 12288)
  **  ((( &( "n_spec_467" ) )) # Int  |-> 2)
|--
  TT && emp 
.

Definition array_vector_sum_safety_wit_2 := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg 4096 1 2 )
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 0)
  **  ((( &( "ret_spec_476" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_473" ) )) # Ptr  |-> 8192)
  **  ((( &( "b_spec_470" ) )) # Ptr  |-> 12288)
  **  ((( &( "n_spec_467" ) )) # Int  |-> 2)
|--
  TT && emp 
.

Definition array_vector_sum_safety_wit_3 := 
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  ((( &( "i_spec_553" ) )) # Int  |->_)
  **  ((( &( "ret_spec_476" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_473" ) )) # Ptr  |-> 8192)
  **  ((( &( "b_spec_470" ) )) # Ptr  |-> 12288)
  **  ((( &( "n_spec_467" ) )) # Int  |-> 2)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((8192) # UInt  |-> array_value)
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((12288) # UInt  |-> array_value_3)
  **  (((4096 + (1 * 4))) # UInt  |->_)
  **  ((4096) # UInt  |->_)
|--
  TT && emp 
.

Definition array_vector_sum_safety_wit_4 := 
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  ((( &( "i_spec_553" ) )) # Int  |-> 0)
  **  ((( &( "ret_spec_476" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_473" ) )) # Ptr  |-> 8192)
  **  ((( &( "b_spec_470" ) )) # Ptr  |-> 12288)
  **  ((( &( "n_spec_467" ) )) # Int  |-> 2)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((8192) # UInt  |-> array_value)
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((12288) # UInt  |-> array_value_3)
  **  (((4096 + (1 * 4))) # UInt  |->_)
  **  ((4096) # UInt  |->_)
|--
  “ False ”
.

Definition array_vector_sum_safety_wit_5 := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg 4096 1 2 )
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
  **  ((( &( "i_spec_553" ) )) # Int  |-> 1)
  **  ((( &( "ret_spec_476" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_473" ) )) # Ptr  |-> 8192)
  **  ((( &( "b_spec_470" ) )) # Ptr  |-> 12288)
  **  ((( &( "n_spec_467" ) )) # Int  |-> 2)
|--
  “ False ”
.

Definition array_vector_sum_safety_wit_6 := 
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : False) ,
  (UIntArray.undef_seg 4096 2 2 )
  **  (((4096 + (1 * 4))) # UInt  |-> (unsigned_last_nbits ((x_3 + x_4 )) (32)))
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
  **  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  ((( &( "i_spec_553" ) )) # Int  |-> 2)
  **  ((( &( "ret_spec_476" ) )) # Ptr  |-> 4096)
  **  ((( &( "a_spec_473" ) )) # Ptr  |-> 8192)
  **  ((( &( "b_spec_470" ) )) # Ptr  |-> 12288)
  **  ((( &( "n_spec_467" ) )) # Int  |-> 2)
|--
  “ False ”
.

Definition array_vector_sum_entail_wit_1 := 
(
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (UIntArray.undef_seg 4096 2 2 )
  **  (((4096 + (1 * 4))) # UInt  |-> (unsigned_last_nbits ((x_3 + x_4 )) (32)))
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
  **  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
|--
  (UIntArray.seg_shape 4096 0 2 )
) \/
(
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : ((unsigned_last_nbits ((x + x_2 )) (32)) <= UINT_MAX)) (PreH2 : (array_value_3 <= UINT_MAX)) (PreH3 : (array_value_4 <= UINT_MAX)) (PreH4 : (array_value <= UINT_MAX)) (PreH5 : (array_value_2 <= UINT_MAX)) (PreH6 : ((unsigned_last_nbits ((x_3 + x_4 )) (32)) <= UINT_MAX)) (PreH7 : ((unsigned_last_nbits ((x + x_2 )) (32)) >= 0)) (PreH8 : (array_value_3 >= 0)) (PreH9 : (array_value_4 >= 0)) (PreH10 : (array_value >= 0)) (PreH11 : (array_value_2 >= 0)) (PreH12 : ((unsigned_last_nbits ((x_3 + x_4 )) (32)) >= 0)) ,
  (((4096 + (1 * 4))) # UInt  |-> (unsigned_last_nbits ((x_3 + x_4 )) (32)))
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
  **  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
|--
  (UIntArray.seg_shape 4096 0 2 )
).

Definition array_vector_sum_entail_wit_1_split_goal_spatial := 
forall (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : ((unsigned_last_nbits ((x + x_2 )) (32)) <= UINT_MAX)) (PreH2 : (array_value_3 <= UINT_MAX)) (PreH3 : (array_value_4 <= UINT_MAX)) (PreH4 : (array_value <= UINT_MAX)) (PreH5 : (array_value_2 <= UINT_MAX)) (PreH6 : ((unsigned_last_nbits ((x_3 + x_4 )) (32)) <= UINT_MAX)) (PreH7 : ((unsigned_last_nbits ((x + x_2 )) (32)) >= 0)) (PreH8 : (array_value_3 >= 0)) (PreH9 : (array_value_4 >= 0)) (PreH10 : (array_value >= 0)) (PreH11 : (array_value_2 >= 0)) (PreH12 : ((unsigned_last_nbits ((x_3 + x_4 )) (32)) >= 0)) ,
  (((4096 + (1 * 4))) # UInt  |-> (unsigned_last_nbits ((x_3 + x_4 )) (32)))
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
  **  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
|--
  (UIntArray.seg_shape 4096 0 2 )
.

Definition array_vector_sum_entail_wit_2 := 
(
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg 4096 1 2 )
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
|--
  (UIntArray.seg_shape 4096 0 1 )
  **  (UIntArray.undef_seg 4096 1 2 )
) \/
(
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= UINT_MAX)) (PreH2 : (array_value_4 <= UINT_MAX)) (PreH3 : (array_value <= UINT_MAX)) (PreH4 : (array_value_2 <= UINT_MAX)) (PreH5 : ((unsigned_last_nbits ((x + x_2 )) (32)) <= UINT_MAX)) (PreH6 : (array_value_3 >= 0)) (PreH7 : (array_value_4 >= 0)) (PreH8 : (array_value >= 0)) (PreH9 : (array_value_2 >= 0)) (PreH10 : ((unsigned_last_nbits ((x + x_2 )) (32)) >= 0)) ,
  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
|--
  (UIntArray.seg_shape 4096 0 1 )
).

Definition array_vector_sum_entail_wit_2_split_goal_spatial := 
forall (x: Z) (x_2: Z) (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= UINT_MAX)) (PreH2 : (array_value_4 <= UINT_MAX)) (PreH3 : (array_value <= UINT_MAX)) (PreH4 : (array_value_2 <= UINT_MAX)) (PreH5 : ((unsigned_last_nbits ((x + x_2 )) (32)) <= UINT_MAX)) (PreH6 : (array_value_3 >= 0)) (PreH7 : (array_value_4 >= 0)) (PreH8 : (array_value >= 0)) (PreH9 : (array_value_2 >= 0)) (PreH10 : ((unsigned_last_nbits ((x + x_2 )) (32)) >= 0)) ,
  ((4096) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((12288) # UInt  |-> array_value)
  **  (((8192 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((8192) # UInt  |-> array_value_3)
|--
  (UIntArray.seg_shape 4096 0 1 )
.

Definition array_vector_sum_entail_wit_3 := 
(
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) ,
  (((8192 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((8192) # UInt  |-> array_value)
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((12288) # UInt  |-> array_value_3)
  **  (((4096 + (1 * 4))) # UInt  |->_)
  **  ((4096) # UInt  |->_)
|--
  (UIntArray.undef_seg 4096 0 2 )
) \/
(
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= UINT_MAX)) (PreH2 : (array_value_4 <= UINT_MAX)) (PreH3 : (array_value <= UINT_MAX)) (PreH4 : (array_value_2 <= UINT_MAX)) (PreH5 : (array_value_3 >= 0)) (PreH6 : (array_value_4 >= 0)) (PreH7 : (array_value >= 0)) (PreH8 : (array_value_2 >= 0)) ,
  (((8192 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((8192) # UInt  |-> array_value)
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((12288) # UInt  |-> array_value_3)
  **  (((4096 + (1 * 4))) # UInt  |->_)
  **  ((4096) # UInt  |->_)
|--
  (UIntArray.undef_seg 4096 0 2 )
).

Definition array_vector_sum_entail_wit_3_split_goal_spatial := 
forall (array_value: Z) (array_value_2: Z) (array_value_3: Z) (array_value_4: Z) (PreH1 : (array_value_3 <= UINT_MAX)) (PreH2 : (array_value_4 <= UINT_MAX)) (PreH3 : (array_value <= UINT_MAX)) (PreH4 : (array_value_2 <= UINT_MAX)) (PreH5 : (array_value_3 >= 0)) (PreH6 : (array_value_4 >= 0)) (PreH7 : (array_value >= 0)) (PreH8 : (array_value_2 >= 0)) ,
  (((8192 + (1 * 4))) # UInt  |-> array_value_2)
  **  ((8192) # UInt  |-> array_value)
  **  (((12288 + (1 * 4))) # UInt  |-> array_value_4)
  **  ((12288) # UInt  |-> array_value_3)
  **  (((4096 + (1 * 4))) # UInt  |->_)
  **  ((4096) # UInt  |->_)
|--
  (UIntArray.undef_seg 4096 0 2 )
.

Definition array_vector_sum_return_wit_1 := 
forall (n_pre: Z) (b_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (x_3: Z) (x_4: Z) (PreH1 : (((0 + 1 ) + 1 ) >= n_pre)) (PreH2 : ((0 + 1 ) < n_pre)) (PreH3 : (0 < n_pre)) (PreH4 : (ret_pre = 4096)) (PreH5 : (a_pre = 8192)) (PreH6 : (b_pre = 12288)) (PreH7 : (n_pre = 2)) (PreH8 : (0 <= n_pre)) (PreH9 : (n_pre < INT_MAX)) ,
  (UIntArray.undef_seg ret_pre (1 + 1 ) n_pre )
  **  (((ret_pre + ((0 + 1 ) * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x_3 + x_4 )) (32)))
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
|--
  (UIntArray.full_shape a_pre n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.full_shape ret_pre n_pre )
.

Definition array_vector_sum_partial_solve_wit_1 := 
forall (n_pre: Z) (b_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (ret_pre = 4096)) (PreH4 : (a_pre = 8192)) (PreH5 : (b_pre = 12288)) (PreH6 : (n_pre = 2)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre < INT_MAX)) ,
  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg ret_pre 1 n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
|--
  EX (x_3: Z) ,
  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre < INT_MAX) ”
  &&  (((a_pre + ((0 + 1 ) * sizeof(UINT)))) # UInt  |-> x_3)
  **  (UIntArray.missing_i_shape a_pre (0 + 1 ) 0 n_pre )
  **  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg ret_pre 1 n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
.

Definition array_vector_sum_partial_solve_wit_2 := 
forall (n_pre: Z) (b_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (ret_pre = 4096)) (PreH4 : (a_pre = 8192)) (PreH5 : (b_pre = 12288)) (PreH6 : (n_pre = 2)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre < INT_MAX)) ,
  (UIntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg ret_pre 1 n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
|--
  EX (x_3: Z) ,
  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre < INT_MAX) ”
  &&  (((b_pre + ((0 + 1 ) * sizeof(UINT)))) # UInt  |-> x_3)
  **  (UIntArray.missing_i_shape b_pre (0 + 1 ) 0 n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg ret_pre 1 n_pre )
.

Definition array_vector_sum_partial_solve_wit_3 := 
forall (n_pre: Z) (b_pre: Z) (a_pre: Z) (ret_pre: Z) (x: Z) (x_2: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (ret_pre = 4096)) (PreH4 : (a_pre = 8192)) (PreH5 : (b_pre = 12288)) (PreH6 : (n_pre = 2)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre < INT_MAX)) ,
  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
  **  (UIntArray.undef_seg ret_pre 1 n_pre )
|--
  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre < INT_MAX) ”
  &&  (((ret_pre + ((0 + 1 ) * sizeof(UINT)))) # UInt  |->_)
  **  (UIntArray.undef_missing_i ret_pre (0 + 1 ) 1 n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
  **  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |-> (unsigned_last_nbits ((x + x_2 )) (32)))
.

Definition array_vector_sum_partial_solve_wit_4 := 
forall (n_pre: Z) (b_pre: Z) (a_pre: Z) (ret_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (ret_pre = 4096)) (PreH3 : (a_pre = 8192)) (PreH4 : (b_pre = 12288)) (PreH5 : (n_pre = 2)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre < INT_MAX)) ,
  (UIntArray.full_shape a_pre n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.undef_full ret_pre n_pre )
|--
  EX (x: Z) ,
  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre < INT_MAX) ”
  &&  (((a_pre + (0 * sizeof(UINT)))) # UInt  |-> x)
  **  (UIntArray.missing_i_shape a_pre 0 0 n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.undef_full ret_pre n_pre )
.

Definition array_vector_sum_partial_solve_wit_5 := 
forall (n_pre: Z) (b_pre: Z) (a_pre: Z) (ret_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (ret_pre = 4096)) (PreH3 : (a_pre = 8192)) (PreH4 : (b_pre = 12288)) (PreH5 : (n_pre = 2)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre < INT_MAX)) ,
  (UIntArray.full_shape a_pre n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.undef_full ret_pre n_pre )
|--
  EX (x: Z) ,
  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre < INT_MAX) ”
  &&  (((b_pre + (0 * sizeof(UINT)))) # UInt  |-> x)
  **  (UIntArray.missing_i_shape b_pre 0 0 n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
  **  (UIntArray.undef_full ret_pre n_pre )
.

Definition array_vector_sum_partial_solve_wit_6 := 
forall (n_pre: Z) (b_pre: Z) (a_pre: Z) (ret_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (ret_pre = 4096)) (PreH3 : (a_pre = 8192)) (PreH4 : (b_pre = 12288)) (PreH5 : (n_pre = 2)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre < INT_MAX)) ,
  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
  **  (UIntArray.undef_full ret_pre n_pre )
|--
  “ (0 < n_pre) ” 
  &&  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre < INT_MAX) ”
  &&  (((ret_pre + (0 * sizeof(UINT)))) # UInt  |->_)
  **  (UIntArray.undef_seg ret_pre 1 n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.full_shape a_pre n_pre )
.

Definition array_vector_sum_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (b_pre: Z) ,
exists (a_pre: Z) ,
exists (ret_pre: Z) ,
~ ((  “ (ret_pre = 4096) ” 
  &&  “ (a_pre = 8192) ” 
  &&  “ (b_pre = 12288) ” 
  &&  “ (n_pre = 2) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre < INT_MAX) ”
  &&  (UIntArray.full_shape a_pre n_pre )
  **  (UIntArray.full_shape b_pre n_pre )
  **  (UIntArray.undef_full ret_pre n_pre )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_array_vector_sum_safety_wit_1 : array_vector_sum_safety_wit_1.
Axiom proof_of_array_vector_sum_safety_wit_2 : array_vector_sum_safety_wit_2.
Axiom proof_of_array_vector_sum_safety_wit_3 : array_vector_sum_safety_wit_3.
Axiom proof_of_array_vector_sum_safety_wit_4 : array_vector_sum_safety_wit_4.
Axiom proof_of_array_vector_sum_safety_wit_5 : array_vector_sum_safety_wit_5.
Axiom proof_of_array_vector_sum_safety_wit_6 : array_vector_sum_safety_wit_6.
Axiom proof_of_array_vector_sum_entail_wit_1 : array_vector_sum_entail_wit_1.
Axiom proof_of_array_vector_sum_entail_wit_2 : array_vector_sum_entail_wit_2.
Axiom proof_of_array_vector_sum_entail_wit_3 : array_vector_sum_entail_wit_3.
Axiom proof_of_array_vector_sum_return_wit_1 : array_vector_sum_return_wit_1.
Axiom proof_of_array_vector_sum_partial_solve_wit_1 : array_vector_sum_partial_solve_wit_1.
Axiom proof_of_array_vector_sum_partial_solve_wit_2 : array_vector_sum_partial_solve_wit_2.
Axiom proof_of_array_vector_sum_partial_solve_wit_3 : array_vector_sum_partial_solve_wit_3.
Axiom proof_of_array_vector_sum_partial_solve_wit_4 : array_vector_sum_partial_solve_wit_4.
Axiom proof_of_array_vector_sum_partial_solve_wit_5 : array_vector_sum_partial_solve_wit_5.
Axiom proof_of_array_vector_sum_partial_solve_wit_6 : array_vector_sum_partial_solve_wit_6.
Axiom proof_of_array_vector_sum_precondition_wit_1 : array_vector_sum_precondition_wit_1.

End VC_Correct.
