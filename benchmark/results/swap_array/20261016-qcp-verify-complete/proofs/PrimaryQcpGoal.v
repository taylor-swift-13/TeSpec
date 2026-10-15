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

(*----- Function swap_array -----*)

Definition swap_array_return_wit_1 := 
forall (j_pre: Z) (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) (PreH3 : (0 <= j_pre)) (PreH4 : (j_pre < n_pre)) (PreH5 : (i_pre <> j_pre)) ,
  (IntArray.full p_pre n_pre (replace_Znth (j_pre) ((Znth i_pre l 0)) ((replace_Znth (i_pre) ((Znth j_pre l 0)) (l)))) )
|--
  (IntArray.full p_pre n_pre (replace_Znth (j_pre) ((Znth (i_pre) (l) (0))) ((replace_Znth (i_pre) ((Znth (j_pre) (l) (0))) (l)))) )
.

Definition swap_array_partial_solve_wit_1 := 
forall (j_pre: Z) (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) (PreH3 : (0 <= j_pre)) (PreH4 : (j_pre < n_pre)) (PreH5 : (i_pre <> j_pre)) ,
  (IntArray.full p_pre n_pre l )
|--
  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ” 
  &&  “ (0 <= j_pre) ” 
  &&  “ (j_pre < n_pre) ” 
  &&  “ (i_pre <> j_pre) ”
  &&  (((p_pre + (i_pre * sizeof(INT)))) # Int  |-> (Znth i_pre l 0))
  **  (IntArray.missing_i p_pre i_pre 0 n_pre l )
.

Definition swap_array_partial_solve_wit_2 := 
forall (j_pre: Z) (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) (PreH3 : (0 <= j_pre)) (PreH4 : (j_pre < n_pre)) (PreH5 : (i_pre <> j_pre)) ,
  (IntArray.full p_pre n_pre l )
|--
  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ” 
  &&  “ (0 <= j_pre) ” 
  &&  “ (j_pre < n_pre) ” 
  &&  “ (i_pre <> j_pre) ”
  &&  (((p_pre + (j_pre * sizeof(INT)))) # Int  |-> (Znth j_pre l 0))
  **  (IntArray.missing_i p_pre j_pre 0 n_pre l )
.

Definition swap_array_partial_solve_wit_3 := 
forall (j_pre: Z) (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) (PreH3 : (0 <= j_pre)) (PreH4 : (j_pre < n_pre)) (PreH5 : (i_pre <> j_pre)) ,
  (IntArray.full p_pre n_pre l )
|--
  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ” 
  &&  “ (0 <= j_pre) ” 
  &&  “ (j_pre < n_pre) ” 
  &&  “ (i_pre <> j_pre) ”
  &&  (((p_pre + (i_pre * sizeof(INT)))) # Int  |->_)
  **  (IntArray.missing_i p_pre i_pre 0 n_pre l )
.

Definition swap_array_partial_solve_wit_4 := 
forall (j_pre: Z) (i_pre: Z) (n_pre: Z) (p_pre: Z) (l: (@list Z)) (PreH1 : (0 <= i_pre)) (PreH2 : (i_pre < n_pre)) (PreH3 : (0 <= j_pre)) (PreH4 : (j_pre < n_pre)) (PreH5 : (i_pre <> j_pre)) ,
  (IntArray.full p_pre n_pre (replace_Znth (i_pre) ((Znth j_pre l 0)) (l)) )
|--
  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ” 
  &&  “ (0 <= j_pre) ” 
  &&  “ (j_pre < n_pre) ” 
  &&  “ (i_pre <> j_pre) ”
  &&  (((p_pre + (j_pre * sizeof(INT)))) # Int  |->_)
  **  (IntArray.missing_i p_pre j_pre 0 n_pre (replace_Znth (i_pre) ((Znth j_pre l 0)) (l)) )
.

Module Type VC_Correct.

Axiom proof_of_swap_array_return_wit_1 : swap_array_return_wit_1.
Axiom proof_of_swap_array_partial_solve_wit_1 : swap_array_partial_solve_wit_1.
Axiom proof_of_swap_array_partial_solve_wit_2 : swap_array_partial_solve_wit_2.
Axiom proof_of_swap_array_partial_solve_wit_3 : swap_array_partial_solve_wit_3.
Axiom proof_of_swap_array_partial_solve_wit_4 : swap_array_partial_solve_wit_4.

End VC_Correct.
