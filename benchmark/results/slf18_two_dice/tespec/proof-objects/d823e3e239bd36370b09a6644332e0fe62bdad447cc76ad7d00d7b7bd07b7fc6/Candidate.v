From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_val_rand_return_wit_1 : Goal.val_rand_return_wit_1.
Proof.
  unfold Goal.val_rand_return_wit_1.
  left.
  intros n0___tespec_entry n_pre retval PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8.
  assert (Hmod : 0 <= retval % n_pre < n_pre).
  { apply Z.mod_pos_bound. lia. }
  entailer!; lia.
Qed.

End Proofs.
