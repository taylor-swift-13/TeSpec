From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_main_entail_wit_7 : Goal.main_entail_wit_7.
Proof.
  unfold Goal.main_entail_wit_7.
  left.
  replace (&("a_spec_392")) with
    (&("a_spec_392") + 0 * sizeof(INT)) at 2 by ring.
  eapply IntArray.full_split; simpl; lia.
Qed.

End Proofs.
