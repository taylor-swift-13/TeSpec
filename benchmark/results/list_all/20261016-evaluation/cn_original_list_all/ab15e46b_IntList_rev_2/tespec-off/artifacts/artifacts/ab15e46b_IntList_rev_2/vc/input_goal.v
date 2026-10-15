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

(*----- Function IntList_rev -----*)

Definition IntList_rev_safety_wit_1 := 
  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_2 := 
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) ,
  ((( &( "ys_spec_559" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_558" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_545" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_542" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_541" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_3 := 
forall (y: Z) (PreH1 : False) ,
  ((( &( "ys_spec_559" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_558" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_545" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_542" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_541" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_safety_wit_4 := 
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) ,
  ((( &( "ys_spec_542" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_541" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_5 := 
  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_6 := 
forall (PreH1 : False) ,
  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_479" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_rev_entail_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
|--
  EX (retval: Z) ,
  “ (retval = y) ” 
  &&  “ (y <> 0) ” 
  &&  “ (y_2 = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (app ((rev ((@nil Z)))) ((cons ((-1)) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_entail_wit_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z) ,
  “ (retval = y) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (app ((rev (l___tespec_entry))) ((@nil Z))) )
.

Definition IntList_rev_entail_wit_3 := 
(
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
|--
  EX (retval: Z) ,
  “ (retval = xs_pre) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (app ((rev (l___tespec_entry))) ((@nil Z))) )
) \/
(
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
|--
  “ (xs_pre <> 0) ” 
  &&  “ ((app ((rev (l___tespec_entry))) ((@nil Z))) = (cons (2) ((@nil Z)))) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  emp
).

Definition IntList_rev_entail_wit_3_split_goal_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
|--
  “ (xs_pre <> 0) ”
.

Definition IntList_rev_entail_wit_3_split_goal_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
|--
  “ ((app ((rev (l___tespec_entry))) ((@nil Z))) = (cons (2) ((@nil Z)))) ”
.

Definition IntList_rev_entail_wit_3_split_goal_3 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
|--
  “ (xs_pre = 8192) ”
.

Definition IntList_rev_entail_wit_3_split_goal_4 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
|--
  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
.

Definition IntList_rev_entail_wit_3_split_goal_spatial := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
|--
  TT && emp 
.

Definition IntList_rev_return_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll y (rev (l___tespec_entry)) )
.

Definition IntList_rev_return_wit_2 := 
(
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll xs_pre (rev (l___tespec_entry)) )
) \/
(
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  “ (xs_pre <> 0) ” 
  &&  “ ((rev (l___tespec_entry)) = (cons (2) ((@nil Z)))) ”
  &&  emp
).

Definition IntList_rev_return_wit_2_split_goal_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  “ (xs_pre <> 0) ”
.

Definition IntList_rev_return_wit_2_split_goal_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  “ ((rev (l___tespec_entry)) = (cons (2) ((@nil Z)))) ”
.

Definition IntList_rev_return_wit_2_split_goal_spatial := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : ((-1) >= INT_MIN)) (PreH3 : (y = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
|--
  TT && emp 
.

Definition IntList_rev_partial_solve_wit_1 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (xs_pre = 8192)) (PreH2 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (sll xs_pre l___tespec_entry )
|--
  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll 0 (@nil Z) )
  **  (sll xs_pre l___tespec_entry )
.

Definition IntList_rev_partial_solve_wit_2 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
|--
  “ (y <> 0) ” 
  &&  “ (y_2 = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (cons ((-1)) ((cons (2) ((@nil Z))))) )
  **  (sll y_2 (@nil Z) )
  **  ((( &( "tmp_spec_528" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_partial_solve_wit_3 := 
forall (xs_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) ,
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z)  (y_2: Z) ,
  “ (y_2 = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_rev_precondition_wit_1 :=
exists (xs_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_safety_wit_1 : IntList_rev_safety_wit_1.
Axiom proof_of_IntList_rev_safety_wit_2 : IntList_rev_safety_wit_2.
Axiom proof_of_IntList_rev_safety_wit_3 : IntList_rev_safety_wit_3.
Axiom proof_of_IntList_rev_safety_wit_4 : IntList_rev_safety_wit_4.
Axiom proof_of_IntList_rev_safety_wit_5 : IntList_rev_safety_wit_5.
Axiom proof_of_IntList_rev_safety_wit_6 : IntList_rev_safety_wit_6.
Axiom proof_of_IntList_rev_entail_wit_1 : IntList_rev_entail_wit_1.
Axiom proof_of_IntList_rev_entail_wit_2 : IntList_rev_entail_wit_2.
Axiom proof_of_IntList_rev_entail_wit_3 : IntList_rev_entail_wit_3.
Axiom proof_of_IntList_rev_return_wit_1 : IntList_rev_return_wit_1.
Axiom proof_of_IntList_rev_return_wit_2 : IntList_rev_return_wit_2.
Axiom proof_of_IntList_rev_partial_solve_wit_1 : IntList_rev_partial_solve_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_2 : IntList_rev_partial_solve_wit_2.
Axiom proof_of_IntList_rev_partial_solve_wit_3 : IntList_rev_partial_solve_wit_3.
Axiom proof_of_IntList_rev_precondition_wit_1 : IntList_rev_precondition_wit_1.

End VC_Correct.
