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

(*----- Function bump -----*)

Definition bump_safety_wit_1 := 
forall (p_pre: Z) ,
  ((( &( "p_spec_371" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 3)
|--
  “ ((3 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (3 + 1 )) ”
.

Definition bump_safety_wit_2 := 
forall (p_pre: Z) ,
  ((( &( "p_spec_371" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> 3)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition bump_return_wit_1 := 
forall (p_pre: Z) ,
  ((p_pre) # Int  |-> 4)
|--
  ((p_pre) # Int  |-> 4)
.

Definition bump_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (3 = 3) ” 
  &&  “ (0 <= 3) ” 
  &&  “ (3 < 100) ”
  &&  ((p_pre) # Int  |-> 3)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_bump_safety_wit_1 : bump_safety_wit_1.
Axiom proof_of_bump_safety_wit_2 : bump_safety_wit_2.
Axiom proof_of_bump_return_wit_1 : bump_return_wit_1.
Axiom proof_of_bump_precondition_wit_1 : bump_precondition_wit_1.

End VC_Correct.
