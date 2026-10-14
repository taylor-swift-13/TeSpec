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
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function length -----*)

Definition length_safety_wit_1 := 
  ((( &( "n_spec_421" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition length_safety_wit_2 := 
  ((( &( "n_spec_421" ) )) # Int  |->_)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition length_return_wit_1 := 
forall (y: Z) (PreH1 : (y = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  ((4096) # Int  |-> (INT_MIN))
|--
  “ (1 = 1) ”
  &&  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )
.

Definition length_partial_solve_wit_1 := 
  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )
|--
  EX (y: Z) ,
  “ (y = 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  ((4096) # Int  |-> (INT_MIN))
.

Definition length_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ ((cons ((INT_MIN)) ((@nil Z))) = (cons ((INT_MIN)) ((@nil Z)))) ” 
  &&  “ ((Zlength ((cons ((INT_MIN)) ((@nil Z))))) <= INT_MAX) ”
  &&  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_length_safety_wit_1 : length_safety_wit_1.
Axiom proof_of_length_safety_wit_2 : length_safety_wit_2.
Axiom proof_of_length_return_wit_1 : length_return_wit_1.
Axiom proof_of_length_partial_solve_wit_1 : length_partial_solve_wit_1.
Axiom proof_of_length_precondition_wit_1 : length_precondition_wit_1.

End VC_Correct.
