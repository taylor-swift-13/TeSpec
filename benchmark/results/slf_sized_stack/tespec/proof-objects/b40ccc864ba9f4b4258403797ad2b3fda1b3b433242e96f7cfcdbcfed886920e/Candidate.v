From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists (cons 1 (@nil Z)).
  exists INT_MIN.
  exists 8192.
  exists 4096.
  exists INT_MIN.
Abort.

End Proofs.
