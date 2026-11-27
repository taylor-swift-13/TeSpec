From SimpleC.Verification Require Import VCPrelude.
Require Import input_def.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_mergesort -----*)

Definition IntList_mergesort_safety_wit_1 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y <> 0)),
  ((( &( "ys_spec_764" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_763" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_612" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_2 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_764" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_763" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_612" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_3 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y <> 0)),
  ((( &( "ys_spec_764" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_763" ) )) # Ptr  |-> 8192)
  **  ((( &( "zs_spec_612" ) )) # Ptr  |->_)
  **  ((( &( "ys_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_4 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y <> 0)),
  ((( &( "ys_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_5 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_6 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y <> 0)),
  ((( &( "ys_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_7 :=
forall (PreH1 : False),
  ((( &( "ys_spec_753" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_8 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_753" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_752" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_9 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)),
  ((( &( "xs_spec_737" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_10 :=
forall (PreH1 : False),
  ((( &( "xs_spec_737" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_11 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y <> 0)),
  ((( &( "tail_spec_739" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_737" ) )) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_12 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)),
  ((( &( "xs_spec_727" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_13 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_727" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_14 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)),
  ((( &( "tail_spec_729" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_727" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_15 :=
  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_16 :=
forall (PreH1 : False),
  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_17 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_18 :=
forall (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_19 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)),
  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_20 :=
forall (y: Z) (y_2: Z) (PreH1 : False),
  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_21 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)),
  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_22 :=
forall (PreH1 : False),
  ((( &( "cdr_spec_590" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_23 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)),
  ((( &( "xs_spec_691" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_24 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_691" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_25 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)),
  ((( &( "xs_spec_691" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_26 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y <> 0)),
  ((( &( "xs_spec_691" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "cdr_spec_590" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> 8192)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tail_spec_625" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_614" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_entail_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z),
  “ (retval = xs_pre) ”
  &&  “ (2 >= (-1)) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (cn_merge ((cons (2) ((@nil Z)))) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ ((cn_merge ((cons (2) ((@nil Z)))) ((@nil Z))) = (cons (2) ((@nil Z)))) ”
  &&  “ (2 >= (-1)) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_merge ((cons (2) ((@nil Z)))) ((@nil Z))) = (cons (2) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_1_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (2 >= (-1))
.

Definition IntList_mergesort_entail_wit_1_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_1_split_goal_17 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_1_split_goal_18 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_2 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (cn_merge ((cons (2) ((@nil Z)))) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_merge ((cons (2) ((@nil Z)))) ((cons ((-1)) ((@nil Z))))) = (cons ((-1)) ((cons (2) ((@nil Z)))))) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_2_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_merge ((cons (2) ((@nil Z)))) ((cons ((-1)) ((@nil Z))))) = (cons ((-1)) ((cons (2) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_2_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_2_split_goal_15 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_2_split_goal_16 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_3 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (cn_mergesort ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ (y <> 0) ”
  &&  “ ((cn_mergesort ((cons ((-1)) ((@nil Z))))) = (cons ((-1)) ((@nil Z)))) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_3_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_mergesort ((cons ((-1)) ((@nil Z))))) = (cons ((-1)) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_3_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_3_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_3_split_goal_14 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_4 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z),
  “ (retval = xs_pre) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (cn_mergesort ((cons (2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ ((cn_mergesort ((cons (2) ((@nil Z))))) = (cons (2) ((@nil Z)))) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_4_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_mergesort ((cons (2) ((@nil Z))))) = (cons (2) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_4_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y_2 = 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_entail_wit_4_split_goal_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre = 8192)
.

Definition IntList_mergesort_entail_wit_4_split_goal_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))
.

Definition IntList_mergesort_entail_wit_5 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval_snd: Z) (retval_fst: Z) (retval: Z),
  “ (retval = record_return) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((@nil Z))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ ((cn_split_snd ((@nil Z))) = (@nil Z)) ”
  &&  “ ((cn_split_fst ((@nil Z))) = (@nil Z)) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_5_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_snd ((@nil Z))) = (@nil Z))
.

Definition IntList_mergesort_entail_wit_5_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_fst ((@nil Z))) = (@nil Z))
.

Definition IntList_mergesort_entail_wit_5_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_5_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_6 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval_snd: Z) (retval_fst: Z) (retval: Z),
  “ (retval = record_return) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ (8192 <> 0) ”
  &&  “ ((cn_split_fst ((cons (2) ((cons ((-1)) ((@nil Z))))))) = (cons (2) ((@nil Z)))) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_split_snd ((cons (2) ((cons ((-1)) ((@nil Z))))))) = (cons ((-1)) ((@nil Z)))) ”
  &&  “ (y <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  emp
).

Definition IntList_mergesort_entail_wit_6_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_fst ((cons (2) ((cons ((-1)) ((@nil Z))))))) = (cons (2) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_6_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_snd ((cons (2) ((cons ((-1)) ((@nil Z))))))) = (cons ((-1)) ((@nil Z))))
.

Definition IntList_mergesort_entail_wit_6_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (0 = 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_entail_wit_6_split_goal_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_mergesort_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll y (cn_mergesort (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_mergesort (l___tespec_entry)) = (cons ((-1)) ((cons (2) ((@nil Z)))))) ”
  &&  emp
).

Definition IntList_mergesort_return_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_mergesort_return_wit_1_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_mergesort_return_wit_1_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (2 >= (-1))) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (y <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre <> 0)) (PreH16 : (xs_pre = 8192)) (PreH17 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_mergesort (l___tespec_entry)) = (cons ((-1)) ((cons (2) ((@nil Z))))))
.

Definition IntList_mergesort_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y <> 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y_2 = 0)) (PreH9 : (y <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre <> 0)) (PreH12 : (xs_pre = 8192)) (PreH13 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre (cons (2) ((@nil Z))) )
  **  (sll y (cons ((-1)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
.

Definition IntList_mergesort_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (2 >= (-1))) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 = 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y <> 0)) (PreH13 : (xs_pre <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (xs_pre = 8192)) (PreH16 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (2 >= (-1)) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre (cons (2) ((@nil Z))) )
  **  (sll 0 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
.

Definition IntList_mergesort_partial_solve_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y_2 = 0)) (PreH8 : (y <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (xs_pre <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (cons ((-1)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre (cons (2) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
.

Definition IntList_mergesort_partial_solve_wit_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z),
  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
.

Definition IntList_mergesort_partial_solve_wit_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_596" ) ) (make_record_int_list_pair (xs_pre) (y)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_596" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_596" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_596" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_596" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_596" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_596" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_9 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (y <> 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y_2 (@nil Z) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_10 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_588" ) ) (make_record_int_list_pair (0) (0)) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_588" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_588" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_11 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_588" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_588" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_588" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_588" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  ((( &( "xs_spec_682" ) )) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_12 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_594" ) ) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_594" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_594" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_partial_solve_wit_13 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (y <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair ( &( "p_spec_627" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_627" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_627" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_mergesort_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
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
Axiom proof_of_IntList_mergesort_entail_wit_1 : IntList_mergesort_entail_wit_1.
Axiom proof_of_IntList_mergesort_entail_wit_2 : IntList_mergesort_entail_wit_2.
Axiom proof_of_IntList_mergesort_entail_wit_3 : IntList_mergesort_entail_wit_3.
Axiom proof_of_IntList_mergesort_entail_wit_4 : IntList_mergesort_entail_wit_4.
Axiom proof_of_IntList_mergesort_entail_wit_5 : IntList_mergesort_entail_wit_5.
Axiom proof_of_IntList_mergesort_entail_wit_6 : IntList_mergesort_entail_wit_6.
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
Axiom proof_of_IntList_mergesort_precondition_wit_1 : IntList_mergesort_precondition_wit_1.

End VC_Correct.
