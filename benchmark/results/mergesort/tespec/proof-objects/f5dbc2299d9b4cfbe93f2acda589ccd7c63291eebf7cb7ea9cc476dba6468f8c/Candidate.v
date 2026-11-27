From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_merge_return_wit_1 : Goal.IntList_merge_return_wit_1.
Proof.
  unfold Goal.IntList_merge_return_wit_1.
  right.
  intros.
  subst l___tespec_entry r___tespec_entry.
  assert (E :
    cn_merge (cons 2 (cons (-1) nil))
      (cons INT_MAX (cons 0 (cons INT_MIN nil))) =
    cons 2 (cn_merge (cons (-1) nil)
      (cons INT_MAX (cons 0 (cons INT_MIN nil))))).
  { vm_compute; reflexivity. }
  rewrite E.
  entailer!.
Qed.

Lemma proof_of_IntList_merge_precondition_wit_1 : Goal.IntList_merge_precondition_wit_1.
Proof.
Abort.

End Proofs.
