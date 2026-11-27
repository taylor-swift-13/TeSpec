From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_top_precondition_wit_1 : Goal.top_precondition_wit_1.
Proof.
  unfold Goal.top_precondition_wit_1.
  exists (cons 0 (cons 3 (@nil Z))).
  exists (-1).
  exists 8192.
  exists 4096.
  (* Unresolved: construct a concrete state satisfying the nonempty
     spatial assertion, then apply the alleged entailment to it. *)
Abort.

End Proofs.
