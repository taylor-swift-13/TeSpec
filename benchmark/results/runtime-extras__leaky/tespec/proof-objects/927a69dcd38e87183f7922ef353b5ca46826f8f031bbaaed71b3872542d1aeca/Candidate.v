From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_leaky_get_return_wit_1 : ~ Goal.leaky_get_return_wit_1.
Proof.
  unfold Goal.leaky_get_return_wit_1.
  intros [Hleft | Hright].
Abort.

End Proofs.
