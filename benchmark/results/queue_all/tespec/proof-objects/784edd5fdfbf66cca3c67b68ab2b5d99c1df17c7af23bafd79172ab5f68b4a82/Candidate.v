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
    Hbn Hrn Hx Hq Hl Hx0 Hxx Hfn Hbn' Hlist Hrlo Hrhi.
  rewrite <- Hlist.
  rewrite Hxx.
  apply orp_right2.
  Exists x0 retval f l.
  entailer!.
Qed.

Lemma proof_of_IntQueue_push_precondition_wit_1 : Goal.IntQueue_push_precondition_wit_1.
Proof.
Abort.

End Proofs.
