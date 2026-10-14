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
forall (n_pre: Z) (p_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  ((( &( "j" ) )) # UInt  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
  **  (CharArray.undef_full p_pre n_pre )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition init_array2_safety_wit_2 := 
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  ((( &( "j" ) )) # UInt  |-> j)
  **  (CharArray.full p_pre j (repeat_Z (0) (j)) )
  **  (CharArray.undef_seg p_pre j n_pre )
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition init_array2_entail_wit_1 := 
(
forall (n_pre: Z) (p_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  (CharArray.undef_full p_pre n_pre )
|--
  “ (0 <= 0) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.full p_pre 0 (repeat_Z (0) (0)) )
  **  (CharArray.undef_seg p_pre 0 n_pre )
) \/
(
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((repeat_Z (0) (0)) = (@nil Z)) ”
  &&  emp
).

Definition init_array2_entail_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  ((repeat_Z (0) (0)) = (@nil Z))
.

Definition init_array2_entail_wit_2 := 
(
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre (j + 1 ) (app ((repeat_Z (0) (j))) ((cons (0) ((@nil Z))))) )
  **  (CharArray.undef_seg p_pre (j + 1 ) n_pre )
|--
  “ (0 <= (j + 1 )) ” 
  &&  “ ((j + 1 ) <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.full p_pre (j + 1 ) (repeat_Z (0) ((j + 1 ))) )
  **  (CharArray.undef_seg p_pre (j + 1 ) n_pre )
) \/
(
forall (n_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((app ((repeat_Z (0) (j))) ((cons (0) ((@nil Z))))) = (repeat_Z (0) ((j + 1 )))) ”
  &&  emp
).

Definition init_array2_entail_wit_2_split_goal_1 := 
forall (n_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  ((app ((repeat_Z (0) (j))) ((cons (0) ((@nil Z))))) = (repeat_Z (0) ((j + 1 ))))
.

Definition init_array2_return_wit_1 := 
(
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j >= n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre j (repeat_Z (0) (j)) )
  **  (CharArray.undef_seg p_pre j n_pre )
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
) \/
(
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j >= n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre j (repeat_Z (0) (j)) )
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
).

Definition init_array2_partial_solve_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre j (repeat_Z (0) (j)) )
  **  (CharArray.undef_seg p_pre j n_pre )
|--
  “ (j < n_pre) ” 
  &&  “ (0 <= j) ” 
  &&  “ (j <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (((p_pre + (j * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.undef_missing_i p_pre j j n_pre )
  **  (CharArray.full p_pre j (repeat_Z (0) (j)) )
.

Module Type VC_Correct.

Axiom proof_of_init_array2_safety_wit_1 : init_array2_safety_wit_1.
Axiom proof_of_init_array2_safety_wit_2 : init_array2_safety_wit_2.
Axiom proof_of_init_array2_entail_wit_1 : init_array2_entail_wit_1.
Axiom proof_of_init_array2_entail_wit_2 : init_array2_entail_wit_2.
Axiom proof_of_init_array2_return_wit_1 : init_array2_return_wit_1.
Axiom proof_of_init_array2_partial_solve_wit_1 : init_array2_partial_solve_wit_1.

End VC_Correct.
