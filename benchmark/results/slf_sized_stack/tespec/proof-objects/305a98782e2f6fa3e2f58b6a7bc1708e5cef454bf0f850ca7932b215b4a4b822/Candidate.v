From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_sizeOf_precondition_wit_1 : Goal.sizeOf_precondition_wit_1.
Proof.
  unfold Goal.sizeOf_precondition_wit_1.
  exists (cons 1 (nil : list Z)), 8192, 4096.
Abort.

End Proofs.
