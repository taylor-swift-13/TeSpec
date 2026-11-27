From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_loop_precondition_wit_1 : Goal.IntList_rev_loop_precondition_wit_1.
Proof.
  unfold Goal.IntList_rev_loop_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  pose proof (@ConAssertion.empty_state_is_empty naive_C_Rules.sts) as HE.
  assert (HS :
    ((“ (0 = 0) ” && “ ((@nil Z) = (@nil Z)) ” &&
      (sll 0 (@nil Z)))
      (@ConAssertion.empty_state naive_C_Rules.sts))).
  {
    cbn [sll].
    repeat first [exact HE | reflexivity | split].
  }
  exact (H (@ConAssertion.empty_state naive_C_Rules.sts) HS).
Qed.

End Proofs.
