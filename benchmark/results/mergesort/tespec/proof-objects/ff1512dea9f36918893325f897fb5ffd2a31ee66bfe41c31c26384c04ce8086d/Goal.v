From SimpleC.Verification Require Import VCPrelude.
Require Import input_def.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_mergesort -----*)

Definition IntList_mergesort_safety_wit_1 :=
  ((( &( "xs_spec_512" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_512" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_mergesort_safety_wit_3 :=
forall (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_2 <> 0)) (PreH3 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_523" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_512" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_4 :=
forall (y: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> INT_MAX)
  **  ((( &( "tail_spec_523" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_512" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_mergesort_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_snd: Z) (retval_fst: Z) (retval_2: Z) (retval_3: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval_fst)) (PreH11 : (retval_fst <= UINT_MAX)) (PreH12 : (0 <= retval_snd)) (PreH13 : (retval_snd <= UINT_MAX)) (PreH14 : (0 <= retval_2)) (PreH15 : (retval_2 <= UINT_MAX)) (PreH16 : (0 <= retval_3)) (PreH17 : (retval_3 <= UINT_MAX)) (PreH18 : (0 <= retval)) (PreH19 : (retval <= UINT_MAX)),
  (sll retval (cn_merge ((cn_mergesort ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))))))) ((cn_mergesort ((cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))))) )
|--
  (sll retval (cn_mergesort (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_snd: Z) (retval_fst: Z) (retval_2: Z) (retval_3: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval_fst)) (PreH11 : (retval_fst <= UINT_MAX)) (PreH12 : (0 <= retval_snd)) (PreH13 : (retval_snd <= UINT_MAX)) (PreH14 : (0 <= retval_2)) (PreH15 : (retval_2 <= UINT_MAX)) (PreH16 : (0 <= retval_3)) (PreH17 : (retval_3 <= UINT_MAX)) (PreH18 : (0 <= retval)) (PreH19 : (retval <= UINT_MAX)),
  TT && emp 
|--
  “ ((cn_merge ((cn_mergesort ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))))))) ((cn_mergesort ((cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))))) = (cn_mergesort (l___tespec_entry))) ”
  &&  emp
).

Definition IntList_mergesort_return_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_snd: Z) (retval_fst: Z) (retval_2: Z) (retval_3: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval_fst)) (PreH11 : (retval_fst <= UINT_MAX)) (PreH12 : (0 <= retval_snd)) (PreH13 : (retval_snd <= UINT_MAX)) (PreH14 : (0 <= retval_2)) (PreH15 : (retval_2 <= UINT_MAX)) (PreH16 : (0 <= retval_3)) (PreH17 : (retval_3 <= UINT_MAX)) (PreH18 : (0 <= retval)) (PreH19 : (retval <= UINT_MAX)),
  ((cn_merge ((cn_mergesort ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))))))) ((cn_mergesort ((cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))))) = (cn_mergesort (l___tespec_entry)))
.

Definition IntList_mergesort_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_snd: Z) (retval_fst: Z) (retval: Z) (retval_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval_fst)) (PreH11 : (retval_fst <= UINT_MAX)) (PreH12 : (0 <= retval_snd)) (PreH13 : (retval_snd <= UINT_MAX)) (PreH14 : (0 <= retval)) (PreH15 : (retval <= UINT_MAX)) (PreH16 : (0 <= retval_2)) (PreH17 : (retval_2 <= UINT_MAX)),
  (sll retval_2 (cn_mergesort ((cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))) )
  **  (sll retval (cn_mergesort ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_525" ) ) + 4)) # Ptr  |-> retval_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_525" ) ) + 0)) # Ptr  |-> retval)
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
  &&  “ (0 <= retval_fst) ”
  &&  “ (retval_fst <= UINT_MAX) ”
  &&  “ (0 <= retval_snd) ”
  &&  “ (retval_snd <= UINT_MAX) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  “ (0 <= retval_2) ”
  &&  “ (retval_2 <= UINT_MAX) ”
  &&  (sll retval (cn_mergesort ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))) )
  **  (sll retval_2 (cn_mergesort ((cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_525" ) ) + 4)) # Ptr  |-> retval_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_525" ) ) + 0)) # Ptr  |-> retval)
