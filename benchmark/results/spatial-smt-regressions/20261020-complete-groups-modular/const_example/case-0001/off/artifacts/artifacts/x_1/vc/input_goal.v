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

(*----- Function foo -----*)

Definition foo_safety_wit_1 := 
  ((( &( "x_spec_371" ) )) # Int  |-> (-100))
|--
  TT && emp 
.

Definition foo_return_wit_1 := 
forall (x_pre: Z) (PreH1 : (x_pre = (-100))) ,
  TT && emp 
|--
  “ (1 = 1) ”
  &&  emp
.

Definition foo_precondition_wit_1 :=
exists (x_pre: Z) ,
~ ((  “ (x_pre = (-100)) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_foo_safety_wit_1 : foo_safety_wit_1.
Axiom proof_of_foo_return_wit_1 : foo_return_wit_1.
Axiom proof_of_foo_precondition_wit_1 : foo_precondition_wit_1.

End VC_Correct.
