From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

Lemma proof_of_read_return_wit_1 : ~ Goal.read_return_wit_1.
Proof.
  unfold Goal.read_return_wit_1.
  intros [H | H].
  (* Unresolved: constructing a valid nonempty Int heap requires the
     underlying heap definitions and their supporting lemmas. *)
Abort.

End Proofs.
