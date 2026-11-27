From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_copy_precondition_wit_1 : Goal.IntList_copy_precondition_wit_1.
Proof.
  unfold Goal.IntList_copy_precondition_wit_1.
  exists (cons 1 (@nil Z)), 8192.
  (* Unresolved: construct a concrete model of the singleton list,
     with integer 1 at address 8192 and null pointer at address 8196,
     and use it to contradict entailment of False. *)
Abort.

End Proofs.
