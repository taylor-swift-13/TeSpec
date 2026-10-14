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
forall (p_pre: Z) (v: Z) ,
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
forall (p_pre: Z) (v: Z) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((v + 1 )) (32)))
|--
  ((p_pre) # UInt  |-> ((v + 1 ) % ( 4294967296 ) ))
) \/
(
forall (v: Z) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((v + 1 )) (32)) = ((v + 1 ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition incr_return_wit_1_split_goal_1 := 
forall (v: Z) ,
  ((unsigned_last_nbits ((v + 1 )) (32)) = ((v + 1 ) % ( 4294967296 ) ))
.

Module Type VC_Correct.

Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.

End VC_Correct.
