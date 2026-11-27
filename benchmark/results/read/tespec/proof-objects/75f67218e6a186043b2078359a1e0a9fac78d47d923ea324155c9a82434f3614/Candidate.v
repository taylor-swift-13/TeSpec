From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_read_return_wit_1 : ~ Goal.read_return_wit_1.
Proof.
  unfold Goal.read_return_wit_1.
  intro H.
  destruct H as [H | H].
  - specialize (H (-1) 4096 eq_refl eq_refl).
  - specialize (H (-1) 4096).
Abort.

End Proofs.
