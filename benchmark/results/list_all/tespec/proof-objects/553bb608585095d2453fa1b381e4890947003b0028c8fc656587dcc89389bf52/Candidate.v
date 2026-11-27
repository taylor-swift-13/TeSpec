From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_precondition_wit_1 : Goal.IntList_rev_precondition_wit_1.
Proof.
  unfold Goal.IntList_rev_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  assert (Hs : emp |--
    “ ((0 : Z) = 0) ” &&
    “ ((@nil Z) = (@nil Z)) ” &&
    sll 0 (@nil Z)).
  { simpl sll. entailer!. }
  exact (H (@ConAssertion.empty_state naive_C_Rules.sts)
    (Hs (@ConAssertion.empty_state naive_C_Rules.sts)
      (@ConAssertion.empty_state_is_empty naive_C_Rules.sts))).
Qed.

End Proofs.
