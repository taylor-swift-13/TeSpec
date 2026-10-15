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

(*----- Function read_and_free -----*)

Definition read_and_free_return_wit_1 := 
forall (v: Z) ,
  TT && emp 
|--
  “ (v = v) ”
  &&  emp
.

Definition read_and_free_partial_solve_wit_1_pure := 
forall (p_pre: Z) (v: Z) ,
  ((( &( "result" ) )) # UInt  |-> v)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> v)
|--
  “ (sizeof(UINT) = 4) ”
.

Definition read_and_free_partial_solve_wit_1_aux := 
forall (p_pre: Z) (v: Z) ,
  ((p_pre) # UInt  |-> v)
|--
  “ (sizeof(UINT) = 4) ”
  &&  ((p_pre) # UInt  |->_)
.

Definition read_and_free_partial_solve_wit_1 := read_and_free_partial_solve_wit_1_pure -> read_and_free_partial_solve_wit_1_aux.

(*----- Function main -----*)

Definition main_safety_wit_1 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((retval) # UInt  |->_)
  **  ((( &( "x" ) )) # Ptr  |-> retval)
|--
  “ (5 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 5) ”
.

Definition main_safety_wit_2 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 5)) (PreH2 : (retval <> 0)) ,
  ((( &( "res" ) )) # UInt  |-> retval_2)
  **  ((( &( "x" ) )) # Ptr  |-> retval)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition main_return_wit_1 := 
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 5)) (PreH2 : (retval <> 0)) ,
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1_pure := 
  ((( &( "x" ) )) # Ptr  |->_)
|--
  “ (sizeof(UINT) = 4) ”
.

Definition main_partial_solve_wit_1_aux := 
  TT && emp 
|--
  “ (sizeof(UINT) = 4) ”
  &&  emp
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_partial_solve_wit_2 := 
forall (retval: Z) (PreH1 : (retval <> 0)) ,
  ((retval) # UInt  |-> 5)
|--
  “ (retval <> 0) ”
  &&  ((retval) # UInt  |-> 5)
.

Module Type VC_Correct.

Axiom proof_of_read_and_free_return_wit_1 : read_and_free_return_wit_1.
Axiom proof_of_read_and_free_partial_solve_wit_1_pure : read_and_free_partial_solve_wit_1_pure.
Axiom proof_of_read_and_free_partial_solve_wit_1 : read_and_free_partial_solve_wit_1.
Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_safety_wit_2 : main_safety_wit_2.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.

End VC_Correct.
