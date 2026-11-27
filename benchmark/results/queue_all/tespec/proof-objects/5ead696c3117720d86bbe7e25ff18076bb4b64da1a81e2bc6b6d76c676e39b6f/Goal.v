From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_5b48e99c1f6bafd5808d7dbb.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntQueue_pop -----*)

Definition IntQueue_pop_safety_wit_1 :=
forall (h: Z) (b: Z) (last: Z) (pre: (@list Z)) (PreH1 : False),
  ((( &( "x_spec_516" ) )) # Int  |-> 2)
  **  ((( &( "h_spec_514" ) )) # Ptr  |-> h)
  **  ((( &( "q_spec_481" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> b)
  **  (sllseg 0 b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntQueue_pop_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (h: Z) (t: Z) (b_2: Z) (last_2: Z) (pre_2: (@list Z)) (q_pre: Z) (PreH1 : (t <> 0)) (PreH2 : (q_pre = 4096)) (PreH3 : (l___tespec_entry = (cons ((-1)) ((@nil Z))))) (PreH4 : (x0___tespec_entry = 2)) (PreH5 : (h <> 0)) (PreH6 : (t <> 0)) (PreH7 : (b_2 <> 0)) (PreH8 : (l___tespec_entry = (app (pre_2) ((cons (last_2) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> t)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b_2)
  **  (sllseg t b_2 pre_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b_2 + 0)) # Int  |-> last_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b_2 + 4)) # Ptr  |-> 0)
|--
  (EX (last: Z) (b: Z) (f: Z) (pre: (@list Z)),
  “ (x0___tespec_entry = x0___tespec_entry) ”
  &&  “ (f <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0))
  ||
  (“ (x0___tespec_entry = x0___tespec_entry) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> 0))
.

Definition IntQueue_pop_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (h: Z) (t: Z) (b: Z) (last: Z) (pre: (@list Z)) (q_pre: Z) (PreH1 : (q_pre = 4096)) (PreH2 : (l___tespec_entry = (cons ((-1)) ((@nil Z))))) (PreH3 : (x0___tespec_entry = 2)) (PreH4 : (h <> 0)) (PreH5 : (t <> 0)) (PreH6 : (b <> 0)) (PreH7 : (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> t)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (h + 0)) # Int  |-> x0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (h + 4)) # Ptr  |-> t)
  **  (sllseg t b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0)
|--
  “ (q_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons ((-1)) ((@nil Z)))) ”
  &&  “ (x0___tespec_entry = 2) ”
  &&  “ (h <> 0) ”
  &&  “ (t <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (h + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (h + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> t)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (sllseg t b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0)
.

Definition IntQueue_pop_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (x0___tespec_entry: Z),
exists (q_pre: Z),
~ ((  (EX (last: Z) (b: Z) (t: Z) (h: Z) (pre: (@list Z)),
  “ (q_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons ((-1)) ((@nil Z)))) ”
  &&  “ (x0___tespec_entry = 2) ”
  &&  “ (h <> 0) ”
  &&  “ (t <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> h)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (h + 0)) # Int  |-> x0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (h + 4)) # Ptr  |-> t)
  **  (sllseg t b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0))
  ||
  (EX (h_2: Z),
  “ (q_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons ((-1)) ((@nil Z)))) ”
  &&  “ (x0___tespec_entry = 2) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  “ (h_2 <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> h_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> h_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (h_2 + 0)) # Int  |-> x0___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (h_2 + 4)) # Ptr  |-> 0))) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntQueue_pop_safety_wit_1 : IntQueue_pop_safety_wit_1.
Axiom proof_of_IntQueue_pop_return_wit_1 : IntQueue_pop_return_wit_1.
Axiom proof_of_IntQueue_pop_partial_solve_wit_1 : IntQueue_pop_partial_solve_wit_1.
Axiom proof_of_IntQueue_pop_precondition_wit_1 : IntQueue_pop_precondition_wit_1.

End VC_Correct.
