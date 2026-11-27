From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_top_precondition_wit_1 : Goal.top_precondition_wit_1.
Proof.
  unfold Goal.top_precondition_wit_1.
  exists (@nil Z), 0%Z, 8192%Z, 4096%Z.
  intro Hunsat.
  (* Unresolved: construct a concrete state satisfying the instantiated
     assertion, with p_size = 1 and the list's next pointer = 0. *)
Abort.

End Proofs.
