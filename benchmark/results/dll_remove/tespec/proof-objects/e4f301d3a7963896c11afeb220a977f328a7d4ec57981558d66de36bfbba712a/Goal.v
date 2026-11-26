From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function remove -----*)

Definition remove_safety_wit_1 :=
  ((( &( "temp_spec_486" ) )) # Ptr  |->_)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 0 4096 (@nil Z) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  TT && emp 
.

Definition remove_safety_wit_2 :=
  ((( &( "temp_spec_486" ) )) # Ptr  |-> 0)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 0 4096 (@nil Z) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  TT && emp 
.

Definition remove_safety_wit_3 :=
forall (PreH1 : False),
  ((( &( "temp_spec_486" ) )) # Ptr  |-> 0)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 0 4096 (@nil Z) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  “ False ”
.

Definition remove_safety_wit_4 :=
  ((( &( "temp_spec_486" ) )) # Ptr  |-> 0)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 0 4096 (@nil Z) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  TT && emp 
.

Definition remove_safety_wit_5 :=
forall (PreH1 : False),
  ((( &( "temp_spec_486" ) )) # Ptr  |-> 0)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> (INT_MIN))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 0 4096 (@nil Z) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  “ False ”
.

Definition remove_return_wit_1 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr___tespec_entry = (@nil Z))) (PreH3 : (ll___tespec_entry = (@nil Z))) (PreH4 : (q___tespec_entry = 0)) (PreH5 : (p___tespec_entry = 0)) (PreH6 : (n_pre = 4096)) (PreH7 : (h___tespec_entry = (INT_MIN))) (PreH8 : (ll___tespec_entry = (@nil Z))) (PreH9 : (lr___tespec_entry = (@nil Z))) (PreH10 : (p___tespec_entry = 0)) (PreH11 : (q___tespec_entry = 0)) (PreH12 : (n_pre <> 0)) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
|--
  (EX (v: Z) (t: Z),
  “ (q___tespec_entry = 0) ”
  &&  “ (p___tespec_entry <> 0) ”
  &&  “ (t = p___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> t)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
  **  (Dll t (dll_tail (ll___tespec_entry)) v lr___tespec_entry ))
  ||
  (EX (v: Z) (t: Z),
  “ (q___tespec_entry <> 0) ”
  &&  “ (t = q___tespec_entry) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> t)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
  **  (Dll t ll___tespec_entry v (dll_tail (lr___tespec_entry)) ))
  ||
  (EX (t: Z),
  “ (p___tespec_entry = 0) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (t = 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> t)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
  **  (Dll t (@nil Z) 0 (@nil Z) ))
.

Definition remove_partial_solve_wit_1 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (lr___tespec_entry = (@nil Z))) (PreH3 : (ll___tespec_entry = (@nil Z))) (PreH4 : (q___tespec_entry = 0)) (PreH5 : (p___tespec_entry = 0)) (PreH6 : (n_pre = 4096)) (PreH7 : (h___tespec_entry = (INT_MIN))) (PreH8 : (ll___tespec_entry = (@nil Z))) (PreH9 : (lr___tespec_entry = (@nil Z))) (PreH10 : (p___tespec_entry = 0)) (PreH11 : (q___tespec_entry = 0)) (PreH12 : (n_pre <> 0)) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
|--
  “ (retval <> 0) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (ll___tespec_entry = (@nil Z)) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (p___tespec_entry = 0) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (h___tespec_entry = (INT_MIN)) ”
  &&  “ (ll___tespec_entry = (@nil Z)) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry = 0) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (n_pre <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
.

Definition remove_partial_solve_wit_2 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (n_pre: Z) (PreH1 : (q___tespec_entry = 0)) (PreH2 : (p___tespec_entry = 0)) (PreH3 : (n_pre = 4096)) (PreH4 : (h___tespec_entry = (INT_MIN))) (PreH5 : (ll___tespec_entry = (@nil Z))) (PreH6 : (lr___tespec_entry = (@nil Z))) (PreH7 : (p___tespec_entry = 0)) (PreH8 : (q___tespec_entry = 0)) (PreH9 : (n_pre <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft p___tespec_entry n_pre ll___tespec_entry )
  **  (DLLRight q___tespec_entry n_pre lr___tespec_entry )
|--
  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (ll___tespec_entry = (@nil Z)) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (p___tespec_entry = 0) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (h___tespec_entry = (INT_MIN)) ”
  &&  “ (ll___tespec_entry = (@nil Z)) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry = 0) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (n_pre <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
.

Definition remove_precondition_wit_1 :=
exists (lr___tespec_entry: (@list Z)),
exists (ll___tespec_entry: (@list Z)),
exists (q___tespec_entry: Z),
exists (p___tespec_entry: Z),
exists (h___tespec_entry: Z),
exists (n_pre: Z),
~ ((  “ (n_pre = 4096) ”
  &&  “ (h___tespec_entry = (INT_MIN)) ”
  &&  “ (ll___tespec_entry = (@nil Z)) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry = 0) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (n_pre <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft p___tespec_entry n_pre ll___tespec_entry )
  **  (DLLRight q___tespec_entry n_pre lr___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_remove_safety_wit_1 : remove_safety_wit_1.
Axiom proof_of_remove_safety_wit_2 : remove_safety_wit_2.
Axiom proof_of_remove_safety_wit_3 : remove_safety_wit_3.
Axiom proof_of_remove_safety_wit_4 : remove_safety_wit_4.
Axiom proof_of_remove_safety_wit_5 : remove_safety_wit_5.
Axiom proof_of_remove_return_wit_1 : remove_return_wit_1.
Axiom proof_of_remove_partial_solve_wit_1 : remove_partial_solve_wit_1.
Axiom proof_of_remove_partial_solve_wit_2 : remove_partial_solve_wit_2.
Axiom proof_of_remove_precondition_wit_1 : remove_precondition_wit_1.

End VC_Correct.
