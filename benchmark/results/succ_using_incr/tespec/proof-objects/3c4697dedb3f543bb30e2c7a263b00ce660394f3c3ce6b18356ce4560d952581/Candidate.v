From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_succ_using_incr_attempt_return_wit_1 :
  ~ Goal.succ_using_incr_attempt_return_wit_1.
Proof.
  (* Unresolved: a checked concrete model satisfying the UInt points-to
     assertion and contradicting emp is needed to refute both disjuncts. *)
Abort.

End Proofs.
