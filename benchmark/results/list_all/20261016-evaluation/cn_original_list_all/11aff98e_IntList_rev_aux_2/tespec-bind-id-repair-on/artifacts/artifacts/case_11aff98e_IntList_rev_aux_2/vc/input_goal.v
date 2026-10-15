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
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev_aux -----*)

Definition IntList_rev_aux_safety_wit_1 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_4 <> 0)) (PreH2 : (y_3 <> 0)) (PreH3 : (y_5 = 0)) (PreH4 : (y_2 = 0)) ,
  ((( &( "ys_spec_702" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_701" ) )) # Ptr  |-> y_4)
  **  ((( &( "tmp_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_683" ) )) # Ptr  |-> y_4)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y_3)
  **  ((( &( "tmp_spec_670" ) )) # Ptr  |-> y_4)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> y_3)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_650" ) )) # Ptr  |-> y_3)
  **  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_2 := 
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : False) ,
  ((( &( "ys_spec_702" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_701" ) )) # Ptr  |-> y_3)
  **  ((( &( "tmp_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_683" ) )) # Ptr  |-> y_3)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y_2)
  **  ((( &( "tmp_spec_670" ) )) # Ptr  |-> y_3)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_650" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_rev_aux_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_3 <> 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_2 = 0)) ,
  ((( &( "ys_spec_683" ) )) # Ptr  |-> y_4)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y_3)
  **  ((( &( "tmp_spec_670" ) )) # Ptr  |-> y_4)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> y_3)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_650" ) )) # Ptr  |-> y_3)
  **  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_2 = 0)) ,
  ((( &( "ys_spec_667" ) )) # Ptr  |-> y_3)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 16384)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_650" ) )) # Ptr  |-> y_3)
  **  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_5 := 
  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_6 := 
forall (PreH1 : False) ,
  ((( &( "xs_spec_469" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_466" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_rev_aux_return_wit_1 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y_2: Z) (y_3: Z) (y_4: Z) (y: Z) (y_5: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_5 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (ys_pre = 16384)) (PreH9 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH10 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll y (app ((rev (b___tespec_entry))) (a___tespec_entry)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y_2: Z) (y_3: Z) (y_4: Z) (y: Z) (y_5: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : ((-1) <= INT_MAX)) (PreH3 : (2 >= INT_MIN)) (PreH4 : ((-1) >= INT_MIN)) (PreH5 : (y_5 = 0)) (PreH6 : (y <> 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_5 = 0)) (PreH9 : (y_3 = 0)) (PreH10 : (ys_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 16384)) (PreH13 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (l0: (@list Z)) ,
  “ (ys_pre <> 0) ” 
  &&  “ (y_4 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ ((app ((rev (b___tespec_entry))) (a___tespec_entry)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) (l0))))))) ”
  &&  (sll xs_pre l0 )
).

Definition IntList_rev_aux_return_wit_2 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y_2: Z) (y_3: Z) (y: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_4 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_5 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (ys_pre = 16384)) (PreH8 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH9 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ,
  ((( &( "tmp_spec_670" ) )) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll y (app ((rev (b___tespec_entry))) (a___tespec_entry)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y_2: Z) (y_3: Z) (y: Z) (y_4: Z) (y_5: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : ((-1) <= INT_MAX)) (PreH3 : ((INT_MIN) <= INT_MAX)) (PreH4 : (2 >= INT_MIN)) (PreH5 : ((-1) >= INT_MIN)) (PreH6 : ((INT_MIN) >= INT_MIN)) (PreH7 : (y_4 = 0)) (PreH8 : (y <> 0)) (PreH9 : (y_5 = 0)) (PreH10 : (y_3 = 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (ys_pre = 16384)) (PreH14 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH15 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ,
  ((( &( "tmp_spec_670" ) )) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (l0: (@list Z)) ,
  “ (ys_pre <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ ((app ((rev (b___tespec_entry))) (a___tespec_entry)) = (cons (0) ((cons (INT_MAX) (l0))))) ”
  &&  (sll xs_pre l0 )
).

Definition IntList_rev_aux_return_wit_3 := 
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_2 = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (ys_pre = 16384)) (PreH7 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH8 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll ys_pre (app ((rev (b___tespec_entry))) (a___tespec_entry)) )
) \/
(
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : ((-1) <= INT_MAX)) (PreH3 : (0 <= INT_MAX)) (PreH4 : ((INT_MIN) <= INT_MAX)) (PreH5 : (2 >= INT_MIN)) (PreH6 : ((-1) >= INT_MIN)) (PreH7 : (0 >= INT_MIN)) (PreH8 : ((INT_MIN) >= INT_MIN)) (PreH9 : (y_3 = 0)) (PreH10 : (y_5 = 0)) (PreH11 : (y_2 = 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH16 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ,
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (l0: (@list Z)) ,
  “ (ys_pre <> 0) ” 
  &&  “ ((app ((rev (b___tespec_entry))) (a___tespec_entry)) = (cons (INT_MAX) (l0))) ”
  &&  (sll xs_pre l0 )
).

Definition IntList_rev_aux_partial_solve_wit_1 := 
forall (ys_pre: Z) (xs_pre: Z) (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (ys_pre = 16384)) (PreH4 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH5 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ,
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z)  (y_4: Z)  (y_5: Z) ,
  “ (y_5 = 0) ” 
  &&  “ (y_2 = 0) ” 
  &&  “ (ys_pre <> 0) ” 
  &&  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ” 
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_rev_aux_precondition_wit_1 :=
exists (ys_pre: Z) ,
exists (xs_pre: Z) ,
exists (b___tespec_entry: (@list Z)) ,
exists (a___tespec_entry: (@list Z)) ,
~ ((  “ (xs_pre = 8192) ” 
  &&  “ (ys_pre = 16384) ” 
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ” 
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_aux_safety_wit_1 : IntList_rev_aux_safety_wit_1.
Axiom proof_of_IntList_rev_aux_safety_wit_2 : IntList_rev_aux_safety_wit_2.
Axiom proof_of_IntList_rev_aux_safety_wit_3 : IntList_rev_aux_safety_wit_3.
Axiom proof_of_IntList_rev_aux_safety_wit_4 : IntList_rev_aux_safety_wit_4.
Axiom proof_of_IntList_rev_aux_safety_wit_5 : IntList_rev_aux_safety_wit_5.
Axiom proof_of_IntList_rev_aux_safety_wit_6 : IntList_rev_aux_safety_wit_6.
Axiom proof_of_IntList_rev_aux_return_wit_1 : IntList_rev_aux_return_wit_1.
Axiom proof_of_IntList_rev_aux_return_wit_2 : IntList_rev_aux_return_wit_2.
Axiom proof_of_IntList_rev_aux_return_wit_3 : IntList_rev_aux_return_wit_3.
Axiom proof_of_IntList_rev_aux_partial_solve_wit_1 : IntList_rev_aux_partial_solve_wit_1.
Axiom proof_of_IntList_rev_aux_precondition_wit_1 : IntList_rev_aux_precondition_wit_1.

End VC_Correct.
