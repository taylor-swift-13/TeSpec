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
  “ (sizeof(INT) = 4) ”
.

Definition freeUnsignedInt_partial_solve_wit_1_aux := 
forall (p_pre: Z) ,
  ((p_pre) # UInt  |->_)
|--
  “ (sizeof(INT) = 4) ”
  &&  ((p_pre) # UInt  |->_)
.

Definition freeUnsignedInt_partial_solve_wit_1 := freeUnsignedInt_partial_solve_wit_1_pure -> freeUnsignedInt_partial_solve_wit_1_aux.

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

(*----- Function incr -----*)

Definition incr_safety_wit_1 := 
forall (p_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> n0)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> n0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr_return_wit_1 := 
(
forall (p_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n0 + 1 )) (32)))
|--
  ((p_pre) # UInt  |-> ((n0 + 1 ) % ( 4294967296 ) ))
) \/
(
forall (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((n0 + 1 )) (32)) = ((n0 + 1 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr_return_wit_1_split_goal_1 := 
forall (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) ,
  ((unsigned_last_nbits ((n0 + 1 )) (32)) = ((n0 + 1 ) % ( 4294967296 ) ))
.

(*----- Function succ_using_incr -----*)

Definition succ_using_incr_return_wit_1 := 
forall (n_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n_pre = n0)) ,
  TT && emp 
|--
  “ (((n_pre + 1 ) % ( 4294967296 ) ) = ((n0 + 1 ) % ( 4294967296 ) )) ”
  &&  emp
.

Definition succ_using_incr_partial_solve_wit_1_pure := 
forall (n_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n_pre = n0)) ,
  ((( &( "p" ) )) # Ptr  |->_)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (n_pre = n_pre) ”
.

Definition succ_using_incr_partial_solve_wit_1_aux := 
forall (n_pre: Z) (n0: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n_pre = n0)) ,
  TT && emp 
|--
  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (n_pre = n_pre) ” 
  &&  “ (0 <= n0) ” 
  &&  “ (n0 <= UINT_MAX) ” 
  &&  “ (n_pre = n0) ”
  &&  emp
.

Definition succ_using_incr_partial_solve_wit_1 := succ_using_incr_partial_solve_wit_1_pure -> succ_using_incr_partial_solve_wit_1_aux.

Definition succ_using_incr_partial_solve_wit_2_pure := 
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n_pre = n0)) ,
  ((retval) # UInt  |-> n_pre)
  **  ((( &( "p" ) )) # Ptr  |-> retval)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
.

Definition succ_using_incr_partial_solve_wit_2_aux := 
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n_pre = n0)) ,
  ((retval) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ” 
  &&  “ (0 <= n0) ” 
  &&  “ (n0 <= UINT_MAX) ” 
  &&  “ (n_pre = n0) ”
  &&  ((retval) # UInt  |-> n_pre)
.

Definition succ_using_incr_partial_solve_wit_2 := succ_using_incr_partial_solve_wit_2_pure -> succ_using_incr_partial_solve_wit_2_aux.

Definition succ_using_incr_partial_solve_wit_3 := 
forall (n_pre: Z) (n0: Z) (retval: Z) (PreH1 : (0 <= n0)) (PreH2 : (n0 <= UINT_MAX)) (PreH3 : (n_pre = n0)) ,
  ((retval) # UInt  |-> ((n_pre + 1 ) % ( 4294967296 ) ))
|--
  “ (0 <= n0) ” 
  &&  “ (n0 <= UINT_MAX) ” 
  &&  “ (n_pre = n0) ”
  &&  ((retval) # UInt  |->_)
.

Module Type VC_Correct.

Axiom proof_of_freeUnsignedInt_return_wit_1 : freeUnsignedInt_return_wit_1.
Axiom proof_of_freeUnsignedInt_partial_solve_wit_1_pure : freeUnsignedInt_partial_solve_wit_1_pure.
Axiom proof_of_freeUnsignedInt_partial_solve_wit_1 : freeUnsignedInt_partial_solve_wit_1.
Axiom proof_of_refUnsignedInt_return_wit_1 : refUnsignedInt_return_wit_1.
Axiom proof_of_refUnsignedInt_partial_solve_wit_1 : refUnsignedInt_partial_solve_wit_1.
Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.
Axiom proof_of_succ_using_incr_return_wit_1 : succ_using_incr_return_wit_1.
Axiom proof_of_succ_using_incr_partial_solve_wit_1_pure : succ_using_incr_partial_solve_wit_1_pure.
Axiom proof_of_succ_using_incr_partial_solve_wit_1 : succ_using_incr_partial_solve_wit_1.
Axiom proof_of_succ_using_incr_partial_solve_wit_2_pure : succ_using_incr_partial_solve_wit_2_pure.
Axiom proof_of_succ_using_incr_partial_solve_wit_2 : succ_using_incr_partial_solve_wit_2.
Axiom proof_of_succ_using_incr_partial_solve_wit_3 : succ_using_incr_partial_solve_wit_3.

End VC_Correct.
