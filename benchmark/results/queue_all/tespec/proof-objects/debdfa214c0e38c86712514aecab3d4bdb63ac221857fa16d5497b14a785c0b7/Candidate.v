From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntQueue_push_return_wit_1 : Goal.IntQueue_push_return_wit_1.
Proof.
  unfold Goal.IntQueue_push_return_wit_1.
  intros l_entry x_entry f_2 b_2 last_2 pre_2 x_pre q_pre retval
    PreH1 PreH2 PreH3 PreH4 PreH5 PreH6 PreH7 PreH8 PreH9
    PreH10 PreH11 PreH12.
  rewrite PreH5 in PreH10.
  destruct pre_2; discriminate PreH10.
Qed.

End Proofs.
