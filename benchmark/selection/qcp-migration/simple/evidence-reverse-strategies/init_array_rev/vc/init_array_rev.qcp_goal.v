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

(*----- Function init_array2 -----*)

Definition init_array2_safety_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) (PreH3 : (0 < n_pre)) ,
  ((( &( "j" ) )) # UInt  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
  **  (CharArray.undef_full p_pre n_pre )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition init_array2_safety_wit_2 := 
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  ((( &( "j" ) )) # UInt  |-> j)
  **  (CharArray.undef_seg p_pre 0 (n_pre - j ) )
  **  (CharArray.seg p_pre (n_pre - j ) n_pre (repeat_Z (0) (j)) )
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition init_array2_safety_wit_3 := 
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  ((( &( "j" ) )) # UInt  |-> j)
  **  (CharArray.undef_seg p_pre 0 (n_pre - j ) )
  **  (CharArray.seg p_pre (n_pre - j ) n_pre (repeat_Z (0) (j)) )
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition init_array2_entail_wit_1 := 
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) (PreH3 : (0 < n_pre)) ,
  (CharArray.undef_full p_pre n_pre )
|--
  “ (0 <= 0) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (CharArray.undef_seg p_pre 0 (n_pre - 0 ) )
  **  (CharArray.seg p_pre (n_pre - 0 ) n_pre (repeat_Z (0) (0)) )
) \/
(
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) (PreH3 : (0 < n_pre)) ,
  TT && emp 
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
  &&  emp
).

Definition init_array2_entail_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) (PreH3 : (0 < n_pre)) ,
  ((repeat_Z (0) (0)) = (@nil Z))
.

Definition init_array2_entail_wit_2 := 
(
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.seg p_pre (n_pre - (j + 1 ) ) n_pre (cons (0) ((repeat_Z (0) (j)))) )
  **  (CharArray.undef_seg p_pre 0 (n_pre - (j + 1 ) ) )
|--
  “ (0 <= (j + 1 )) ” 
  &&  “ ((j + 1 ) <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (CharArray.undef_seg p_pre 0 (n_pre - (j + 1 ) ) )
  **  (CharArray.seg p_pre (n_pre - (j + 1 ) ) n_pre (repeat_Z (0) ((j + 1 ))) )
) \/
(
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (j + 1 ) ) )
|--
  “ ((cons (0) ((repeat_Z (0) (j)))) = (repeat_Z (0) ((j + 1 )))) ”
  &&  (CharArray.undef_full p_pre (n_pre - (j + 1 ) ) )
).

Definition init_array2_entail_wit_2_split_goal_1 := 
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (j + 1 ) ) )
|--
  “ ((cons (0) ((repeat_Z (0) (j)))) = (repeat_Z (0) ((j + 1 )))) ”
.

Definition init_array2_entail_wit_2_split_goal_spatial := 
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - (j + 1 ) ) )
|--
  (CharArray.undef_full p_pre (n_pre - (j + 1 ) ) )
.

Definition init_array2_return_wit_1 := 
(
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j >= n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - j ) )
  **  (CharArray.seg p_pre (n_pre - j ) n_pre (repeat_Z (0) (j)) )
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
) \/
(
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j >= n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.seg p_pre (n_pre - j ) n_pre (repeat_Z (0) (j)) )
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
).

Definition init_array2_partial_solve_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) (PreH6 : (0 < n_pre)) ,
  (CharArray.undef_seg p_pre 0 (n_pre - j ) )
  **  (CharArray.seg p_pre (n_pre - j ) n_pre (repeat_Z (0) (j)) )
|--
  “ (j < n_pre) ” 
  &&  “ (0 <= j) ” 
  &&  “ (j <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 < n_pre) ”
  &&  (((p_pre + ((n_pre - (j + 1 ) ) * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre (n_pre - (j + 1 ) ) 0 (n_pre - j ) )
  **  (CharArray.seg p_pre (n_pre - j ) n_pre (repeat_Z (0) (j)) )
.

Module Type VC_Correct.

Axiom proof_of_init_array2_safety_wit_1 : init_array2_safety_wit_1.
Axiom proof_of_init_array2_safety_wit_2 : init_array2_safety_wit_2.
Axiom proof_of_init_array2_safety_wit_3 : init_array2_safety_wit_3.
Axiom proof_of_init_array2_entail_wit_1 : init_array2_entail_wit_1.
Axiom proof_of_init_array2_entail_wit_2 : init_array2_entail_wit_2.
Axiom proof_of_init_array2_return_wit_1 : init_array2_return_wit_1.
Axiom proof_of_init_array2_partial_solve_wit_1 : init_array2_partial_solve_wit_1.

End VC_Correct.
