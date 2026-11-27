From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_ec5eb2e77309e00519b44a2d.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_cons -----*)

Definition IntList_cons_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (t_pre <> 0)) (PreH7 : (h_pre = (-1))) (PreH8 : (t_pre = 8192)) (PreH9 : (h0___tespec_entry = (-1))) (PreH10 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH11 : (h_pre = h0___tespec_entry)) (PreH12 : (0 <= retval)) (PreH13 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> h_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> t_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> INT_MAX)
|--
  “ (retval <> 0) ”
  &&  (sll retval (cons (h0___tespec_entry) (l___tespec_entry)) )
.

Definition IntList_cons_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (PreH1 : (t_pre <> 0)) (PreH2 : (h_pre = (-1))) (PreH3 : (t_pre = 8192)) (PreH4 : (h0___tespec_entry = (-1))) (PreH5 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (h_pre = h0___tespec_entry)),
  (sll t_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (t_pre <> 0) ”
  &&  “ (h_pre = (-1)) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (h0___tespec_entry = (-1)) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (h_pre = h0___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> INT_MAX)
.

Definition IntList_cons_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (h0___tespec_entry: Z),
exists (h_pre: Z),
exists (t_pre: Z),
~ ((  “ (t_pre <> 0) ”
  &&  “ (h_pre = (-1)) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (h0___tespec_entry = (-1)) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (h_pre = h0___tespec_entry) ”
  &&  (sll t_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Axiom proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Axiom proof_of_IntList_cons_precondition_wit_1 : IntList_cons_precondition_wit_1.

End VC_Correct.
