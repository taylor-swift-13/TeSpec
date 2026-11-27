From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.

Module Proofs.

(* Unresolved: refuting either disjunct requires a concrete satisfying
   heap for the UInt cell at address 4096 and proof that it is nonempty. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
