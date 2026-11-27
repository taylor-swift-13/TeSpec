From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_succ_using_incr_attempt_return_wit_1 :
  ~ Goal.succ_using_incr_attempt_return_wit_1.
Proof.
  unfold Goal.succ_using_incr_attempt_return_wit_1.
  intros [Hleft | Hright].
  (* Unresolved: each branch requires a concrete state satisfying
     the instantiated UInt points-to assertion but not emp.
     The empty-state helper does not establish this antecedent. *)
Abort.

End Proofs.
