From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function val_rand -----*)

Definition val_rand_safety_wit_1 :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)),
  ((( &( "n_spec_374" ) )) # UInt  |-> 1)
|--
  TT && emp 
.

Definition val_rand_return_wit_1 :=
(
forall (n0___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (n_pre = 1)) (PreH4 : (n0___tespec_entry = 1)) (PreH5 : (0 <= n0___tespec_entry)) (PreH6 : (n0___tespec_entry <= UINT_MAX)) (PreH7 : (n_pre = n0___tespec_entry)) (PreH8 : (n0___tespec_entry > 0)) (PreH9 : ((INT_MIN) <= retval)) (PreH10 : (retval <= INT_MAX)),
  TT && emp 
|--
  “ (0 <= (retval % ( n_pre ) )) ”
  &&  “ ((retval % ( n_pre ) ) < n0___tespec_entry) ”
  &&  emp
) \/
(
forall (n0___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (n_pre = 1)) (PreH4 : (n0___tespec_entry = 1)) (PreH5 : (0 <= n0___tespec_entry)) (PreH6 : (n0___tespec_entry <= UINT_MAX)) (PreH7 : (n_pre = n0___tespec_entry)) (PreH8 : (n0___tespec_entry > 0)) (PreH9 : ((INT_MIN) <= retval)) (PreH10 : (retval <= INT_MAX)),
  TT && emp 
|--
  “ (0 <= (retval % ( n_pre ) )) ”
  &&  “ ((retval % ( n_pre ) ) < n0___tespec_entry) ”
  &&  emp
).

Definition val_rand_return_wit_1_split_goal_1 :=
forall (n0___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (n_pre = 1)) (PreH4 : (n0___tespec_entry = 1)) (PreH5 : (0 <= n0___tespec_entry)) (PreH6 : (n0___tespec_entry <= UINT_MAX)) (PreH7 : (n_pre = n0___tespec_entry)) (PreH8 : (n0___tespec_entry > 0)) (PreH9 : ((INT_MIN) <= retval)) (PreH10 : (retval <= INT_MAX)),
  (0 <= (retval % ( n_pre ) ))
.

Definition val_rand_return_wit_1_split_goal_2 :=
forall (n0___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= INT_MAX)) (PreH3 : (n_pre = 1)) (PreH4 : (n0___tespec_entry = 1)) (PreH5 : (0 <= n0___tespec_entry)) (PreH6 : (n0___tespec_entry <= UINT_MAX)) (PreH7 : (n_pre = n0___tespec_entry)) (PreH8 : (n0___tespec_entry > 0)) (PreH9 : ((INT_MIN) <= retval)) (PreH10 : (retval <= INT_MAX)),
  ((retval % ( n_pre ) ) < n0___tespec_entry)
.

Definition val_rand_partial_solve_wit_1 :=
forall (n0___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = 1)) (PreH2 : (n0___tespec_entry = 1)) (PreH3 : (0 <= n0___tespec_entry)) (PreH4 : (n0___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = n0___tespec_entry)) (PreH6 : (n0___tespec_entry > 0)),
  TT && emp 
|--
  “ (n_pre = 1) ”
  &&  “ (n0___tespec_entry = 1) ”
  &&  “ (0 <= n0___tespec_entry) ”
  &&  “ (n0___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = n0___tespec_entry) ”
  &&  “ (n0___tespec_entry > 0) ”
  &&  emp
.

Definition val_rand_precondition_wit_1 :=
exists (n0___tespec_entry: Z),
exists (n_pre: Z),
~ ((  “ (n_pre = 1) ”
  &&  “ (n0___tespec_entry = 1) ”
  &&  “ (0 <= n0___tespec_entry) ”
  &&  “ (n0___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = n0___tespec_entry) ”
  &&  “ (n0___tespec_entry > 0) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_val_rand_safety_wit_1 : val_rand_safety_wit_1.
Axiom proof_of_val_rand_return_wit_1 : val_rand_return_wit_1.
Axiom proof_of_val_rand_partial_solve_wit_1 : val_rand_partial_solve_wit_1.
Axiom proof_of_val_rand_precondition_wit_1 : val_rand_precondition_wit_1.

End VC_Correct.
