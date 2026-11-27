From SimpleC.Verification Require Import VCPrelude.
Require Import input_def.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_split -----*)

Definition IntList_split_safety_wit_1 :=
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_split_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_split_safety_wit_3 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cdr_spec_493" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_split_safety_wit_4 :=
forall (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cdr_spec_493" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_split_safety_wit_5 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)),
  ((( &( "xs_spec_544" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cdr_spec_493" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_split_safety_wit_6 :=
forall (y: Z) (PreH1 : False),
  ((( &( "xs_spec_544" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cdr_spec_493" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_split_safety_wit_7 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)),
  ((( &( "xs_spec_544" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cdr_spec_493" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_split_safety_wit_8 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y <> 0)),
  ((( &( "xs_spec_544" ) )) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cdr_spec_493" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_split_entail_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
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
  **  (sll retval_fst (cn_split_fst ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd ((@nil Z))) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ ((cn_split_snd ((@nil Z))) = (@nil Z)) ”
  &&  “ ((cn_split_fst ((@nil Z))) = (@nil Z)) ”
  &&  “ (y <> 0) ”
  &&  “ (0 = 0) ”
  &&  “ (0 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  “ (8192 <> 0) ”
  &&  emp
).

Definition IntList_split_entail_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_snd ((@nil Z))) = (@nil Z))
.

Definition IntList_split_entail_wit_1_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_fst ((@nil Z))) = (@nil Z))
.

Definition IntList_split_entail_wit_1_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_split_entail_wit_1_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (0 = 0)
.

Definition IntList_split_entail_wit_1_split_goal_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (0 = 0)
.

Definition IntList_split_entail_wit_1_split_goal_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_split_entail_wit_1_split_goal_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_split_entail_wit_1_split_goal_8 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (8192 <> 0)
.

Definition IntList_split_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval_snd: Z) (retval_fst: Z),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ ((cn_split_fst (l___tespec_entry)) = (cons (2) ((@nil Z)))) ”
  &&  “ (y <> 0) ”
  &&  “ ((cn_split_snd (l___tespec_entry)) = (cons ((-1)) ((@nil Z)))) ”
  &&  emp
).

Definition IntList_split_return_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (xs_pre <> 0)
.

Definition IntList_split_return_wit_1_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_fst (l___tespec_entry)) = (cons (2) ((@nil Z))))
.

Definition IntList_split_return_wit_1_split_goal_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (y <> 0)
.

Definition IntList_split_return_wit_1_split_goal_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  ((cn_split_snd (l___tespec_entry)) = (cons ((-1)) ((@nil Z))))
.

Definition IntList_split_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_499" ) ) (make_record_int_list_pair (xs_pre) (y)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_497" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_497" ) ) + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_499" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_499" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_497" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_497" ) ) + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_split_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_499" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_499" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (UndefStructPredint_list_pair record_return )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_497" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_497" ) ) + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
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
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_499" ) ) + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_499" ) ) + 0)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_497" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_497" ) ) + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_split_partial_solve_wit_3 :=
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

Definition IntList_split_partial_solve_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
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
  &&  (sll y_2 (@nil Z) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_split_partial_solve_wit_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_491" ) ) (make_record_int_list_pair (0) (0)) )
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_491" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_491" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_split_partial_solve_wit_6 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_491" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_491" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> xs_pre)
|--
  “ (y_2 = 0) ”
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
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_491" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_491" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_split_partial_solve_wit_7 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (record_return: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair ( &( "p_spec_497" ) ) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "p_spec_497" ) ) + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "p_spec_497" ) ) + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_split_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_split_safety_wit_1 : IntList_split_safety_wit_1.
Axiom proof_of_IntList_split_safety_wit_2 : IntList_split_safety_wit_2.
Axiom proof_of_IntList_split_safety_wit_3 : IntList_split_safety_wit_3.
Axiom proof_of_IntList_split_safety_wit_4 : IntList_split_safety_wit_4.
Axiom proof_of_IntList_split_safety_wit_5 : IntList_split_safety_wit_5.
Axiom proof_of_IntList_split_safety_wit_6 : IntList_split_safety_wit_6.
Axiom proof_of_IntList_split_safety_wit_7 : IntList_split_safety_wit_7.
Axiom proof_of_IntList_split_safety_wit_8 : IntList_split_safety_wit_8.
Axiom proof_of_IntList_split_entail_wit_1 : IntList_split_entail_wit_1.
Axiom proof_of_IntList_split_return_wit_1 : IntList_split_return_wit_1.
Axiom proof_of_IntList_split_partial_solve_wit_1 : IntList_split_partial_solve_wit_1.
Axiom proof_of_IntList_split_partial_solve_wit_2 : IntList_split_partial_solve_wit_2.
Axiom proof_of_IntList_split_partial_solve_wit_3 : IntList_split_partial_solve_wit_3.
Axiom proof_of_IntList_split_partial_solve_wit_4 : IntList_split_partial_solve_wit_4.
Axiom proof_of_IntList_split_partial_solve_wit_5 : IntList_split_partial_solve_wit_5.
Axiom proof_of_IntList_split_partial_solve_wit_6 : IntList_split_partial_solve_wit_6.
Axiom proof_of_IntList_split_partial_solve_wit_7 : IntList_split_partial_solve_wit_7.
Axiom proof_of_IntList_split_precondition_wit_1 : IntList_split_precondition_wit_1.

End VC_Correct.
