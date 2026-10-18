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

(*----- Function abs -----*)

Definition abs_safety_wit_1 := 
  ((( &( "x_spec_371" ) )) # Int  |-> INT_MAX)
|--
  TT && emp 
.

Definition abs_return_wit_1 := 
forall (x_pre: Z) (PreH1 : (x_pre = INT_MAX)) (PreH2 : ((INT_MIN) < x_pre)) ,
  TT && emp 
|--
  (“ (x_pre < 0) ” 
  &&  “ ((-x_pre) = (-x_pre)) ”
  &&  emp)
  ||
  (“ (x_pre >= 0) ” 
  &&  “ ((-x_pre) = x_pre) ”
  &&  emp)
.

Definition abs_precondition_wit_1 :=
exists (x_pre: Z) ,
~ ((  “ (x_pre = INT_MAX) ” 
  &&  “ ((INT_MIN) < x_pre) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_abs_safety_wit_1 : abs_safety_wit_1.
Axiom proof_of_abs_return_wit_1 : abs_return_wit_1.
Axiom proof_of_abs_precondition_wit_1 : abs_precondition_wit_1.

End VC_Correct.
