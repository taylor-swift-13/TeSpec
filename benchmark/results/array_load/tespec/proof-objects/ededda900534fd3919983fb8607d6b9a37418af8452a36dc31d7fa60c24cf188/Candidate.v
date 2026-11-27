From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

Lemma proof_of_main_entail_wit_2 : ~ Goal.main_entail_wit_2.
Proof.
Abort.

End Proofs.
