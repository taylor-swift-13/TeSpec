From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_append2_precondition_wit_1 : Goal.IntList_append2_precondition_wit_1.
Proof.
  unfold Goal.IntList_append2_precondition_wit_1.
  exists (cons 1 (@nil Z)).
  exists (@nil Z).
  exists 0.
  exists 16384.
  (* Unresolved: establish satisfiability of the singleton-list heap,
     with data 1 at 16384 and next pointer 0 at 16388.
     The concrete empty model does not satisfy this assertion. *)
Abort.

End Proofs.
