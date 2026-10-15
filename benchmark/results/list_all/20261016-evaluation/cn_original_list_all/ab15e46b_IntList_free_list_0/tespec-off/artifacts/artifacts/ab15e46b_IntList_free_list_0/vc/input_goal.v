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
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_free_list -----*)

Definition IntList_free_list_safety_wit_1 := 
  ((( &( "xs_spec_449" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_free_list_safety_wit_2 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_449" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_free_list_return_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))) ,
  (sll xs_pre l___tespec_entry )
|--
  TT && emp 
.

Definition IntList_free_list_precondition_wit_1 :=
exists (xs_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 0) ” 
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_free_list_safety_wit_1 : IntList_free_list_safety_wit_1.
Axiom proof_of_IntList_free_list_safety_wit_2 : IntList_free_list_safety_wit_2.
Axiom proof_of_IntList_free_list_return_wit_1 : IntList_free_list_return_wit_1.
Axiom proof_of_IntList_free_list_precondition_wit_1 : IntList_free_list_precondition_wit_1.

End VC_Correct.
