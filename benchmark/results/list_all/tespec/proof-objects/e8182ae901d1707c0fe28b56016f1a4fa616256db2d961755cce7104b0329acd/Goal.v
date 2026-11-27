From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append -----*)

Definition IntList_append_safety_wit_1 :=
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y <> 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y <> 0)),
  ((( &( "ys_spec_571" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_570" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_554" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_552" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_2 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : False),
  ((( &( "ys_spec_571" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_570" ) )) # Ptr  |-> 0)
  **  ((( &( "new_tail_spec_554" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_552" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_append_safety_wit_3 :=
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_4 <> 0)) (PreH3 : (y_3 <> 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)),
  ((( &( "ys_spec_552" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_append_safety_wit_4 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_552" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_551" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_append_safety_wit_5 :=
  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_append_safety_wit_6 :=
forall (PreH1 : False),
  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_append_entail_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_5 = 0)) (PreH4 : (y_5 = 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH16 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = ys_pre) ”
  &&  “ (y <> 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (app ((@nil Z)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_entail_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_5 = 0)) (PreH4 : (y_5 = 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH16 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (app ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_append_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_5 = 0)) (PreH4 : (y_5 = 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH16 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll xs_pre (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append_partial_solve_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (ys_pre <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH7 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z),
  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_append_partial_solve_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (ys_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 16384)) (PreH13 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons ((-1)) ((@nil Z))) )
  **  (sll ys_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_append_partial_solve_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y <> 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_5 = 0)) (PreH4 : (y_4 <> 0)) (PreH5 : (y_3 <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (ys_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (ys_pre = 16384)) (PreH14 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH15 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
|--
  “ (y <> 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y_2 (@nil Z) )
  **  (sll ys_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_501" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_486" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_append_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
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
Axiom proof_of_IntList_append_entail_wit_2 : IntList_append_entail_wit_2.
Axiom proof_of_IntList_append_return_wit_1 : IntList_append_return_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_1 : IntList_append_partial_solve_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_2 : IntList_append_partial_solve_wit_2.
Axiom proof_of_IntList_append_partial_solve_wit_3 : IntList_append_partial_solve_wit_3.
Axiom proof_of_IntList_append_precondition_wit_1 : IntList_append_precondition_wit_1.

End VC_Correct.
