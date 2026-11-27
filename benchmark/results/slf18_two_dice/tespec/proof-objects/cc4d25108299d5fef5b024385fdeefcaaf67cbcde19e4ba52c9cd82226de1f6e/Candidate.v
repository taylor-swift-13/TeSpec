From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import Coq.micromega.Lia.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_two_dice_entail_wit_1 : Goal.two_dice_entail_wit_1.
Proof.
  unfold Goal.two_dice_entail_wit_1.
  right.
  intros.
  assert (Hmod : 0 <= retval_3 % 6 < 6).
  { apply Z.mod_pos_bound; lia. }
  entailer!.
Qed.

Lemma proof_of_two_dice_entail_wit_2 : Goal.two_dice_entail_wit_2.
Proof.
  unfold Goal.two_dice_entail_wit_2.
  right.
  intros.
  assert (Hmod : 0 <= retval_2 % 6 < 6).
  { apply Z.mod_pos_bound; lia. }
  entailer!.
Qed.

Lemma small_unsigned_last_nbits :
  forall x : Z, 0 <= x <= 12 -> unsigned_last_nbits x 32 = x.
Proof.
  intros x Hx.
  unfold unsigned_last_nbits.
  apply Z.mod_small.
  change (0 <= x < 4294967296).
  lia.
Qed.

Lemma proof_of_two_dice_return_wit_1 : Goal.two_dice_return_wit_1.
Proof.
  unfold Goal.two_dice_return_wit_1.
  left.
  intros.
  assert (Hmod1 : 0 <= retval % 6 < 6).
  { apply Z.mod_pos_bound; lia. }
  assert (Hmod2 : 0 <= retval_2 % 6 < 6).
  { apply Z.mod_pos_bound; lia. }
  assert (Hsum : unsigned_last_nbits (retval % 6 + retval_2 % 6) 32 =
                 retval % 6 + retval_2 % 6).
  { apply small_unsigned_last_nbits; lia. }
  rewrite Hsum.
  assert (Hresult : unsigned_last_nbits (retval % 6 + retval_2 % 6 + 2) 32 =
                    retval % 6 + retval_2 % 6 + 2).
  { apply small_unsigned_last_nbits; lia. }
  rewrite Hresult.
  entailer!.
Qed.

End Proofs.
