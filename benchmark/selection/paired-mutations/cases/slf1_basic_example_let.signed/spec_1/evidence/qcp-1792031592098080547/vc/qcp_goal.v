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

(*----- Function doubled -----*)

Definition doubled_safety_wit_1 := 
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  ((( &( "a" ) )) # Int  |->_)
  **  ((( &( "n" ) )) # Int  |-> n_pre)
|--
  “ ((n_pre + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (n_pre + 1 )) ”
.

Definition doubled_safety_wit_2 := 
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  ((( &( "a" ) )) # Int  |->_)
  **  ((( &( "n" ) )) # Int  |-> n_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition doubled_safety_wit_3 := 
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  ((( &( "b" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Int  |-> (n_pre + 1 ))
  **  ((( &( "n" ) )) # Int  |-> n_pre)
|--
  “ ((n_pre - 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (n_pre - 1 )) ”
.

Definition doubled_safety_wit_4 := 
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  ((( &( "b" ) )) # Int  |->_)
  **  ((( &( "a" ) )) # Int  |-> (n_pre + 1 ))
  **  ((( &( "n" ) )) # Int  |-> n_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition doubled_safety_wit_5 := 
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  ((( &( "b" ) )) # Int  |-> (n_pre - 1 ))
  **  ((( &( "a" ) )) # Int  |-> (n_pre + 1 ))
  **  ((( &( "n" ) )) # Int  |-> n_pre)
|--
  “ (((n_pre + 1 ) + (n_pre - 1 ) ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= ((n_pre + 1 ) + (n_pre - 1 ) )) ”
.

Definition doubled_return_wit_1 := 
(
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  TT && emp 
|--
  “ (((n_pre + 1 ) + (n_pre - 1 ) ) = n_pre) ”
  &&  emp
) \/
(
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  TT && emp 
|--
  “ (((n_pre + 1 ) + (n_pre - 1 ) ) = n_pre) ”
  &&  emp
).

Definition doubled_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : ((-1073741824) <= n_pre)) (PreH2 : (n_pre <= 1073741823)) ,
  (((n_pre + 1 ) + (n_pre - 1 ) ) = n_pre)
.

Module Type VC_Correct.

Axiom proof_of_doubled_safety_wit_1 : doubled_safety_wit_1.
Axiom proof_of_doubled_safety_wit_2 : doubled_safety_wit_2.
Axiom proof_of_doubled_safety_wit_3 : doubled_safety_wit_3.
Axiom proof_of_doubled_safety_wit_4 : doubled_safety_wit_4.
Axiom proof_of_doubled_safety_wit_5 : doubled_safety_wit_5.
Axiom proof_of_doubled_return_wit_1 : doubled_return_wit_1.

End VC_Correct.
