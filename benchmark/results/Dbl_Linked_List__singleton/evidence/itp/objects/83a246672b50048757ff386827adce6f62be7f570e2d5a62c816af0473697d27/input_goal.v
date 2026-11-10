From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function singleton -----*)

Definition singleton_safety_wit_1 :=
forall (retval: Z) (PreH1 : (( &( "element_spec_463" ) ) = 4096)) (PreH2 : (( &( "n_spec_474" ) ) = 8192)) (PreH3 : (retval = 12288)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |->_)
  **  ((8192) # Ptr  |-> 12288)
  **  ((4096) # Int  |-> INT_MAX)
|--
  TT && emp 
.

Definition singleton_safety_wit_2 :=
forall (retval: Z) (PreH1 : (( &( "element_spec_463" ) ) = 4096)) (PreH2 : (( &( "n_spec_474" ) ) = 8192)) (PreH3 : (retval = 12288)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> INT_MAX)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |->_)
  **  ((8192) # Ptr  |-> 12288)
  **  ((4096) # Int  |-> INT_MAX)
|--
  TT && emp 
.

Definition singleton_return_wit_1 :=
(
forall (e___tespec_entry: Z) (element_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = INT_MAX)) (PreH3 : (e___tespec_entry = INT_MAX)) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (( &( "element_spec_463" ) ) = 4096)) (PreH6 : (( &( "n_spec_474" ) ) = 8192)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)) (PreH9 : (retval = 12288)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
|--
  (Dll retval (@nil Z) e___tespec_entry (@nil Z) )
) \/
(
forall (e___tespec_entry: Z) (element_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (element_pre = INT_MAX)) (PreH3 : (e___tespec_entry = INT_MAX)) (PreH4 : (element_pre = e___tespec_entry)) (PreH5 : (( &( "element_spec_463" ) ) = 4096)) (PreH6 : (( &( "n_spec_474" ) ) = 8192)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)) (PreH9 : (retval = 12288)),
  TT && emp 
|--
  TT && emp 
).

Definition singleton_partial_solve_wit_1 :=
forall (e___tespec_entry: Z) (element_pre: Z) (PreH1 : (element_pre = INT_MAX)) (PreH2 : (e___tespec_entry = INT_MAX)) (PreH3 : (element_pre = e___tespec_entry)) (PreH4 : (( &( "element_spec_463" ) ) = 4096)) (PreH5 : (( &( "n_spec_474" ) ) = 8192)),
  TT && emp 
|--
  “ (element_pre = INT_MAX) ”
  &&  “ (e___tespec_entry = INT_MAX) ”
  &&  “ (element_pre = e___tespec_entry) ”
  &&  “ (( &( "element_spec_463" ) ) = 4096) ”
  &&  “ (( &( "n_spec_474" ) ) = 8192) ”
  &&  emp
.

Definition singleton_precondition_wit_1 :=
exists (e___tespec_entry: Z),
exists (element_pre: Z),
~ ((  “ (element_pre = INT_MAX) ”
  &&  “ (e___tespec_entry = INT_MAX) ”
  &&  “ (element_pre = e___tespec_entry) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_singleton_safety_wit_1 : singleton_safety_wit_1.
Axiom proof_of_singleton_safety_wit_2 : singleton_safety_wit_2.
Axiom proof_of_singleton_return_wit_1 : singleton_return_wit_1.
Axiom proof_of_singleton_partial_solve_wit_1 : singleton_partial_solve_wit_1.
Axiom proof_of_singleton_precondition_wit_1 : singleton_precondition_wit_1.

End VC_Correct.
