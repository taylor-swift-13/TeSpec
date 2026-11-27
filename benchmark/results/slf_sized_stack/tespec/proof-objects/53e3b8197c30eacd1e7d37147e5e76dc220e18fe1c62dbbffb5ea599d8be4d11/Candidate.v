From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_sizeOf_precondition_wit_1 : Goal.sizeOf_precondition_wit_1.
Proof.
  (* Requires a concrete heap containing the stack fields at 4096 and
     4100, and the singleton list node at 8192 and 8196. *)
Abort.

End Proofs.
