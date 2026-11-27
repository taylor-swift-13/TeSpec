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
  (* Unresolved: construct a concrete model of the nonempty list heap. *)
Abort.

End Proofs.
