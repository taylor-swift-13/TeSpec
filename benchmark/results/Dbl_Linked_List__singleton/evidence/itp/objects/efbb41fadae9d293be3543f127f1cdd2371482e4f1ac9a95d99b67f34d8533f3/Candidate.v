Require Import Goal.
Import SeparationLogic.naive_C_Rules.

Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  unfold Goal.singleton_return_wit_1.
  right.
  intros.
  first [ assumption | apply derivable1_refl ].
Qed.

End Proofs.
