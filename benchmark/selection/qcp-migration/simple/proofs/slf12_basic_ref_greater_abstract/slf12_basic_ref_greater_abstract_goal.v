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

(*----- Function ref_greater -----*)

Definition ref_greater_safety_wit_1 := 
forall (p_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n0 < UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> n0)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> n0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition ref_greater_return_wit_1 := 
forall (p_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n0 < UINT_MAX)) ,
  ((retval) # UInt  |-> (n0 + 1 ))
  **  ((p_pre) # UInt  |-> n0)
|--
  EX (m: Z) ,
  “ (m > n0) ”
  &&  ((p_pre) # UInt  |-> n0)
  **  ((retval) # UInt  |-> m)
.

Definition ref_greater_partial_solve_wit_1_pure := 
forall (p_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n0 < UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |-> (n0 + 1 ))
  **  ((( &( "n" ) )) # UInt  |-> n0)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> n0)
|--
  “ (0 <= (n0 + 1 )) ” 
  &&  “ ((n0 + 1 ) <= UINT_MAX) ” 
  &&  “ ((n0 + 1 ) = (n0 + 1 )) ”
.

Definition ref_greater_partial_solve_wit_1_aux := 
forall (p_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n0 < UINT_MAX)) ,
  ((p_pre) # UInt  |-> n0)
|--
  “ (0 <= (n0 + 1 )) ” 
  &&  “ ((n0 + 1 ) <= UINT_MAX) ” 
  &&  “ ((n0 + 1 ) = (n0 + 1 )) ” 
  &&  “ (0 <= n0) ” 
  &&  “ (n0 <= UINT_MAX) ” 
  &&  “ (n0 < UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> n0)
.

Definition ref_greater_partial_solve_wit_1 := ref_greater_partial_solve_wit_1_pure -> ref_greater_partial_solve_wit_1_aux.

Module Type VC_Correct.

Axiom proof_of_refUnsignedInt_return_wit_1 : refUnsignedInt_return_wit_1.
Axiom proof_of_refUnsignedInt_partial_solve_wit_1 : refUnsignedInt_partial_solve_wit_1.
Axiom proof_of_ref_greater_safety_wit_1 : ref_greater_safety_wit_1.
Axiom proof_of_ref_greater_return_wit_1 : ref_greater_return_wit_1.
Axiom proof_of_ref_greater_partial_solve_wit_1_pure : ref_greater_partial_solve_wit_1_pure.
Axiom proof_of_ref_greater_partial_solve_wit_1 : ref_greater_partial_solve_wit_1.

End VC_Correct.
