From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.

Lemma proof_of_sizeOf_precondition_wit_1 : Goal.sizeOf_precondition_wit_1.
Proof.
  unfold Goal.sizeOf_precondition_wit_1.
  exists (cons 2 (cons 1 (@nil Z))).
  exists 8192.
  exists 4096.
  (* Unresolved: construct a concrete separating heap satisfying the assertion. *)
Abort.

End Proofs.
