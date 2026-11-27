From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

(* Unresolved: both disjuncts require a nonempty UInt points-to heap
   to entail emp, despite the satisfiable address and value guards. *)
Lemma proof_of_leaky_get_return_wit_1 : Goal.leaky_get_return_wit_1.
Proof. Abort.

End Proofs.
