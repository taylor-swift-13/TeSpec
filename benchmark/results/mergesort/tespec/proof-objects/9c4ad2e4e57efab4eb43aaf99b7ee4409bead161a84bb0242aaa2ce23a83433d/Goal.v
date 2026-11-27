From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_cons -----*)

Definition IntList_cons_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h_pre: Z) (t_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (t_pre <> 0)) (PreH5 : (h_pre = (INT_MIN))) (PreH6 : (t_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> h_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> t_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 1)
|--
  “ (retval <> 0) ”
  &&  (sll retval (cons (h_pre) (l___tespec_entry)) )
.

Definition IntList_cons_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h_pre: Z) (t_pre: Z) (PreH1 : (t_pre <> 0)) (PreH2 : (h_pre = (INT_MIN))) (PreH3 : (t_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (sll t_pre l___tespec_entry )
|--
  EX (y: Z),
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (t_pre <> 0) ”
  &&  “ (h_pre = (INT_MIN)) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 1)
.

Definition IntList_cons_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (h_pre: Z),
exists (t_pre: Z),
~ ((  “ (t_pre <> 0) ”
  &&  “ (h_pre = (INT_MIN)) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll t_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Axiom proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Axiom proof_of_IntList_cons_precondition_wit_1 : IntList_cons_precondition_wit_1.

End VC_Correct.
