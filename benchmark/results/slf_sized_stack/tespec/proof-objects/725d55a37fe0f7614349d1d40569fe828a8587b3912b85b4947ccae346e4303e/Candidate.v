From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_top_precondition_wit_1 : Goal.top_precondition_wit_1.
Proof.
  unfold Goal.top_precondition_wit_1.
  exists (@nil Z), INT_MIN, 8192%Z, 4096%Z.
  (* Unresolved: construct a concrete separating heap containing the
     size 1 at 4096, pointer 8192 at 4100, INT_MIN at 8192,
     and null pointer at 8196, then instantiate the entailment. *)
Abort.

End Proofs.
