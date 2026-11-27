From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.

Lemma proof_of_pop_precondition_wit_1 : Goal.pop_precondition_wit_1.
Proof.
  unfold Goal.pop_precondition_wit_1.
  exists (cons 0 (cons 3 (@nil Z))).
  exists (-1).
  exists 8192.
  exists 4096.
  intro Hunsat.
  (* Unresolved: construct a concrete heap satisfying the antecedent
     of Hunsat, with p_size = 3 and list nodes at 8192, 8200, 8208. *)
Abort.

End Proofs.
