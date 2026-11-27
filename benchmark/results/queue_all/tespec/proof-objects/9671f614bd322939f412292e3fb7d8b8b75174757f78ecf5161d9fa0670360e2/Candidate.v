From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntQueue_push_return_wit_1 : Goal.IntQueue_push_return_wit_1.
Proof.
  unfold Goal.IntQueue_push_return_wit_1.
  intros l___tespec_entry x0___tespec_entry f_2 b_2 last_2 pre_2
         x_pre q_pre retval
         PreH1 PreH2 PreH3 PreH4 PreH5 PreH6
         PreH7 PreH8 PreH9 PreH10 PreH11 PreH12.
  rewrite <- PreH10.
  rewrite PreH7.
  apply orp_right2.
  Exists x0___tespec_entry retval f_2 l___tespec_entry.
  entailer!.
Qed.

Lemma proof_of_IntQueue_push_precondition_wit_1 : Goal.IntQueue_push_precondition_wit_1.
Proof.
Abort.

End Proofs.
