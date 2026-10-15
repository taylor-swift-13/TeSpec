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
forall (p_pre: Z) (old: Z) (PreH1 : (0 <= old)) (PreH2 : (old <= UINT_MAX)) ,
  ((( &( "m" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> old)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> old)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition incr_return_wit_1 := 
(
forall (p_pre: Z) (old: Z) (PreH1 : (0 <= old)) (PreH2 : (old <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((old + 1 )) (32)))
|--
  TT && emp 
) \/
(
forall (p_pre: Z) (old: Z) (PreH1 : ((unsigned_last_nbits ((old + 1 )) (32)) <= UINT_MAX)) (PreH2 : ((unsigned_last_nbits ((old + 1 )) (32)) >= 0)) (PreH3 : (0 <= old)) (PreH4 : (old <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((old + 1 )) (32)))
|--
  TT && emp 
).

Definition incr_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (old: Z) (PreH1 : ((unsigned_last_nbits ((old + 1 )) (32)) <= UINT_MAX)) (PreH2 : ((unsigned_last_nbits ((old + 1 )) (32)) >= 0)) (PreH3 : (0 <= old)) (PreH4 : (old <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((old + 1 )) (32)))
|--
  TT && emp 
.

Module Type VC_Correct.

Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.

End VC_Correct.
