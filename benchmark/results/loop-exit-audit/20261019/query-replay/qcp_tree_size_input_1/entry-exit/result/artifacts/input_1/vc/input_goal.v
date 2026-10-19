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
forall (l: Z) (r: Z) (PreH1 : (r = 0)) (PreH2 : (l = 0)) (PreH3 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH4 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
forall (l: Z) (r: Z) (PreH1 : (l = 0)) (PreH2 : (r = 0)) (PreH3 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH4 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
forall (PreH1 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH2 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
  **  (store_tree 4096 (make_tree (empty) (1) (10) (empty)) )
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
forall (l: Z) (r: Z) (PreH1 : (l = 0)) (PreH2 : (r = 0)) (PreH3 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH4 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  ((( &( "p_spec_458" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
forall (l: Z) (r: Z) (PreH1 : (l = 0)) (PreH2 : (r = 0)) (PreH3 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH4 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  ((( &( "p_spec_458" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
forall (PreH1 : False) ,
  ((( &( "p_spec_458" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_7 := 
forall (l: Z) (r: Z) (PreH1 : (r = 0)) (PreH2 : (l = 0)) (PreH3 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH4 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  ((( &( "p_spec_459" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
forall (l: Z) (r: Z) (PreH1 : (l = 0)) (PreH2 : (r = 0)) (PreH3 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH4 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  ((( &( "p_spec_459" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
forall (PreH1 : False) ,
  ((( &( "p_spec_459" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_10 := 
forall (PreH1 : (0 <= (tree_size ((make_tree (empty) (1) (10) (empty)))))) (PreH2 : ((tree_size ((make_tree (empty) (1) (10) (empty)))) <= 100)) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
  **  (store_tree 4096 (make_tree (empty) (1) (10) (empty)) )
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
  **  (store_tree 4096 (make_tree (empty) (1) (10) (empty)) )
|--
  “ False ”
.

Definition sample_return_wit_1 := 
(
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (PreH1 : (r = 0)) (PreH2 : (l = 0)) (PreH3 : (l = 0)) (PreH4 : (r = 0)) (PreH5 : (p_pre <> 0)) (PreH6 : (p_pre <> 0)) (PreH7 : (p_pre = 4096)) (PreH8 : (t___tespec_entry = (make_tree (empty) (1) (10) (empty)))) (PreH9 : (0 <= (tree_size (t___tespec_entry)))) (PreH10 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  “ (((1 + 0 ) + 0 ) = (tree_size (t___tespec_entry))) ”
  &&  (store_tree p_pre t___tespec_entry )
) \/
(
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (10 <= INT_MAX)) (PreH3 : (1 >= INT_MIN)) (PreH4 : (10 >= INT_MIN)) (PreH5 : (r = 0)) (PreH6 : (l = 0)) (PreH7 : (l = 0)) (PreH8 : (r = 0)) (PreH9 : (p_pre <> 0)) (PreH10 : (p_pre <> 0)) (PreH11 : (p_pre = 4096)) (PreH12 : (t___tespec_entry = (make_tree (empty) (1) (10) (empty)))) (PreH13 : (0 <= (tree_size (t___tespec_entry)))) (PreH14 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  “ (((1 + 0 ) + 0 ) = (tree_size (t___tespec_entry))) ”
  &&  (store_tree p_pre t___tespec_entry )
).

Definition sample_return_wit_1_split_goal_1 := 
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (10 <= INT_MAX)) (PreH3 : (1 >= INT_MIN)) (PreH4 : (10 >= INT_MIN)) (PreH5 : (r = 0)) (PreH6 : (l = 0)) (PreH7 : (l = 0)) (PreH8 : (r = 0)) (PreH9 : (p_pre <> 0)) (PreH10 : (p_pre <> 0)) (PreH11 : (p_pre = 4096)) (PreH12 : (t___tespec_entry = (make_tree (empty) (1) (10) (empty)))) (PreH13 : (0 <= (tree_size (t___tespec_entry)))) (PreH14 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  “ (((1 + 0 ) + 0 ) = (tree_size (t___tespec_entry))) ”
.

Definition sample_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (10 <= INT_MAX)) (PreH3 : (1 >= INT_MIN)) (PreH4 : (10 >= INT_MIN)) (PreH5 : (r = 0)) (PreH6 : (l = 0)) (PreH7 : (l = 0)) (PreH8 : (r = 0)) (PreH9 : (p_pre <> 0)) (PreH10 : (p_pre <> 0)) (PreH11 : (p_pre = 4096)) (PreH12 : (t___tespec_entry = (make_tree (empty) (1) (10) (empty)))) (PreH13 : (0 <= (tree_size (t___tespec_entry)))) (PreH14 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  (store_tree p_pre t___tespec_entry )
.

Definition sample_partial_solve_wit_1 := 
forall (p_pre: Z) (t___tespec_entry: tree) (PreH1 : (p_pre <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (t___tespec_entry = (make_tree (empty) (1) (10) (empty)))) (PreH4 : (0 <= (tree_size (t___tespec_entry)))) (PreH5 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (store_tree p_pre t___tespec_entry )
|--
  EX (l: Z)  (r: Z) ,
  “ (l = 0) ” 
  &&  “ (r = 0) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (t___tespec_entry = (make_tree (empty) (1) (10) (empty))) ” 
  &&  “ (0 <= (tree_size (t___tespec_entry))) ” 
  &&  “ ((tree_size (t___tespec_entry)) <= 100) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (t___tespec_entry: tree) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (t___tespec_entry = (make_tree (empty) (1) (10) (empty))) ” 
  &&  “ (0 <= (tree_size (t___tespec_entry))) ” 
  &&  “ ((tree_size (t___tespec_entry)) <= 100) ”
  &&  (store_tree p_pre t___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : sample_safety_wit_3.
Axiom proof_of_sample_safety_wit_4 : sample_safety_wit_4.
Axiom proof_of_sample_safety_wit_5 : sample_safety_wit_5.
Axiom proof_of_sample_safety_wit_6 : sample_safety_wit_6.
Axiom proof_of_sample_safety_wit_7 : sample_safety_wit_7.
Axiom proof_of_sample_safety_wit_8 : sample_safety_wit_8.
Axiom proof_of_sample_safety_wit_9 : sample_safety_wit_9.
Axiom proof_of_sample_safety_wit_10 : sample_safety_wit_10.
Axiom proof_of_sample_safety_wit_11 : sample_safety_wit_11.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_partial_solve_wit_1 : sample_partial_solve_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
