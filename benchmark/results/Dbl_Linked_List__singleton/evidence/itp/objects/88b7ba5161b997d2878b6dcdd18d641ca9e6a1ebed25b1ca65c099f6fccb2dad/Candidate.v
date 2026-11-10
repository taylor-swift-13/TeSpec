Require Import Goal.
Module Proofs.

Lemma proof_of_singleton_return_wit_1 : Goal.singleton_return_wit_1.
Proof.
  unfold Goal.singleton_return_wit_1.
  right.
  intros e element retval Hnonzero Helement Hentry Heq
         Haddr_element Haddr_n Hmin Hmax Hretval.
  unfold SeparationLogic.naive_C_Rules.derivable1.
  intros.
  assumption.
Qed.

End Proofs.
