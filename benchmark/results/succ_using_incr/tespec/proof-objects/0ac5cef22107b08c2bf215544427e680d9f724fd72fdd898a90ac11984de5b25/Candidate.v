From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

(* Both disjuncts demand emp from an allocated UInt cell.
   The original target remains unresolved; refutation is requested below. *)
Lemma proof_of_succ_using_incr_attempt_return_wit_1 : Goal.succ_using_incr_attempt_return_wit_1.
Proof. Abort.

End Proofs.
