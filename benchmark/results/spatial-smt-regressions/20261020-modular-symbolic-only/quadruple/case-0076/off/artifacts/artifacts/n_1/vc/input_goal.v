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

(*----- Function quadruple -----*)

Definition quadruple_safety_wit_1 := 
  ((( &( "m_spec_380" ) )) # Int  |-> (-2))
  **  ((( &( "n_spec_371" ) )) # Int  |-> (-1))
|--
  TT && emp 
.

Definition quadruple_safety_wit_2 := 
  ((( &( "m_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> (-1))
|--
  TT && emp 
.

Definition quadruple_return_wit_1 := 
(
forall (n_pre: Z) (PreH1 : (n_pre = (-1))) (PreH2 : ((-536870912) <= n_pre)) (PreH3 : (n_pre <= 536870911)) ,
  TT && emp 
|--
  “ (((n_pre + n_pre ) + (n_pre + n_pre ) ) = 0) ”
  &&  emp
) \/
(
forall (n_pre: Z) (PreH1 : (n_pre = (-1))) (PreH2 : ((-536870912) <= n_pre)) (PreH3 : (n_pre <= 536870911)) ,
  TT && emp 
|--
  “ (((n_pre + n_pre ) + (n_pre + n_pre ) ) = 0) ”
  &&  emp
).

Definition quadruple_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : (n_pre = (-1))) (PreH2 : ((-536870912) <= n_pre)) (PreH3 : (n_pre <= 536870911)) ,
  (((n_pre + n_pre ) + (n_pre + n_pre ) ) = 0)
.

Definition quadruple_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = (-1)) ” 
  &&  “ ((-536870912) <= n_pre) ” 
  &&  “ (n_pre <= 536870911) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_quadruple_safety_wit_1 : quadruple_safety_wit_1.
Axiom proof_of_quadruple_safety_wit_2 : quadruple_safety_wit_2.
Axiom proof_of_quadruple_return_wit_1 : quadruple_return_wit_1.
Axiom proof_of_quadruple_precondition_wit_1 : quadruple_precondition_wit_1.

End VC_Correct.
