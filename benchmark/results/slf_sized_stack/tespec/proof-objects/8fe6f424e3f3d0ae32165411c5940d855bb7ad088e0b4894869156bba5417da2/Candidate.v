From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.

Lemma proof_of_pop_precondition_wit_1 : Goal.pop_precondition_wit_1.
Proof.
  unfold Goal.pop_precondition_wit_1.
  exists (@nil Z), 0, 8192, 4096.
  (* Unresolved: construct a concrete separating heap satisfying the
     instantiated assertion, with p_size = 1. *)
Abort.

End Proofs.
