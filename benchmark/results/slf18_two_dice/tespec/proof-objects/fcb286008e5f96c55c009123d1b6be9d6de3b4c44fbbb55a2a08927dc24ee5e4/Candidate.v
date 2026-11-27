From Coq Require Import ZArith Lia.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma small_unsigned_32 : forall x : Z,
  0 <= x <= 12 -> unsigned_last_nbits x 32 = x.
Proof.
  intros x Hx.
  change (x mod 4294967296 = x).
  apply Z.mod_small.
  lia.
Qed.

Lemma proof_of_two_dice_entail_wit_1 : Goal.two_dice_entail_wit_1.
Proof.
  unfold Goal.two_dice_entail_wit_1.
  right.
  intros retval retval_3 PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8.
  pose proof (Z.mod_pos_bound retval_3 6 ltac:(lia)) as Hmod.
  entailer!.
Qed.

Lemma proof_of_two_dice_entail_wit_2 : Goal.two_dice_entail_wit_2.
Proof.
  unfold Goal.two_dice_entail_wit_2.
  right.
  intros retval_2 PreH1 PreH2 PreH3 PreH4.
  pose proof (Z.mod_pos_bound retval_2 6 ltac:(lia)) as Hmod.
  entailer!.
Qed.

Lemma proof_of_two_dice_return_wit_1 : Goal.two_dice_return_wit_1.
Proof.
  unfold Goal.two_dice_return_wit_1.
  left.
  intros retval retval_2 PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8.
  pose proof (Z.mod_pos_bound retval 6 ltac:(lia)) as Hmod1.
  pose proof (Z.mod_pos_bound retval_2 6 ltac:(lia)) as Hmod2.
  assert (Hsum : unsigned_last_nbits (retval mod 6 + retval_2 mod 6) 32 =
                 retval mod 6 + retval_2 mod 6).
  { apply small_unsigned_32. lia. }
  rewrite Hsum.
  assert (Hresult : unsigned_last_nbits (retval mod 6 + retval_2 mod 6 + 2) 32 =
                    retval mod 6 + retval_2 mod 6 + 2).
  { apply small_unsigned_32. lia. }
  rewrite Hresult.
  entailer!.
Qed.

End Proofs.
