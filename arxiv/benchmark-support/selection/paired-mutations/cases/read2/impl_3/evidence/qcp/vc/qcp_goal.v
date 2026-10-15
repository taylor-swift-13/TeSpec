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

(*----- Function read -----*)

Definition read_safety_wit_1 := 
forall (p_pre: Z) (old: Z) ,
  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> old)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition read_return_wit_1 := 
(
forall (p_pre: Z) (old: Z) ,
  ((p_pre) # Int  |-> 0)
|--
  “ (0 = old) ”
  &&  ((p_pre) # Int  |-> old)
) \/
(
forall (old: Z) ,
  TT && emp 
|--
  “ (0 = old) ” 
  &&  “ (0 = old) ”
  &&  emp
).

Definition read_return_wit_1_split_goal_1 := 
forall (old: Z) ,
  (0 = old)
.

Definition read_return_wit_1_split_goal_2 := 
forall (old: Z) ,
  (0 = old)
.

Module Type VC_Correct.

Axiom proof_of_read_safety_wit_1 : read_safety_wit_1.
Axiom proof_of_read_return_wit_1 : read_return_wit_1.

End VC_Correct.
