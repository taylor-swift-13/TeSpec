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
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> 0)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_2)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_2 := 
  ((( &( "u_spec_429" ) )) # Ptr  |->_)
  **  ((( &( "t_spec_426" ) )) # Ptr  |->_)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
  **  (sll32 4096 (cons (1) ((cons (100) ((cons (2147483646) ((@nil Z))))))) )
  **  (sll32 0 (@nil Z) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> 4096)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> 4096)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_5 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_2)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_safety_wit_6 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> y_2)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition append_safety_wit_7 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
  **  ((( &( "u_spec_429" ) )) # Ptr  |-> 0)
  **  ((( &( "t_spec_426" ) )) # Ptr  |-> y_2)
  **  ((( &( "x_spec_413" ) )) # Ptr  |-> 4096)
  **  ((( &( "y_spec_410" ) )) # Ptr  |-> 0)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition append_return_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) ,
  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
|--
  (sll32 4096 (cons (1) ((cons (100) ((cons (2147483646) ((@nil Z))))))) )
.

Definition append_partial_solve_wit_1 := 
  (sll32 4096 (cons (1) ((cons (100) ((cons (2147483646) ((@nil Z))))))) )
  **  (sll32 0 (@nil Z) )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z) ,
  “ (y_3 = 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 2147483646)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 100)
  **  ((4096) # Int  |-> 1)
.

Definition append_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ (0 = 0) ” 
  &&  “ ((cons (1) ((cons (100) ((cons (2147483646) ((@nil Z))))))) = (cons (1) ((cons (100) ((cons (2147483646) ((@nil Z)))))))) ” 
  &&  “ ((@nil Z) = (@nil Z)) ”
  &&  (sll32 4096 (cons (1) ((cons (100) ((cons (2147483646) ((@nil Z))))))) )
  **  (sll32 0 (@nil Z) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_append_safety_wit_1 : append_safety_wit_1.
Axiom proof_of_append_safety_wit_2 : append_safety_wit_2.
Axiom proof_of_append_safety_wit_3 : append_safety_wit_3.
Axiom proof_of_append_safety_wit_4 : append_safety_wit_4.
Axiom proof_of_append_safety_wit_5 : append_safety_wit_5.
Axiom proof_of_append_safety_wit_6 : append_safety_wit_6.
Axiom proof_of_append_safety_wit_7 : append_safety_wit_7.
Axiom proof_of_append_return_wit_1 : append_return_wit_1.
Axiom proof_of_append_partial_solve_wit_1 : append_partial_solve_wit_1.
Axiom proof_of_append_precondition_wit_1 : append_precondition_wit_1.

End VC_Correct.
