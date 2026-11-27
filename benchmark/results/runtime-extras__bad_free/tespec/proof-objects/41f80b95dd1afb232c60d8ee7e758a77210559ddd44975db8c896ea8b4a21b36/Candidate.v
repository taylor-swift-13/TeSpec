From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_main_entail_wit_1 : ~ Goal.main_entail_wit_1.
Proof.
  unfold Goal.main_entail_wit_1.
  assert (Hne : (1 : Z) <> 0) by lia.
  assert (Hlo : (0 <= 1)%Z) by lia.
  assert (Hhi : (1 <= UINT_MAX)%Z)
    by (vm_compute; intuition discriminate).
  assert (Hempty :
    (TT && emp) (@ConAssertion.empty_state naive_C_Rules.sts)).
  { split.
    - exact I.
    - exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts).
  }
  intros [H | H];
    specialize (H 1 Hne Hlo Hhi);
    specialize (H (@ConAssertion.empty_state naive_C_Rules.sts) Hempty);
    cbv in H;
    firstorder congruence.
Qed.

End Proofs.
