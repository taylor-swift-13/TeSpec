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

(*----- Function mkref -----*)

Definition mkref_return_wit_1 := 
forall (x_pre: Z) (v: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= v)) (PreH3 : (v <= UINT_MAX)) (PreH4 : (x_pre = v)) ,
  ((retval) # UInt  |-> x_pre)
|--
  ((retval) # UInt  |-> v)
.

Definition mkref_partial_solve_wit_1_pure := 
forall (x_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (x_pre = v)) ,
  ((( &( "p" ) )) # Ptr  |->_)
  **  ((( &( "x" ) )) # UInt  |-> x_pre)
|--
  “ (sizeof(UINT) = 4) ”
.

Definition mkref_partial_solve_wit_1_aux := 
forall (x_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (x_pre = v)) ,
  TT && emp 
|--
  “ (sizeof(UINT) = 4) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (x_pre = v) ”
  &&  emp
.

Definition mkref_partial_solve_wit_1 := mkref_partial_solve_wit_1_pure -> mkref_partial_solve_wit_1_aux.

(*----- Function main -----*)

Definition main_safety_wit_1 := 
  ((( &( "p" ) )) # Ptr  |->_)
|--
  “ (5 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 5) ”
.

Definition main_safety_wit_2 := 
forall (p: Z) ,
  ((( &( "p" ) )) # Ptr  |-> p)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_entail_wit_1 := 
forall (retval: Z) ,
  ((retval) # UInt  |-> 5)
|--
  ((retval) # UInt  |-> 5)
.

Definition main_return_wit_1 := 
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
  ((( &( "p" ) )) # Ptr  |->_)
|--
  “ (0 <= 5) ” 
  &&  “ (5 <= UINT_MAX) ” 
  &&  “ (5 = 5) ”
.

Definition main_partial_solve_wit_1_aux := 
  TT && emp 
|--
  “ (0 <= 5) ” 
  &&  “ (5 <= UINT_MAX) ” 
  &&  “ (5 = 5) ”
  &&  emp
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2_pure := 
forall (p: Z) ,
  ((( &( "p" ) )) # Ptr  |-> p)
  **  ((p) # UInt  |-> 5)
|--
  “ (sizeof(UINT) = 4) ”
.

Definition main_partial_solve_wit_2_aux := 
forall (p: Z) ,
  ((p) # UInt  |-> 5)
|--
  “ (sizeof(UINT) = 4) ”
  &&  ((p) # UInt  |->_)
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Module Type VC_Correct.

Axiom proof_of_mkref_return_wit_1 : mkref_return_wit_1.
Axiom proof_of_mkref_partial_solve_wit_1_pure : mkref_partial_solve_wit_1_pure.
Axiom proof_of_mkref_partial_solve_wit_1 : mkref_partial_solve_wit_1.
Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_safety_wit_2 : main_safety_wit_2.
Axiom proof_of_main_entail_wit_1 : main_entail_wit_1.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.

End VC_Correct.
