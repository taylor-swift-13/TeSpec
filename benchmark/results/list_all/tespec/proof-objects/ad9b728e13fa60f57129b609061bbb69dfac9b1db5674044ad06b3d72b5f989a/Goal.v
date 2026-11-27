From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev_loop -----*)

Definition IntList_rev_loop_safety_wit_1 :=
  ((( &( "last_spec_573" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_2 :=
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_3 :=
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_4 :=
forall (PreH1 : False),
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_rev_loop_safety_wit_5 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> y)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_6 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> y)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_7 :=
forall (y: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_loop_safety_wit_8 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> y_2)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_9 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> y_2)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_10 :=
forall (y: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_loop_safety_wit_11 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_12 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_13 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_loop_entail_wit_1 :=
(
forall (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> 8192)
  **  ((y_2) # Int  |-> 0)
  **  ((8192) # Int  |-> INT_MAX)
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  (sll y l1 )
  **  (sll 0 l2 )
) \/
(
forall (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (INT_MAX <= INT_MAX)) (PreH2 : (0 <= INT_MAX)) (PreH3 : ((INT_MIN) <= INT_MAX)) (PreH4 : (INT_MAX >= INT_MIN)) (PreH5 : (0 >= INT_MIN)) (PreH6 : ((INT_MIN) >= INT_MIN)) (PreH7 : (y <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (INT_MIN))
  **  (((y_2 + 4 )) # Ptr  |-> 8192)
  **  ((y_2) # Int  |-> 0)
  **  ((8192) # Int  |-> INT_MAX)
|--
  EX (y_4: Z) (l0: (@list Z)) (x: Z),
  “ (y <> 0) ”
  &&  “ ((app ((rev ((@nil Z)))) ((cons (x) (l0)))) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  (sll y_4 l0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> x)
).

Definition IntList_rev_loop_entail_wit_2 :=
(
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> 8192)
  **  ((y) # Int  |-> 0)
  **  ((8192) # Int  |-> INT_MAX)
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  (sll y l1 )
  **  (sll y_2 l2 )
) \/
(
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (INT_MAX <= INT_MAX)) (PreH2 : (0 <= INT_MAX)) (PreH3 : ((INT_MIN) <= INT_MAX)) (PreH4 : (INT_MAX >= INT_MIN)) (PreH5 : (0 >= INT_MIN)) (PreH6 : ((INT_MIN) >= INT_MIN)) (PreH7 : (y <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> 8192)
  **  ((y) # Int  |-> 0)
  **  ((8192) # Int  |-> INT_MAX)
|--
  EX (y_5: Z) (l0_2: (@list Z)) (x_2: Z) (y_4: Z) (l0: (@list Z)) (x: Z),
  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ ((app ((rev ((cons (x_2) (l0_2))))) ((cons (x) (l0)))) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  (sll y_5 l0_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> x_2)
  **  (sll y_4 l0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> x)
).

Definition IntList_rev_loop_entail_wit_3 :=
(
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 0)
  **  ((8192) # Int  |-> INT_MAX)
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  (sll 8192 l1 )
  **  (sll y l2 )
) \/
(
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (INT_MAX <= INT_MAX)) (PreH2 : (0 <= INT_MAX)) (PreH3 : ((INT_MIN) <= INT_MAX)) (PreH4 : (INT_MAX >= INT_MIN)) (PreH5 : (0 >= INT_MIN)) (PreH6 : ((INT_MIN) >= INT_MIN)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y_2 + 4 )) # Ptr  |-> 0)
  **  ((y_2) # Int  |-> (INT_MIN))
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> 0)
  **  ((8192) # Int  |-> INT_MAX)
|--
  EX (y_4: Z) (l0: (@list Z)) (x: Z) (l1: (@list Z)),
  “ (y <> 0) ”
  &&  “ ((app ((rev ((cons (x) (l0))))) (l1)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  (sll y_4 l0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> x)
  **  (sll 8192 l1 )
).

Definition IntList_rev_loop_entail_wit_4 :=
  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  “ (8192 <> 0) ”
  &&  (sll 0 l1 )
  **  (sll 8192 l2 )
.

Definition IntList_rev_loop_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  (sll y (rev (l___tespec_entry)) )
.

Definition IntList_rev_loop_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_rev_loop_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_loop_safety_wit_1 : IntList_rev_loop_safety_wit_1.
Axiom proof_of_IntList_rev_loop_safety_wit_2 : IntList_rev_loop_safety_wit_2.
Axiom proof_of_IntList_rev_loop_safety_wit_3 : IntList_rev_loop_safety_wit_3.
Axiom proof_of_IntList_rev_loop_safety_wit_4 : IntList_rev_loop_safety_wit_4.
Axiom proof_of_IntList_rev_loop_safety_wit_5 : IntList_rev_loop_safety_wit_5.
Axiom proof_of_IntList_rev_loop_safety_wit_6 : IntList_rev_loop_safety_wit_6.
Axiom proof_of_IntList_rev_loop_safety_wit_7 : IntList_rev_loop_safety_wit_7.
Axiom proof_of_IntList_rev_loop_safety_wit_8 : IntList_rev_loop_safety_wit_8.
Axiom proof_of_IntList_rev_loop_safety_wit_9 : IntList_rev_loop_safety_wit_9.
Axiom proof_of_IntList_rev_loop_safety_wit_10 : IntList_rev_loop_safety_wit_10.
Axiom proof_of_IntList_rev_loop_safety_wit_11 : IntList_rev_loop_safety_wit_11.
Axiom proof_of_IntList_rev_loop_safety_wit_12 : IntList_rev_loop_safety_wit_12.
Axiom proof_of_IntList_rev_loop_safety_wit_13 : IntList_rev_loop_safety_wit_13.
Axiom proof_of_IntList_rev_loop_entail_wit_1 : IntList_rev_loop_entail_wit_1.
Axiom proof_of_IntList_rev_loop_entail_wit_2 : IntList_rev_loop_entail_wit_2.
Axiom proof_of_IntList_rev_loop_entail_wit_3 : IntList_rev_loop_entail_wit_3.
Axiom proof_of_IntList_rev_loop_entail_wit_4 : IntList_rev_loop_entail_wit_4.
Axiom proof_of_IntList_rev_loop_return_wit_1 : IntList_rev_loop_return_wit_1.
Axiom proof_of_IntList_rev_loop_partial_solve_wit_1 : IntList_rev_loop_partial_solve_wit_1.
Axiom proof_of_IntList_rev_loop_precondition_wit_1 : IntList_rev_loop_precondition_wit_1.

End VC_Correct.
