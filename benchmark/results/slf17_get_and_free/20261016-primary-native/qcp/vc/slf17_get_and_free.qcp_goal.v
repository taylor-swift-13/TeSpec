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

(*----- Function freeUnsignedInt -----*)

Definition freeUnsignedInt_return_wit_1 := 
  TT && emp 
|--
  TT && emp 
.

Definition freeUnsignedInt_partial_solve_wit_1_pure := 
forall (p_pre: Z) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |->_)
|--
  “ (sizeof(UINT) = 4) ”
.

Definition freeUnsignedInt_partial_solve_wit_1_aux := 
forall (p_pre: Z) ,
  ((p_pre) # UInt  |->_)
|--
  “ (sizeof(UINT) = 4) ”
  &&  ((p_pre) # UInt  |->_)
.

Definition freeUnsignedInt_partial_solve_wit_1 := freeUnsignedInt_partial_solve_wit_1_pure -> freeUnsignedInt_partial_solve_wit_1_aux.

(*----- Function get_and_free -----*)

Definition get_and_free_return_wit_1 := 
forall (v0: Z) ,
  TT && emp 
|--
  “ (v0 = v0) ”
  &&  emp
.

Definition get_and_free_partial_solve_wit_1 := 
forall (p_pre: Z) (v0: Z) ,
  ((p_pre) # UInt  |-> v0)
|--
  ((p_pre) # UInt  |->_)
.

Module Type VC_Correct.

Axiom proof_of_freeUnsignedInt_return_wit_1 : freeUnsignedInt_return_wit_1.
Axiom proof_of_freeUnsignedInt_partial_solve_wit_1_pure : freeUnsignedInt_partial_solve_wit_1_pure.
Axiom proof_of_freeUnsignedInt_partial_solve_wit_1 : freeUnsignedInt_partial_solve_wit_1.
Axiom proof_of_get_and_free_return_wit_1 : get_and_free_return_wit_1.
Axiom proof_of_get_and_free_partial_solve_wit_1 : get_and_free_partial_solve_wit_1.

End VC_Correct.
