From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* Both disjuncts require a heap containing a UInt cell to satisfy emp.
   The pure guards do not eliminate that cell. *)
Lemma proof_of_leaky_get_return_wit_1 : Goal.leaky_get_return_wit_1.
Proof.
Abort.

End Proofs.
