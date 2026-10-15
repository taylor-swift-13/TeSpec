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

(*----- Function abs -----*)

Definition abs_return_wit_1 := 
(
forall (x_pre: Z) (PreH1 : ((INT_MIN) < x_pre)) ,
  TT && emp 
|--
  “ (x_pre >= 0) ” 
  &&  “ (x_pre = x_pre) ”
  &&  emp
) \/
(
forall (x_pre: Z) (PreH1 : ((INT_MIN) < x_pre)) ,
  TT && emp 
|--
  “ (x_pre >= 0) ”
  &&  emp
).

Definition abs_return_wit_1_split_goal_1 := 
forall (x_pre: Z) (PreH1 : ((INT_MIN) < x_pre)) ,
  (x_pre >= 0)
.

Module Type VC_Correct.

Axiom proof_of_abs_return_wit_1 : abs_return_wit_1.

End VC_Correct.
