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

(*----- Function incr2b -----*)

Definition incr2b_safety_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> v)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2b_safety_wit_2 := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((q_pre) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
  **  ((( &( "m" ) )) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
  **  ((( &( "n" ) )) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2b_return_wit_1 := 
(
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((q_pre) # UInt  |-> (unsigned_last_nbits (((unsigned_last_nbits ((v + 1 )) (32)) + 1 )) (32)))
|--
  “ (p_pre = q_pre) ”
  &&  ((p_pre) # UInt  |-> ((v + 2 ) % ( 4294967296 ) ))
) \/
(
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits (((unsigned_last_nbits ((v + 1 )) (32)) + 1 )) (32)) = ((v + 2 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr2b_return_wit_1_split_goal_1 := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((unsigned_last_nbits (((unsigned_last_nbits ((v + 1 )) (32)) + 1 )) (32)) = ((v + 2 ) % ( 4294967296 ) ))
.

Definition incr2b_partial_solve_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (p_pre = q_pre) ”
  &&  ((q_pre) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
.

(*----- Function incr2a -----*)

Definition incr2a_safety_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> v)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2a_safety_wit_2 := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
  **  ((( &( "n" ) )) # UInt  |-> w)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
  **  ((q_pre) # UInt  |-> w)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2a_return_wit_1 := 
(
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w + 1 )) (32)))
|--
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
) \/
(
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((v + 1 )) (32)) = ((v + 1 ) % ( 4294967296 ) )) ” 
  &&  “ ((unsigned_last_nbits ((w + 1 )) (32)) = ((w + 1 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr2a_return_wit_1_split_goal_1 := 
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((unsigned_last_nbits ((v + 1 )) (32)) = ((v + 1 ) % ( 4294967296 ) ))
.

Definition incr2a_return_wit_1_split_goal_2 := 
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((unsigned_last_nbits ((w + 1 )) (32)) = ((w + 1 ) % ( 4294967296 ) ))
.

(*----- Function call_both -----*)

Definition call_both_return_wit_1 := 
(
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (p_pre = p_pre)) (PreH2 : (0 <= v)) (PreH3 : (v <= UINT_MAX)) (PreH4 : (0 <= w)) (PreH5 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((((v + 1 ) % ( 4294967296 ) ) + 2 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
|--
  ((p_pre) # UInt  |-> ((v + 3 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
) \/
(
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  TT && emp 
|--
  “ (((((v + 1 ) % ( 4294967296 ) ) + 2 ) % ( 4294967296 ) ) = ((v + 3 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition call_both_return_wit_1_split_goal_1 := 
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  (((((v + 1 ) % ( 4294967296 ) ) + 2 ) % ( 4294967296 ) ) = ((v + 3 ) % ( 4294967296 ) ))
.

Definition call_both_partial_solve_wit_1_pure := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ”
.

Definition call_both_partial_solve_wit_1_aux := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
.

Definition call_both_partial_solve_wit_1 := call_both_partial_solve_wit_1_pure -> call_both_partial_solve_wit_1_aux.

Definition call_both_partial_solve_wit_2_pure := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
|--
  “ (p_pre = p_pre) ” 
  &&  “ (((v + 1 ) % ( 4294967296 ) ) <= UINT_MAX) ” 
  &&  “ (0 <= ((v + 1 ) % ( 4294967296 ) )) ”
.

Definition call_both_partial_solve_wit_2_aux := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
|--
  “ (p_pre = p_pre) ” 
  &&  “ (((v + 1 ) % ( 4294967296 ) ) <= UINT_MAX) ” 
  &&  “ (0 <= ((v + 1 ) % ( 4294967296 ) )) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
.

Definition call_both_partial_solve_wit_2 := call_both_partial_solve_wit_2_pure -> call_both_partial_solve_wit_2_aux.

Module Type VC_Correct.

Axiom proof_of_incr2b_safety_wit_1 : incr2b_safety_wit_1.
Axiom proof_of_incr2b_safety_wit_2 : incr2b_safety_wit_2.
Axiom proof_of_incr2b_return_wit_1 : incr2b_return_wit_1.
Axiom proof_of_incr2b_partial_solve_wit_1 : incr2b_partial_solve_wit_1.
Axiom proof_of_incr2a_safety_wit_1 : incr2a_safety_wit_1.
Axiom proof_of_incr2a_safety_wit_2 : incr2a_safety_wit_2.
Axiom proof_of_incr2a_return_wit_1 : incr2a_return_wit_1.
Axiom proof_of_call_both_return_wit_1 : call_both_return_wit_1.
Axiom proof_of_call_both_partial_solve_wit_1_pure : call_both_partial_solve_wit_1_pure.
Axiom proof_of_call_both_partial_solve_wit_1 : call_both_partial_solve_wit_1.
Axiom proof_of_call_both_partial_solve_wit_2_pure : call_both_partial_solve_wit_2_pure.
Axiom proof_of_call_both_partial_solve_wit_2 : call_both_partial_solve_wit_2.

End VC_Correct.
