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

(*----- Function append -----*)

Definition append_safety_wit_1 := 
  ((( &( "u_spec_429" ) )) # Ptr  |->_)
  **  ((( &( "t_spec_426" ) )) # Ptr  |->_)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 8192)
  **  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )
  **  (sll32 8192 (cons ((-INT_MAX)) ((@nil Z))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_2 := 
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  ((8196) # Ptr  |-> 0)
  **  ((8192) # Int  |-> (-INT_MAX))
  **  ((4096) # Int  |-> (INT_MIN))
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> 0)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> 4096)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 8192)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_return_wit_1 := 
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y = 0)) ,
  ((4100) # Ptr  |-> 8192)
  **  ((8196) # Ptr  |-> 0)
  **  ((8192) # Int  |-> (-INT_MAX))
  **  ((4096) # Int  |-> (INT_MIN))
|--
  (sll32 4096 (cons ((INT_MIN)) ((cons ((-INT_MAX)) ((@nil Z))))) )
.

Definition append_partial_solve_wit_1 := 
  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )
  **  (sll32 8192 (cons ((-INT_MAX)) ((@nil Z))) )
|--
  EX (y: Z)  (y_2: Z) ,
  “ (y_2 = 0) ” 
  &&  “ (y = 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  ((8196) # Ptr  |-> y_2)
  **  ((8192) # Int  |-> (-INT_MAX))
  **  ((4096) # Int  |-> (INT_MIN))
.

Definition append_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ (8192 = 8192) ” 
  &&  “ ((cons ((INT_MIN)) ((@nil Z))) = (cons ((INT_MIN)) ((@nil Z)))) ” 
  &&  “ ((cons ((-INT_MAX)) ((@nil Z))) = (cons ((-INT_MAX)) ((@nil Z)))) ”
  &&  (sll32 4096 (cons ((INT_MIN)) ((@nil Z))) )
  **  (sll32 8192 (cons ((-INT_MAX)) ((@nil Z))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_append_safety_wit_1 : append_safety_wit_1.
Axiom proof_of_append_safety_wit_2 : append_safety_wit_2.
Axiom proof_of_append_return_wit_1 : append_return_wit_1.
Axiom proof_of_append_partial_solve_wit_1 : append_partial_solve_wit_1.
Axiom proof_of_append_precondition_wit_1 : append_precondition_wit_1.

End VC_Correct.
