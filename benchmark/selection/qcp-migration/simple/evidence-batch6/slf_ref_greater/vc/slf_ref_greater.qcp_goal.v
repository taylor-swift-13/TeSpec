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

(*----- Function refUnsignedInt -----*)

Definition refUnsignedInt_return_wit_1 := 
forall (v_pre: Z) (v0: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= v0)) (PreH3 : (v0 <= UINT_MAX)) (PreH4 : (v_pre = v0)) ,
  ((retval) # UInt  |-> v_pre)
|--
  ((retval) # UInt  |-> v0)
.

Definition refUnsignedInt_partial_solve_wit_1 := 
forall (v_pre: Z) (v0: Z) (PreH1 : (0 <= v0)) (PreH2 : (v0 <= UINT_MAX)) (PreH3 : (v_pre = v0)) ,
  TT && emp 
|--
  “ (0 <= v0) ” 
  &&  “ (v0 <= UINT_MAX) ” 
  &&  “ (v_pre = v0) ”
  &&  emp
.

(*----- Function ref_greater_abstract -----*)

Definition ref_greater_abstract_safety_wit_1 := 
forall (p_pre: Z) (v: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= v)) (PreH3 : (v < UINT_MAX)) ,
  ((retval) # UInt  |->_)
  **  ((( &( "q" ) )) # Ptr  |-> retval)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> v)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition ref_greater_abstract_return_wit_1 := 
forall (p_pre: Z) (v: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= v)) (PreH3 : (v < UINT_MAX)) ,
  ((retval) # UInt  |-> (v + 1 ))
  **  ((p_pre) # UInt  |-> v)
|--
  EX (w: Z) ,
  “ (v <= w) ”
  &&  ((p_pre) # UInt  |-> v)
  **  ((retval) # UInt  |-> w)
.

Definition ref_greater_abstract_partial_solve_wit_1 := 
forall (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v < UINT_MAX)) ,
  ((p_pre) # UInt  |-> v)
|--
  “ (0 <= v) ” 
  &&  “ (v < UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v)
.

Module Type VC_Correct.

Axiom proof_of_refUnsignedInt_return_wit_1 : refUnsignedInt_return_wit_1.
Axiom proof_of_refUnsignedInt_partial_solve_wit_1 : refUnsignedInt_partial_solve_wit_1.
Axiom proof_of_ref_greater_abstract_safety_wit_1 : ref_greater_abstract_safety_wit_1.
Axiom proof_of_ref_greater_abstract_return_wit_1 : ref_greater_abstract_return_wit_1.
Axiom proof_of_ref_greater_abstract_partial_solve_wit_1 : ref_greater_abstract_partial_solve_wit_1.

End VC_Correct.
