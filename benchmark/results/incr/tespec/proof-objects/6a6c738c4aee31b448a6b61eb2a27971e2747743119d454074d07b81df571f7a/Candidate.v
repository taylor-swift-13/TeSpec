From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_incr_return_wit_1 : Goal.incr_return_wit_1.
Proof.
  unfold Goal.incr_return_wit_1.
  left.
  intros.
  entailer!.
Qed.

End Proofs.
