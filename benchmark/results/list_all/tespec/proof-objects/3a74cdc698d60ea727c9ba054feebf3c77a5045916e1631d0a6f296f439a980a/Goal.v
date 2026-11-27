From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append2 -----*)

Definition IntList_append2_safety_wit_1 :=
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 8192 (cons (1) ((@nil Z))) )
  **  (sll 16384 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_append2_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (y_4: Z) (y_5: Z) (retval: Z) (PreH1 : (y_5 = 0)) (PreH2 : (y_5 = 0)) (PreH3 : (y_4 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y_3 = 0)) (PreH6 : (y_3 = 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y = 0)) (PreH9 : (y = 0)) (PreH10 : (xs_pre <> 0)) (PreH11 : (ys_pre <> 0)) (PreH12 : (xs_pre <> 0)) (PreH13 : (xs_pre = 8192)) (PreH14 : (ys_pre = 16384)) (PreH15 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH16 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH17 : (0 <= retval_2)) (PreH18 : (retval_2 <= UINT_MAX)) (PreH19 : (0 <= retval)) (PreH20 : (retval <= UINT_MAX)),
  (sll retval (cons (1) ((app ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z))))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
  **  (sll retval (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append2_partial_solve_wit_1_pure :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (ys_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 16384)) (PreH11 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH12 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  (sll y (@nil Z) )
  **  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll retval (app ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_515" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_500" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> ys_pre)
|--
  “ (1 = 1) ”
.

Definition IntList_append2_partial_solve_wit_1_aux :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (ys_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 16384)) (PreH11 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH12 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  (sll y (@nil Z) )
  **  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (sll retval (app ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (y_4: Z) (y_5: Z),
  “ (1 = 1) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_5 = 0) ”
  &&  “ (y_4 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (sll retval (app ((@nil Z)) ((cons (2) ((cons ((-1)) ((@nil Z))))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_4 + 4)) # Ptr  |-> y_5)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_4 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_4)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_1 := IntList_append2_partial_solve_wit_1_pure -> IntList_append2_partial_solve_wit_1_aux.

Definition IntList_append2_partial_solve_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (ys_pre <> 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre = 8192)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_append2_partial_solve_wit_3 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (ys_pre <> 0)) (PreH8 : (xs_pre <> 0)) (PreH9 : (xs_pre = 8192)) (PreH10 : (ys_pre = 16384)) (PreH11 : (a___tespec_entry = (cons (1) ((@nil Z))))) (PreH12 : (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (@nil Z) )
  **  (sll ys_pre (cons (2) ((cons ((-1)) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
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
  &&  “ (a___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (b___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
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
