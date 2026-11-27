From SimpleC.Verification Require Import VCPrelude.
Require Import input_def.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_mergesort -----*)

Definition IntList_mergesort_safety_wit_1 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)),
  ((( &( "ys_spec_904" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_903" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_893" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_891" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_890" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_2 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_904" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_903" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_893" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_891" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_890" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_3 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)),
  ((( &( "ys_spec_904" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_903" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_893" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_891" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_890" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_4 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)),
  ((( &( "ys_spec_891" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_890" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_5 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_891" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_890" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_6 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)),
  ((( &( "ys_spec_891" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_890" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_7 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_891" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_890" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_8 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)),
  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_9 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_10 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)),
  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_11 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_875" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_12 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_13 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)),
  ((( &( "ys_spec_858" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_857" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_612" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_847" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_14 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_858" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_857" ) )) # Ptr  |-> 0)
  **  ((( &( "zs_spec_612" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_847" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> 0)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_15 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)),
  ((( &( "ys_spec_858" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_857" ) )) # Ptr  |-> y)
  **  ((( &( "zs_spec_612" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_847" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_16 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)),
  ((( &( "ys_spec_847" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_17 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_847" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> 0)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_18 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y <> 0)),
  ((( &( "ys_spec_847" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_19 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_847" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_20 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "ys_spec_847" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_846" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_21 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)),
  ((( &( "xs_spec_831" ) )) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_22 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_831" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_23 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)),
  ((( &( "tail_spec_833" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_831" ) )) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_24 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)),
  ((( &( "xs_spec_821" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_25 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_821" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> 0)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_26 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)),
  ((( &( "tail_spec_823" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_821" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_27 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)),
  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_28 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_751" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_29 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)),
  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_30 :=
forall (y: Z) (PreH1 : False),
  ((( &( "tail_spec_753" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_31 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)),
  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_32 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_770" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_33 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)),
  ((( &( "cdr_spec_772" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_34 :=
forall (y: Z) (PreH1 : False),
  ((( &( "cdr_spec_772" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_35 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)),
  ((( &( "xs_spec_783" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "cdr_spec_772" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_36 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "xs_spec_783" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "cdr_spec_772" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_37 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)),
  ((( &( "xs_spec_783" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "cdr_spec_772" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_38 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)),
  ((( &( "xs_spec_783" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "cdr_spec_772" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  ((( &( "tail_spec_753" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_751" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_39 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)),
  ((( &( "xs_spec_738" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_40 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : False),
  ((( &( "xs_spec_738" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_41 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)),
  ((( &( "tail_spec_740" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_738" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_42 :=
  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_43 :=
forall (PreH1 : False),
  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_44 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_45 :=
forall (y: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_46 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_47 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : False),
  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_48 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)),
  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_49 :=
forall (y: Z) (PreH1 : False),
  ((( &( "cdr_spec_590" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_50 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)),
  ((( &( "xs_spec_700" ) )) # Ptr  |-> y_2)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_51 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_700" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_52 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)),
  ((( &( "cdr_spec_702" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_700" ) )) # Ptr  |-> y_2)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_53 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "cdr_spec_702" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_700" ) )) # Ptr  |-> y_2)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_54 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)),
  ((( &( "cdr_spec_702" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_700" ) )) # Ptr  |-> y_2)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_entail_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = xs_pre) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (INT_MAX >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_merge ((cons (INT_MAX) ((@nil Z)))) ((@nil Z))) )
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ ((cn_merge ((cons (INT_MAX) ((@nil Z)))) ((@nil Z))) = (cons (INT_MAX) ((@nil Z)))) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (INT_MAX >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge ((cons (INT_MAX) ((@nil Z)))) ((@nil Z))) = (cons (INT_MAX) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_1_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (INT_MAX >= (INT_MIN))
.

Definition IntList_mergesort_entail_wit_1_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 >= (INT_MIN))
.

Definition IntList_mergesort_entail_wit_1_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_22 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_23 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_24 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_25 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_26 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_27 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_28 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_29 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_30 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_31 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_1_split_goal_32 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_2 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (INT_MAX >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_merge ((cons (INT_MAX) ((@nil Z)))) ((cons (0) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_merge ((cons (INT_MAX) ((@nil Z)))) ((cons (0) ((@nil Z))))) = (cons (0) ((cons (INT_MAX) ((@nil Z)))))) ”
  &&  “ (INT_MAX >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_2_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge ((cons (INT_MAX) ((@nil Z)))) ((cons (0) ((@nil Z))))) = (cons (0) ((cons (INT_MAX) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_2_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (INT_MAX >= (INT_MIN))
.

Definition IntList_mergesort_entail_wit_2_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 >= (INT_MIN))
.

Definition IntList_mergesort_entail_wit_2_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_22 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_23 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_24 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_25 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_26 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_27 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_28 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_29 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_30 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_2_split_goal_31 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_3 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_merge ((cons (INT_MAX) ((@nil Z)))) ((cons ((INT_MIN)) ((cons (0) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ ((cn_merge ((cons (INT_MAX) ((@nil Z)))) ((cons ((INT_MIN)) ((cons (0) ((@nil Z))))))) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_3_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge ((cons (INT_MAX) ((@nil Z)))) ((cons ((INT_MIN)) ((cons (0) ((@nil Z))))))) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_3_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 >= (INT_MIN))
.

Definition IntList_mergesort_entail_wit_3_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_22 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_23 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_24 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_25 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_26 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_27 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_28 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_3_split_goal_29 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y_2 <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y_2 <> 0)) (PreH27 : (y <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_4 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_merge ((cons (0) ((@nil Z)))) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y <> 0) ”
  &&  “ ((cn_merge ((cons (0) ((@nil Z)))) ((@nil Z))) = (cons (0) ((@nil Z)))) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_4_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge ((cons (0) ((@nil Z)))) ((@nil Z))) = (cons (0) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_4_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 >= (INT_MIN))
.

Definition IntList_mergesort_entail_wit_4_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_22 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_23 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_24 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_25 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_4_split_goal_26 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_5 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_merge ((cons (0) ((@nil Z)))) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ ((cn_merge ((cons (0) ((@nil Z)))) ((cons ((INT_MIN)) ((@nil Z))))) = (cons ((INT_MIN)) ((cons (0) ((@nil Z)))))) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_5_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_merge ((cons (0) ((@nil Z)))) ((cons ((INT_MIN)) ((@nil Z))))) = (cons ((INT_MIN)) ((cons (0) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_5_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_22 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_23 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_5_split_goal_24 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_6 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_mergesort ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y_2 <> 0) ”
  &&  “ ((cn_mergesort ((cons ((INT_MIN)) ((@nil Z))))) = (cons ((INT_MIN)) ((@nil Z)))) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_6_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_mergesort ((cons ((INT_MIN)) ((@nil Z))))) = (cons ((INT_MIN)) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_6_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_6_split_goal_22 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_7 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_mergesort ((cons (0) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y <> 0) ”
  &&  “ ((cn_mergesort ((cons (0) ((@nil Z))))) = (cons (0) ((@nil Z)))) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_7_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_mergesort ((cons (0) ((@nil Z))))) = (cons (0) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_7_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_7_split_goal_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_7_split_goal_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_8 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval_snd: Z) (retval_fst: Z) (retval: Z),
  “ (retval = record_return) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((@nil Z))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ ((cn_split_snd ((@nil Z))) = (@nil Z)) ”
  &&  “ ((cn_split_fst ((@nil Z))) = (@nil Z)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_8_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_snd ((@nil Z))) = (@nil Z))
.

Definition IntList_mergesort_entail_wit_8_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_fst ((@nil Z))) = (@nil Z))
.

Definition IntList_mergesort_entail_wit_8_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_8_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_9 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval_snd: Z) (retval_fst: Z) (retval: Z),
  “ (retval = record_return) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y <> 0) ”
  &&  “ ((cn_split_fst ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (cons (0) ((@nil Z)))) ”
  &&  “ (y_2 <> 0) ”
  &&  “ ((cn_split_snd ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (cons ((INT_MIN)) ((@nil Z)))) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_9_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_fst ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (cons (0) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_9_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_snd ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (cons ((INT_MIN)) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_9_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_9_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_10 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = y_2) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_mergesort ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ ((cn_mergesort ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (cons ((INT_MIN)) ((cons (0) ((@nil Z)))))) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_10_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_mergesort ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (cons ((INT_MIN)) ((cons (0) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_10_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_10_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_10_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_11 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval: Z),
  “ (retval = xs_pre) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll retval (cn_mergesort ((cons (INT_MAX) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ ((cn_mergesort ((cons (INT_MAX) ((@nil Z))))) = (cons (INT_MAX) ((@nil Z)))) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_11_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_mergesort ((cons (INT_MAX) ((@nil Z))))) = (cons (INT_MAX) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_11_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_3 = 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_11_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_11_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))
.

Definition IntList_mergesort_entail_wit_12 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval_snd: Z) (retval_fst: Z) (retval: Z),
  “ (retval = record_return) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (y_2 <> 0) ”
  &&  “ ((cn_split_snd ((cons ((INT_MIN)) ((@nil Z))))) = (cons ((INT_MIN)) ((@nil Z)))) ”
  &&  “ ((cn_split_fst ((cons ((INT_MIN)) ((@nil Z))))) = (@nil Z)) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_12_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_snd ((cons ((INT_MIN)) ((@nil Z))))) = (cons ((INT_MIN)) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_12_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_fst ((cons ((INT_MIN)) ((@nil Z))))) = (@nil Z))
.

Definition IntList_mergesort_entail_wit_12_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_12_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_13 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  EX (retval_snd: Z) (retval_fst: Z) (retval: Z),
  “ (retval = record_return) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (8192 <> 0) ”
  &&  “ ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons (INT_MAX) ((@nil Z)))) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons (0) ((cons ((INT_MIN)) ((@nil Z)))))) ”
  &&  “ (y <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_13_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons (INT_MAX) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_13_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) = (cons (0) ((cons ((INT_MIN)) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_13_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_13_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y <> 0)) (PreH21 : (y_2 <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y_2 <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y <> 0)) (PreH27 : (y_2 <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  (sll y (cn_mergesort (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y <> 0)) (PreH21 : (y_2 <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y_2 <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y <> 0)) (PreH27 : (y_2 <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_mergesort (l___tespec_entry)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z)))))))) ”
  &&  emp
).

Definition IntList_mergesort_return_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y <> 0)) (PreH21 : (y_2 <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y_2 <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y <> 0)) (PreH27 : (y_2 <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_return_wit_1_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y <> 0)) (PreH21 : (y_2 <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y_2 <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y <> 0)) (PreH27 : (y_2 <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y_2 <> 0)
.

Definition IntList_mergesort_return_wit_1_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y <> 0)) (PreH21 : (y_2 <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y_2 <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y <> 0)) (PreH27 : (y_2 <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (y <> 0)
.

Definition IntList_mergesort_return_wit_1_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (y: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (INT_MAX >= (INT_MIN))) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (0 >= (INT_MIN))) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_2 <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y <> 0)) (PreH21 : (y_2 <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (y_2 <> 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_3 = 0)) (PreH26 : (y <> 0)) (PreH27 : (y_2 <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre <> 0)) (PreH30 : (xs_pre = 8192)) (PreH31 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((cn_mergesort (l___tespec_entry)) = (cons ((INT_MIN)) ((cons (0) ((cons (INT_MAX) ((@nil Z))))))))
.

Definition IntList_mergesort_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (0 >= (INT_MIN))) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (y <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_3 = 0)) (PreH20 : (y_2 <> 0)) (PreH21 : (y <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre <> 0)) (PreH24 : (xs_pre = 8192)) (PreH25 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre (cons (INT_MAX) ((@nil Z))) )
  **  (sll y_2 (cons ((INT_MIN)) ((cons (0) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (INT_MAX >= (INT_MIN))) (PreH2 : (y_2 <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (0 >= (INT_MIN))) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_3 = 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (y_3 = 0)) (PreH17 : (y_2 <> 0)) (PreH18 : (y <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (y <> 0)) (PreH21 : (y_3 = 0)) (PreH22 : (y_3 = 0)) (PreH23 : (y_2 <> 0)) (PreH24 : (y <> 0)) (PreH25 : (xs_pre <> 0)) (PreH26 : (xs_pre <> 0)) (PreH27 : (xs_pre = 8192)) (PreH28 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (INT_MAX >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre (cons (INT_MAX) ((@nil Z))) )
  **  (sll y (cons (0) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
.

Definition IntList_mergesort_partial_solve_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (INT_MAX >= (INT_MIN))) (PreH4 : (y_2 <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (0 >= (INT_MIN))) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_2 <> 0)) (PreH20 : (y <> 0)) (PreH21 : (xs_pre <> 0)) (PreH22 : (y <> 0)) (PreH23 : (y_3 = 0)) (PreH24 : (y_3 = 0)) (PreH25 : (y_2 <> 0)) (PreH26 : (y <> 0)) (PreH27 : (xs_pre <> 0)) (PreH28 : (xs_pre <> 0)) (PreH29 : (xs_pre = 8192)) (PreH30 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (INT_MAX >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre (cons (INT_MAX) ((@nil Z))) )
  **  (sll 0 (@nil Z) )
  **  ((( &( "zs_spec_877" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_875" ) )) # Ptr  |-> y_2)
  **  ((( &( "xs_spec_874" ) )) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
.

Definition IntList_mergesort_partial_solve_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_partial_solve_wit_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (y <> 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_3 = 0)) (PreH16 : (y_2 <> 0)) (PreH17 : (y <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre <> 0)) (PreH20 : (xs_pre = 8192)) (PreH21 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons (0) ((@nil Z))) )
  **  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (0 >= (INT_MIN))) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (y <> 0)) (PreH17 : (y_3 = 0)) (PreH18 : (y_3 = 0)) (PreH19 : (y_2 <> 0)) (PreH20 : (y <> 0)) (PreH21 : (xs_pre <> 0)) (PreH22 : (xs_pre <> 0)) (PreH23 : (xs_pre = 8192)) (PreH24 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 >= (INT_MIN)) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons (0) ((@nil Z))) )
  **  (sll 0 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (y <> 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_3 = 0)) (PreH15 : (y_2 <> 0)) (PreH16 : (y <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre <> 0)) (PreH19 : (xs_pre = 8192)) (PreH20 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons (0) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_2 <> 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y_3 = 0)) (PreH10 : (y_3 = 0)) (PreH11 : (y_2 <> 0)) (PreH12 : (y <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_799" ) ) (make_record_int_list_pair (y) (y_2)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_774" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_774" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_799" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_799" ) ) + 0)) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_774" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_774" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_799" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_799" ) ) + 0)) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_774" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_774" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_799" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_799" ) ) + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_774" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_774" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_2 <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_3 = 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_2 <> 0)) (PreH14 : (y <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre = 8192)) (PreH18 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y_3 (@nil Z) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_588" ) ) (make_record_int_list_pair (0) (0)) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_588" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_588" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_588" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_588" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_588" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_588" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  ((( &( "xs_spec_770" ) )) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_774" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_774" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_774" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (y <> 0)) (PreH12 : (y_3 = 0)) (PreH13 : (y_3 = 0)) (PreH14 : (y_2 <> 0)) (PreH15 : (y <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre <> 0)) (PreH18 : (xs_pre = 8192)) (PreH19 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> y)
  **  (UndefStructPredint_list_pair ( &( "p_spec_755" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_755" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_755" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre (cons (INT_MAX) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
.

Definition IntList_mergesort_partial_solve_wit_18 :=
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

Definition IntList_mergesort_partial_solve_wit_19 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
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
  &&  (sll xs_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
.

Definition IntList_mergesort_partial_solve_wit_20 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_596" ) ) (make_record_int_list_pair (xs_pre) (y)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_596" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_596" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_partial_solve_wit_21 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_596" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_596" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_596" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_596" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_partial_solve_wit_22 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_3 = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_2 <> 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y_2 (cons ((INT_MIN)) ((@nil Z))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_partial_solve_wit_23 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_592" ) ) (make_record_int_list_pair (0) (y_2)) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_592" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_592" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_partial_solve_wit_24 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_592" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_592" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_592" ) ) + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_592" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_partial_solve_wit_25 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_partial_solve_wit_26 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (record_return: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_3 = 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_mergesort_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_mergesort_safety_wit_1 : IntList_mergesort_safety_wit_1.
Axiom proof_of_IntList_mergesort_safety_wit_2 : IntList_mergesort_safety_wit_2.
Axiom proof_of_IntList_mergesort_safety_wit_3 : IntList_mergesort_safety_wit_3.
Axiom proof_of_IntList_mergesort_safety_wit_4 : IntList_mergesort_safety_wit_4.
Axiom proof_of_IntList_mergesort_safety_wit_5 : IntList_mergesort_safety_wit_5.
Axiom proof_of_IntList_mergesort_safety_wit_6 : IntList_mergesort_safety_wit_6.
Axiom proof_of_IntList_mergesort_safety_wit_7 : IntList_mergesort_safety_wit_7.
Axiom proof_of_IntList_mergesort_safety_wit_8 : IntList_mergesort_safety_wit_8.
Axiom proof_of_IntList_mergesort_safety_wit_9 : IntList_mergesort_safety_wit_9.
Axiom proof_of_IntList_mergesort_safety_wit_10 : IntList_mergesort_safety_wit_10.
Axiom proof_of_IntList_mergesort_safety_wit_11 : IntList_mergesort_safety_wit_11.
Axiom proof_of_IntList_mergesort_safety_wit_12 : IntList_mergesort_safety_wit_12.
Axiom proof_of_IntList_mergesort_safety_wit_13 : IntList_mergesort_safety_wit_13.
Axiom proof_of_IntList_mergesort_safety_wit_14 : IntList_mergesort_safety_wit_14.
Axiom proof_of_IntList_mergesort_safety_wit_15 : IntList_mergesort_safety_wit_15.
Axiom proof_of_IntList_mergesort_safety_wit_16 : IntList_mergesort_safety_wit_16.
Axiom proof_of_IntList_mergesort_safety_wit_17 : IntList_mergesort_safety_wit_17.
Axiom proof_of_IntList_mergesort_safety_wit_18 : IntList_mergesort_safety_wit_18.
Axiom proof_of_IntList_mergesort_safety_wit_19 : IntList_mergesort_safety_wit_19.
Axiom proof_of_IntList_mergesort_safety_wit_20 : IntList_mergesort_safety_wit_20.
Axiom proof_of_IntList_mergesort_safety_wit_21 : IntList_mergesort_safety_wit_21.
Axiom proof_of_IntList_mergesort_safety_wit_22 : IntList_mergesort_safety_wit_22.
Axiom proof_of_IntList_mergesort_safety_wit_23 : IntList_mergesort_safety_wit_23.
Axiom proof_of_IntList_mergesort_safety_wit_24 : IntList_mergesort_safety_wit_24.
Axiom proof_of_IntList_mergesort_safety_wit_25 : IntList_mergesort_safety_wit_25.
Axiom proof_of_IntList_mergesort_safety_wit_26 : IntList_mergesort_safety_wit_26.
Axiom proof_of_IntList_mergesort_safety_wit_27 : IntList_mergesort_safety_wit_27.
Axiom proof_of_IntList_mergesort_safety_wit_28 : IntList_mergesort_safety_wit_28.
Axiom proof_of_IntList_mergesort_safety_wit_29 : IntList_mergesort_safety_wit_29.
Axiom proof_of_IntList_mergesort_safety_wit_30 : IntList_mergesort_safety_wit_30.
Axiom proof_of_IntList_mergesort_safety_wit_31 : IntList_mergesort_safety_wit_31.
Axiom proof_of_IntList_mergesort_safety_wit_32 : IntList_mergesort_safety_wit_32.
Axiom proof_of_IntList_mergesort_safety_wit_33 : IntList_mergesort_safety_wit_33.
Axiom proof_of_IntList_mergesort_safety_wit_34 : IntList_mergesort_safety_wit_34.
Axiom proof_of_IntList_mergesort_safety_wit_35 : IntList_mergesort_safety_wit_35.
Axiom proof_of_IntList_mergesort_safety_wit_36 : IntList_mergesort_safety_wit_36.
Axiom proof_of_IntList_mergesort_safety_wit_37 : IntList_mergesort_safety_wit_37.
Axiom proof_of_IntList_mergesort_safety_wit_38 : IntList_mergesort_safety_wit_38.
Axiom proof_of_IntList_mergesort_safety_wit_39 : IntList_mergesort_safety_wit_39.
Axiom proof_of_IntList_mergesort_safety_wit_40 : IntList_mergesort_safety_wit_40.
Axiom proof_of_IntList_mergesort_safety_wit_41 : IntList_mergesort_safety_wit_41.
Axiom proof_of_IntList_mergesort_safety_wit_42 : IntList_mergesort_safety_wit_42.
Axiom proof_of_IntList_mergesort_safety_wit_43 : IntList_mergesort_safety_wit_43.
Axiom proof_of_IntList_mergesort_safety_wit_44 : IntList_mergesort_safety_wit_44.
Axiom proof_of_IntList_mergesort_safety_wit_45 : IntList_mergesort_safety_wit_45.
Axiom proof_of_IntList_mergesort_safety_wit_46 : IntList_mergesort_safety_wit_46.
Axiom proof_of_IntList_mergesort_safety_wit_47 : IntList_mergesort_safety_wit_47.
Axiom proof_of_IntList_mergesort_safety_wit_48 : IntList_mergesort_safety_wit_48.
Axiom proof_of_IntList_mergesort_safety_wit_49 : IntList_mergesort_safety_wit_49.
Axiom proof_of_IntList_mergesort_safety_wit_50 : IntList_mergesort_safety_wit_50.
Axiom proof_of_IntList_mergesort_safety_wit_51 : IntList_mergesort_safety_wit_51.
Axiom proof_of_IntList_mergesort_safety_wit_52 : IntList_mergesort_safety_wit_52.
Axiom proof_of_IntList_mergesort_safety_wit_53 : IntList_mergesort_safety_wit_53.
Axiom proof_of_IntList_mergesort_safety_wit_54 : IntList_mergesort_safety_wit_54.
Axiom proof_of_IntList_mergesort_entail_wit_1 : IntList_mergesort_entail_wit_1.
Axiom proof_of_IntList_mergesort_entail_wit_2 : IntList_mergesort_entail_wit_2.
Axiom proof_of_IntList_mergesort_entail_wit_3 : IntList_mergesort_entail_wit_3.
Axiom proof_of_IntList_mergesort_entail_wit_4 : IntList_mergesort_entail_wit_4.
Axiom proof_of_IntList_mergesort_entail_wit_5 : IntList_mergesort_entail_wit_5.
Axiom proof_of_IntList_mergesort_entail_wit_6 : IntList_mergesort_entail_wit_6.
Axiom proof_of_IntList_mergesort_entail_wit_7 : IntList_mergesort_entail_wit_7.
Axiom proof_of_IntList_mergesort_entail_wit_8 : IntList_mergesort_entail_wit_8.
Axiom proof_of_IntList_mergesort_entail_wit_9 : IntList_mergesort_entail_wit_9.
Axiom proof_of_IntList_mergesort_entail_wit_10 : IntList_mergesort_entail_wit_10.
Axiom proof_of_IntList_mergesort_entail_wit_11 : IntList_mergesort_entail_wit_11.
Axiom proof_of_IntList_mergesort_entail_wit_12 : IntList_mergesort_entail_wit_12.
Axiom proof_of_IntList_mergesort_entail_wit_13 : IntList_mergesort_entail_wit_13.
Axiom proof_of_IntList_mergesort_return_wit_1 : IntList_mergesort_return_wit_1.
Axiom proof_of_IntList_mergesort_partial_solve_wit_1 : IntList_mergesort_partial_solve_wit_1.
Axiom proof_of_IntList_mergesort_partial_solve_wit_2 : IntList_mergesort_partial_solve_wit_2.
Axiom proof_of_IntList_mergesort_partial_solve_wit_3 : IntList_mergesort_partial_solve_wit_3.
Axiom proof_of_IntList_mergesort_partial_solve_wit_4 : IntList_mergesort_partial_solve_wit_4.
Axiom proof_of_IntList_mergesort_partial_solve_wit_5 : IntList_mergesort_partial_solve_wit_5.
Axiom proof_of_IntList_mergesort_partial_solve_wit_6 : IntList_mergesort_partial_solve_wit_6.
Axiom proof_of_IntList_mergesort_partial_solve_wit_7 : IntList_mergesort_partial_solve_wit_7.
Axiom proof_of_IntList_mergesort_partial_solve_wit_8 : IntList_mergesort_partial_solve_wit_8.
Axiom proof_of_IntList_mergesort_partial_solve_wit_9 : IntList_mergesort_partial_solve_wit_9.
Axiom proof_of_IntList_mergesort_partial_solve_wit_10 : IntList_mergesort_partial_solve_wit_10.
Axiom proof_of_IntList_mergesort_partial_solve_wit_11 : IntList_mergesort_partial_solve_wit_11.
Axiom proof_of_IntList_mergesort_partial_solve_wit_12 : IntList_mergesort_partial_solve_wit_12.
Axiom proof_of_IntList_mergesort_partial_solve_wit_13 : IntList_mergesort_partial_solve_wit_13.
Axiom proof_of_IntList_mergesort_partial_solve_wit_14 : IntList_mergesort_partial_solve_wit_14.
Axiom proof_of_IntList_mergesort_partial_solve_wit_15 : IntList_mergesort_partial_solve_wit_15.
Axiom proof_of_IntList_mergesort_partial_solve_wit_16 : IntList_mergesort_partial_solve_wit_16.
Axiom proof_of_IntList_mergesort_partial_solve_wit_17 : IntList_mergesort_partial_solve_wit_17.
Axiom proof_of_IntList_mergesort_partial_solve_wit_18 : IntList_mergesort_partial_solve_wit_18.
Axiom proof_of_IntList_mergesort_partial_solve_wit_19 : IntList_mergesort_partial_solve_wit_19.
Axiom proof_of_IntList_mergesort_partial_solve_wit_20 : IntList_mergesort_partial_solve_wit_20.
Axiom proof_of_IntList_mergesort_partial_solve_wit_21 : IntList_mergesort_partial_solve_wit_21.
Axiom proof_of_IntList_mergesort_partial_solve_wit_22 : IntList_mergesort_partial_solve_wit_22.
Axiom proof_of_IntList_mergesort_partial_solve_wit_23 : IntList_mergesort_partial_solve_wit_23.
Axiom proof_of_IntList_mergesort_partial_solve_wit_24 : IntList_mergesort_partial_solve_wit_24.
Axiom proof_of_IntList_mergesort_partial_solve_wit_25 : IntList_mergesort_partial_solve_wit_25.
Axiom proof_of_IntList_mergesort_partial_solve_wit_26 : IntList_mergesort_partial_solve_wit_26.
Axiom proof_of_IntList_mergesort_precondition_wit_1 : IntList_mergesort_precondition_wit_1.

End VC_Correct.
