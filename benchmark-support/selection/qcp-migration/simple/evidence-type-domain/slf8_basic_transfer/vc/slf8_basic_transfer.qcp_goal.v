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

(*----- Function transfer -----*)

Definition transfer_safety_wit_1 := 
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((( &( "s" ) )) # UInt  |-> (unsigned_last_nbits ((v + w )) (32)))
  **  ((( &( "m" ) )) # UInt  |-> w)
  **  ((( &( "n" ) )) # UInt  |-> v)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((( &( "q" ) )) # Ptr  |-> q_pre)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v + w )) (32)))
  **  ((q_pre) # UInt  |-> w)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition transfer_return_wit_1 := 
(
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v + w )) (32)))
  **  ((q_pre) # UInt  |-> 0)
|--
  ((p_pre) # UInt  |-> ((v + w ) % ( 4294967296 ) ))
  **  ((q_pre) # UInt  |-> 0)
) \/
(
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((v + w )) (32)) = ((v + w ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition transfer_return_wit_1_split_goal_1 := 
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((unsigned_last_nbits ((v + w )) (32)) = ((v + w ) % ( 4294967296 ) ))
.

Module Type VC_Correct.

Axiom proof_of_transfer_safety_wit_1 : transfer_safety_wit_1.
Axiom proof_of_transfer_return_wit_1 : transfer_return_wit_1.

End VC_Correct.
