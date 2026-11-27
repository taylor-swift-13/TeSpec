From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* Refutation remains unresolved: it requires a concrete nonempty heap
   satisfying the integer points-to assertion at address 4096. *)
Lemma proof_of_read_return_wit_1 : ~ Goal.read_return_wit_1.
Proof.
Abort.

End Proofs.
