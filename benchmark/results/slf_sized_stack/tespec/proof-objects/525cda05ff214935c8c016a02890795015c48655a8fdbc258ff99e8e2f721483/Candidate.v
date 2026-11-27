From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_sizeOf_precondition_wit_1 : Goal.sizeOf_precondition_wit_1.
Proof.
  unfold Goal.sizeOf_precondition_wit_1.
  exists (cons (-1) (cons 0 (cons 3 (@nil Z)))).
  exists 8192.
  exists 4096.
  (* Unresolved: construct a concrete state satisfying the size and data
     fields together with three disjoint linked-list nodes. *)
Abort.

End Proofs.
