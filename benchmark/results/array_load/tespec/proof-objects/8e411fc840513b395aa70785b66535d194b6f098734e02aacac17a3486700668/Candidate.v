From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_main_entail_wit_2 : Goal.main_entail_wit_2.
Proof. Abort.

Lemma proof_of_main_entail_wit_4 : Goal.main_entail_wit_4.
Proof. Abort.

Lemma proof_of_main_entail_wit_5 : Goal.main_entail_wit_5.
Proof.
  unfold Goal.main_entail_wit_5.
  right.
  intros.
  entailer!.
Qed.

Lemma proof_of_main_entail_wit_6 : Goal.main_entail_wit_6.
Proof. Abort.

End Proofs.
