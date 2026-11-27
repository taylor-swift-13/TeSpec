From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* Unresolved: refutation requires a concrete satisfying heap for
   4096 # Int |-> 0 and a proof that this heap does not satisfy emp. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
