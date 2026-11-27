From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_1c59d86d2590d95de97f91f1.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_cons -----*)

Definition IntList_cons_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (t_pre <> 0)) (PreH5 : (h_pre = (INT_MIN))) (PreH6 : (t_pre = 8192)) (PreH7 : (h0___tespec_entry = (INT_MIN))) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (h_pre = h0___tespec_entry)) (PreH10 : (0 <= retval)) (PreH11 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> h_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> t_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 1)
|--
  “ (retval <> 0) ”
  &&  (sll retval (cons (h0___tespec_entry) (l___tespec_entry)) )
.

Definition IntList_cons_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (PreH1 : (t_pre <> 0)) (PreH2 : (h_pre = (INT_MIN))) (PreH3 : (t_pre = 8192)) (PreH4 : (h0___tespec_entry = (INT_MIN))) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH6 : (h_pre = h0___tespec_entry)),
  (sll t_pre l___tespec_entry )
|--
  EX (y: Z),
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (t_pre <> 0) ”
  &&  “ (h_pre = (INT_MIN)) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (h0___tespec_entry = (INT_MIN)) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (h_pre = h0___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 1)
.

Definition IntList_cons_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (h0___tespec_entry: Z),
exists (h_pre: Z),
exists (t_pre: Z),
~ ((  “ (t_pre <> 0) ”
  &&  “ (h_pre = (INT_MIN)) ”
  &&  “ (t_pre = 8192) ”
  &&  “ (h0___tespec_entry = (INT_MIN)) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (h_pre = h0___tespec_entry) ”
  &&  (sll t_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_cons_return_wit_1 : IntList_cons_return_wit_1.
Axiom proof_of_IntList_cons_partial_solve_wit_1 : IntList_cons_partial_solve_wit_1.
Axiom proof_of_IntList_cons_precondition_wit_1 : IntList_cons_precondition_wit_1.

End VC_Correct.
