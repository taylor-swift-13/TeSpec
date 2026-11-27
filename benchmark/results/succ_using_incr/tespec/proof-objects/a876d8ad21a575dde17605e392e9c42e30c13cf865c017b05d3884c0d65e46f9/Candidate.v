From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

(* Unresolved: refuting both disjuncts requires a concrete model of
   (retval # UInt |-> 6) and a proof that this model does not satisfy emp.
   The empty-state helper cannot supply that points-to model. *)
Lemma proof_of_succ_using_incr_attempt_return_wit_1 :
  ~ Goal.succ_using_incr_attempt_return_wit_1.
Proof. Abort.

End Proofs.
