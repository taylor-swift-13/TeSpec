From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

(* Both disjuncts require discarding an allocated UInt cell to establish emp.
   The target is left unresolved pending refutation. *)
Lemma proof_of_succ_using_incr_attempt_return_wit_1 : Goal.succ_using_incr_attempt_return_wit_1.
Proof.
Abort.

End Proofs.
