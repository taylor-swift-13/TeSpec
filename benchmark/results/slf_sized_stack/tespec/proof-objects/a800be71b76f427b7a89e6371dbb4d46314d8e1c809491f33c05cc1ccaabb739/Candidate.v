From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_pop_precondition_wit_1 : Goal.pop_precondition_wit_1.
Proof.
  unfold Goal.pop_precondition_wit_1.
  exists (@nil Z), INT_MIN, 8192, 4096.
  intro Hunsat.
  (* Unresolved: construct a concrete model satisfying the four disjoint
     stores at 4096, 4100, 8192 and 8196, with values 1, 8192,
     INT_MIN and 0 respectively, then contradict Hunsat.
     The empty model does not satisfy this assertion. *)
Abort.

End Proofs.
