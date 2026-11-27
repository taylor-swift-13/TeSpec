From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_val_rand_return_wit_1 : Goal.val_rand_return_wit_1.
Proof.
  unfold Goal.val_rand_return_wit_1.
  left.
  intros n0 n r H1 H2 H3 H4 H5 H6 H7 H8 H9 H10.
  rewrite H3, H4.
  entailer!;
    try rewrite Z.mod_1_r;
    try rewrite Z.rem_1_r;
    lia.
Qed.

End Proofs.
