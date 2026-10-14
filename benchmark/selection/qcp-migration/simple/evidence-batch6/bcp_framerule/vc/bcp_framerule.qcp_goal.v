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

(*----- Function incr_first -----*)

Definition incr_first_safety_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> v)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr_first_return_wit_1 := 
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

Definition incr_first_return_wit_1_split_goal_1 := 
forall (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) ,
  ((unsigned_last_nbits ((v + 1 )) (32)) = ((v + 1 ) % ( 4294967296 ) ))
.

(*----- Function incr_first_frame -----*)

Definition incr_first_frame_return_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> w)
|--
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> w)
.

Definition incr_first_frame_partial_solve_wit_1_pure := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ”
.

Definition incr_first_frame_partial_solve_wit_1_aux := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
.

Definition incr_first_frame_partial_solve_wit_1 := incr_first_frame_partial_solve_wit_1_pure -> incr_first_frame_partial_solve_wit_1_aux.

Module Type VC_Correct.

Axiom proof_of_incr_first_safety_wit_1 : incr_first_safety_wit_1.
Axiom proof_of_incr_first_return_wit_1 : incr_first_return_wit_1.
Axiom proof_of_incr_first_frame_return_wit_1 : incr_first_frame_return_wit_1.
Axiom proof_of_incr_first_frame_partial_solve_wit_1_pure : incr_first_frame_partial_solve_wit_1_pure.
Axiom proof_of_incr_first_frame_partial_solve_wit_1 : incr_first_frame_partial_solve_wit_1.

End VC_Correct.
