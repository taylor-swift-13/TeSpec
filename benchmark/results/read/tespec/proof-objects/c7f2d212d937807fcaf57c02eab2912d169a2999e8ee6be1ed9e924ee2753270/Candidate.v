From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* Refutation target remains unresolved. *)
Lemma proof_of_read_return_wit_1 : ~ Goal.read_return_wit_1.
Proof. Abort.

End Proofs.
