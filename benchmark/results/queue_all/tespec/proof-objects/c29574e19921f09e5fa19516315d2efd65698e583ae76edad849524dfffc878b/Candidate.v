From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntQueue_push_return_wit_1 : Goal.IntQueue_push_return_wit_1.
Proof.
  unfold Goal.IntQueue_push_return_wit_1.
  intros l x0 f b last pre x q retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6
    PreH7 PreH8 PreH9 PreH10 PreH11 PreH12.
  rewrite <- PreH10.
  rewrite PreH7.
  apply orp_right.
  right.
  Exists x0 retval f l.
  entailer!.
Qed.

Lemma proof_of_IntQueue_push_precondition_wit_1 : Goal.IntQueue_push_precondition_wit_1.
Proof.
Abort.

End Proofs.
