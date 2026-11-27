From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_top_precondition_wit_1 : Goal.top_precondition_wit_1.
Proof.
  unfold Goal.top_precondition_wit_1.
  exists (cons 1 (@nil Z)), 2, 8192, 4096.
  (* Unresolved: construct a concrete state satisfying the spatial
     assertion with p_size = 2 and two disjoint list nodes. *)
Abort.

End Proofs.
