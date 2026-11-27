From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_main_entail_wit_7 : Goal.main_entail_wit_7.
Proof.
  unfold Goal.main_entail_wit_7.
  left.
  unfold IntArray.full, IntArray.missing_i.
  simpl.
  entailer!.
Qed.

End Proofs.
