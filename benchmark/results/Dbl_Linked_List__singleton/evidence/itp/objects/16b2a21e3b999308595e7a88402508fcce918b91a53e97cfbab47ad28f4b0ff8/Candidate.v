From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  unfold Goal.singleton_return_wit_1.
  right.
  intros.
  apply derivable1_refl.
Qed.

End Proofs.
