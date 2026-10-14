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
  **  (sll32 4096 (cons ((-1637406115)) ((cons (391302586) ((cons (514881784) ((@nil Z))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition reverse_safety_wit_2 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 514881784)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 391302586)
  **  ((4096) # Int  |-> (-1637406115))
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 514881784)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> 391302586)
  **  ((4096) # Int  |-> (-1637406115))
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_2)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_return_wit_1 := 
forall (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 514881784)
  **  (((y_2 + 4 )) # Ptr  |-> 4096)
  **  ((y_2) # Int  |-> 391302586)
  **  ((4096) # Int  |-> (-1637406115))
|--
  (sll32 y (cons (514881784) ((cons (391302586) ((cons ((-1637406115)) ((@nil Z))))))) )
.

Definition reverse_partial_solve_wit_1 := 
  (sll32 4096 (cons ((-1637406115)) ((cons (391302586) ((cons (514881784) ((@nil Z))))))) )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z) ,
  “ (y_3 = 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 514881784)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 391302586)
  **  ((4096) # Int  |-> (-1637406115))
.

Definition reverse_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ ((cons ((-1637406115)) ((cons (391302586) ((cons (514881784) ((@nil Z))))))) = (cons ((-1637406115)) ((cons (391302586) ((cons (514881784) ((@nil Z)))))))) ”
  &&  (sll32 4096 (cons ((-1637406115)) ((cons (391302586) ((cons (514881784) ((@nil Z))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_reverse_safety_wit_1 : reverse_safety_wit_1.
Axiom proof_of_reverse_safety_wit_2 : reverse_safety_wit_2.
Axiom proof_of_reverse_safety_wit_3 : reverse_safety_wit_3.
Axiom proof_of_reverse_return_wit_1 : reverse_return_wit_1.
Axiom proof_of_reverse_partial_solve_wit_1 : reverse_partial_solve_wit_1.
Axiom proof_of_reverse_precondition_wit_1 : reverse_precondition_wit_1.

End VC_Correct.
