From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.

Module Proofs.

(* Proposed refutation: both disjuncts require a heap containing an
   allocated integer cell to satisfy emp. A formal countermodel is
   still needed; this target remains unresolved. *)
Lemma proof_of_read_return_wit_1 : ~ Goal.read_return_wit_1.
Proof.
Abort.

End Proofs.
