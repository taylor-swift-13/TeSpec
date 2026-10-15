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

(*----- Function IntList_append -----*)

Definition IntList_append_safety_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) ,
  ((( &( "ys_spec_556" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_555" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_548" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_545" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_544" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_538" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_535" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_2 := 
forall (y: Z) (y_2: Z) (PreH1 : False) ,
  ((( &( "ys_spec_556" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_555" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_548" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_545" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_544" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_538" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_535" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntList_append_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) ,
  ((( &( "ys_spec_545" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_544" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_538" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_535" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) ,
  ((( &( "ys_spec_535" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_5 := 
  ((( &( "xs_spec_491" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_append_safety_wit_6 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_491" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_append_entail_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (ys_pre = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (ys_pre = 0)) (PreH9 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_535" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z) ,
  “ (retval = ys_pre) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (y_3 = 0) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll retval (app ((@nil Z)) ((@nil Z))) )
  **  ((( &( "new_tail_spec_538" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_535" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_return_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (ys_pre = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (ys_pre = 0)) (PreH9 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (b___tespec_entry = (@nil Z))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  (sll xs_pre (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append_return_wit_2 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (ys_pre = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (ys_pre = 0)) (PreH8 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH9 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  (sll xs_pre (app (a___tespec_entry) (b___tespec_entry)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : ((INT_MIN) <= INT_MAX)) (PreH2 : ((INT_MIN) >= INT_MIN)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (ys_pre = 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
|--
  “ (y <> 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ ((app (a___tespec_entry) (b___tespec_entry)) = (cons (INT_MAX) ((cons (0) ((@nil Z)))))) ”
  &&  emp
).

Definition IntList_append_return_wit_2_split_goal_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : ((INT_MIN) <= INT_MAX)) (PreH2 : ((INT_MIN) >= INT_MIN)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (ys_pre = 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
|--
  “ (y <> 0) ”
.

Definition IntList_append_return_wit_2_split_goal_2 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : ((INT_MIN) <= INT_MAX)) (PreH2 : ((INT_MIN) >= INT_MIN)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (ys_pre = 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
|--
  “ (xs_pre <> 0) ”
.

Definition IntList_append_return_wit_2_split_goal_3 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : ((INT_MIN) <= INT_MAX)) (PreH2 : ((INT_MIN) >= INT_MIN)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (ys_pre = 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
|--
  “ ((app (a___tespec_entry) (b___tespec_entry)) = (cons (INT_MAX) ((cons (0) ((@nil Z)))))) ”
.

Definition IntList_append_return_wit_2_split_goal_spatial := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : ((INT_MIN) <= INT_MAX)) (PreH2 : ((INT_MIN) >= INT_MIN)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (ys_pre = 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
|--
  TT && emp 
.

Definition IntList_append_return_wit_3 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (ys_pre = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (ys_pre = 0)) (PreH7 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH8 : (b___tespec_entry = (@nil Z))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  (sll xs_pre (app (a___tespec_entry) (b___tespec_entry)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (0 <= INT_MAX)) (PreH2 : ((INT_MIN) <= INT_MAX)) (PreH3 : (0 >= INT_MIN)) (PreH4 : ((INT_MIN) >= INT_MIN)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (ys_pre = 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 0)) (PreH11 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (b___tespec_entry = (@nil Z))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
|--
  “ (xs_pre <> 0) ” 
  &&  “ ((app (a___tespec_entry) (b___tespec_entry)) = (cons (INT_MAX) ((@nil Z)))) ”
  &&  emp
).

Definition IntList_append_return_wit_3_split_goal_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (0 <= INT_MAX)) (PreH2 : ((INT_MIN) <= INT_MAX)) (PreH3 : (0 >= INT_MIN)) (PreH4 : ((INT_MIN) >= INT_MIN)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (ys_pre = 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 0)) (PreH11 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (b___tespec_entry = (@nil Z))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
|--
  “ (xs_pre <> 0) ”
.

Definition IntList_append_return_wit_3_split_goal_2 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (0 <= INT_MAX)) (PreH2 : ((INT_MIN) <= INT_MAX)) (PreH3 : (0 >= INT_MIN)) (PreH4 : ((INT_MIN) >= INT_MIN)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (ys_pre = 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 0)) (PreH11 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (b___tespec_entry = (@nil Z))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
|--
  “ ((app (a___tespec_entry) (b___tespec_entry)) = (cons (INT_MAX) ((@nil Z)))) ”
.

Definition IntList_append_return_wit_3_split_goal_spatial := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (0 <= INT_MAX)) (PreH2 : ((INT_MIN) <= INT_MAX)) (PreH3 : (0 >= INT_MIN)) (PreH4 : ((INT_MIN) >= INT_MIN)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (ys_pre = 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 0)) (PreH11 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (b___tespec_entry = (@nil Z))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
|--
  TT && emp 
.

Definition IntList_append_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (ys_pre = 0)) (PreH4 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH5 : (b___tespec_entry = (@nil Z))) ,
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z) ,
  “ (y_3 = 0) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_append_partial_solve_wit_2 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (ys_pre = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (ys_pre = 0)) (PreH8 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH9 : (b___tespec_entry = (@nil Z))) ,
  ((( &( "new_tail_spec_538" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_535" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> ys_pre)
|--
  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (y_3 = 0) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (xs_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll y_3 (@nil Z) )
  **  (sll ys_pre (@nil Z) )
  **  ((( &( "new_tail_spec_538" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_535" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_534" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_523" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_491" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_488" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_precondition_wit_1 :=
exists (ys_pre: Z) ,
exists (xs_pre: Z) ,
exists (b___tespec_entry: (@list Z)) ,
exists (a___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 0) ” 
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ” 
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_append_safety_wit_1 : IntList_append_safety_wit_1.
Axiom proof_of_IntList_append_safety_wit_2 : IntList_append_safety_wit_2.
Axiom proof_of_IntList_append_safety_wit_3 : IntList_append_safety_wit_3.
Axiom proof_of_IntList_append_safety_wit_4 : IntList_append_safety_wit_4.
Axiom proof_of_IntList_append_safety_wit_5 : IntList_append_safety_wit_5.
Axiom proof_of_IntList_append_safety_wit_6 : IntList_append_safety_wit_6.
Axiom proof_of_IntList_append_entail_wit_1 : IntList_append_entail_wit_1.
Axiom proof_of_IntList_append_return_wit_1 : IntList_append_return_wit_1.
Axiom proof_of_IntList_append_return_wit_2 : IntList_append_return_wit_2.
Axiom proof_of_IntList_append_return_wit_3 : IntList_append_return_wit_3.
Axiom proof_of_IntList_append_partial_solve_wit_1 : IntList_append_partial_solve_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_2 : IntList_append_partial_solve_wit_2.
Axiom proof_of_IntList_append_precondition_wit_1 : IntList_append_precondition_wit_1.

End VC_Correct.
