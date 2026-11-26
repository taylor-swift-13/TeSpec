From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntQueue_push_induction -----*)

Definition IntQueue_push_induction_safety_wit_1 :=
forall (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (f <> 0)) (PreH3 : (b <> 0)) (PreH4 : ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (app (pre) ((cons (last) ((@nil Z))))))) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |->_)
  **  ((( &( "c_spec_535" ) )) # Ptr  |-> retval)
  **  ((( &( "x_spec_506" ) )) # Int  |-> (-1))
  **  ((( &( "q_spec_504" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntQueue_push_induction_safety_wit_2 :=
forall (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (f <> 0)) (PreH3 : (b <> 0)) (PreH4 : ((cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) = (app (pre) ((cons (last) ((@nil Z))))))) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  ((( &( "c_spec_535" ) )) # Ptr  |-> retval)
  **  ((( &( "x_spec_506" ) )) # Int  |-> (-1))
  **  ((( &( "q_spec_504" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntQueue_push_induction_safety_wit_3 :=
forall (f: Z) (last: Z) (pre: (@list Z)) (retval: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  ((( &( "c_spec_535" ) )) # Ptr  |-> retval)
  **  ((( &( "x_spec_506" ) )) # Int  |-> (-1))
  **  ((( &( "q_spec_504" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 0)
  **  (sllseg f 0 pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntQueue_push_induction_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (f_2: Z) (b_2: Z) (last_2: Z) (pre_2: (@list Z)) (x_pre: Z) (q_pre: Z) (retval: Z) (PreH1 : (b_2 <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = (-1))) (PreH4 : (q_pre = 4096)) (PreH5 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (x0___tespec_entry = (-1))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (f_2 <> 0)) (PreH9 : (b_2 <> 0)) (PreH10 : (l___tespec_entry = (app (pre_2) ((cons (last_2) ((@nil Z))))))) (PreH11 : (0 <= retval)) (PreH12 : (retval <= UINT_MAX)),
  (sllseg f_2 retval (app (pre_2) ((cons (last_2) ((@nil Z))))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> x_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> retval)
|--
  (“ ((app (l___tespec_entry) ((cons (x0___tespec_entry) ((@nil Z))))) = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> 0))
  ||
  (EX (last: Z) (b: Z) (f: Z) (pre: (@list Z)),
  “ (f <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ ((app (l___tespec_entry) ((cons (x0___tespec_entry) ((@nil Z))))) = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0))
.

Definition IntQueue_push_induction_partial_solve_wit_1_pure :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (x_pre: Z) (q_pre: Z) (retval: Z) (PreH1 : (b <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = (-1))) (PreH4 : (q_pre = 4096)) (PreH5 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (x0___tespec_entry = (-1))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (f <> 0)) (PreH9 : (b <> 0)) (PreH10 : (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z))))))) (PreH11 : (0 <= retval)) (PreH12 : (retval <= UINT_MAX)),
  ((( &( "oldback_spec_537" ) )) # Ptr  |-> b)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> x_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  ((( &( "c_spec_535" ) )) # Ptr  |-> retval)
  **  ((( &( "x_spec_506" ) )) # Int  |-> x_pre)
  **  ((( &( "q_spec_504" ) )) # Ptr  |-> q_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> retval)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> retval)
|--
  “ (b <> 0) ”
.

Definition IntQueue_push_induction_partial_solve_wit_1_aux :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (x_pre: Z) (q_pre: Z) (retval: Z) (PreH1 : (b <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (x_pre = (-1))) (PreH4 : (q_pre = 4096)) (PreH5 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (x0___tespec_entry = (-1))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (f <> 0)) (PreH9 : (b <> 0)) (PreH10 : (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z))))))) (PreH11 : (0 <= retval)) (PreH12 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> x_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> retval)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> retval)
|--
  “ (b <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (x_pre = (-1)) ”
  &&  “ (q_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (f <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> x_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> retval)
.

Definition IntQueue_push_induction_partial_solve_wit_1 := IntQueue_push_induction_partial_solve_wit_1_pure -> IntQueue_push_induction_partial_solve_wit_1_aux.

Definition IntQueue_push_induction_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (f: Z) (b: Z) (last: Z) (pre: (@list Z)) (x_pre: Z) (q_pre: Z) (PreH1 : (x_pre = (-1))) (PreH2 : (q_pre = 4096)) (PreH3 : (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH4 : (x0___tespec_entry = (-1))) (PreH5 : (x_pre = x0___tespec_entry)) (PreH6 : (f <> 0)) (PreH7 : (b <> 0)) (PreH8 : (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0)
|--
  “ (x_pre = (-1)) ”
  &&  “ (q_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (f <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0)
.

Definition IntQueue_push_induction_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (x0___tespec_entry: Z),
exists (x_pre: Z),
exists (q_pre: Z),
~ ((  (EX (last: Z) (b: Z) (f: Z) (pre: (@list Z)),
  “ (x_pre = (-1)) ”
  &&  “ (q_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (f <> 0) ”
  &&  “ (b <> 0) ”
  &&  “ (l___tespec_entry = (app (pre) ((cons (last) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> f)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> b)
  **  (sllseg f b pre )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (b + 0)) # Int  |-> last)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (b + 4)) # Ptr  |-> 0))
  ||
  (“ (x_pre = (-1)) ”
  &&  “ (q_pre = 4096) ”
  &&  “ (l___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q_pre + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q_pre + 4)) # Ptr  |-> 0))) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntQueue_push_induction_safety_wit_1 : IntQueue_push_induction_safety_wit_1.
Axiom proof_of_IntQueue_push_induction_safety_wit_2 : IntQueue_push_induction_safety_wit_2.
Axiom proof_of_IntQueue_push_induction_safety_wit_3 : IntQueue_push_induction_safety_wit_3.
Axiom proof_of_IntQueue_push_induction_return_wit_1 : IntQueue_push_induction_return_wit_1.
Axiom proof_of_IntQueue_push_induction_partial_solve_wit_1_pure : IntQueue_push_induction_partial_solve_wit_1_pure.
Axiom proof_of_IntQueue_push_induction_partial_solve_wit_1 : IntQueue_push_induction_partial_solve_wit_1.
Axiom proof_of_IntQueue_push_induction_partial_solve_wit_2 : IntQueue_push_induction_partial_solve_wit_2.
Axiom proof_of_IntQueue_push_induction_precondition_wit_1 : IntQueue_push_induction_precondition_wit_1.

End VC_Correct.
