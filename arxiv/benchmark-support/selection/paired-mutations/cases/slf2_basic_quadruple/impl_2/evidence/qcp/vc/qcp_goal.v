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

(*----- Function quadruple -----*)

Definition quadruple_safety_wit_1 := 
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  ((( &( "n" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition quadruple_return_wit_1 := 
(
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ (0 = ((4 * n_pre ) % ( 4294967296 ) )) ”
  &&  emp
) \/
(
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  TT && emp 
|--
  “ (0 = ((4 * n_pre ) % ( 4294967296 ) )) ”
  &&  emp
).

Definition quadruple_return_wit_1_split_goal_1 := 
forall (n_pre: Z) (PreH1 : (0 <= n_pre)) (PreH2 : (n_pre <= UINT_MAX)) ,
  (0 = ((4 * n_pre ) % ( 4294967296 ) ))
.

Module Type VC_Correct.

Axiom proof_of_quadruple_safety_wit_1 : quadruple_safety_wit_1.
Axiom proof_of_quadruple_return_wit_1 : quadruple_return_wit_1.

End VC_Correct.
