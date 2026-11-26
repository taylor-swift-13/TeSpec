Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.

Module Proofs.

(* Refutation remains unresolved: a proof must exhibit a valid UInt
   cell at address 4096 containing 2, then show its heap is not empty. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
