From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_5b48e99c1f6bafd5808d7dbb.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_push_induction_return_wit_1 : Goal.push_induction_return_wit_1.
Proof.
  unfold Goal.push_induction_return_wit_1.
  left.
  intros.
  subst.
  simpl app.
  simpl sllseg.
  Intros.
  Exists 16384.
  entailer!.
Qed.

Lemma proof_of_push_induction_precondition_wit_1 : Goal.push_induction_precondition_wit_1.
Proof.
Abort.

End Proofs.
