From Coq Require Import ZArith.
Definition Zgcd (x y : Z) : Z := Z.gcd x y.
Definition Zabs (x : Z) : Z := Z.abs x.
Lemma gcd_zero_right x : Zgcd x 0 = Zabs x.
Proof. apply Z.gcd_0_r. Qed.
Print Assumptions gcd_zero_right.
