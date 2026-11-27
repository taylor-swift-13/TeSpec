From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* Unresolved: refuting both disjuncts requires a concrete heap
   satisfying the UInt points-to assertion but not emp. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
