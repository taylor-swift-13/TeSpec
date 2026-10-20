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

(*----- Function zero -----*)

Definition zero_safety_wit_1 := 
  ((( &( "p_spec_371" ) )) # Ptr  |-> 4112)
  **  ((4112) # Int  |->_)
|--
  TT && emp 
.

Definition zero_safety_wit_2 := 
  ((( &( "p_spec_371" ) )) # Ptr  |-> 4112)
  **  ((4112) # Int  |->_)
|--
  TT && emp 
.

Definition zero_return_wit_1 := 
(
forall (p_pre: Z) (PreH1 : (p_pre = 4112)) ,
  ((p_pre) # Int  |-> (-1))
|--
  ((p_pre) # Int  |-> 0)
) \/
(
forall (p_pre: Z) (PreH1 : (p_pre = 4112)) ,
  TT && emp 
|--
  “ ((-1) = 0) ”
  &&  emp
).

Definition zero_return_wit_1_split_goal_1 := 
forall (p_pre: Z) (PreH1 : (p_pre = 4112)) ,
  ((-1) = 0)
.

Definition zero_precondition_wit_1 :=
exists (p_pre: Z) ,
~ ((  “ (p_pre = 4112) ”
  &&  ((p_pre) # Int  |->_)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_zero_safety_wit_1 : zero_safety_wit_1.
Axiom proof_of_zero_safety_wit_2 : zero_safety_wit_2.
Axiom proof_of_zero_return_wit_1 : zero_return_wit_1.
Axiom proof_of_zero_precondition_wit_1 : zero_precondition_wit_1.

End VC_Correct.
