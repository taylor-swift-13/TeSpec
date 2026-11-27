From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.

Module Proofs.

(* Refutation remains unresolved: both disjuncts require a nonempty
   UInt cell at address 4096, containing 2147483649, to entail emp.
   A formal counterheap construction is still required. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
