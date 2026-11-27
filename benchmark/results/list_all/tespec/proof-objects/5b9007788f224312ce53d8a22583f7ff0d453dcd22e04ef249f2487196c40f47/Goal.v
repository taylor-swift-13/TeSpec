From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length_acc_aux -----*)

Definition IntList_length_acc_aux_safety_wit_1 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)),
  ((( &( "p_spec_698" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_692" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_691" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 2)
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_2 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "p_spec_698" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_697" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_692" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_691" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 2)
|--
  “ False ”
.

Definition IntList_length_acc_aux_safety_wit_3 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)),
  ((( &( "p_spec_692" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_691" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 1)
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_4 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  ((( &( "p_spec_692" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_691" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 1)
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_5 :=
forall (y: Z) (PreH1 : False),
  ((( &( "p_spec_692" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_691" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 1)
|--
  “ False ”
.

Definition IntList_length_acc_aux_safety_wit_6 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 0)
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_7 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 0)
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_8 :=
forall (y: Z) (PreH1 : False),
  ((( &( "p_spec_683" ) )) # Ptr  |-> 4096)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 0)
|--
  “ False ”
.

Definition IntList_length_acc_aux_safety_wit_9 :=
  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> UINT_MAX)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_10 :=
  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> UINT_MAX)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_11 :=
forall (PreH1 : False),
  ((( &( "xs_spec_637" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> UINT_MAX)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_length_acc_aux_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (p_pre = 4096)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (n___tespec_entry = UINT_MAX)) (PreH14 : (0 <= n___tespec_entry)) (PreH15 : (n___tespec_entry <= UINT_MAX)),
  ((( &( "p_spec_683" ) )) # Ptr  |-> p_pre)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ))
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
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (((((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ) + (Zlength ((@nil Z))) ) % ( 4294967296 ) ))
  **  (sll y_3 (@nil Z) )
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> p_pre)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
.

Definition IntList_length_acc_aux_entail_wit_2 :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (p_pre = 4096)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (n___tespec_entry = UINT_MAX)) (PreH14 : (0 <= n___tespec_entry)) (PreH15 : (n___tespec_entry <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ))
|--
  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> ((((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + (Zlength ((cons ((INT_MIN)) ((@nil Z))))) ) % ( 4294967296 ) ))
  **  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
.

Definition IntList_length_acc_aux_entail_wit_3 :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (p_pre = 4096)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (n___tespec_entry = UINT_MAX)) (PreH14 : (0 <= n___tespec_entry)) (PreH15 : (n___tespec_entry <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ))
|--
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + (Zlength ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) ) % ( 4294967296 ) ))
  **  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_aux_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (p_pre = 4096)) (PreH12 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH13 : (n___tespec_entry = UINT_MAX)) (PreH14 : (0 <= n___tespec_entry)) (PreH15 : (n___tespec_entry <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ))
|--
  ((p_pre) # UInt  |-> ((n___tespec_entry + (Zlength (l___tespec_entry)) ) % ( 4294967296 ) ))
  **  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_acc_aux_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (p_pre = 4096)) (PreH5 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (n___tespec_entry = UINT_MAX)) (PreH7 : (0 <= n___tespec_entry)) (PreH8 : (n___tespec_entry <= UINT_MAX)),
  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n___tespec_entry + 1 )) (32)))
  **  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n___tespec_entry + 1 )) (32)))
.

Definition IntList_length_acc_aux_partial_solve_wit_2_pure :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (p_pre = 4096)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (n___tespec_entry = UINT_MAX)) (PreH11 : (0 <= n___tespec_entry)) (PreH12 : (n___tespec_entry <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n___tespec_entry + 1 )) (32)))
|--
  “ (0 <= (unsigned_last_nbits ((n___tespec_entry + 1 )) (32))) ”
  &&  “ ((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) <= UINT_MAX) ”
.

Definition IntList_length_acc_aux_partial_solve_wit_2_aux :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (p_pre = 4096)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (n___tespec_entry = UINT_MAX)) (PreH11 : (0 <= n___tespec_entry)) (PreH12 : (n___tespec_entry <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n___tespec_entry + 1 )) (32)))
|--
  “ (0 <= (unsigned_last_nbits ((n___tespec_entry + 1 )) (32))) ”
  &&  “ ((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) <= UINT_MAX) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (unsigned_last_nbits ((n___tespec_entry + 1 )) (32)))
  **  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_length_acc_aux_partial_solve_wit_2 := IntList_length_acc_aux_partial_solve_wit_2_pure -> IntList_length_acc_aux_partial_solve_wit_2_aux.

