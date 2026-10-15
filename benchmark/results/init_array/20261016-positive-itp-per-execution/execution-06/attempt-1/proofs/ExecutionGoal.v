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
  (CharArray.undef_seg 4096 2 3 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
|--
  TT && emp 
.

Definition init_array2_safety_wit_2 := 
  ((4096) # Char  |-> 0)
  **  (CharArray.undef_seg 4096 1 3 )
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
|--
  TT && emp 
.

Definition init_array2_safety_wit_3 := 
  ((( &( "j_spec_383" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  TT && emp 
.

Definition init_array2_safety_wit_4 := 
  ((( &( "j_spec_383" ) )) # UInt  |->_)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  TT && emp 
.

Definition init_array2_safety_wit_5 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_383" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
  **  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  “ False ”
.

Definition init_array2_safety_wit_6 := 
forall (PreH1 : False) ,
  ((4096) # Char  |-> 0)
  **  (CharArray.undef_seg 4096 1 3 )
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
|--
  “ False ”
.

Definition init_array2_safety_wit_7 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 2 3 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
|--
  “ False ”
.

Definition init_array2_safety_wit_8 := 
forall (PreH1 : False) ,
  (CharArray.undef_seg 4096 3 3 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 3)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 3)
|--
  “ False ”
.

Definition init_array2_entail_wit_1 := 
(
  (CharArray.undef_seg 4096 3 3 )
  **  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 3 (repeat_Z (0) (3)) )
) \/
(
  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 3 (repeat_Z (0) (3)) )
).

Definition init_array2_entail_wit_1_split_goal_spatial := 
  (((4096 + (2 * 1))) # Char  |-> 0)
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 3 (repeat_Z (0) (3)) )
.

Definition init_array2_entail_wit_2 := 
(
  (CharArray.undef_seg 4096 2 3 )
  **  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 2 (repeat_Z (0) (2)) )
  **  (CharArray.undef_seg 4096 2 3 )
) \/
(
  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 2 (repeat_Z (0) (2)) )
).

Definition init_array2_entail_wit_2_split_goal_spatial := 
  (((4096 + (1 * 1))) # Char  |-> 0)
  **  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 2 (repeat_Z (0) (2)) )
.

Definition init_array2_entail_wit_3 := 
(
  ((4096) # Char  |-> 0)
  **  (CharArray.undef_seg 4096 1 3 )
|--
  (CharArray.full 4096 1 (repeat_Z (0) (1)) )
  **  (CharArray.undef_seg 4096 1 3 )
) \/
(
  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 1 (repeat_Z (0) (1)) )
).

Definition init_array2_entail_wit_3_split_goal_spatial := 
  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 1 (repeat_Z (0) (1)) )
.

Definition init_array2_entail_wit_4 := 
(
  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  (CharArray.full 4096 0 (repeat_Z (0) (0)) )
  **  (CharArray.undef_seg 4096 0 3 )
) \/
(
  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
  &&  (CharArray.undef_full 4096 3 )
).

Definition init_array2_entail_wit_4_split_goal_1 := 
  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
.

Definition init_array2_entail_wit_4_split_goal_spatial := 
  (((4096 + (2 * 1))) # Char  |->_)
  **  (((4096 + (1 * 1))) # Char  |->_)
  **  ((4096) # Char  |->_)
|--
  (CharArray.undef_full 4096 3 )
.

Definition init_array2_return_wit_1 := 
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((0 + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : (((0 + 1 ) + 1 ) < n_pre)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : (0 < n_pre)) (PreH5 : (p_pre = 4096)) (PreH6 : (n_pre = 3)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre <= UINT_MAX)) ,
  (CharArray.undef_seg p_pre ((1 + 1 ) + 1 ) n_pre )
  **  (((p_pre + (((0 + 1 ) + 1 ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((0 + 1 ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
) \/
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((((0 + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : (((0 + 1 ) + 1 ) < n_pre)) (PreH3 : ((0 + 1 ) < n_pre)) (PreH4 : (0 < n_pre)) (PreH5 : (p_pre = 4096)) (PreH6 : (n_pre = 3)) (PreH7 : (0 <= n_pre)) (PreH8 : (n_pre <= UINT_MAX)) ,
  (((p_pre + (((0 + 1 ) + 1 ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + ((0 + 1 ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
).

Definition init_array2_partial_solve_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (((0 + 1 ) + 1 ) < n_pre)) (PreH2 : ((0 + 1 ) < n_pre)) (PreH3 : (0 < n_pre)) (PreH4 : (p_pre = 4096)) (PreH5 : (n_pre = 3)) (PreH6 : (0 <= n_pre)) (PreH7 : (n_pre <= UINT_MAX)) ,
  (CharArray.undef_seg p_pre (1 + 1 ) n_pre )
  **  (((p_pre + ((0 + 1 ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
|--
  “ (((0 + 1 ) + 1 ) < n_pre) ” 
  &&  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (((p_pre + (((0 + 1 ) + 1 ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre ((0 + 1 ) + 1 ) (1 + 1 ) n_pre )
  **  (((p_pre + ((0 + 1 ) * sizeof(CHAR)))) # Char  |-> 0)
  **  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_2 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((0 + 1 ) < n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (p_pre = 4096)) (PreH4 : (n_pre = 3)) (PreH5 : (0 <= n_pre)) (PreH6 : (n_pre <= UINT_MAX)) ,
  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
  **  (CharArray.undef_seg p_pre 1 n_pre )
|--
  “ ((0 + 1 ) < n_pre) ” 
  &&  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (((p_pre + ((0 + 1 ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (0 + 1 ) 1 n_pre )
  **  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
.

Definition init_array2_partial_solve_wit_3 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (p_pre = 4096)) (PreH3 : (n_pre = 3)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.undef_full p_pre n_pre )
|--
  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (((p_pre + (0 * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_seg p_pre 1 n_pre )
.

Definition init_array2_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (p_pre: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 3) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
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
Axiom proof_of_init_array2_entail_wit_1 : init_array2_entail_wit_1.
Axiom proof_of_init_array2_entail_wit_2 : init_array2_entail_wit_2.
Axiom proof_of_init_array2_entail_wit_3 : init_array2_entail_wit_3.
Axiom proof_of_init_array2_entail_wit_4 : init_array2_entail_wit_4.
Axiom proof_of_init_array2_return_wit_1 : init_array2_return_wit_1.
Axiom proof_of_init_array2_partial_solve_wit_1 : init_array2_partial_solve_wit_1.
Axiom proof_of_init_array2_partial_solve_wit_2 : init_array2_partial_solve_wit_2.
Axiom proof_of_init_array2_partial_solve_wit_3 : init_array2_partial_solve_wit_3.
Axiom proof_of_init_array2_precondition_wit_1 : init_array2_precondition_wit_1.

End VC_Correct.
