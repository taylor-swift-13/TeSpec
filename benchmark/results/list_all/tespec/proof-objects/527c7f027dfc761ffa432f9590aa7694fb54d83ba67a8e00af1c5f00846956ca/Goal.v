From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append2 -----*)

Definition IntList_append2_safety_wit_1 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y = 0)) (PreH4 : (y_2 <> 0)),
  ((( &( "xs_spec_566" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_561" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> 16384)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_2 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)),
  ((( &( "xs_spec_566" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_561" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> 16384)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_3 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_566" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_561" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_559" ) )) # Ptr  |-> y)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> 16384)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_append2_safety_wit_4 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)),
  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> 16384)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_5 :=
forall (PreH1 : False),
  ((( &( "xs_spec_559" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> 16384)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_append2_safety_wit_6 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)),
  ((( &( "xs_spec_551" ) )) # Ptr  |-> 16384)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_7 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : False),
  ((( &( "xs_spec_551" ) )) # Ptr  |-> 16384)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_append2_safety_wit_8 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y = 0)),
  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_9 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_540" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_append2_safety_wit_10 :=
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_11 :=
forall (PreH1 : False),
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_append2_entail_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (retval_2: Z) (retval_4: Z) (PreH1 : (retval_4 <> 0)) (PreH2 : (retval_2 <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (y = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y = 0)) (PreH12 : (y = 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH19 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH20 : (0 <= retval)) (PreH21 : (retval <= UINT_MAX)) (PreH22 : (0 <= retval_2)) (PreH23 : (retval_2 <= UINT_MAX)) (PreH24 : (0 <= retval_4)) (PreH25 : (retval_4 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_4 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_4 + 4)) # Ptr  |-> retval_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval_3: Z),
  “ (retval_3 = retval_4) ”
  &&  “ (retval_2 <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  “ (0 <= retval_2) ”
  &&  “ (retval_2 <= UINT_MAX) ”
  &&  (sll retval_3 (cons (1) ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_entail_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (retval_3: Z) (PreH1 : (retval_3 <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (y = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y = 0)) (PreH11 : (y = 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (ys_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (ys_pre = 16384)) (PreH17 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH18 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (0 <= retval)) (PreH20 : (retval <= UINT_MAX)) (PreH21 : (0 <= retval_3)) (PreH22 : (retval_3 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_3 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_3 + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval_2: Z),
  “ (retval_2 = retval_3) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (sll retval_2 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_entail_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y = 0)) (PreH10 : (y = 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (xs_pre = 8192)) (PreH15 : (ys_pre = 16384)) (PreH16 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH17 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH18 : (0 <= retval_2)) (PreH19 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (cons ((-1)) ((@nil Z))) )
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_entail_wit_4 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y = 0)) (PreH9 : (y = 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH16 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (@nil Z) )
  **  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_entail_wit_5 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y = 0)) (PreH9 : (y = 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH16 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y_3 (@nil Z) )
  **  (sll retval (@nil Z) )
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_entail_wit_6 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y = 0)) (PreH10 : (y = 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (xs_pre = 8192)) (PreH15 : (ys_pre = 16384)) (PreH16 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH17 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH18 : (0 <= retval_2)) (PreH19 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y_2 (cons ((-1)) ((@nil Z))) )
  **  (sll retval (cons ((-1)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_entail_wit_7 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_3: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (retval_3 <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (y = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y = 0)) (PreH11 : (y = 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (ys_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (ys_pre = 16384)) (PreH17 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH18 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (0 <= retval_3)) (PreH20 : (retval_3 <= UINT_MAX)) (PreH21 : (0 <= retval_2)) (PreH22 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> retval_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_3 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_3 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll retval (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_entail_wit_8 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_3: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (retval_3 <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (y = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y = 0)) (PreH11 : (y = 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (ys_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (ys_pre = 16384)) (PreH17 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH18 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (0 <= retval_3)) (PreH20 : (retval_3 <= UINT_MAX)) (PreH21 : (0 <= retval_2)) (PreH22 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> retval_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_3 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_3 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (@nil Z) )
  **  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll retval (app ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (retval_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (retval_3 <> 0)) (PreH3 : (retval_2 <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (y = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y = 0)) (PreH12 : (y = 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH19 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH20 : (0 <= retval_2)) (PreH21 : (retval_2 <= UINT_MAX)) (PreH22 : (0 <= retval_3)) (PreH23 : (retval_3 <= UINT_MAX)) (PreH24 : (0 <= retval)) (PreH25 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_3 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_3 + 4)) # Ptr  |-> retval_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
  **  (sll retval (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append2_partial_solve_wit_1_pure :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (y = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y = 0)) (PreH11 : (y = 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (ys_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (ys_pre = 16384)) (PreH17 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH18 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (0 <= retval)) (PreH20 : (retval <= UINT_MAX)) (PreH21 : (0 <= retval_2)) (PreH22 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |-> retval_2)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (1 = 1) ”
.

Definition IntList_append2_partial_solve_wit_1_aux :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (y = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y = 0)) (PreH11 : (y = 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (ys_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (ys_pre = 16384)) (PreH17 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH18 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (0 <= retval)) (PreH20 : (retval <= UINT_MAX)) (PreH21 : (0 <= retval_2)) (PreH22 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (1 = 1) ”
  &&  “ (retval_2 <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  “ (0 <= retval_2) ”
  &&  “ (retval_2 <= UINT_MAX) ”
  &&  (sll retval_2 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_1 := IntList_append2_partial_solve_wit_1_pure -> IntList_append2_partial_solve_wit_1_aux.

Definition IntList_append2_partial_solve_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (ys_pre <> 0)) (PreH6 : (y = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y = 0)) (PreH11 : (y = 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (ys_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (ys_pre = 16384)) (PreH17 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH18 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (0 <= retval)) (PreH20 : (retval <= UINT_MAX)) (PreH21 : (0 <= retval_2)) (PreH22 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (retval_2 <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  “ (0 <= retval_2) ”
  &&  “ (retval_2 <= UINT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (ys_pre <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_4 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (ys_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 16384)) (PreH11 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH12 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (@nil Z) )
  **  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_5 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y = 0)) (PreH6 : (y = 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (ys_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (ys_pre = 16384)) (PreH12 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH13 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_partial_solve_wit_6_pure :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y = 0)) (PreH10 : (y = 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (xs_pre = 8192)) (PreH15 : (ys_pre = 16384)) (PreH16 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH17 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH18 : (0 <= retval)) (PreH19 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (2 = 2) ”
.

Definition IntList_append2_partial_solve_wit_6_aux :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y = 0)) (PreH10 : (y = 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (xs_pre = 8192)) (PreH15 : (ys_pre = 16384)) (PreH16 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH17 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH18 : (0 <= retval)) (PreH19 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (2 = 2) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (sll retval (cons ((-1)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_partial_solve_wit_6 := IntList_append2_partial_solve_wit_6_pure -> IntList_append2_partial_solve_wit_6_aux.

Definition IntList_append2_partial_solve_wit_7 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (ys_pre <> 0)) (PreH5 : (y = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y = 0)) (PreH10 : (y = 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (xs_pre = 8192)) (PreH15 : (ys_pre = 16384)) (PreH16 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH17 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH18 : (0 <= retval)) (PreH19 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_partial_solve_wit_8 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (ys_pre <> 0)) (PreH2 : (y = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y = 0)) (PreH7 : (y = 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (ys_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 16384)) (PreH13 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH14 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y_2 (cons ((-1)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_partial_solve_wit_9_pure :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y = 0)) (PreH9 : (y = 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH16 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((( &( "new_tail_spec_561" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "ys_spec_540" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_539" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ ((-1) = (-1)) ”
.

Definition IntList_append2_partial_solve_wit_9_aux :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y = 0)) (PreH9 : (y = 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH16 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ ((-1) = (-1)) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll 0 (@nil Z) )
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_partial_solve_wit_9 := IntList_append2_partial_solve_wit_9_pure -> IntList_append2_partial_solve_wit_9_aux.

Definition IntList_append2_partial_solve_wit_10 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y = 0)) (PreH9 : (y = 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH16 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_partial_solve_wit_11 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (ys_pre <> 0)) (PreH3 : (y = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y = 0)) (PreH8 : (y = 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (ys_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (ys_pre = 16384)) (PreH14 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH15 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y_3 (@nil Z) )
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_partial_solve_wit_12 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y = 0)) (PreH9 : (y = 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH16 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  ((( &( "xs_spec_559" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_445" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append2_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
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
Axiom proof_of_IntList_append2_safety_wit_8 : IntList_append2_safety_wit_8.
Axiom proof_of_IntList_append2_safety_wit_9 : IntList_append2_safety_wit_9.
Axiom proof_of_IntList_append2_safety_wit_10 : IntList_append2_safety_wit_10.
Axiom proof_of_IntList_append2_safety_wit_11 : IntList_append2_safety_wit_11.
Axiom proof_of_IntList_append2_entail_wit_1 : IntList_append2_entail_wit_1.
Axiom proof_of_IntList_append2_entail_wit_2 : IntList_append2_entail_wit_2.
Axiom proof_of_IntList_append2_entail_wit_3 : IntList_append2_entail_wit_3.
Axiom proof_of_IntList_append2_entail_wit_4 : IntList_append2_entail_wit_4.
Axiom proof_of_IntList_append2_entail_wit_5 : IntList_append2_entail_wit_5.
Axiom proof_of_IntList_append2_entail_wit_6 : IntList_append2_entail_wit_6.
Axiom proof_of_IntList_append2_entail_wit_7 : IntList_append2_entail_wit_7.
Axiom proof_of_IntList_append2_entail_wit_8 : IntList_append2_entail_wit_8.
Axiom proof_of_IntList_append2_return_wit_1 : IntList_append2_return_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_1_pure : IntList_append2_partial_solve_wit_1_pure.
Axiom proof_of_IntList_append2_partial_solve_wit_1 : IntList_append2_partial_solve_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_2 : IntList_append2_partial_solve_wit_2.
Axiom proof_of_IntList_append2_partial_solve_wit_3 : IntList_append2_partial_solve_wit_3.
Axiom proof_of_IntList_append2_partial_solve_wit_4 : IntList_append2_partial_solve_wit_4.
Axiom proof_of_IntList_append2_partial_solve_wit_5 : IntList_append2_partial_solve_wit_5.
Axiom proof_of_IntList_append2_partial_solve_wit_6_pure : IntList_append2_partial_solve_wit_6_pure.
Axiom proof_of_IntList_append2_partial_solve_wit_6 : IntList_append2_partial_solve_wit_6.
Axiom proof_of_IntList_append2_partial_solve_wit_7 : IntList_append2_partial_solve_wit_7.
Axiom proof_of_IntList_append2_partial_solve_wit_8 : IntList_append2_partial_solve_wit_8.
Axiom proof_of_IntList_append2_partial_solve_wit_9_pure : IntList_append2_partial_solve_wit_9_pure.
Axiom proof_of_IntList_append2_partial_solve_wit_9 : IntList_append2_partial_solve_wit_9.
Axiom proof_of_IntList_append2_partial_solve_wit_10 : IntList_append2_partial_solve_wit_10.
Axiom proof_of_IntList_append2_partial_solve_wit_11 : IntList_append2_partial_solve_wit_11.
Axiom proof_of_IntList_append2_partial_solve_wit_12 : IntList_append2_partial_solve_wit_12.
Axiom proof_of_IntList_append2_precondition_wit_1 : IntList_append2_precondition_wit_1.

End VC_Correct.
