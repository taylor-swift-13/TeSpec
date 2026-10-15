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
Require Import DLLSupplement.
Local Open Scope sac.

(*----- Function singleton -----*)

Definition singleton_safety_wit_1 := 
forall (element_pre: Z) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |->_)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "n" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition singleton_safety_wit_2 := 
forall (element_pre: Z) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |->_)
  **  ((( &( "n" ) )) # Ptr  |-> retval)
  **  ((( &( "element" ) )) # Int  |-> element_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition singleton_return_wit_1 := 
forall (element_pre: Z) (e: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = e)) ,
  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> 0)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> 0)
|--
  (Dll retval (@nil Z) e (@nil Z) )
.

Definition singleton_partial_solve_wit_1 := 
forall (element_pre: Z) (e: Z) (PreH1 : (element_pre = e)) ,
  TT && emp 
|--
  “ (element_pre = e) ”
  &&  emp
.

Module Type VC_Correct.

Axiom proof_of_singleton_safety_wit_1 : singleton_safety_wit_1.
Axiom proof_of_singleton_safety_wit_2 : singleton_safety_wit_2.
Axiom proof_of_singleton_return_wit_1 : singleton_return_wit_1.
Axiom proof_of_singleton_partial_solve_wit_1 : singleton_partial_solve_wit_1.

End VC_Correct.
