From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal CNQueueGuarded.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_push_induction_precondition_wit_1 : Goal.push_induction_precondition_wit_1.
Proof.
  unfold Goal.push_induction_precondition_wit_1.
  exists (@nil Z), 16384, 7, 12288, 12288.
  cbn [CNQueueAux].
Abort.

End Proofs.
