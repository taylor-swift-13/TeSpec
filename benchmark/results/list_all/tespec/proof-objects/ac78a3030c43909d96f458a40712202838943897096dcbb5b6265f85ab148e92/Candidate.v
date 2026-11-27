From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (cons 1 nil), INT_MIN, INT_MIN, 8192.
  (* Remaining obligation: establish satisfiability of the concrete singleton-list heap. *)
Abort.

End Proofs.
