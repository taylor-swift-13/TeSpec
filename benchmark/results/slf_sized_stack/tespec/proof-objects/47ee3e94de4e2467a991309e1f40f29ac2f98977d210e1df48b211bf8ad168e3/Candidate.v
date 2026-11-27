From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_pop_precondition_wit_1 : Goal.pop_precondition_wit_1.
Proof.
  unfold Goal.pop_precondition_wit_1.
  exists (cons 0 (cons 3 nil)), (-1), 8192, 4096.
  (* Unresolved: prove satisfiability of the nonempty separating assertion. *)
Abort.

End Proofs.
