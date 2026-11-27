From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

Lemma proof_of_bad_return_wit_1 : ~ Goal.bad_return_wit_1.
Proof.
Abort.

End Proofs.
