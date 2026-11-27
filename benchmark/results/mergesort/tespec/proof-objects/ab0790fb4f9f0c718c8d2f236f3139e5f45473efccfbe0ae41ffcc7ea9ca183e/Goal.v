From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_merge -----*)

Definition IntList_merge_safety_wit_1 :=
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_merge_safety_wit_3 :=
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_4 :=
forall (PreH1 : False),
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_merge_return_wit_1 :=
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (ys_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (ys_pre = 16384)) (PreH12 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH13 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (0 <= retval)) (PreH15 : (retval <= UINT_MAX)),
  (sll retval (cn_merge ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> retval)
|--
  (sll xs_pre (cn_merge (l___tespec_entry) (r___tespec_entry)) )
) \/
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (ys_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (ys_pre = 16384)) (PreH12 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH13 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (0 <= retval)) (PreH15 : (retval <= UINT_MAX)),
  TT && emp 
|--
  “ (xs_pre <> 0) ”
  &&  “ ((cn_merge (l___tespec_entry) (r___tespec_entry)) = (cons (1) ((cn_merge ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z)))))))))) ”
  &&  emp
).

Definition IntList_merge_return_wit_1_split_goal_1 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (ys_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (ys_pre = 16384)) (PreH12 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH13 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (0 <= retval)) (PreH15 : (retval <= UINT_MAX)),
  (xs_pre <> 0)
.

Definition IntList_merge_return_wit_1_split_goal_2 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (ys_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (ys_pre = 16384)) (PreH12 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH13 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (0 <= retval)) (PreH15 : (retval <= UINT_MAX)),
  ((cn_merge (l___tespec_entry) (r___tespec_entry)) = (cons (1) ((cn_merge ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z))))))))))
.

Definition IntList_merge_partial_solve_wit_1 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (ys_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (ys_pre <> 0)) (PreH9 : (xs_pre <> 0)) (PreH10 : (xs_pre = 8192)) (PreH11 : (ys_pre = 16384)) (PreH12 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH13 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
|--
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (@nil Z) )
  **  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
.

Definition IntList_merge_partial_solve_wit_2 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (ys_pre = 16384)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
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
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (r___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_merge_safety_wit_1 : IntList_merge_safety_wit_1.
Axiom proof_of_IntList_merge_safety_wit_2 : IntList_merge_safety_wit_2.
Axiom proof_of_IntList_merge_safety_wit_3 : IntList_merge_safety_wit_3.
Axiom proof_of_IntList_merge_safety_wit_4 : IntList_merge_safety_wit_4.
Axiom proof_of_IntList_merge_return_wit_1 : IntList_merge_return_wit_1.
Axiom proof_of_IntList_merge_partial_solve_wit_1 : IntList_merge_partial_solve_wit_1.
Axiom proof_of_IntList_merge_partial_solve_wit_2 : IntList_merge_partial_solve_wit_2.
Axiom proof_of_IntList_merge_precondition_wit_1 : IntList_merge_precondition_wit_1.

End VC_Correct.
