From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_succ_using_incr_attempt_return_wit_1 :
  ~ Goal.succ_using_incr_attempt_return_wit_1.
Proof.
  (* Unresolved: refuting both disjuncts requires a concrete state
     satisfying the UInt points-to assertion and not emp.
     The supplied empty-state helper cannot establish that assertion. *)
Abort.

End Proofs.
