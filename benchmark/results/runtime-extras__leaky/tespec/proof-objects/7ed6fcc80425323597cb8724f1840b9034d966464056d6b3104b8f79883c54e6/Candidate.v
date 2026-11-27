Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.

Module Proofs.

Lemma proof_of_main_entail_wit_1 : ~ Goal.main_entail_wit_1.
Proof.
Abort.

End Proofs.
