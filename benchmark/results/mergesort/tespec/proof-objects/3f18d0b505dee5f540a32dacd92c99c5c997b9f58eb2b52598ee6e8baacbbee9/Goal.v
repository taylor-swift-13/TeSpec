From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_cons -----*)

Definition IntList_cons_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h_pre: Z) (t_pre: Z) (y: Z) (y_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (t_pre <> 0)) (PreH6 : (h_pre = INT_MAX)) (PreH7 : (t_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> h_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> t_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 2)
|--
  “ (retval <> 0) ”
  &&  (sll retval (cons (h_pre) (l___tespec_entry)) )
.

Definition IntList_cons_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h_pre: Z) (t_pre: Z) (PreH1 : (t_pre <> 0)) (PreH2 : (h_pre = INT_MAX)) (PreH3 : (t_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll t_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z),
  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (t_pre <> 0) ”
  &&  “ (h_pre = INT_MAX) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 2)
.

Definition IntList_cons_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (h_pre: Z),
exists (t_pre: Z),
~ ((  “ (t_pre <> 0) ”
  &&  “ (h_pre = INT_MAX) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll t_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Axiom proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Axiom proof_of_IntList_cons_precondition_wit_1 : IntList_cons_precondition_wit_1.

End VC_Correct.
