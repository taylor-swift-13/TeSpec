From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length_acc -----*)

Definition IntList_length_acc_safety_wit_1 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((( &( "p_spec_713" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_712" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_707" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_706" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_2 :=
forall (y: Z) (y_2: Z) (retval: Z) (PreH1 : False),
  ((( &( "p_spec_713" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_712" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_707" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_706" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_acc_safety_wit_3 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((( &( "p_spec_707" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_706" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_4 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  ((( &( "p_spec_707" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_706" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_5 :=
forall (y: Z) (retval: Z) (PreH1 : False),
  ((( &( "p_spec_707" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_706" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_acc_safety_wit_6 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_7 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)),
  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_8 :=
forall (y: Z) (retval: Z) (PreH1 : False),
  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_acc_safety_wit_9 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)),
  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_10 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)),
  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_11 :=
forall (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : False),
  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_acc_safety_wit_12 :=
  ((( &( "p_spec_657" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_length_acc_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (retval <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> (((((0 + 1 ) + 1 ) + 1 ) + (Zlength ((@nil Z))) ) % ( 4294967296 ) ))
  **  (sll y_3 (@nil Z) )
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_entail_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (retval <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> ((((0 + 1 ) + 1 ) + (Zlength ((cons ((INT_MIN)) ((@nil Z))))) ) % ( 4294967296 ) ))
  **  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_entail_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (retval <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> (((0 + 1 ) + (Zlength ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) ) % ( 4294967296 ) ))
  **  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_entail_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (retval <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> ((0 + (Zlength ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) ) % ( 4294967296 ) ))
  **  (sll xs_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
.

Definition IntList_length_acc_entail_wit_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_4: Z) (y_5: Z) (y_6: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y_6 = 0)) (PreH3 : (y_6 = 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH9 : (0 <= retval_2)) (PreH10 : (retval_2 <= UINT_MAX)),
  ((retval_2) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_5 + 4)) # Ptr  |-> y_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_5 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z) (y_3: Z) (y_2: Z) (y: Z),
  “ (retval = retval_2) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (retval <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ ((((0 + 1 ) + 1 ) + 1 ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_acc_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (retval <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_partial_solve_wit_2_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_2_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 0)
  **  (sll xs_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
.

Definition IntList_length_acc_partial_solve_wit_2 := IntList_length_acc_partial_solve_wit_2_pure -> IntList_length_acc_partial_solve_wit_2_aux.

Definition IntList_length_acc_partial_solve_wit_3_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval)) (PreH11 : (retval <= UINT_MAX)),
  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> (0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= (0 + 1 )) ”
  &&  “ ((0 + 1 ) <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_3_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval)) (PreH11 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (0 <= (0 + 1 )) ”
  &&  “ ((0 + 1 ) <= UINT_MAX) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> (0 + 1 ))
  **  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_partial_solve_wit_3 := IntList_length_acc_partial_solve_wit_3_pure -> IntList_length_acc_partial_solve_wit_3_aux.

Definition IntList_length_acc_partial_solve_wit_4_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (0 <= retval)) (PreH12 : (retval <= UINT_MAX)),
  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> ((0 + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= ((0 + 1 ) + 1 )) ”
  &&  “ (((0 + 1 ) + 1 ) <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_4_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (0 <= retval)) (PreH12 : (retval <= UINT_MAX)),
  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> ((0 + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (0 <= ((0 + 1 ) + 1 )) ”
  &&  “ (((0 + 1 ) + 1 ) <= UINT_MAX) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> ((0 + 1 ) + 1 ))
  **  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_partial_solve_wit_4 := IntList_length_acc_partial_solve_wit_4_pure -> IntList_length_acc_partial_solve_wit_4_aux.

Definition IntList_length_acc_partial_solve_wit_5_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (retval <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (0 <= retval)) (PreH13 : (retval <= UINT_MAX)),
  ((( &( "p_spec_707" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_706" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= (((0 + 1 ) + 1 ) + 1 )) ”
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_5_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (retval <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (0 <= retval)) (PreH13 : (retval <= UINT_MAX)),
  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (0 <= (((0 + 1 ) + 1 ) + 1 )) ”
  &&  “ ((((0 + 1 ) + 1 ) + 1 ) <= UINT_MAX) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> (((0 + 1 ) + 1 ) + 1 ))
  **  (sll y_3 (@nil Z) )
  **  ((( &( "p_spec_698" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_686" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_685" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_partial_solve_wit_5 := IntList_length_acc_partial_solve_wit_5_pure -> IntList_length_acc_partial_solve_wit_5_aux.

Definition IntList_length_acc_partial_solve_wit_6_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((( &( "p_spec_657" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l___tespec_entry )
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_6_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_partial_solve_wit_6 := IntList_length_acc_partial_solve_wit_6_pure -> IntList_length_acc_partial_solve_wit_6_aux.

Definition IntList_length_acc_partial_solve_wit_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_acc_safety_wit_1 : IntList_length_acc_safety_wit_1.
Axiom proof_of_IntList_length_acc_safety_wit_2 : IntList_length_acc_safety_wit_2.
Axiom proof_of_IntList_length_acc_safety_wit_3 : IntList_length_acc_safety_wit_3.
Axiom proof_of_IntList_length_acc_safety_wit_4 : IntList_length_acc_safety_wit_4.
Axiom proof_of_IntList_length_acc_safety_wit_5 : IntList_length_acc_safety_wit_5.
Axiom proof_of_IntList_length_acc_safety_wit_6 : IntList_length_acc_safety_wit_6.
Axiom proof_of_IntList_length_acc_safety_wit_7 : IntList_length_acc_safety_wit_7.
Axiom proof_of_IntList_length_acc_safety_wit_8 : IntList_length_acc_safety_wit_8.
Axiom proof_of_IntList_length_acc_safety_wit_9 : IntList_length_acc_safety_wit_9.
Axiom proof_of_IntList_length_acc_safety_wit_10 : IntList_length_acc_safety_wit_10.
Axiom proof_of_IntList_length_acc_safety_wit_11 : IntList_length_acc_safety_wit_11.
Axiom proof_of_IntList_length_acc_safety_wit_12 : IntList_length_acc_safety_wit_12.
Axiom proof_of_IntList_length_acc_entail_wit_1 : IntList_length_acc_entail_wit_1.
Axiom proof_of_IntList_length_acc_entail_wit_2 : IntList_length_acc_entail_wit_2.
Axiom proof_of_IntList_length_acc_entail_wit_3 : IntList_length_acc_entail_wit_3.
Axiom proof_of_IntList_length_acc_entail_wit_4 : IntList_length_acc_entail_wit_4.
Axiom proof_of_IntList_length_acc_entail_wit_5 : IntList_length_acc_entail_wit_5.
Axiom proof_of_IntList_length_acc_return_wit_1 : IntList_length_acc_return_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_1 : IntList_length_acc_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2_pure : IntList_length_acc_partial_solve_wit_2_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2 : IntList_length_acc_partial_solve_wit_2.
Axiom proof_of_IntList_length_acc_partial_solve_wit_3_pure : IntList_length_acc_partial_solve_wit_3_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_3 : IntList_length_acc_partial_solve_wit_3.
Axiom proof_of_IntList_length_acc_partial_solve_wit_4_pure : IntList_length_acc_partial_solve_wit_4_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_4 : IntList_length_acc_partial_solve_wit_4.
Axiom proof_of_IntList_length_acc_partial_solve_wit_5_pure : IntList_length_acc_partial_solve_wit_5_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_5 : IntList_length_acc_partial_solve_wit_5.
Axiom proof_of_IntList_length_acc_partial_solve_wit_6_pure : IntList_length_acc_partial_solve_wit_6_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_6 : IntList_length_acc_partial_solve_wit_6.
Axiom proof_of_IntList_length_acc_partial_solve_wit_7 : IntList_length_acc_partial_solve_wit_7.
Axiom proof_of_IntList_length_acc_precondition_wit_1 : IntList_length_acc_precondition_wit_1.

End VC_Correct.
