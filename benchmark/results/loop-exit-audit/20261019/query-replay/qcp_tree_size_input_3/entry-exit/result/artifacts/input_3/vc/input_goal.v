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
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_4 = 0)) (PreH2 : (l_4 = 0)) (PreH3 : (r_3 <> 0)) (PreH4 : (l_3 = 0)) (PreH5 : (r_2 <> 0)) (PreH6 : (l_2 = 0)) (PreH7 : (r <> 0)) (PreH8 : (l = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l = 0)) (PreH2 : (l_2 = 0)) (PreH3 : (l_3 = 0)) (PreH4 : (l_4 = 0)) (PreH5 : (r_4 = 0)) (PreH6 : (r_3 <> 0)) (PreH7 : (r_2 <> 0)) (PreH8 : (r <> 0)) (PreH9 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH10 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
forall (PreH1 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH2 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
  **  (store_tree 4096 (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l = 0)) (PreH2 : (l_2 = 0)) (PreH3 : (l_3 = 0)) (PreH4 : (l_4 = 0)) (PreH5 : (r_4 = 0)) (PreH6 : (r_3 <> 0)) (PreH7 : (r_2 <> 0)) (PreH8 : (r <> 0)) (PreH9 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH10 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_476" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l = 0)) (PreH2 : (l_2 = 0)) (PreH3 : (l_3 = 0)) (PreH4 : (l_4 = 0)) (PreH5 : (r_4 = 0)) (PreH6 : (r_3 <> 0)) (PreH7 : (r_2 <> 0)) (PreH8 : (r <> 0)) (PreH9 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH10 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_476" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
forall (r: Z) (r_2: Z) (r_3: Z) (PreH1 : False) ,
  ((( &( "p_spec_476" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_7 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_4 = 0)) (PreH2 : (l_4 = 0)) (PreH3 : (r_3 <> 0)) (PreH4 : (l_3 = 0)) (PreH5 : (r_2 <> 0)) (PreH6 : (l_2 = 0)) (PreH7 : (r <> 0)) (PreH8 : (l = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_2 = 0)) (PreH2 : (r <> 0)) (PreH3 : (l = 0)) (PreH4 : (l_3 = 0)) (PreH5 : (l_4 = 0)) (PreH6 : (r_4 = 0)) (PreH7 : (r_3 <> 0)) (PreH8 : (r_2 <> 0)) (PreH9 : (r <> 0)) (PreH10 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH11 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r <> 0)) (PreH2 : (l = 0)) (PreH3 : (l_2 = 0)) (PreH4 : (l_3 = 0)) (PreH5 : (l_4 = 0)) (PreH6 : (r_4 = 0)) (PreH7 : (r_3 <> 0)) (PreH8 : (r_2 <> 0)) (PreH9 : (r <> 0)) (PreH10 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH11 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_2 = 0)) (PreH2 : (r <> 0)) (PreH3 : (l = 0)) (PreH4 : (l_3 = 0)) (PreH5 : (l_4 = 0)) (PreH6 : (r_4 = 0)) (PreH7 : (r_3 <> 0)) (PreH8 : (r_2 <> 0)) (PreH9 : (r <> 0)) (PreH10 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH11 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_478" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r <> 0)) (PreH2 : (l = 0)) (PreH3 : (l_2 = 0)) (PreH4 : (l_3 = 0)) (PreH5 : (l_4 = 0)) (PreH6 : (r_4 = 0)) (PreH7 : (r_3 <> 0)) (PreH8 : (r_2 <> 0)) (PreH9 : (r <> 0)) (PreH10 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH11 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_478" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_12 := 
forall (r: Z) (r_2: Z) (r_3: Z) (PreH1 : False) ,
  ((( &( "p_spec_478" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_13 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_4 = 0)) (PreH2 : (l_4 = 0)) (PreH3 : (r_3 <> 0)) (PreH4 : (l_3 = 0)) (PreH5 : (r_2 <> 0)) (PreH6 : (l_2 = 0)) (PreH7 : (r <> 0)) (PreH8 : (l = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_14 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_3 = 0)) (PreH2 : (r_2 <> 0)) (PreH3 : (l_2 = 0)) (PreH4 : (r <> 0)) (PreH5 : (l = 0)) (PreH6 : (l_4 = 0)) (PreH7 : (r_4 = 0)) (PreH8 : (r_3 <> 0)) (PreH9 : (r_2 <> 0)) (PreH10 : (r <> 0)) (PreH11 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH12 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_2 <> 0)) (PreH2 : (l_2 = 0)) (PreH3 : (r <> 0)) (PreH4 : (l = 0)) (PreH5 : (l_3 = 0)) (PreH6 : (l_4 = 0)) (PreH7 : (r_4 = 0)) (PreH8 : (r_3 <> 0)) (PreH9 : (r_2 <> 0)) (PreH10 : (r <> 0)) (PreH11 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH12 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_16 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_3 = 0)) (PreH2 : (r_2 <> 0)) (PreH3 : (l_2 = 0)) (PreH4 : (r <> 0)) (PreH5 : (l = 0)) (PreH6 : (l_4 = 0)) (PreH7 : (r_4 = 0)) (PreH8 : (r_3 <> 0)) (PreH9 : (r_2 <> 0)) (PreH10 : (r <> 0)) (PreH11 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH12 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_480" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_17 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_2 <> 0)) (PreH2 : (l_2 = 0)) (PreH3 : (r <> 0)) (PreH4 : (l = 0)) (PreH5 : (l_3 = 0)) (PreH6 : (l_4 = 0)) (PreH7 : (r_4 = 0)) (PreH8 : (r_3 <> 0)) (PreH9 : (r_2 <> 0)) (PreH10 : (r <> 0)) (PreH11 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH12 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_480" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_18 := 
forall (r: Z) (r_2: Z) (r_3: Z) (PreH1 : False) ,
  ((( &( "p_spec_480" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_19 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_4 = 0)) (PreH2 : (l_4 = 0)) (PreH3 : (r_3 <> 0)) (PreH4 : (l_3 = 0)) (PreH5 : (r_2 <> 0)) (PreH6 : (l_2 = 0)) (PreH7 : (r <> 0)) (PreH8 : (l = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_20 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_4 = 0)) (PreH2 : (r_3 <> 0)) (PreH3 : (l_3 = 0)) (PreH4 : (r_2 <> 0)) (PreH5 : (l_2 = 0)) (PreH6 : (r <> 0)) (PreH7 : (l = 0)) (PreH8 : (r_4 = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_21 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_3 <> 0)) (PreH2 : (l_3 = 0)) (PreH3 : (r_2 <> 0)) (PreH4 : (l_2 = 0)) (PreH5 : (r <> 0)) (PreH6 : (l = 0)) (PreH7 : (l_4 = 0)) (PreH8 : (r_4 = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_22 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_4 = 0)) (PreH2 : (r_3 <> 0)) (PreH3 : (l_3 = 0)) (PreH4 : (r_2 <> 0)) (PreH5 : (l_2 = 0)) (PreH6 : (r <> 0)) (PreH7 : (l = 0)) (PreH8 : (r_4 = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_482" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_23 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_3 <> 0)) (PreH2 : (l_3 = 0)) (PreH3 : (r_2 <> 0)) (PreH4 : (l_2 = 0)) (PreH5 : (r <> 0)) (PreH6 : (l = 0)) (PreH7 : (l_4 = 0)) (PreH8 : (r_4 = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_482" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_24 := 
forall (r: Z) (r_2: Z) (r_3: Z) (PreH1 : False) ,
  ((( &( "p_spec_482" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_25 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_4 = 0)) (PreH2 : (l_4 = 0)) (PreH3 : (r_3 <> 0)) (PreH4 : (l_3 = 0)) (PreH5 : (r_2 <> 0)) (PreH6 : (l_2 = 0)) (PreH7 : (r <> 0)) (PreH8 : (l = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_483" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_26 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_4 = 0)) (PreH2 : (r_3 <> 0)) (PreH3 : (l_3 = 0)) (PreH4 : (r_2 <> 0)) (PreH5 : (l_2 = 0)) (PreH6 : (r <> 0)) (PreH7 : (l = 0)) (PreH8 : (r_4 = 0)) (PreH9 : (r_3 <> 0)) (PreH10 : (r_2 <> 0)) (PreH11 : (r <> 0)) (PreH12 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH13 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_483" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_27 := 
forall (r: Z) (r_2: Z) (r_3: Z) (PreH1 : False) ,
  ((( &( "p_spec_483" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_28 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_3 = 0)) (PreH2 : (r_2 <> 0)) (PreH3 : (l_2 = 0)) (PreH4 : (r <> 0)) (PreH5 : (l = 0)) (PreH6 : (l_4 = 0)) (PreH7 : (r_4 = 0)) (PreH8 : (r_3 <> 0)) (PreH9 : (r_2 <> 0)) (PreH10 : (r <> 0)) (PreH11 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH12 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_481" ) )) # Ptr  |-> r_3)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_29 := 
forall (r: Z) (r_2: Z) (PreH1 : False) ,
  ((( &( "p_spec_481" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (0 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (0 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_30 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l_2 = 0)) (PreH2 : (r <> 0)) (PreH3 : (l = 0)) (PreH4 : (l_3 = 0)) (PreH5 : (l_4 = 0)) (PreH6 : (r_4 = 0)) (PreH7 : (r_3 <> 0)) (PreH8 : (r_2 <> 0)) (PreH9 : (r <> 0)) (PreH10 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH11 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_479" ) )) # Ptr  |-> r_2)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_31 := 
forall (r: Z) (r_2: Z) (PreH1 : False) ,
  ((( &( "p_spec_479" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (0 + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (0 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_32 := 
forall (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (l = 0)) (PreH2 : (l_2 = 0)) (PreH3 : (l_3 = 0)) (PreH4 : (l_4 = 0)) (PreH5 : (r_4 = 0)) (PreH6 : (r_3 <> 0)) (PreH7 : (r_2 <> 0)) (PreH8 : (r <> 0)) (PreH9 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH10 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_477" ) )) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition sample_safety_wit_33 := 
forall (r: Z) (r_2: Z) (PreH1 : False) ,
  ((( &( "p_spec_477" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (0 + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (0 + 8)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (4096 + 12)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition sample_safety_wit_34 := 
forall (PreH1 : (0 <= (tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))))) (PreH2 : ((tree_size ((make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) <= 100)) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
  **  (store_tree 4096 (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_35 := 
forall (PreH1 : False) ,
  ((( &( "p_spec_441" ) )) # Ptr  |-> 4096)
  **  (store_tree 4096 (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))) )
|--
  “ False ”
.

Definition sample_return_wit_1 := 
(
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (r_4 = 0)) (PreH2 : (l_4 = 0)) (PreH3 : (r_3 <> 0)) (PreH4 : (l_3 = 0)) (PreH5 : (r_2 <> 0)) (PreH6 : (l_2 = 0)) (PreH7 : (r <> 0)) (PreH8 : (l = 0)) (PreH9 : (l = 0)) (PreH10 : (l_2 = 0)) (PreH11 : (l_3 = 0)) (PreH12 : (l_4 = 0)) (PreH13 : (r_4 = 0)) (PreH14 : (r_3 <> 0)) (PreH15 : (r_2 <> 0)) (PreH16 : (r <> 0)) (PreH17 : (p_pre <> 0)) (PreH18 : (p_pre <> 0)) (PreH19 : (p_pre = 4096)) (PreH20 : (t___tespec_entry = (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) (PreH21 : (0 <= (tree_size (t___tespec_entry)))) (PreH22 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> r_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> l_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> l_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> l_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  “ (((1 + 0 ) + ((1 + 0 ) + ((1 + 0 ) + ((1 + 0 ) + 0 ) ) ) ) = (tree_size (t___tespec_entry))) ”
  &&  (store_tree p_pre t___tespec_entry )
) \/
(
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (10 <= INT_MAX)) (PreH3 : (2 <= INT_MAX)) (PreH4 : (20 <= INT_MAX)) (PreH5 : (3 <= INT_MAX)) (PreH6 : (30 <= INT_MAX)) (PreH7 : (4 <= INT_MAX)) (PreH8 : (40 <= INT_MAX)) (PreH9 : (1 >= INT_MIN)) (PreH10 : (10 >= INT_MIN)) (PreH11 : (2 >= INT_MIN)) (PreH12 : (20 >= INT_MIN)) (PreH13 : (3 >= INT_MIN)) (PreH14 : (30 >= INT_MIN)) (PreH15 : (4 >= INT_MIN)) (PreH16 : (40 >= INT_MIN)) (PreH17 : (r_4 = 0)) (PreH18 : (l_4 = 0)) (PreH19 : (r_3 <> 0)) (PreH20 : (l_3 = 0)) (PreH21 : (r_2 <> 0)) (PreH22 : (l_2 = 0)) (PreH23 : (r <> 0)) (PreH24 : (l = 0)) (PreH25 : (l = 0)) (PreH26 : (l_2 = 0)) (PreH27 : (l_3 = 0)) (PreH28 : (l_4 = 0)) (PreH29 : (r_4 = 0)) (PreH30 : (r_3 <> 0)) (PreH31 : (r_2 <> 0)) (PreH32 : (r <> 0)) (PreH33 : (p_pre <> 0)) (PreH34 : (p_pre <> 0)) (PreH35 : (p_pre = 4096)) (PreH36 : (t___tespec_entry = (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) (PreH37 : (0 <= (tree_size (t___tespec_entry)))) (PreH38 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> r_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> l_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> l_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> l_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  “ (((1 + 0 ) + ((1 + 0 ) + ((1 + 0 ) + ((1 + 0 ) + 0 ) ) ) ) = (tree_size (t___tespec_entry))) ”
  &&  (store_tree p_pre t___tespec_entry )
).

Definition sample_return_wit_1_split_goal_1 := 
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (10 <= INT_MAX)) (PreH3 : (2 <= INT_MAX)) (PreH4 : (20 <= INT_MAX)) (PreH5 : (3 <= INT_MAX)) (PreH6 : (30 <= INT_MAX)) (PreH7 : (4 <= INT_MAX)) (PreH8 : (40 <= INT_MAX)) (PreH9 : (1 >= INT_MIN)) (PreH10 : (10 >= INT_MIN)) (PreH11 : (2 >= INT_MIN)) (PreH12 : (20 >= INT_MIN)) (PreH13 : (3 >= INT_MIN)) (PreH14 : (30 >= INT_MIN)) (PreH15 : (4 >= INT_MIN)) (PreH16 : (40 >= INT_MIN)) (PreH17 : (r_4 = 0)) (PreH18 : (l_4 = 0)) (PreH19 : (r_3 <> 0)) (PreH20 : (l_3 = 0)) (PreH21 : (r_2 <> 0)) (PreH22 : (l_2 = 0)) (PreH23 : (r <> 0)) (PreH24 : (l = 0)) (PreH25 : (l = 0)) (PreH26 : (l_2 = 0)) (PreH27 : (l_3 = 0)) (PreH28 : (l_4 = 0)) (PreH29 : (r_4 = 0)) (PreH30 : (r_3 <> 0)) (PreH31 : (r_2 <> 0)) (PreH32 : (r <> 0)) (PreH33 : (p_pre <> 0)) (PreH34 : (p_pre <> 0)) (PreH35 : (p_pre = 4096)) (PreH36 : (t___tespec_entry = (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) (PreH37 : (0 <= (tree_size (t___tespec_entry)))) (PreH38 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> r_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> l_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> l_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> l_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  “ (((1 + 0 ) + ((1 + 0 ) + ((1 + 0 ) + ((1 + 0 ) + 0 ) ) ) ) = (tree_size (t___tespec_entry))) ”
.

Definition sample_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (t___tespec_entry: tree) (l: Z) (r: Z) (l_2: Z) (r_2: Z) (l_3: Z) (r_3: Z) (l_4: Z) (r_4: Z) (PreH1 : (1 <= INT_MAX)) (PreH2 : (10 <= INT_MAX)) (PreH3 : (2 <= INT_MAX)) (PreH4 : (20 <= INT_MAX)) (PreH5 : (3 <= INT_MAX)) (PreH6 : (30 <= INT_MAX)) (PreH7 : (4 <= INT_MAX)) (PreH8 : (40 <= INT_MAX)) (PreH9 : (1 >= INT_MIN)) (PreH10 : (10 >= INT_MIN)) (PreH11 : (2 >= INT_MIN)) (PreH12 : (20 >= INT_MIN)) (PreH13 : (3 >= INT_MIN)) (PreH14 : (30 >= INT_MIN)) (PreH15 : (4 >= INT_MIN)) (PreH16 : (40 >= INT_MIN)) (PreH17 : (r_4 = 0)) (PreH18 : (l_4 = 0)) (PreH19 : (r_3 <> 0)) (PreH20 : (l_3 = 0)) (PreH21 : (r_2 <> 0)) (PreH22 : (l_2 = 0)) (PreH23 : (r <> 0)) (PreH24 : (l = 0)) (PreH25 : (l = 0)) (PreH26 : (l_2 = 0)) (PreH27 : (l_3 = 0)) (PreH28 : (l_4 = 0)) (PreH29 : (r_4 = 0)) (PreH30 : (r_3 <> 0)) (PreH31 : (r_2 <> 0)) (PreH32 : (r <> 0)) (PreH33 : (p_pre <> 0)) (PreH34 : (p_pre <> 0)) (PreH35 : (p_pre = 4096)) (PreH36 : (t___tespec_entry = (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) (PreH37 : (0 <= (tree_size (t___tespec_entry)))) (PreH38 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> r_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> l_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> l_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> l_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
|--
  (store_tree p_pre t___tespec_entry )
.

Definition sample_partial_solve_wit_1 := 
forall (p_pre: Z) (t___tespec_entry: tree) (PreH1 : (p_pre <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (t___tespec_entry = (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty)))))))))) (PreH4 : (0 <= (tree_size (t___tespec_entry)))) (PreH5 : ((tree_size (t___tespec_entry)) <= 100)) ,
  (store_tree p_pre t___tespec_entry )
|--
  EX (l: Z)  (r: Z)  (l_2: Z)  (r_2: Z)  (l_3: Z)  (r_3: Z)  (l_4: Z)  (r_4: Z) ,
  “ (l = 0) ” 
  &&  “ (l_2 = 0) ” 
  &&  “ (l_3 = 0) ” 
  &&  “ (l_4 = 0) ” 
  &&  “ (r_4 = 0) ” 
  &&  “ (r_3 <> 0) ” 
  &&  “ (r_2 <> 0) ” 
  &&  “ (r <> 0) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (p_pre <> 0) ” 
  &&  “ (p_pre = 4096) ” 
  &&  “ (t___tespec_entry = (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty))))))))) ” 
  &&  “ (0 <= (tree_size (t___tespec_entry))) ” 
  &&  “ ((tree_size (t___tespec_entry)) <= 100) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p_pre + 8)) # Ptr  |-> l)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_3 + 12)) # Ptr  |-> r_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_3 + 8)) # Ptr  |-> l_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_3 + 4)) # Int  |-> 40)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_3 + 0)) # Int  |-> 4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r_2 + 12)) # Ptr  |-> r_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r_2 + 8)) # Ptr  |-> l_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r_2 + 4)) # Int  |-> 30)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (r + 12)) # Ptr  |-> r_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (r + 8)) # Ptr  |-> l_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (r + 4)) # Int  |-> 20)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (r + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=12; size=4; align=4 *) (p_pre + 12)) # Ptr  |-> r)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # Int  |-> 1)
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (t___tespec_entry: tree) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (t___tespec_entry = (make_tree (empty) (1) (10) ((make_tree (empty) (2) (20) ((make_tree (empty) (3) (30) ((make_tree (empty) (4) (40) (empty))))))))) ” 
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
Axiom proof_of_sample_safety_wit_12 : sample_safety_wit_12.
Axiom proof_of_sample_safety_wit_13 : sample_safety_wit_13.
Axiom proof_of_sample_safety_wit_14 : sample_safety_wit_14.
Axiom proof_of_sample_safety_wit_15 : sample_safety_wit_15.
Axiom proof_of_sample_safety_wit_16 : sample_safety_wit_16.
Axiom proof_of_sample_safety_wit_17 : sample_safety_wit_17.
Axiom proof_of_sample_safety_wit_18 : sample_safety_wit_18.
Axiom proof_of_sample_safety_wit_19 : sample_safety_wit_19.
Axiom proof_of_sample_safety_wit_20 : sample_safety_wit_20.
Axiom proof_of_sample_safety_wit_21 : sample_safety_wit_21.
Axiom proof_of_sample_safety_wit_22 : sample_safety_wit_22.
Axiom proof_of_sample_safety_wit_23 : sample_safety_wit_23.
Axiom proof_of_sample_safety_wit_24 : sample_safety_wit_24.
Axiom proof_of_sample_safety_wit_25 : sample_safety_wit_25.
Axiom proof_of_sample_safety_wit_26 : sample_safety_wit_26.
Axiom proof_of_sample_safety_wit_27 : sample_safety_wit_27.
Axiom proof_of_sample_safety_wit_28 : sample_safety_wit_28.
Axiom proof_of_sample_safety_wit_29 : sample_safety_wit_29.
Axiom proof_of_sample_safety_wit_30 : sample_safety_wit_30.
Axiom proof_of_sample_safety_wit_31 : sample_safety_wit_31.
Axiom proof_of_sample_safety_wit_32 : sample_safety_wit_32.
Axiom proof_of_sample_safety_wit_33 : sample_safety_wit_33.
Axiom proof_of_sample_safety_wit_34 : sample_safety_wit_34.
Axiom proof_of_sample_safety_wit_35 : sample_safety_wit_35.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_partial_solve_wit_1 : sample_partial_solve_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
