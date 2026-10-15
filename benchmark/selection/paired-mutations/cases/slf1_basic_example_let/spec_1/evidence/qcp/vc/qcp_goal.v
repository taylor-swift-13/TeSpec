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

(*----- Function example_let -----*)

Definition example_let_safety_wit_1 := 
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  ((( &( "a" ) )) # UInt  |->_)
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition example_let_safety_wit_2 := 
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  ((( &( "b" ) )) # UInt  |->_)
  **  ((( &( "a" ) )) # UInt  |-> (unsigned_last_nbits ((n_pre + 1 )) (32)))
  **  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition example_let_return_wit_1 := 
(
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits (((unsigned_last_nbits ((n_pre + 1 )) (32)) + (unsigned_last_nbits ((n_pre - 1 )) (32)) )) (32)) = n_pre) ”
  &&  emp
) \/
(
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ ((unsigned_last_nbits (((unsigned_last_nbits ((n_pre + 1 )) (32)) + (unsigned_last_nbits ((n_pre - 1 )) (32)) )) (32)) = n_pre) ”
  &&  emp
).

Definition example_let_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  ((unsigned_last_nbits (((unsigned_last_nbits ((n_pre + 1 )) (32)) + (unsigned_last_nbits ((n_pre - 1 )) (32)) )) (32)) = n_pre)
.

Module Type VC_Correct.

Axiom proof_of_example_let_safety_wit_1 : example_let_safety_wit_1.
Axiom proof_of_example_let_safety_wit_2 : example_let_safety_wit_2.
Axiom proof_of_example_let_return_wit_1 : example_let_return_wit_1.

End VC_Correct.
