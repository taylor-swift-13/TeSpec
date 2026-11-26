From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function inplace_double -----*)

Definition inplace_double_safety_wit_1 :=
  ((( &( "m_spec_381" ) )) # Int  |->_)
  **  ((( &( "n_spec_379" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_370" ) )) # Ptr  |-> 4096)
  **  ((4096) # Int  |-> 0)
|--
  TT && emp 
.

Definition inplace_double_return_wit_1 :=
(
forall (old___tespec_entry: Z) (p_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = 0)) (PreH3 : ((-1073741824) <= old___tespec_entry)) (PreH4 : (old___tespec_entry <= 1073741823)),
  ((p_pre) # Int  |-> (old___tespec_entry + old___tespec_entry ))
|--
  TT && emp 
) \/
(
forall (old___tespec_entry: Z) (p_pre: Z) (PreH1 : ((old___tespec_entry + old___tespec_entry ) <= INT_MAX)) (PreH2 : ((old___tespec_entry + old___tespec_entry ) >= INT_MIN)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = 0)) (PreH5 : ((-1073741824) <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= 1073741823)),
  ((p_pre) # Int  |-> (old___tespec_entry + old___tespec_entry ))
|--
  TT && emp 
).

Definition inplace_double_return_wit_1_split_goal_spatial :=
forall (old___tespec_entry: Z) (p_pre: Z) (PreH1 : ((old___tespec_entry + old___tespec_entry ) <= INT_MAX)) (PreH2 : ((old___tespec_entry + old___tespec_entry ) >= INT_MIN)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = 0)) (PreH5 : ((-1073741824) <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= 1073741823)),
  ((p_pre) # Int  |-> (old___tespec_entry + old___tespec_entry ))
|--
  TT && emp 
.

Definition inplace_double_precondition_wit_1 :=
exists (old___tespec_entry: Z),
exists (p_pre: Z),
~ ((  “ (p_pre = 4096) ”
  &&  “ (old___tespec_entry = 0) ”
  &&  “ ((-1073741824) <= old___tespec_entry) ”
  &&  “ (old___tespec_entry <= 1073741823) ”
  &&  ((p_pre) # Int  |-> old___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_inplace_double_safety_wit_1 : inplace_double_safety_wit_1.
Axiom proof_of_inplace_double_return_wit_1 : inplace_double_return_wit_1.
Axiom proof_of_inplace_double_precondition_wit_1 : inplace_double_precondition_wit_1.

End VC_Correct.
