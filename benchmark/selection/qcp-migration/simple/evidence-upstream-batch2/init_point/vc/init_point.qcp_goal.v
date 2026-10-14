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

(*----- Function zero -----*)

Definition zero_safety_wit_1 := 
forall (p_pre: Z) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |->_)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition zero_return_wit_1 := 
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 0)
|--
  ((p_pre) # Int  |-> 0)
.

(*----- Function init_point -----*)

Definition init_point_return_wit_1 := 
forall (p_pre: Z) ,
  ((&((p_pre)  # "point" ->ₛ "y")) # Int  |-> 0)
  **  ((&((p_pre)  # "point" ->ₛ "x")) # Int  |-> 0)
|--
  ((&((p_pre)  # "point" ->ₛ "x")) # Int  |-> 0)
  **  ((&((p_pre)  # "point" ->ₛ "y")) # Int  |-> 0)
.

Definition init_point_partial_solve_wit_1 := 
forall (p_pre: Z) ,
  ((&((p_pre)  # "point" ->ₛ "x")) # Int  |->_)
  **  ((&((p_pre)  # "point" ->ₛ "y")) # Int  |->_)
|--
  ((&((p_pre)  # "point" ->ₛ "x")) # Int  |->_)
  **  ((&((p_pre)  # "point" ->ₛ "y")) # Int  |->_)
.

Definition init_point_partial_solve_wit_2 := 
forall (p_pre: Z) ,
  ((&((p_pre)  # "point" ->ₛ "x")) # Int  |-> 0)
  **  ((&((p_pre)  # "point" ->ₛ "y")) # Int  |->_)
|--
  ((&((p_pre)  # "point" ->ₛ "y")) # Int  |->_)
  **  ((&((p_pre)  # "point" ->ₛ "x")) # Int  |-> 0)
.

Module Type VC_Correct.

Axiom proof_of_zero_safety_wit_1 : zero_safety_wit_1.
Axiom proof_of_zero_return_wit_1 : zero_return_wit_1.
Axiom proof_of_init_point_return_wit_1 : init_point_return_wit_1.
Axiom proof_of_init_point_partial_solve_wit_1 : init_point_partial_solve_wit_1.
Axiom proof_of_init_point_partial_solve_wit_2 : init_point_partial_solve_wit_2.

End VC_Correct.
