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
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 0)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 0 (@nil Z) )
  **  (sll32 4096 (cons (INT_MAX) ((cons (INT_MAX) ((cons (INT_MAX) ((cons (100) ((cons (100) ((cons (100) ((cons (1) ((cons (1) ((cons (1) ((cons (0) ((cons (0) ((cons (0) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((@nil Z))))))))))))))))))))))))))))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_return_wit_1 := 
  (sll32 0 (@nil Z) )
  **  (sll32 4096 (cons (INT_MAX) ((cons (INT_MAX) ((cons (INT_MAX) ((cons (100) ((cons (100) ((cons (100) ((cons (1) ((cons (1) ((cons (1) ((cons (0) ((cons (0) ((cons (0) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((@nil Z))))))))))))))))))))))))))))))))) )
|--
  (sll32 4096 (cons (INT_MAX) ((cons (INT_MAX) ((cons (INT_MAX) ((cons (100) ((cons (100) ((cons (100) ((cons (1) ((cons (1) ((cons (1) ((cons (0) ((cons (0) ((cons (0) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((@nil Z))))))))))))))))))))))))))))))))) )
.

Definition append_precondition_wit_1 :=
~ ((  “ (0 = 0) ” 
  &&  “ (4096 = 4096) ” 
  &&  “ ((@nil Z) = (@nil Z)) ” 
  &&  “ ((cons (INT_MAX) ((cons (INT_MAX) ((cons (INT_MAX) ((cons (100) ((cons (100) ((cons (100) ((cons (1) ((cons (1) ((cons (1) ((cons (0) ((cons (0) ((cons (0) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((@nil Z))))))))))))))))))))))))))))))))) = (cons (INT_MAX) ((cons (INT_MAX) ((cons (INT_MAX) ((cons (100) ((cons (100) ((cons (100) ((cons (1) ((cons (1) ((cons (1) ((cons (0) ((cons (0) ((cons (0) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((@nil Z)))))))))))))))))))))))))))))))))) ”
  &&  (sll32 0 (@nil Z) )
  **  (sll32 4096 (cons (INT_MAX) ((cons (INT_MAX) ((cons (INT_MAX) ((cons (100) ((cons (100) ((cons (100) ((cons (1) ((cons (1) ((cons (1) ((cons (0) ((cons (0) ((cons (0) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((cons ((-INT_MAX)) ((@nil Z))))))))))))))))))))))))))))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_append_safety_wit_1 : append_safety_wit_1.
Axiom proof_of_append_return_wit_1 : append_return_wit_1.
Axiom proof_of_append_precondition_wit_1 : append_precondition_wit_1.

End VC_Correct.
