From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists ((-1) :: 0 :: 3 :: nil)%list.
  exists (-1)%Z, 8192%Z, 4096%Z, (-1)%Z.
Abort.

End Proofs.
