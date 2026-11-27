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
    H_b H_ret H_x H_q H_l H_x0 H_eq H_f H_b' H_split H_lo H_hi.
  rewrite <- H_split.
  rewrite H_eq.
  apply derivable1_orp_intros2.
  Exists x0 retval f l.
  entailer!.
Qed.

Lemma proof_of_IntQueue_push_precondition_wit_1 : Goal.IntQueue_push_precondition_wit_1.
Proof.
Abort.

End Proofs.
