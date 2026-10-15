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

(*----- Function add -----*)

Definition add_return_wit_1 := 
(
forall (q_pre: Z) (p_pre: Z) (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
|--
  “ ((unsigned_last_nbits ((v + w )) (32)) = ((v + w ) % ( 4294967296 ) )) ”
  &&  ((p_pre) # UInt  |-> v)
  **  ((q_pre) # UInt  |-> w)
) \/
(
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits ((v + w )) (32)) = ((v + w ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition add_return_wit_1_split_goal_1 := 
forall (w: Z) (v: Z) (PreH1 : (0 <= v)) (PreH2 : (v <= UINT_MAX)) (PreH3 : (0 <= w)) (PreH4 : (w <= UINT_MAX)) ,
  ((unsigned_last_nbits ((v + w )) (32)) = ((v + w ) % ( 4294967296 ) ))
.

Module Type VC_Correct.

Axiom proof_of_add_return_wit_1 : add_return_wit_1.

End VC_Correct.
