From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append2 -----*)

Definition IntList_append2_safety_wit_1 :=
forall (y: Z) (PreH1 : (y = 0)),
  ((( &( "xs_spec_532" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_2 :=
forall (y: Z) (PreH1 : (y = 0)),
  ((( &( "xs_spec_532" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_3 :=
forall (PreH1 : False),
  ((( &( "xs_spec_532" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_append2_safety_wit_4 :=
  ((( &( "xs_spec_522" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_5 :=
forall (PreH1 : False),
  ((( &( "xs_spec_522" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_append2_safety_wit_6 :=
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_7 :=
forall (PreH1 : False),
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_append2_entail_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (xs_pre = 0)) (PreH8 : (ys_pre = 16384)) (PreH9 : (a___tespec_entry = (@nil Z))) (PreH10 : (b___tespec_entry = (cons (1) ((@nil Z))))) (PreH11 : (0 <= retval_2)) (PreH12 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll retval (cons (1) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_entail_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (ys_pre = 16384)) (PreH8 : (a___tespec_entry = (@nil Z))) (PreH9 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll retval (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_entail_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (ys_pre = 16384)) (PreH8 : (a___tespec_entry = (@nil Z))) (PreH9 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll y (@nil Z) )
  **  (sll retval (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_entail_wit_4 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (xs_pre = 0)) (PreH8 : (ys_pre = 16384)) (PreH9 : (a___tespec_entry = (@nil Z))) (PreH10 : (b___tespec_entry = (cons (1) ((@nil Z))))) (PreH11 : (0 <= retval_2)) (PreH12 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll ys_pre b___tespec_entry )
  **  (sll retval b___tespec_entry )
.

Definition IntList_append2_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (xs_pre = 0)) (PreH8 : (ys_pre = 16384)) (PreH9 : (a___tespec_entry = (@nil Z))) (PreH10 : (b___tespec_entry = (cons (1) ((@nil Z))))) (PreH11 : (0 <= retval)) (PreH12 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
  **  (sll retval (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append2_partial_solve_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre = 16384)) (PreH4 : (a___tespec_entry = (@nil Z))) (PreH5 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll ys_pre b___tespec_entry )
.

Definition IntList_append2_partial_solve_wit_2_pure :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (ys_pre = 16384)) (PreH8 : (a___tespec_entry = (@nil Z))) (PreH9 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (1 = 1) ”
.

Definition IntList_append2_partial_solve_wit_2_aux :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (ys_pre = 16384)) (PreH8 : (a___tespec_entry = (@nil Z))) (PreH9 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  “ (1 = 1) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll 0 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_2 := IntList_append2_partial_solve_wit_2_pure -> IntList_append2_partial_solve_wit_2_aux.

Definition IntList_append2_partial_solve_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (ys_pre = 16384)) (PreH8 : (a___tespec_entry = (@nil Z))) (PreH9 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_4 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre = 16384)) (PreH5 : (a___tespec_entry = (@nil Z))) (PreH6 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z),
  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_5 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (ys_pre = 16384)) (PreH7 : (a___tespec_entry = (@nil Z))) (PreH8 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_6 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (xs_pre = 0)) (PreH6 : (xs_pre = 0)) (PreH7 : (ys_pre = 16384)) (PreH8 : (a___tespec_entry = (@nil Z))) (PreH9 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> ys_pre)
|--
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_522" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_append2_safety_wit_1 : IntList_append2_safety_wit_1.
Axiom proof_of_IntList_append2_safety_wit_2 : IntList_append2_safety_wit_2.
Axiom proof_of_IntList_append2_safety_wit_3 : IntList_append2_safety_wit_3.
Axiom proof_of_IntList_append2_safety_wit_4 : IntList_append2_safety_wit_4.
Axiom proof_of_IntList_append2_safety_wit_5 : IntList_append2_safety_wit_5.
Axiom proof_of_IntList_append2_safety_wit_6 : IntList_append2_safety_wit_6.
Axiom proof_of_IntList_append2_safety_wit_7 : IntList_append2_safety_wit_7.
Axiom proof_of_IntList_append2_entail_wit_1 : IntList_append2_entail_wit_1.
Axiom proof_of_IntList_append2_entail_wit_2 : IntList_append2_entail_wit_2.
Axiom proof_of_IntList_append2_entail_wit_3 : IntList_append2_entail_wit_3.
Axiom proof_of_IntList_append2_entail_wit_4 : IntList_append2_entail_wit_4.
Axiom proof_of_IntList_append2_return_wit_1 : IntList_append2_return_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_1 : IntList_append2_partial_solve_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_2_pure : IntList_append2_partial_solve_wit_2_pure.
Axiom proof_of_IntList_append2_partial_solve_wit_2 : IntList_append2_partial_solve_wit_2.
Axiom proof_of_IntList_append2_partial_solve_wit_3 : IntList_append2_partial_solve_wit_3.
Axiom proof_of_IntList_append2_partial_solve_wit_4 : IntList_append2_partial_solve_wit_4.
Axiom proof_of_IntList_append2_partial_solve_wit_5 : IntList_append2_partial_solve_wit_5.
Axiom proof_of_IntList_append2_partial_solve_wit_6 : IntList_append2_partial_solve_wit_6.
Axiom proof_of_IntList_append2_precondition_wit_1 : IntList_append2_precondition_wit_1.

End VC_Correct.
