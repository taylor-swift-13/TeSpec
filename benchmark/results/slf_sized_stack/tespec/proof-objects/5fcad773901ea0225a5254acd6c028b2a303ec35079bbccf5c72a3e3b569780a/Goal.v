From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_cons -----*)

Definition IntList_cons_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (y: Z) (y_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (h_pre = INT_MAX)) (PreH4 : (t_pre = 8192)) (PreH5 : (h0___tespec_entry = INT_MAX)) (PreH6 : (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z))))))) (PreH7 : (h_pre = h0___tespec_entry)) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> h_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> t_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 2)
|--
  (sll retval (cons (h0___tespec_entry) (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (y: Z) (y_2: Z) (retval: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (1 <= INT_MAX)) (PreH3 : (2 >= INT_MIN)) (PreH4 : (1 >= INT_MIN)) (PreH5 : (retval <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (h_pre = INT_MAX)) (PreH8 : (t_pre = 8192)) (PreH9 : (h0___tespec_entry = INT_MAX)) (PreH10 : (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z))))))) (PreH11 : (h_pre = h0___tespec_entry)) (PreH12 : (0 <= retval)) (PreH13 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 2)
|--
  (sll t_pre l___tespec_entry )
).

Definition IntList_cons_return_wit_1_split_goal_spatial :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (y: Z) (y_2: Z) (retval: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : (1 <= INT_MAX)) (PreH3 : (2 >= INT_MIN)) (PreH4 : (1 >= INT_MIN)) (PreH5 : (retval <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (h_pre = INT_MAX)) (PreH8 : (t_pre = 8192)) (PreH9 : (h0___tespec_entry = INT_MAX)) (PreH10 : (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z))))))) (PreH11 : (h_pre = h0___tespec_entry)) (PreH12 : (0 <= retval)) (PreH13 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 2)
|--
  (sll t_pre l___tespec_entry )
.

Definition IntList_cons_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (PreH1 : (h_pre = INT_MAX)) (PreH2 : (t_pre = 8192)) (PreH3 : (h0___tespec_entry = INT_MAX)) (PreH4 : (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z))))))) (PreH5 : (h_pre = h0___tespec_entry)),
  (sll t_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z),
  “ (y_2 = 0) ”
  &&  “ (h_pre = INT_MAX) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (h0___tespec_entry = INT_MAX) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z)))))) ”
  &&  “ (h_pre = h0___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 2)
.

Definition IntList_cons_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (h0___tespec_entry: Z),
exists (h_pre: Z),
exists (t_pre: Z),
~ ((  “ (h_pre = INT_MAX) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (h0___tespec_entry = INT_MAX) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z)))))) ”
  &&  “ (h_pre = h0___tespec_entry) ”
  &&  (sll t_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Axiom proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Axiom proof_of_IntList_cons_precondition_wit_1 : IntList_cons_precondition_wit_1.

End VC_Correct.
