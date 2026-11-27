From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
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
