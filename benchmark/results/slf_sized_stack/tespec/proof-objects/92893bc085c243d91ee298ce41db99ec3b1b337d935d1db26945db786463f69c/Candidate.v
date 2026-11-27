From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.

Lemma proof_of_sizeOf_precondition_wit_1 : Goal.sizeOf_precondition_wit_1.
Proof.
  unfold Goal.sizeOf_precondition_wit_1.
  exists (cons 1 (@nil Z)), 8192, 4096.
  (* Unresolved: construct a concrete state satisfying the four disjoint
     stores and the empty tail of the singleton linked list. *)
Abort.

End Proofs.
