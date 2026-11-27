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
    H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12.
  rewrite <- H10.
  apply orp_right2.
  Exists x retval f l.
  entailer!; congruence.
Qed.

Lemma proof_of_IntQueue_push_precondition_wit_1 : Goal.IntQueue_push_precondition_wit_1.
Proof.
Abort.

End Proofs.
