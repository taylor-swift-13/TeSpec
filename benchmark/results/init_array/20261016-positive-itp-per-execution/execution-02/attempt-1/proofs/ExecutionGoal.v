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
  ((( &( "j_spec_383" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 1)
  **  ((4096) # Char  |->_)
|--
  TT && emp 
.

Definition init_array2_safety_wit_2 := 
  ((( &( "j_spec_383" ) )) # UInt  |->_)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 1)
  **  ((4096) # Char  |->_)
|--
  TT && emp 
.

Definition init_array2_safety_wit_3 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_383" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 1)
  **  ((4096) # Char  |->_)
|--
  “ False ”
.

Definition init_array2_safety_wit_4 := 
forall (PreH1 : False) ,
  ((4096) # Char  |-> 0)
  **  ((( &( "j_spec_383" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 1)
|--
  “ False ”
.

Definition init_array2_entail_wit_1 := 
(
  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 1 (repeat_Z (0) (1)) )
) \/
(
  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 1 (repeat_Z (0) (1)) )
).

Definition init_array2_entail_wit_1_split_goal_spatial := 
  ((4096) # Char  |-> 0)
|--
  (CharArray.full 4096 1 (repeat_Z (0) (1)) )
.

Definition init_array2_entail_wit_2 := 
(
  ((4096) # Char  |->_)
|--
  (CharArray.full 4096 0 (repeat_Z (0) (0)) )
  **  (CharArray.undef_seg 4096 0 1 )
) \/
(
  ((4096) # Char  |->_)
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
  &&  (CharArray.undef_full 4096 1 )
).

Definition init_array2_entail_wit_2_split_goal_1 := 
  ((4096) # Char  |->_)
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
.

Definition init_array2_entail_wit_2_split_goal_spatial := 
  ((4096) # Char  |->_)
|--
  (CharArray.undef_full 4096 1 )
.

Definition init_array2_return_wit_1 := 
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((0 + 1 ) >= n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (p_pre = 4096)) (PreH4 : (n_pre = 1)) (PreH5 : (0 <= n_pre)) (PreH6 : (n_pre <= UINT_MAX)) ,
  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
) \/
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : ((0 + 1 ) >= n_pre)) (PreH2 : (0 < n_pre)) (PreH3 : (p_pre = 4096)) (PreH4 : (n_pre = 1)) (PreH5 : (0 <= n_pre)) (PreH6 : (n_pre <= UINT_MAX)) ,
  (((p_pre + (0 * sizeof(CHAR)))) # Char  |-> 0)
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
).

Definition init_array2_partial_solve_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (0 < n_pre)) (PreH2 : (p_pre = 4096)) (PreH3 : (n_pre = 1)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.undef_full p_pre n_pre )
|--
  “ (0 < n_pre) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 1) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (((p_pre + (0 * sizeof(CHAR)))) # Char  |->_)
.

Definition init_array2_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (p_pre: Z) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 1) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.undef_full p_pre n_pre )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_init_array2_safety_wit_1 : init_array2_safety_wit_1.
Axiom proof_of_init_array2_safety_wit_2 : init_array2_safety_wit_2.
Axiom proof_of_init_array2_safety_wit_3 : init_array2_safety_wit_3.
Axiom proof_of_init_array2_safety_wit_4 : init_array2_safety_wit_4.
Axiom proof_of_init_array2_entail_wit_1 : init_array2_entail_wit_1.
Axiom proof_of_init_array2_entail_wit_2 : init_array2_entail_wit_2.
Axiom proof_of_init_array2_return_wit_1 : init_array2_return_wit_1.
Axiom proof_of_init_array2_partial_solve_wit_1 : init_array2_partial_solve_wit_1.
Axiom proof_of_init_array2_precondition_wit_1 : init_array2_precondition_wit_1.

End VC_Correct.
