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

(*----- Function init_array -----*)

Definition init_array_safety_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  ((( &( "j" ) )) # UInt  |->_)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
  **  (CharArray.full p_pre n_pre l )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition init_array_safety_wit_2 := 
forall (n_pre: Z) (p_pre: Z) (li: (@list Z)) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  ((( &( "j" ) )) # UInt  |-> j)
  **  (CharArray.full p_pre n_pre li )
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition init_array_entail_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre n_pre l )
|--
  EX (li: (@list Z)) ,
  “ (0 <= 0) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.full p_pre n_pre li )
.

Definition init_array_entail_wit_2 := 
forall (n_pre: Z) (p_pre: Z) (li_2: (@list Z)) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre n_pre (replace_Znth (j) (0) (li_2)) )
|--
  EX (li: (@list Z)) ,
  “ (0 <= (j + 1 )) ” 
  &&  “ ((j + 1 ) <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.full p_pre n_pre li )
.

Definition init_array_return_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (li: (@list Z)) (j: Z) (PreH1 : (j >= n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre n_pre li )
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
.

Definition init_array_partial_solve_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (li: (@list Z)) (j: Z) (PreH1 : (j < n_pre)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre n_pre li )
|--
  “ (j < n_pre) ” 
  &&  “ (0 <= j) ” 
  &&  “ (j <= n_pre) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (((p_pre + (j * sizeof(CHAR)))) # Char  |->_)
  **  (CharArray.missing_i p_pre j 0 n_pre li )
.

Module Type VC_Correct.

Axiom proof_of_init_array_safety_wit_1 : init_array_safety_wit_1.
Axiom proof_of_init_array_safety_wit_2 : init_array_safety_wit_2.
Axiom proof_of_init_array_entail_wit_1 : init_array_entail_wit_1.
Axiom proof_of_init_array_entail_wit_2 : init_array_entail_wit_2.
Axiom proof_of_init_array_return_wit_1 : init_array_return_wit_1.
Axiom proof_of_init_array_partial_solve_wit_1 : init_array_partial_solve_wit_1.

End VC_Correct.
