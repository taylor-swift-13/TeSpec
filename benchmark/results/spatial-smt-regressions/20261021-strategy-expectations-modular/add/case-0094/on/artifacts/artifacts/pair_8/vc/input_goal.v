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

Definition add_safety_wit_1 := 
  ((( &( "x_spec_374" ) )) # Int  |-> INT_MAX)
  **  ((( &( "y_spec_371" ) )) # Int  |-> 0)
|--
  TT && emp 
.

Definition add_return_wit_1 := 
(
forall (y_pre: Z) (x_pre: Z) (PreH1 : (x_pre = INT_MAX)) (PreH2 : (y_pre = 0)) (PreH3 : ((INT_MIN) <= (x_pre + y_pre ))) (PreH4 : ((x_pre + y_pre ) <= INT_MAX)) ,
  TT && emp 
|--
  “ ((x_pre * y_pre ) = (x_pre + y_pre )) ”
  &&  emp
) \/
(
forall (y_pre: Z) (x_pre: Z) (PreH1 : (x_pre = INT_MAX)) (PreH2 : (y_pre = 0)) (PreH3 : ((INT_MIN) <= (x_pre + y_pre ))) (PreH4 : ((x_pre + y_pre ) <= INT_MAX)) ,
  TT && emp 
|--
  “ ((x_pre * y_pre ) = (x_pre + y_pre )) ”
  &&  emp
).

Definition add_return_wit_1_split_goal_1 := 
forall (y_pre: Z) (x_pre: Z) (PreH1 : (x_pre = INT_MAX)) (PreH2 : (y_pre = 0)) (PreH3 : ((INT_MIN) <= (x_pre + y_pre ))) (PreH4 : ((x_pre + y_pre ) <= INT_MAX)) ,
  ((x_pre * y_pre ) = (x_pre + y_pre ))
.

Definition add_precondition_wit_1 :=
exists (y_pre: Z) ,
exists (x_pre: Z) ,
~ ((  “ (x_pre = INT_MAX) ” 
  &&  “ (y_pre = 0) ” 
  &&  “ ((INT_MIN) <= (x_pre + y_pre )) ” 
  &&  “ ((x_pre + y_pre ) <= INT_MAX) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_add_safety_wit_1 : add_safety_wit_1.
Axiom proof_of_add_return_wit_1 : add_return_wit_1.
Axiom proof_of_add_precondition_wit_1 : add_precondition_wit_1.

End VC_Correct.
