From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.

Module Proofs.

(* Refutation target: input_3 / proof_of_incr_return_wit_1.
   Both disjuncts require a heap containing an integer cell to entail emp.
   The semantic counterexample proof remains unresolved. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof.
Abort.

End Proofs.
