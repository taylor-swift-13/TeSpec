From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_merge -----*)

Definition IntList_merge_safety_wit_1 :=
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y <> 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y <> 0)),
  ((( &( "ys_spec_593" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_592" ) )) # Ptr  |-> 0)
  **  ((( &( "zs_spec_576" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_574" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_2 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : False),
  ((( &( "ys_spec_593" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_592" ) )) # Ptr  |-> 0)
  **  ((( &( "zs_spec_576" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_574" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_merge_safety_wit_3 :=
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_4 <> 0)) (PreH3 : (y_3 <> 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)),
  ((( &( "ys_spec_574" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_4 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_574" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_merge_safety_wit_5 :=
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y <> 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y <> 0)),
  ((( &( "ys_spec_574" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_6 :=
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : False),
  ((( &( "ys_spec_574" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_merge_safety_wit_7 :=
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : False),
  ((( &( "ys_spec_574" ) )) # Ptr  |-> 16384)
  **  ((( &( "xs_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (16384 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (16384 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
|--
  “ False ”
.

Definition IntList_merge_safety_wit_8 :=
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_9 :=
forall (PreH1 : False),
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_merge_safety_wit_10 :=
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_11 :=
forall (PreH1 : False),
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_merge_entail_wit_1 :=
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> ys_pre)
|--
  EX (retval: Z),
  “ (retval = ys_pre) ”
  &&  “ ((-1) < INT_MAX) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_merge ((@nil Z)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> ys_pre)
) \/
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ ((cn_merge ((@nil Z)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ ((-1) < INT_MAX) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_merge_entail_wit_1_split_goal_1 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_4 <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_2 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_3 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_4 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge ((@nil Z)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_merge_entail_wit_1_split_goal_5 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((-1) < INT_MAX)
.

Definition IntList_merge_entail_wit_1_split_goal_6 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_7 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_8 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_5 = 0)
.

Definition IntList_merge_entail_wit_1_split_goal_9 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_5 = 0)
.

Definition IntList_merge_entail_wit_1_split_goal_10 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_4 <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_11 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_12 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 = 0)
.

Definition IntList_merge_entail_wit_1_split_goal_13 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 = 0)
.

Definition IntList_merge_entail_wit_1_split_goal_14 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_15 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_16 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_17 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_18 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_merge_entail_wit_1_split_goal_19 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_merge_entail_wit_1_split_goal_20 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre = 16384)
.

Definition IntList_merge_entail_wit_1_split_goal_21 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))
.

Definition IntList_merge_entail_wit_1_split_goal_22 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_merge_entail_wit_2 :=
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
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
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_merge ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
) \/
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_merge ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons ((-1)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))))) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_merge_entail_wit_2_split_goal_1 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_4 <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_2 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_3 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_4 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_5 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons ((-1)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))
.

Definition IntList_merge_entail_wit_2_split_goal_6 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_5 = 0)
.

Definition IntList_merge_entail_wit_2_split_goal_7 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_5 = 0)
.

Definition IntList_merge_entail_wit_2_split_goal_8 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_4 <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_9 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_10 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 = 0)
.

Definition IntList_merge_entail_wit_2_split_goal_11 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 = 0)
.

Definition IntList_merge_entail_wit_2_split_goal_12 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_13 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_14 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_15 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_16 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_merge_entail_wit_2_split_goal_17 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_merge_entail_wit_2_split_goal_18 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre = 16384)
.

Definition IntList_merge_entail_wit_2_split_goal_19 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))
.

Definition IntList_merge_entail_wit_2_split_goal_20 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_merge_return_wit_1 :=
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> ys_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
|--
  (sll xs_pre (cn_merge (l___tespec_entry) (r___tespec_entry)) )
) \/
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ ((cn_merge (l___tespec_entry) (r___tespec_entry)) = (cons (2) ((cons ((-1)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))))))) ”
  &&  emp
).

Definition IntList_merge_return_wit_1_split_goal_1 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_4 <> 0)
.

Definition IntList_merge_return_wit_1_split_goal_2 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 <> 0)
.

Definition IntList_merge_return_wit_1_split_goal_3 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (ys_pre <> 0)
.

Definition IntList_merge_return_wit_1_split_goal_4 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_merge_return_wit_1_split_goal_5 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_merge_return_wit_1_split_goal_6 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_2 = 0)) (PreH2 : ((-1) < INT_MAX)) (PreH3 : (ys_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_5 = 0)) (PreH7 : (y_4 <> 0)) (PreH8 : (y_3 <> 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y <> 0)) (PreH12 : (ys_pre <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (ys_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (ys_pre = 16384)) (PreH18 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH19 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge (l___tespec_entry) (r___tespec_entry)) = (cons (2) ((cons ((-1)) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))))
.

Definition IntList_merge_partial_solve_wit_1 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (ys_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (ys_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (ys_pre = 16384)) (PreH14 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH15 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
|--
  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons ((-1)) ((@nil Z))) )
  **  (sll ys_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
.

Definition IntList_merge_partial_solve_wit_2 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : ((-1) < INT_MAX)) (PreH2 : (ys_pre <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_5 = 0)) (PreH5 : (y_5 = 0)) (PreH6 : (y_4 <> 0)) (PreH7 : (y_3 <> 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y_2 = 0)) (PreH10 : (y <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (ys_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (ys_pre = 16384)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH18 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> ys_pre)
|--
  “ ((-1) < INT_MAX) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y_2 (@nil Z) )
  **  (sll ys_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  ((( &( "zs_spec_513" ) )) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  ((( &( "xs_spec_498" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> ys_pre)
.

Definition IntList_merge_partial_solve_wit_3 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (ys_pre = 16384)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH8 : (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z),
  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
.

Definition IntList_merge_precondition_wit_1 :=
exists (r___tespec_entry: (@list Z)),
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (r___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_merge_safety_wit_1 : IntList_merge_safety_wit_1.
Axiom proof_of_IntList_merge_safety_wit_2 : IntList_merge_safety_wit_2.
Axiom proof_of_IntList_merge_safety_wit_3 : IntList_merge_safety_wit_3.
Axiom proof_of_IntList_merge_safety_wit_4 : IntList_merge_safety_wit_4.
Axiom proof_of_IntList_merge_safety_wit_5 : IntList_merge_safety_wit_5.
Axiom proof_of_IntList_merge_safety_wit_6 : IntList_merge_safety_wit_6.
Axiom proof_of_IntList_merge_safety_wit_7 : IntList_merge_safety_wit_7.
Axiom proof_of_IntList_merge_safety_wit_8 : IntList_merge_safety_wit_8.
Axiom proof_of_IntList_merge_safety_wit_9 : IntList_merge_safety_wit_9.
Axiom proof_of_IntList_merge_safety_wit_10 : IntList_merge_safety_wit_10.
Axiom proof_of_IntList_merge_safety_wit_11 : IntList_merge_safety_wit_11.
Axiom proof_of_IntList_merge_entail_wit_1 : IntList_merge_entail_wit_1.
Axiom proof_of_IntList_merge_entail_wit_2 : IntList_merge_entail_wit_2.
Axiom proof_of_IntList_merge_return_wit_1 : IntList_merge_return_wit_1.
Axiom proof_of_IntList_merge_partial_solve_wit_1 : IntList_merge_partial_solve_wit_1.
Axiom proof_of_IntList_merge_partial_solve_wit_2 : IntList_merge_partial_solve_wit_2.
Axiom proof_of_IntList_merge_partial_solve_wit_3 : IntList_merge_partial_solve_wit_3.
Axiom proof_of_IntList_merge_precondition_wit_1 : IntList_merge_precondition_wit_1.

End VC_Correct.
