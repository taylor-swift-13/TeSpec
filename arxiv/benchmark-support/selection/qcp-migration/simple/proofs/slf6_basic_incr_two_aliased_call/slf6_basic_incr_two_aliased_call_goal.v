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

(*----- Function incr -----*)

Definition incr_safety_wit_1 := 
forall (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> v)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> v)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr_return_wit_1 := 
(
forall (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
|--
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
) \/
(
forall (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((v + 1 )) (32)) = ((v + 1 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr_return_wit_1_split_goal_1 := 
forall (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  ((unsigned_last_nbits ((v + 1 )) (32)) = ((v + 1 ) % ( 4294967296 ) ))
.

(*----- Function incr_two -----*)

Definition incr_two_return_wit_1 := 
(
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((q_pre) # UInt  |-> ((((v + 1 ) % ( 4294967296 ) ) + 1 ) % ( 4294967296 ) ))
|--
  “ (p_pre = q_pre) ”
  &&  ((p_pre) # UInt  |-> ((v + 2 ) % ( 4294967296 ) ))
) \/
(
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  TT && emp 
|--
  “ (((((v + 1 ) % ( 4294967296 ) ) + 1 ) % ( 4294967296 ) ) = ((v + 2 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr_two_return_wit_1_split_goal_1 := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  (((((v + 1 ) % ( 4294967296 ) ) + 1 ) % ( 4294967296 ) ) = ((v + 2 ) % ( 4294967296 ) ))
.

Definition incr_two_partial_solve_wit_1_pure := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ”
.

Definition incr_two_partial_solve_wit_1_aux := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((p_pre) # UInt  |-> v)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (p_pre = q_pre) ”
  &&  ((p_pre) # UInt  |-> v)
.

Definition incr_two_partial_solve_wit_1 := incr_two_partial_solve_wit_1_pure -> incr_two_partial_solve_wit_1_aux.

Definition incr_two_partial_solve_wit_2_pure := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
|--
  “ (((v + 1 ) % ( 4294967296 ) ) <= UINT_MAX) ” 
  &&  “ (0 <= ((v + 1 ) % ( 4294967296 ) )) ”
.

Definition incr_two_partial_solve_wit_2_aux := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
|--
  “ (((v + 1 ) % ( 4294967296 ) ) <= UINT_MAX) ” 
  &&  “ (0 <= ((v + 1 ) % ( 4294967296 ) )) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (p_pre = q_pre) ”
  &&  ((q_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
.

Definition incr_two_partial_solve_wit_2 := incr_two_partial_solve_wit_2_pure -> incr_two_partial_solve_wit_2_aux.

(*----- Function aliased_call -----*)

Definition aliased_call_return_wit_1 := 
forall (p_pre: Z) (v: Z) (PreH1 : (p_pre = p_pre)) (PreH2 : (0 <= v)) (PreH3 : (v <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((v + 2 ) % ( 4294967296 ) ))
|--
  ((p_pre) # UInt  |-> ((v + 2 ) % ( 4294967296 ) ))
.

Definition aliased_call_partial_solve_wit_1_pure := 
forall (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> v)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (p_pre = p_pre) ”
.

Definition aliased_call_partial_solve_wit_1_aux := 
forall (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (p_pre = p_pre) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v)
.

Definition aliased_call_partial_solve_wit_1 := aliased_call_partial_solve_wit_1_pure -> aliased_call_partial_solve_wit_1_aux.

Module Type VC_Correct.

Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.
Axiom proof_of_incr_two_return_wit_1 : incr_two_return_wit_1.
Axiom proof_of_incr_two_partial_solve_wit_1_pure : incr_two_partial_solve_wit_1_pure.
Axiom proof_of_incr_two_partial_solve_wit_1 : incr_two_partial_solve_wit_1.
Axiom proof_of_incr_two_partial_solve_wit_2_pure : incr_two_partial_solve_wit_2_pure.
Axiom proof_of_incr_two_partial_solve_wit_2 : incr_two_partial_solve_wit_2.
Axiom proof_of_aliased_call_return_wit_1 : aliased_call_return_wit_1.
Axiom proof_of_aliased_call_partial_solve_wit_1_pure : aliased_call_partial_solve_wit_1_pure.
Axiom proof_of_aliased_call_partial_solve_wit_1 : aliased_call_partial_solve_wit_1.

End VC_Correct.
