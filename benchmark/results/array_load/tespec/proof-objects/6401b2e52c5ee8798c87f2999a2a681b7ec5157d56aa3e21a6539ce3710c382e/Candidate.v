From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_main_entail_wit_5 : Goal.main_entail_wit_5.
Proof.
  unfold Goal.main_entail_wit_5.
  right.
  intros.
  entailer!.
Qed.

End Proofs.
