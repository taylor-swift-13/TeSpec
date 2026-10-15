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

(*----- Function incr2 -----*)

Definition incr2_safety_wit_1_eq := 
forall (q_pre: Z) (p_pre: Z) (v_eq: Z) (PreH1 : (0 <= v_eq)) (PreH2 : (v_eq <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> v_eq)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v_eq)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2_safety_wit_2_neq := 
forall (q_pre: Z) (p_pre: Z) (w_neq: Z) (v_neq: Z) (PreH1 : (0 <= v_neq)) (PreH2 : (v_neq <= UINT_MAX)) (PreH3 : (0 <= w_neq)) (PreH4 : (w_neq <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> v_neq)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v_neq)
  **  ((q_pre) # UInt  |-> w_neq)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2_safety_wit_3_eq := 
forall (q_pre: Z) (p_pre: Z) (v_eq: Z) (PreH1 : (0 <= v_eq)) (PreH2 : (v_eq <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((q_pre) # UInt  |-> (unsigned_last_nbits ((v_eq + 1 )) (32)))
  **  ((( &( "m" ) )) # UInt  |-> (unsigned_last_nbits ((v_eq + 1 )) (32)))
  **  ((( &( "n" ) )) # UInt  |-> (unsigned_last_nbits ((v_eq + 1 )) (32)))
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2_safety_wit_4_neq := 
forall (q_pre: Z) (p_pre: Z) (w_neq: Z) (v_neq: Z) (PreH1 : (0 <= v_neq)) (PreH2 : (v_neq <= UINT_MAX)) (PreH3 : (0 <= w_neq)) (PreH4 : (w_neq <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((( &( "m" ) )) # UInt  |-> (unsigned_last_nbits ((v_neq + 1 )) (32)))
  **  ((( &( "n" ) )) # UInt  |-> w_neq)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v_neq + 1 )) (32)))
  **  ((q_pre) # UInt  |-> w_neq)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr2_return_wit_1_eq := 
(
forall (q_pre: Z) (p_pre: Z) (v_eq: Z) (PreH1 : (0 <= v_eq)) (PreH2 : (v_eq <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((q_pre) # UInt  |-> (unsigned_last_nbits (((unsigned_last_nbits ((v_eq + 1 )) (32)) + 1 )) (32)))
|--
  “ (p_pre = q_pre) ”
  &&  ((p_pre) # UInt  |-> ((v_eq + 2 ) % ( 4294967296 ) ))
) \/
(
forall (q_pre: Z) (p_pre: Z) (v_eq: Z) (PreH1 : (0 <= v_eq)) (PreH2 : (v_eq <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits (((unsigned_last_nbits ((v_eq + 1 )) (32)) + 1 )) (32)) = ((v_eq + 2 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr2_return_wit_1_eq_split_goal_1 := 
forall (q_pre: Z) (p_pre: Z) (v_eq: Z) (PreH1 : (0 <= v_eq)) (PreH2 : (v_eq <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((unsigned_last_nbits (((unsigned_last_nbits ((v_eq + 1 )) (32)) + 1 )) (32)) = ((v_eq + 2 ) % ( 4294967296 ) ))
.

Definition incr2_return_wit_2_neq := 
(
forall (q_pre: Z) (p_pre: Z) (w_neq: Z) (v_neq: Z) (PreH1 : (0 <= v_neq)) (PreH2 : (v_neq <= UINT_MAX)) (PreH3 : (0 <= w_neq)) (PreH4 : (w_neq <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v_neq + 1 )) (32)))
  **  ((q_pre) # UInt  |-> (unsigned_last_nbits ((w_neq + 1 )) (32)))
|--
  ((p_pre) # UInt  |-> ((v_neq + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w_neq + 1 ) % ( 4294967296 ) ))
) \/
(
forall (q_pre: Z) (p_pre: Z) (w_neq: Z) (v_neq: Z) (PreH1 : (0 <= v_neq)) (PreH2 : (v_neq <= UINT_MAX)) (PreH3 : (0 <= w_neq)) (PreH4 : (w_neq <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((v_neq + 1 )) (32)) = ((v_neq + 1 ) % ( 4294967296 ) )) ” 
  &&  “ ((unsigned_last_nbits ((w_neq + 1 )) (32)) = ((w_neq + 1 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr2_return_wit_2_neq_split_goal_1 := 
forall (q_pre: Z) (p_pre: Z) (w_neq: Z) (v_neq: Z) (PreH1 : (0 <= v_neq)) (PreH2 : (v_neq <= UINT_MAX)) (PreH3 : (0 <= w_neq)) (PreH4 : (w_neq <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((unsigned_last_nbits ((v_neq + 1 )) (32)) = ((v_neq + 1 ) % ( 4294967296 ) ))
.

Definition incr2_return_wit_2_neq_split_goal_2 := 
forall (q_pre: Z) (p_pre: Z) (w_neq: Z) (v_neq: Z) (PreH1 : (0 <= v_neq)) (PreH2 : (v_neq <= UINT_MAX)) (PreH3 : (0 <= w_neq)) (PreH4 : (w_neq <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((unsigned_last_nbits ((w_neq + 1 )) (32)) = ((w_neq + 1 ) % ( 4294967296 ) ))
.

Definition incr2_partial_solve_wit_1_eq := 
forall (q_pre: Z) (p_pre: Z) (v_eq: Z) (PreH1 : (0 <= v_eq)) (PreH2 : (v_eq <= UINT_MAX)) (PreH3 : (p_pre = q_pre)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v_eq + 1 )) (32)))
|--
  “ (0 <= v_eq) ” 
  &&  “ (v_eq <= UINT_MAX) ” 
  &&  “ (p_pre = q_pre) ”
  &&  ((q_pre) # UInt  |-> (unsigned_last_nbits ((v_eq + 1 )) (32)))
.

(*----- Function call_both_better -----*)

Definition call_both_better_return_wit_1 := 
(
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (p_pre = p_pre)) (PreH2 : (0 <= v)) (PreH3 : (v <= UINT_MAX)) (PreH4 : (0 <= w)) (PreH5 : (w <= UINT_MAX)) (PreH6 : (p_pre <> q_pre)) ,
  ((p_pre) # UInt  |-> ((((v + 1 ) % ( 4294967296 ) ) + 2 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
|--
  ((p_pre) # UInt  |-> ((v + 3 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
) \/
(
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  TT && emp 
|--
  “ (((((v + 1 ) % ( 4294967296 ) ) + 2 ) % ( 4294967296 ) ) = ((v + 3 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition call_both_better_return_wit_1_split_goal_1 := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  (((((v + 1 ) % ( 4294967296 ) ) + 2 ) % ( 4294967296 ) ) = ((v + 3 ) % ( 4294967296 ) ))
.

Definition call_both_better_partial_solve_wit_1_pure := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ” 
  &&  “ (p_pre <> q_pre) ”
.

Definition call_both_better_partial_solve_wit_1_aux := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ” 
  &&  “ (p_pre <> q_pre) ” 
  &&  “ (0 <= v) ” 
  &&  “ (v <= UINT_MAX) ” 
  &&  “ (0 <= w) ” 
  &&  “ (w <= UINT_MAX) ” 
  &&  “ (p_pre <> q_pre) ”
  &&  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
.

Definition call_both_better_partial_solve_wit_1 := call_both_better_partial_solve_wit_1_pure -> call_both_better_partial_solve_wit_1_aux.

Definition call_both_better_partial_solve_wit_2_pure := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
|--
  “ (p_pre = p_pre) ” 
  &&  “ (((v + 1 ) % ( 4294967296 ) ) <= UINT_MAX) ” 
  &&  “ (0 <= ((v + 1 ) % ( 4294967296 ) )) ”
.

Definition call_both_better_partial_solve_wit_2_aux := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) (PreH5 : (p_pre <> q_pre)) ,
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
  &&  “ (p_pre <> q_pre) ”
  &&  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> ((w + 1 ) % ( 4294967296 ) ))
.

Definition call_both_better_partial_solve_wit_2 := call_both_better_partial_solve_wit_2_pure -> call_both_better_partial_solve_wit_2_aux.

Module Type VC_Correct.

Axiom proof_of_incr2_safety_wit_1_eq : incr2_safety_wit_1_eq.
Axiom proof_of_incr2_safety_wit_2_neq : incr2_safety_wit_2_neq.
Axiom proof_of_incr2_safety_wit_3_eq : incr2_safety_wit_3_eq.
Axiom proof_of_incr2_safety_wit_4_neq : incr2_safety_wit_4_neq.
Axiom proof_of_incr2_return_wit_1_eq : incr2_return_wit_1_eq.
Axiom proof_of_incr2_return_wit_2_neq : incr2_return_wit_2_neq.
Axiom proof_of_incr2_partial_solve_wit_1_eq : incr2_partial_solve_wit_1_eq.
Axiom proof_of_call_both_better_return_wit_1 : call_both_better_return_wit_1.
Axiom proof_of_call_both_better_partial_solve_wit_1_pure : call_both_better_partial_solve_wit_1_pure.
Axiom proof_of_call_both_better_partial_solve_wit_1 : call_both_better_partial_solve_wit_1.
Axiom proof_of_call_both_better_partial_solve_wit_2_pure : call_both_better_partial_solve_wit_2_pure.
Axiom proof_of_call_both_better_partial_solve_wit_2 : call_both_better_partial_solve_wit_2.

End VC_Correct.
