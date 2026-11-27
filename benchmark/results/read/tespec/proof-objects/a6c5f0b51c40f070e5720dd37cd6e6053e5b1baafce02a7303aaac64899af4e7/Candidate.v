From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

Lemma proof_of_read_return_wit_1 : ~ Goal.read_return_wit_1.
Proof.
Abort.

End Proofs.
