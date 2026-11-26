From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function init_array -----*)

Definition init_array_safety_wit_1 :=
  ((( &( "j_spec_385" ) )) # UInt  |->_)
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_370" ) )) # UInt  |-> 0)
  **  (CharArray.full 4096 0 (@nil Z) )
|--
  TT && emp 
.

Definition init_array_safety_wit_2 :=
forall (li: (@list Z)) (PreH1 : False),
  ((( &( "j_spec_385" ) )) # UInt  |-> 0)
  **  (CharArray.full 4096 0 li )
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_370" ) )) # UInt  |-> 0)
  **  (CharArray.full 4096 0 (@nil Z) )
|--
  “ False ”
.

Definition init_array_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (p_pre: Z) (n_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (n_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))) (PreH4 : (0 <= n_pre)) (PreH5 : (n_pre <= UINT_MAX)),
  ((( &( "p_spec_372" ) )) # Ptr  |-> p_pre)
  **  ((( &( "n_spec_370" ) )) # UInt  |-> n_pre)
  **  (CharArray.full p_pre n_pre l___tespec_entry )
|--
  EX (li: (@list Z)),
  “ (0 <= 0) ”
  &&  “ (0 <= n_pre) ”
  &&  “ (4096 = 4096) ”
  &&  “ (0 = 0) ”
  &&  “ ((@nil Z) = (@nil Z)) ”
  &&  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
  &&  (CharArray.full p_pre n_pre li )
  **  ((( &( "p_spec_372" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_370" ) )) # UInt  |-> 0)
  **  (CharArray.full 4096 0 (@nil Z) )
.

Definition init_array_return_wit_1 :=
(
forall (p_pre: Z) (n_pre: Z) (j: Z) (li: (@list Z)) (PreH1 : (j >= 0)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (4096 = 4096)) (PreH5 : (0 = 0)) (PreH6 : ((@nil Z) = (@nil Z))) (PreH7 : (0 <= 0)) (PreH8 : (0 <= UINT_MAX)),
  (CharArray.full p_pre n_pre li )
  **  (CharArray.full 4096 0 (@nil Z) )
|--
  EX (l2: (@list Z)),
  (CharArray.full p_pre n_pre l2 )
) \/
(
forall (n_pre: Z) (j: Z) (PreH1 : (j >= 0)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= 0)) (PreH5 : (0 <= UINT_MAX)),
  (CharArray.full 4096 0 (@nil Z) )
|--
  TT && emp 
).

Definition init_array_return_wit_1_split_goal_spatial :=
forall (n_pre: Z) (j: Z) (PreH1 : (j >= 0)) (PreH2 : (0 <= j)) (PreH3 : (j <= n_pre)) (PreH4 : (0 <= 0)) (PreH5 : (0 <= UINT_MAX)),
  (CharArray.full 4096 0 (@nil Z) )
|--
  TT && emp 
.

Definition init_array_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (p_pre: Z),
exists (n_pre: Z),
~ ((  “ (p_pre = 4096) ”
  &&  “ (n_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.full p_pre n_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_init_array_safety_wit_1 : init_array_safety_wit_1.
Axiom proof_of_init_array_safety_wit_2 : init_array_safety_wit_2.
Axiom proof_of_init_array_entail_wit_1 : init_array_entail_wit_1.
Axiom proof_of_init_array_return_wit_1 : init_array_return_wit_1.
Axiom proof_of_init_array_precondition_wit_1 : init_array_precondition_wit_1.

End VC_Correct.
