From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists (cons (-1) (cons 0 (cons 3 nil))).
  exists (-1), 8192, 4096, (-1).
  (* Unresolved: construct a concrete heap satisfying the stack header
     and the three disjoint list nodes. *)
Abort.

End Proofs.
