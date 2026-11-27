From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.

Module Proofs.

(* Unresolved: requires a concrete satisfying heap and a proof that it is nonempty. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
