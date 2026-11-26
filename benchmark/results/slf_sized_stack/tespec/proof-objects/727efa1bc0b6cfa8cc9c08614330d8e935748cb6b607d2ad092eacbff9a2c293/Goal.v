From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_cons -----*)

Definition IntList_cons_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (h_pre = (INT_MIN))) (PreH4 : (t_pre = 8192)) (PreH5 : (h0___tespec_entry = (INT_MIN))) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (h_pre = h0___tespec_entry)) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> h_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> t_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (t_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (t_pre + 0)) # Int  |-> 1)
|--
  (sll retval (cons (h0___tespec_entry) (l___tespec_entry)) )
.

Definition IntList_cons_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h0___tespec_entry: Z) (h_pre: Z) (t_pre: Z) (PreH1 : (h_pre = (INT_MIN))) (PreH2 : (t_pre = 8192)) (PreH3 : (h0___tespec_entry = (INT_MIN))) (PreH4 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH5 : (h_pre = h0___tespec_entry)),
  (sll t_pre l___tespec_entry )
|--
  EX (y: Z),
  “ (y = 0) ”
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
~ ((  “ (h_pre = (INT_MIN)) ”
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
