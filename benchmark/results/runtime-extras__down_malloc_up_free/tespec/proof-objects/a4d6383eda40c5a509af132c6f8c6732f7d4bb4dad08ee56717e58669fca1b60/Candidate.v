From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_main_entail_wit_1 : ~ Goal.main_entail_wit_1.
Proof.
  unfold Goal.main_entail_wit_1.
  intro H.
  assert (He : (TT && emp)
    (@ConAssertion.empty_state naive_C_Rules.sts)).
  { split.
    - exact I.
    - exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts).
  }
  destruct H as [H | H];
    specialize (H 1 ltac:(vm_compute; congruence)
                    ltac:(vm_compute; congruence)
                    ltac:(vm_compute; congruence));
    specialize (H (@ConAssertion.empty_state naive_C_Rules.sts) He).
  all: cbv in H; firstorder congruence.
Qed.

End Proofs.
