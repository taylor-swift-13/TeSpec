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

(*----- Function doubled -----*)

Definition doubled_safety_wit_1 := 
  ((( &( "b_spec_383" ) )) # Int  |-> (-1073741825))
  **  ((( &( "a_spec_380" ) )) # Int  |-> (-1073741823))
  **  ((( &( "n_spec_371" ) )) # Int  |-> (-1073741824))
|--
  TT && emp 
.

Definition doubled_safety_wit_2 := 
  ((( &( "b_spec_383" ) )) # Int  |->_)
  **  ((( &( "a_spec_380" ) )) # Int  |-> (-1073741823))
  **  ((( &( "n_spec_371" ) )) # Int  |-> (-1073741824))
|--
  TT && emp 
.

Definition doubled_safety_wit_3 := 
  ((( &( "b_spec_383" ) )) # Int  |->_)
  **  ((( &( "a_spec_380" ) )) # Int  |-> (-1073741823))
  **  ((( &( "n_spec_371" ) )) # Int  |-> (-1073741824))
|--
  TT && emp 
.

Definition doubled_safety_wit_4 := 
  ((( &( "a_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> (-1073741824))
|--
  TT && emp 
.

Definition doubled_safety_wit_5 := 
  ((( &( "a_spec_380" ) )) # Int  |->_)
  **  ((( &( "n_spec_371" ) )) # Int  |-> (-1073741824))
|--
  TT && emp 
.

Definition doubled_return_wit_1 := 
(
forall (n_pre: Z) (PreH1 : (n_pre = (-1073741824))) (PreH2 : ((-1073741824) <= n_pre)) (PreH3 : (n_pre <= 1073741823)) ,
  TT && emp 
|--
  “ (((n_pre + 1 ) + (n_pre - 1 ) ) = n_pre) ”
  &&  emp
) \/
(
forall (n_pre: Z) (PreH1 : (n_pre = (-1073741824))) (PreH2 : ((-1073741824) <= n_pre)) (PreH3 : (n_pre <= 1073741823)) ,
  TT && emp 
|--
  “ (((n_pre + 1 ) + (n_pre - 1 ) ) = n_pre) ”
  &&  emp
).

Definition doubled_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : (n_pre = (-1073741824))) (PreH2 : ((-1073741824) <= n_pre)) (PreH3 : (n_pre <= 1073741823)) ,
  (((n_pre + 1 ) + (n_pre - 1 ) ) = n_pre)
.

Definition doubled_precondition_wit_1 :=
exists (n_pre: Z) ,
~ ((  “ (n_pre = (-1073741824)) ” 
  &&  “ ((-1073741824) <= n_pre) ” 
  &&  “ (n_pre <= 1073741823) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_doubled_safety_wit_1 : doubled_safety_wit_1.
Axiom proof_of_doubled_safety_wit_2 : doubled_safety_wit_2.
Axiom proof_of_doubled_safety_wit_3 : doubled_safety_wit_3.
Axiom proof_of_doubled_safety_wit_4 : doubled_safety_wit_4.
Axiom proof_of_doubled_safety_wit_5 : doubled_safety_wit_5.
Axiom proof_of_doubled_return_wit_1 : doubled_return_wit_1.
Axiom proof_of_doubled_precondition_wit_1 : doubled_precondition_wit_1.

End VC_Correct.
