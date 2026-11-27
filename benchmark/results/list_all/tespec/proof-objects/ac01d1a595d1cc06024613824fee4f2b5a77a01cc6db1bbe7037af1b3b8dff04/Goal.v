From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_ec5eb2e77309e00519b44a2d.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append2 -----*)

Definition IntList_append2_safety_wit_1 :=
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll 16384 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
|--
  “ False ”
.

Definition IntList_append2_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (retval_2: Z) (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z) (retval: Z) (PreH1 : (y_9 = 0)) (PreH2 : (y_9 = 0)) (PreH3 : (y_8 <> 0)) (PreH4 : (y_7 <> 0)) (PreH5 : (y_6 = 0)) (PreH6 : (y_6 = 0)) (PreH7 : (y_5 = 0)) (PreH8 : (y_5 = 0)) (PreH9 : (y_4 <> 0)) (PreH10 : (y_3 <> 0)) (PreH11 : (y_2 = 0)) (PreH12 : (y_2 = 0)) (PreH13 : (y <> 0)) (PreH14 : (xs_pre <> 0)) (PreH15 : (ys_pre <> 0)) (PreH16 : (xs_pre <> 0)) (PreH17 : (xs_pre = 8192)) (PreH18 : (ys_pre = 16384)) (PreH19 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH20 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH21 : (0 <= retval_2)) (PreH22 : (retval_2 <= UINT_MAX)) (PreH23 : (0 <= retval)) (PreH24 : (retval <= UINT_MAX)),
  (sll retval (cons (2) ((app ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_8 + 4)) # Ptr  |-> y_9)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_8 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_7 + 4)) # Ptr  |-> y_8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_7 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
  **  (sll retval (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append2_partial_solve_wit_1_pure :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (retval: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (ys_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 16384)) (PreH13 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH15 : (0 <= retval)) (PreH16 : (retval <= UINT_MAX)),
  (sll y (cons ((-1)) ((@nil Z))) )
  **  (sll ys_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll retval (app ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (2 = 2) ”
.

Definition IntList_append2_partial_solve_wit_1_aux :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (retval: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (ys_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 16384)) (PreH13 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH15 : (0 <= retval)) (PreH16 : (retval <= UINT_MAX)),
  (sll y (cons ((-1)) ((@nil Z))) )
  **  (sll ys_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll retval (app ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (y_6: Z) (y_7: Z) (y_8: Z) (y_9: Z),
  “ (2 = 2) ”
  &&  “ (y_9 = 0) ”
  &&  “ (y_9 = 0) ”
  &&  “ (y_8 <> 0) ”
  &&  “ (y_7 <> 0) ”
  &&  “ (y_6 = 0) ”
  &&  “ (y_6 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (sll retval (app ((cons ((-1)) ((@nil Z)))) ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_8 + 4)) # Ptr  |-> y_9)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_8 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_7 + 4)) # Ptr  |-> y_8)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_7 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_6)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_append2_partial_solve_wit_1 := IntList_append2_partial_solve_wit_1_pure -> IntList_append2_partial_solve_wit_1_aux.

Definition IntList_append2_partial_solve_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (ys_pre <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH7 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z),
  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_append2_partial_solve_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y_3 <> 0)) (PreH5 : (y_2 = 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (ys_pre <> 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (xs_pre = 8192)) (PreH12 : (ys_pre = 16384)) (PreH13 : (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH14 : (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_3 + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_3 + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y_3 <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll y (cons ((-1)) ((@nil Z))) )
  **  (sll ys_pre (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_append2_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (b___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_append2_safety_wit_1 : IntList_append2_safety_wit_1.
Axiom proof_of_IntList_append2_safety_wit_2 : IntList_append2_safety_wit_2.
Axiom proof_of_IntList_append2_return_wit_1 : IntList_append2_return_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_1_pure : IntList_append2_partial_solve_wit_1_pure.
Axiom proof_of_IntList_append2_partial_solve_wit_1 : IntList_append2_partial_solve_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_2 : IntList_append2_partial_solve_wit_2.
Axiom proof_of_IntList_append2_partial_solve_wit_3 : IntList_append2_partial_solve_wit_3.
Axiom proof_of_IntList_append2_precondition_wit_1 : IntList_append2_precondition_wit_1.

End VC_Correct.
