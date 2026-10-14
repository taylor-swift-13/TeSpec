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

(*----- Function reverse -----*)

Definition reverse_safety_wit_1 := 
  ((( &( "w_spec_421" ) )) # Ptr  |->_)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons (1505224731) ((@nil Z))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition reverse_return_wit_1 := 
forall (y: Z) (PreH1 : (y = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  ((4096) # Int  |-> 1505224731)
|--
  (sll32 4096 (cons (1505224731) ((@nil Z))) )
.

Definition reverse_partial_solve_wit_1 := 
  (sll32 4096 (cons (1505224731) ((@nil Z))) )
|--
  EX (y: Z) ,
  “ (y = 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  ((4096) # Int  |-> 1505224731)
.

Definition reverse_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ ((cons (1505224731) ((@nil Z))) = (cons (1505224731) ((@nil Z)))) ”
  &&  (sll32 4096 (cons (1505224731) ((@nil Z))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_reverse_safety_wit_1 : reverse_safety_wit_1.
Axiom proof_of_reverse_return_wit_1 : reverse_return_wit_1.
Axiom proof_of_reverse_partial_solve_wit_1 : reverse_partial_solve_wit_1.
Axiom proof_of_reverse_precondition_wit_1 : reverse_precondition_wit_1.

End VC_Correct.
