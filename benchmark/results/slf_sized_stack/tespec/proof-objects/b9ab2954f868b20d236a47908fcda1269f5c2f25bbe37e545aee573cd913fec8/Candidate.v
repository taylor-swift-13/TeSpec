From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists (cons 2 (cons 1 (@nil Z))).
  exists INT_MAX.
  exists 8192.
  exists 4096.
  exists INT_MAX.
  (* Unresolved: construct a concrete separating heap containing the
     stack at 4096 and a two-node list rooted at 8192. *)
Abort.

End Proofs.
