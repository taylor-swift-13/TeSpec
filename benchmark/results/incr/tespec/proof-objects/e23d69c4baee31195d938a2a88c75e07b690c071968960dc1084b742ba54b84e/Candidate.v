Require Import Goal.
From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.

Module Proofs.

(* Refutation remains unresolved: it requires a concrete nonempty heap
   satisfying the integer points-to assertion and falsifying emp. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
