From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope Z_scope.
Local Open Scope sac.

Module Proofs.

Lemma proof_of_IntList_cons_precondition_wit_1 : Goal.IntList_cons_precondition_wit_1.
Proof.
  unfold Goal.IntList_cons_precondition_wit_1.
  exists (cons (-1) (cons 0 (cons 3 (@nil Z)))) .
  exists (-1), (-1), 8192.
  intro Hfalse.
  (* Unresolved: construct a concrete heap satisfying the three-node sll
     rooted at 8192, then apply Hfalse to that heap. *)
Abort.

End Proofs.