Definition IntList_length_acc_aux_partial_solve_wit_3_pure :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (p_pre = 4096)) (PreH10 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (n___tespec_entry = UINT_MAX)) (PreH12 : (0 <= n___tespec_entry)) (PreH13 : (n___tespec_entry <= UINT_MAX)),
  ((( &( "p_spec_683" ) )) # Ptr  |-> p_pre)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> ((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ))
|--
  “ (0 <= ((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 )) ”
  &&  “ (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) <= UINT_MAX) ”
.

Definition IntList_length_acc_aux_partial_solve_wit_3_aux :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (p_pre = 4096)) (PreH10 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (n___tespec_entry = UINT_MAX)) (PreH12 : (0 <= n___tespec_entry)) (PreH13 : (n___tespec_entry <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> ((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ))
|--
  “ (0 <= ((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 )) ”
  &&  “ (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) <= UINT_MAX) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> ((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ))
  **  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
.

Definition IntList_length_acc_aux_partial_solve_wit_3 := IntList_length_acc_aux_partial_solve_wit_3_pure -> IntList_length_acc_aux_partial_solve_wit_3_aux.

Definition IntList_length_acc_aux_partial_solve_wit_4_pure :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (p_pre = 4096)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (n___tespec_entry = UINT_MAX)) (PreH13 : (0 <= n___tespec_entry)) (PreH14 : (n___tespec_entry <= UINT_MAX)),
  ((( &( "p_spec_692" ) )) # Ptr  |-> p_pre)
  **  ((( &( "xs_spec_691" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> p_pre)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ))
|--
  “ (0 <= (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 )) ”
  &&  “ ((((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ) <= UINT_MAX) ”
.

Definition IntList_length_acc_aux_partial_solve_wit_4_aux :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (p_pre = 4096)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH12 : (n___tespec_entry = UINT_MAX)) (PreH13 : (0 <= n___tespec_entry)) (PreH14 : (n___tespec_entry <= UINT_MAX)),
  ((( &( "p_spec_683" ) )) # Ptr  |-> p_pre)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ))
|--
  “ (0 <= (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 )) ”
  &&  “ ((((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ) <= UINT_MAX) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> (((unsigned_last_nbits ((n___tespec_entry + 1 )) (32)) + 1 ) + 1 ))
  **  (sll y_3 (@nil Z) )
  **  ((( &( "p_spec_683" ) )) # Ptr  |-> p_pre)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "xs_spec_637" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> p_pre)
.

Definition IntList_length_acc_aux_partial_solve_wit_4 := IntList_length_acc_aux_partial_solve_wit_4_pure -> IntList_length_acc_aux_partial_solve_wit_4_aux.

Definition IntList_length_acc_aux_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (n___tespec_entry: Z),
exists (xs_pre: Z),
exists (p_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (n___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> n___tespec_entry)
  **  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_acc_aux_safety_wit_1 : IntList_length_acc_aux_safety_wit_1.
Axiom proof_of_IntList_length_acc_aux_safety_wit_2 : IntList_length_acc_aux_safety_wit_2.
Axiom proof_of_IntList_length_acc_aux_safety_wit_3 : IntList_length_acc_aux_safety_wit_3.
Axiom proof_of_IntList_length_acc_aux_safety_wit_4 : IntList_length_acc_aux_safety_wit_4.
Axiom proof_of_IntList_length_acc_aux_safety_wit_5 : IntList_length_acc_aux_safety_wit_5.
Axiom proof_of_IntList_length_acc_aux_safety_wit_6 : IntList_length_acc_aux_safety_wit_6.
Axiom proof_of_IntList_length_acc_aux_safety_wit_7 : IntList_length_acc_aux_safety_wit_7.
Axiom proof_of_IntList_length_acc_aux_safety_wit_8 : IntList_length_acc_aux_safety_wit_8.
Axiom proof_of_IntList_length_acc_aux_safety_wit_9 : IntList_length_acc_aux_safety_wit_9.
Axiom proof_of_IntList_length_acc_aux_safety_wit_10 : IntList_length_acc_aux_safety_wit_10.
Axiom proof_of_IntList_length_acc_aux_safety_wit_11 : IntList_length_acc_aux_safety_wit_11.
Axiom proof_of_IntList_length_acc_aux_entail_wit_1 : IntList_length_acc_aux_entail_wit_1.
Axiom proof_of_IntList_length_acc_aux_entail_wit_2 : IntList_length_acc_aux_entail_wit_2.
Axiom proof_of_IntList_length_acc_aux_entail_wit_3 : IntList_length_acc_aux_entail_wit_3.
Axiom proof_of_IntList_length_acc_aux_return_wit_1 : IntList_length_acc_aux_return_wit_1.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_1 : IntList_length_acc_aux_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_2_pure : IntList_length_acc_aux_partial_solve_wit_2_pure.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_2 : IntList_length_acc_aux_partial_solve_wit_2.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_3_pure : IntList_length_acc_aux_partial_solve_wit_3_pure.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_3 : IntList_length_acc_aux_partial_solve_wit_3.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_4_pure : IntList_length_acc_aux_partial_solve_wit_4_pure.
Axiom proof_of_IntList_length_acc_aux_partial_solve_wit_4 : IntList_length_acc_aux_partial_solve_wit_4.
Axiom proof_of_IntList_length_acc_aux_precondition_wit_1 : IntList_length_acc_aux_precondition_wit_1.

End VC_Correct.
