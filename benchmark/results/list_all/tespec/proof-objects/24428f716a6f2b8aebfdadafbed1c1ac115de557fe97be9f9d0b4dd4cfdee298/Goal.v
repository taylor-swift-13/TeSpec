From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev -----*)

Definition IntList_rev_safety_wit_1 :=
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_2 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)),
  ((( &( "ys_spec_587" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_586" ) )) # Ptr  |-> y_2)
  **  ((( &( "tmp_spec_570" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_568" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_567" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_551" ) )) # Ptr  |-> y_2)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_3 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_587" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_586" ) )) # Ptr  |-> y_2)
  **  ((( &( "tmp_spec_570" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_568" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_567" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_551" ) )) # Ptr  |-> y_2)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_safety_wit_4 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  ((( &( "ys_spec_568" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_567" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_551" ) )) # Ptr  |-> y_2)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_5 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_568" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_567" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_551" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_safety_wit_6 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_7 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_549" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_safety_wit_8 :=
  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_9 :=
forall (PreH1 : False),
  ((( &( "ys_spec_521" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_rev_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((( &( "tmp_spec_551" ) )) # Ptr  |-> y_2)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (app ((rev ((@nil Z)))) ((cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z))))))))) )
  **  ((( &( "tmp_spec_551" ) )) # Ptr  |-> y_2)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_entail_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (app ((rev ((cons ((INT_MIN)) ((@nil Z)))))) ((cons (0) ((cons (INT_MAX) ((@nil Z))))))) )
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_entail_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (app ((rev ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ((cons (INT_MAX) ((@nil Z))))) )
.

Definition IntList_rev_entail_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (app ((rev (l___tespec_entry))) ((@nil Z))) )
.

Definition IntList_rev_return_wit_1 :=
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

Definition IntList_rev_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (sll xs_pre l___tespec_entry )
|--
  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll 0 (@nil Z) )
  **  (sll xs_pre l___tespec_entry )
.

Definition IntList_rev_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
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
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre (cons (INT_MAX) ((@nil Z))) )
  **  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
.

Definition IntList_rev_partial_solve_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
|--
  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons (0) ((cons (INT_MAX) ((@nil Z))))) )
  **  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_partial_solve_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((( &( "tmp_spec_551" ) )) # Ptr  |-> y_2)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
|--
  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y_2 (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z))))))) )
  **  (sll y_3 (@nil Z) )
  **  ((( &( "tmp_spec_551" ) )) # Ptr  |-> y_2)
  **  ((( &( "ys_spec_549" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_548" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_521" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_520" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_partial_solve_wit_5 :=
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

Definition IntList_rev_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_safety_wit_1 : IntList_rev_safety_wit_1.
Axiom proof_of_IntList_rev_safety_wit_2 : IntList_rev_safety_wit_2.
Axiom proof_of_IntList_rev_safety_wit_3 : IntList_rev_safety_wit_3.
Axiom proof_of_IntList_rev_safety_wit_4 : IntList_rev_safety_wit_4.
Axiom proof_of_IntList_rev_safety_wit_5 : IntList_rev_safety_wit_5.
Axiom proof_of_IntList_rev_safety_wit_6 : IntList_rev_safety_wit_6.
Axiom proof_of_IntList_rev_safety_wit_7 : IntList_rev_safety_wit_7.
Axiom proof_of_IntList_rev_safety_wit_8 : IntList_rev_safety_wit_8.
Axiom proof_of_IntList_rev_safety_wit_9 : IntList_rev_safety_wit_9.
Axiom proof_of_IntList_rev_entail_wit_1 : IntList_rev_entail_wit_1.
Axiom proof_of_IntList_rev_entail_wit_2 : IntList_rev_entail_wit_2.
Axiom proof_of_IntList_rev_entail_wit_3 : IntList_rev_entail_wit_3.
Axiom proof_of_IntList_rev_entail_wit_4 : IntList_rev_entail_wit_4.
Axiom proof_of_IntList_rev_return_wit_1 : IntList_rev_return_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_1 : IntList_rev_partial_solve_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_2 : IntList_rev_partial_solve_wit_2.
Axiom proof_of_IntList_rev_partial_solve_wit_3 : IntList_rev_partial_solve_wit_3.
Axiom proof_of_IntList_rev_partial_solve_wit_4 : IntList_rev_partial_solve_wit_4.
Axiom proof_of_IntList_rev_partial_solve_wit_5 : IntList_rev_partial_solve_wit_5.
Axiom proof_of_IntList_rev_precondition_wit_1 : IntList_rev_precondition_wit_1.

End VC_Correct.
