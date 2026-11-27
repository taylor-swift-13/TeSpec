From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.

Lemma proof_of_IntList_rev_aux_precondition_wit_1 : Goal.IntList_rev_aux_precondition_wit_1.
Proof.
  unfold Goal.IntList_rev_aux_precondition_wit_1.
  exists (cons 1 (@nil Z)).
  exists (@nil Z).
  exists 0.
  exists 16384.
  intro Hunsat.
  (* Unresolved: construct a concrete satisfying state containing the
     integer cell at 16384 and the null pointer cell at 16388,
     then apply Hunsat to that state. *)
Abort.

End Proofs.
