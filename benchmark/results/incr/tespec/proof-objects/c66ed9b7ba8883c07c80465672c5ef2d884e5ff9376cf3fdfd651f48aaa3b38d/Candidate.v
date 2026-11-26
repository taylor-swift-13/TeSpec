From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Module Proofs.

(* Refutation target: input_1 / proof_of_incr_return_wit_1.
   Both disjuncts require a nonempty UInt cell to entail emp.
   The intended counterexample uses old___tespec_entry = 1,
   p_pre = 4096, and a heap storing UInt value 2 at 4096.
   The formal heap counterexample remains unresolved. *)
Lemma proof_of_incr_return_wit_1 : ~ Goal.incr_return_wit_1.
Proof. Abort.

End Proofs.
