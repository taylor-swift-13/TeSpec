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
Require Import SimpleC.EE.QCP_demos_human.bst_lib.
Import get_right_most.
Require Import TreeMeasure.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function sample -----*)

Definition sample_safety_wit_1 := 
forall (PreH1 : (0 <= (tree_size (empty)))) (PreH2 : ((tree_size (empty)) <= 100)) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 0)
  **  (store_tree 0 empty )
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
forall (PreH1 : (0 <= (tree_size (empty)))) (PreH2 : ((tree_size (empty)) <= 100)) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 0)
  **  (store_tree 0 empty )
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
forall (PreH1 : False) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 0)
  **  (store_tree 0 empty )
|--
  “ False ”
.

Definition sample_return_wit_1 := 
(
forall (p_pre: Z) (t___tespec_entry: tree) (PreH1 : (p_pre = 0)) (PreH2 : (p_pre = 0)) (PreH3 : (t___tespec_entry = empty)) (PreH4 : (0 <= (tree_size (t___tespec_entry)))) (PreH5 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (store_tree p_pre t___tespec_entry )
|--
  “ (0 = (tree_size (t___tespec_entry))) ”
  &&  (store_tree p_pre t___tespec_entry )
) \/
(
forall (p_pre: Z) (t___tespec_entry: tree) (PreH1 : (p_pre = 0)) (PreH2 : (p_pre = 0)) (PreH3 : (t___tespec_entry = empty)) (PreH4 : (0 <= (tree_size (t___tespec_entry)))) (PreH5 : ((tree_size (t___tespec_entry)) <= 100)) ,
  TT && emp 
|--
  “ (0 = (tree_size (t___tespec_entry))) ”
  &&  emp
).

Definition sample_return_wit_1_split_goal_1 := 
forall (p_pre: Z) (t___tespec_entry: tree) (PreH1 : (p_pre = 0)) (PreH2 : (p_pre = 0)) (PreH3 : (t___tespec_entry = empty)) (PreH4 : (0 <= (tree_size (t___tespec_entry)))) (PreH5 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (0 = (tree_size (t___tespec_entry)))
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (t___tespec_entry: tree) ,
~ ((  “ (p_pre = 0) ” 
  &&  “ (t___tespec_entry = empty) ” 
  &&  “ (0 <= (tree_size (t___tespec_entry))) ” 
  &&  “ ((tree_size (t___tespec_entry)) <= 100) ”
  &&  (store_tree p_pre t___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : sample_safety_wit_3.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
