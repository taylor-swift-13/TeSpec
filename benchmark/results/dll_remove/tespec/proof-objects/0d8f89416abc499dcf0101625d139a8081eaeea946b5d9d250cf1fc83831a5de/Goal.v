From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function remove -----*)

Definition remove_safety_wit_1 :=
  ((( &( "temp_spec_486" ) )) # Ptr  |->_)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 8192 4096 (cons (2) ((@nil Z))) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  TT && emp 
.

Definition remove_safety_wit_2 :=
  ((( &( "temp_spec_486" ) )) # Ptr  |-> 0)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 8192 4096 (cons (2) ((@nil Z))) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  TT && emp 
.

Definition remove_safety_wit_3 :=
forall (PreH1 : False),
  ((( &( "temp_spec_486" ) )) # Ptr  |-> 0)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
  **  (DLLLeft 8192 4096 (cons (2) ((@nil Z))) )
  **  (DLLRight 0 4096 (@nil Z) )
|--
  “ False ”
.

Definition remove_safety_wit_4 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (PreH1 : (2 = a)) (PreH2 : ((@nil Z) = tl)),
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 0)
  **  (DLLLeft q 8192 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "temp_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition remove_safety_wit_5 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 0)
  **  (DLLLeft q 8192 tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> a)
  **  ((( &( "temp_spec_486" ) )) # Ptr  |-> 8192)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 0)
|--
  “ False ”
.

Definition remove_return_wit_1 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (n_pre: Z) (a: Z) (tl: (@list Z)) (q: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (q___tespec_entry = 0)) (PreH3 : (ll___tespec_entry = (cons (a) (tl)))) (PreH4 : (lr___tespec_entry = (@nil Z))) (PreH5 : (p___tespec_entry <> 0)) (PreH6 : (n_pre = 4096)) (PreH7 : (h___tespec_entry = 7)) (PreH8 : (ll___tespec_entry = (cons (2) ((@nil Z))))) (PreH9 : (lr___tespec_entry = (@nil Z))) (PreH10 : (p___tespec_entry = 8192)) (PreH11 : (q___tespec_entry = 0)) (PreH12 : (n_pre <> 0)) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
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
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (n_pre: Z) (a: Z) (tl: (@list Z)) (q: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (q___tespec_entry = 0)) (PreH3 : (ll___tespec_entry = (cons (a) (tl)))) (PreH4 : (lr___tespec_entry = (@nil Z))) (PreH5 : (p___tespec_entry <> 0)) (PreH6 : (n_pre = 4096)) (PreH7 : (h___tespec_entry = 7)) (PreH8 : (ll___tespec_entry = (cons (2) ((@nil Z))))) (PreH9 : (lr___tespec_entry = (@nil Z))) (PreH10 : (p___tespec_entry = 8192)) (PreH11 : (q___tespec_entry = 0)) (PreH12 : (n_pre <> 0)) (PreH13 : (0 <= retval)) (PreH14 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
|--
  “ (retval <> 0) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (ll___tespec_entry = (cons (a) (tl))) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry <> 0) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (h___tespec_entry = 7) ”
  &&  “ (ll___tespec_entry = (cons (2) ((@nil Z)))) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry = 8192) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (n_pre <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
.

Definition remove_partial_solve_wit_2 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (n_pre: Z) (a: Z) (tl: (@list Z)) (q: Z) (PreH1 : (q___tespec_entry = 0)) (PreH2 : (ll___tespec_entry = (cons (a) (tl)))) (PreH3 : (lr___tespec_entry = (@nil Z))) (PreH4 : (p___tespec_entry <> 0)) (PreH5 : (n_pre = 4096)) (PreH6 : (h___tespec_entry = 7)) (PreH7 : (ll___tespec_entry = (cons (2) ((@nil Z))))) (PreH8 : (lr___tespec_entry = (@nil Z))) (PreH9 : (p___tespec_entry = 8192)) (PreH10 : (q___tespec_entry = 0)) (PreH11 : (n_pre <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
|--
  “ (q___tespec_entry = 0) ”
  &&  “ (ll___tespec_entry = (cons (a) (tl))) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry <> 0) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (h___tespec_entry = 7) ”
  &&  “ (ll___tespec_entry = (cons (2) ((@nil Z)))) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry = 8192) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (n_pre <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
.

Definition remove_partial_solve_wit_3 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (n_pre: Z) (PreH1 : (p___tespec_entry <> 0)) (PreH2 : (n_pre = 4096)) (PreH3 : (h___tespec_entry = 7)) (PreH4 : (ll___tespec_entry = (cons (2) ((@nil Z))))) (PreH5 : (lr___tespec_entry = (@nil Z))) (PreH6 : (p___tespec_entry = 8192)) (PreH7 : (q___tespec_entry = 0)) (PreH8 : (n_pre <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft p___tespec_entry n_pre ll___tespec_entry )
  **  (DLLRight q___tespec_entry n_pre lr___tespec_entry )
|--
  EX (a: Z) (tl: (@list Z)) (q: Z),
  “ (ll___tespec_entry = (cons (a) (tl))) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry <> 0) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (h___tespec_entry = 7) ”
  &&  “ (ll___tespec_entry = (cons (2) ((@nil Z)))) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry = 8192) ”
  &&  “ (q___tespec_entry = 0) ”
  &&  “ (n_pre <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |->_)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
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
  &&  “ (h___tespec_entry = 7) ”
  &&  “ (ll___tespec_entry = (cons (2) ((@nil Z)))) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  “ (p___tespec_entry = 8192) ”
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
Axiom proof_of_remove_partial_solve_wit_3 : remove_partial_solve_wit_3.
Axiom proof_of_remove_precondition_wit_1 : remove_precondition_wit_1.

End VC_Correct.
