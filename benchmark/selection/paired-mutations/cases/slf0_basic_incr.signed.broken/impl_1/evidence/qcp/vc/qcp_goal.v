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
(
forall (p_pre: Z) (old: Z) (PreH1 : (old < INT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> old)
|--
  “ ((old + 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (old + 2 )) ”
) \/
(
forall (p_pre: Z) (old: Z) (PreH1 : (old < INT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> old)
|--
  “ ((old + 2 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (old + 2 )) ”
).

Definition incr_safety_wit_1_split_goal_1 := 
forall (p_pre: Z) (old: Z) (PreH1 : (old < INT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> old)
|--
  “ ((old + 2 ) <= INT_MAX) ”
.

Definition incr_safety_wit_1_split_goal_2 := 
forall (p_pre: Z) (old: Z) (PreH1 : (old < INT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> old)
|--
  “ ((INT_MIN) <= (old + 2 )) ”
.

Definition incr_safety_wit_2 := 
forall (p_pre: Z) (old: Z) (PreH1 : (old < INT_MAX)) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> old)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition incr_return_wit_1 := 
(
forall (p_pre: Z) (old: Z) (PreH1 : (old < INT_MAX)) ,
  ((p_pre) # Int  |-> (old + 2 ))
|--
  ((p_pre) # Int  |-> (old + 1 ))
) \/
(
forall (old: Z) (PreH1 : (old < INT_MAX)) ,
  TT && emp 
|--
  “ ((old + 2 ) = (old + 1 )) ”
  &&  emp
).

Definition incr_return_wit_1_split_goal_1 := 
forall (old: Z) (PreH1 : (old < INT_MAX)) ,
  ((old + 2 ) = (old + 1 ))
.

Module Type VC_Correct.

Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_safety_wit_2 : incr_safety_wit_2.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.

End VC_Correct.
