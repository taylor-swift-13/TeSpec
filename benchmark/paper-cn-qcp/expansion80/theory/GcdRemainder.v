From Coq Require Import ZArith.
Require Import gcd_spec.
Local Open Scope Z_scope.
Theorem gcd_step_mod x y : y <> 0 ->
  Zgcd x y = Zgcd y (Z.modulo x y).
Proof.
  intros H; unfold Zgcd.
  rewrite (Z.gcd_comm y (Z.modulo x y)), Z.gcd_mod by exact H.
  apply Z.gcd_comm.
Qed.
Theorem gcd_step_signed_rem x y : y <> 0 ->
  Zgcd x y = Zgcd y (Z.rem x y).
Proof.
  intros H; unfold Zgcd.
  rewrite (Z.gcd_comm y (Z.rem x y)), Z.gcd_rem by exact H.
  apply Z.gcd_comm.
Qed.
Print Assumptions gcd_step_mod.
Print Assumptions gcd_step_signed_rem.
