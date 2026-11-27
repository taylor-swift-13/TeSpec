From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_leaky_get_return_wit_1 : ~ Goal.leaky_get_return_wit_1.
Proof.
Abort.

End Proofs.