.

Definition IntList_mergesort_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_snd: Z) (retval_fst: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval_fst)) (PreH11 : (retval_fst <= UINT_MAX)) (PreH12 : (0 <= retval_snd)) (PreH13 : (retval_snd <= UINT_MAX)) (PreH14 : (0 <= retval)) (PreH15 : (retval <= UINT_MAX)),
  (sll retval (cn_mergesort ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_525" ) ) + 4)) # Ptr  |-> retval_snd)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_525" ) ) + 0)) # Ptr  |-> retval)
  **  (sll retval_snd (cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
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
  &&  “ (0 <= retval_fst) ”
  &&  “ (retval_fst <= UINT_MAX) ”
  &&  “ (0 <= retval_snd) ”
  &&  “ (retval_snd <= UINT_MAX) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (sll retval_snd (cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (sll retval (cn_mergesort ((cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_525" ) ) + 4)) # Ptr  |-> retval_snd)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_525" ) ) + 0)) # Ptr  |-> retval)
.

Definition IntList_mergesort_partial_solve_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_snd: Z) (retval_fst: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval_fst)) (PreH11 : (retval_fst <= UINT_MAX)) (PreH12 : (0 <= retval_snd)) (PreH13 : (retval_snd <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_525" ) ) + 4)) # Ptr  |-> retval_snd)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_525" ) ) + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (sll retval_snd (cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
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
  &&  “ (0 <= retval_fst) ”
  &&  “ (retval_fst <= UINT_MAX) ”
  &&  “ (0 <= retval_snd) ”
  &&  “ (retval_snd <= UINT_MAX) ”
  &&  (sll retval_fst (cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_525" ) ) + 4)) # Ptr  |-> retval_snd)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_525" ) ) + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_snd (cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
.

Definition IntList_mergesort_partial_solve_wit_4 :=
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

Definition IntList_mergesort_partial_solve_wit_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_525" ) ) )
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
  **  (UndefStructPredint_list_pair ( &( "p_spec_525" ) ) )
.

Definition IntList_mergesort_partial_solve_wit_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_snd: Z) (retval_fst: Z) (retval: Z) (PreH1 : (y <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH10 : (0 <= retval_fst)) (PreH11 : (retval_fst <= UINT_MAX)) (PreH12 : (0 <= retval_snd)) (PreH13 : (retval_snd <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_525" ) ) )
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
  &&  “ (0 <= retval_fst) ”
  &&  “ (retval_fst <= UINT_MAX) ”
  &&  “ (0 <= retval_snd) ”
  &&  “ (retval_snd <= UINT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_525" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_525" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (sll retval_snd (cn_split_snd ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
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
Axiom proof_of_IntList_mergesort_return_wit_1 : IntList_mergesort_return_wit_1.
Axiom proof_of_IntList_mergesort_partial_solve_wit_1 : IntList_mergesort_partial_solve_wit_1.
Axiom proof_of_IntList_mergesort_partial_solve_wit_2 : IntList_mergesort_partial_solve_wit_2.
Axiom proof_of_IntList_mergesort_partial_solve_wit_3 : IntList_mergesort_partial_solve_wit_3.
Axiom proof_of_IntList_mergesort_partial_solve_wit_4 : IntList_mergesort_partial_solve_wit_4.
Axiom proof_of_IntList_mergesort_partial_solve_wit_5 : IntList_mergesort_partial_solve_wit_5.
Axiom proof_of_IntList_mergesort_partial_solve_wit_6 : IntList_mergesort_partial_solve_wit_6.
Axiom proof_of_IntList_mergesort_precondition_wit_1 : IntList_mergesort_precondition_wit_1.

End VC_Correct.
