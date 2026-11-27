From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append -----*)

Definition IntList_append_safety_wit_1 :=
  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_append_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_484" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_append_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (ys_pre = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))) (PreH12 : (0 <= retval)) (PreH13 : (retval <= UINT_MAX)),
  (sll retval (app ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
|--
  (sll xs_pre (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append_partial_solve_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (ys_pre = 0)) (PreH5 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (b___tespec_entry = (@nil Z))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_append_partial_solve_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (ys_pre = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (ys_pre = 0)) (PreH10 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (b___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
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
  &&  “ (ys_pre = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll y (cons (0) ((cons ((INT_MIN)) ((@nil Z))))) )
  **  (sll ys_pre (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_append_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_append_safety_wit_1 : IntList_append_safety_wit_1.
Axiom proof_of_IntList_append_safety_wit_2 : IntList_append_safety_wit_2.
Axiom proof_of_IntList_append_return_wit_1 : IntList_append_return_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_1 : IntList_append_partial_solve_wit_1.
Axiom proof_of_IntList_append_partial_solve_wit_2 : IntList_append_partial_solve_wit_2.
Axiom proof_of_IntList_append_precondition_wit_1 : IntList_append_precondition_wit_1.

End VC_Correct.
