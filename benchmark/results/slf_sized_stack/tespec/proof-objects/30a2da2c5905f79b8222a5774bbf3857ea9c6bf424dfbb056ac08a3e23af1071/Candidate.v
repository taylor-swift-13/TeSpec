From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_pop_precondition_wit_1 : Goal.pop_precondition_wit_1.
Proof.
  unfold Goal.pop_precondition_wit_1.
  exists (cons 1 (@nil Z)), 2, 8192, 4096.
  (* Unresolved: construct a satisfying concrete heap for the two stack
     fields and two disjoint list nodes, then instantiate the entailment
     on that heap to derive False. The empty model does not suffice. *)
Abort.

End Proofs.
