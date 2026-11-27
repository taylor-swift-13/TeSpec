From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_ec5eb2e77309e00519b44a2d.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append -----*)

Definition IntList_append_safety_wit_1 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)),
  ((( &( "ys_spec_709" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_708" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_701" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_699" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_698" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_2 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_709" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_708" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_701" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_699" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_698" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntList_append_safety_wit_3 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  ((( &( "ys_spec_699" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_698" ) )) # Ptr  |-> y_2)
  **  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_4 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_699" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_698" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntList_append_safety_wit_5 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  ((( &( "ys_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_6 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_686" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntList_append_safety_wit_7 :=
  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_append_safety_wit_8 :=
forall (PreH1 : False),
  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_append_entail_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (ys_pre = 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 0)) (PreH13 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH14 : (b___tespec_entry = (@nil Z))),
  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = ys_pre) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll retval (app ((@nil Z)) ((@nil Z))) )
  **  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_entail_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (ys_pre = 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 0)) (PreH13 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH14 : (b___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll retval (app ((cons ((INT_MIN)) ((@nil Z)))) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_entail_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (ys_pre = 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 0)) (PreH13 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH14 : (b___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll retval (app ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_append_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (ys_pre = 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 0)) (PreH13 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH14 : (b___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  (sll xs_pre (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append_partial_solve_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (ys_pre = 0)) (PreH5 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (b___tespec_entry = (@nil Z))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
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
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (ys_pre = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (sll ys_pre (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_append_partial_solve_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (ys_pre = 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 0)) (PreH11 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (b___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
|--
  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  (sll ys_pre (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_partial_solve_wit_4 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (ys_pre = 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (ys_pre = 0)) (PreH12 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (b___tespec_entry = (@nil Z))),
  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
|--
  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll y_3 (@nil Z) )
  **  (sll ys_pre (@nil Z) )
  **  ((( &( "new_tail_spec_688" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_686" ) )) # Ptr  |-> ys_pre)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
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
Axiom proof_of_IntList_append_safety_wit_7 : IntList_append_safety_wit_7.
Axiom proof_of_IntList_append_safety_wit_8 : IntList_append_safety_wit_8.
Axiom proof_of_IntList_append_entail_wit_1 : IntList_append_entail_wit_1.
Axiom proof_of_IntList_append_entail_wit_2 : IntList_append_entail_wit_2.
Axiom proof_of_IntList_append_entail_wit_3 : IntList_append_entail_wit_3.
Axiom proof_of_IntList_append_return_wit_1 : IntList_append_return_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_1 : IntList_append_partial_solve_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_2 : IntList_append_partial_solve_wit_2.
Axiom proof_of_IntList_append_partial_solve_wit_3 : IntList_append_partial_solve_wit_3.
Axiom proof_of_IntList_append_partial_solve_wit_4 : IntList_append_partial_solve_wit_4.
Axiom proof_of_IntList_append_precondition_wit_1 : IntList_append_precondition_wit_1.

End VC_Correct.
