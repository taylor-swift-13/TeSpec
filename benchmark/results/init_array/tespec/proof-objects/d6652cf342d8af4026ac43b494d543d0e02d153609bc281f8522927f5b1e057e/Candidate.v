Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_init_array_return_wit_1 : Goal.init_array_return_wit_1.
Proof.
  unfold Goal.init_array_return_wit_1.
  right.
  intros.
  unfold CharArray.full, store_array.
  simpl.
  entailer!.
Qed.

End Proofs.
