From SimpleC.Verification Require Import VCPrelude.
Require Import ExecutionGoal DLLSupplement.
Require Import ReferenceCandidate.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Theorem resolved_add_precondition_wit_1 : ExecutionGoal.add_precondition_wit_1.
Proof.
  exact ReferenceCandidate.resolved_add_precondition_wit_1.
Qed.
Print Assumptions resolved_add_precondition_wit_1.
