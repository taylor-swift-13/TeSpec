From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_succ_using_incr_attempt_return_wit_1 :
  ~ Goal.succ_using_incr_attempt_return_wit_1.
Proof.
  (* Unresolved: both disjuncts require discarding an allocated UInt cell.
     A refutation needs a checked concrete model of that points-to assertion. *)
Abort.

End Proofs.
