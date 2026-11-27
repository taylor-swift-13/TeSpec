From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_rev_loop_entail_wit_1 : Goal.IntList_rev_loop_entail_wit_1.
Proof.
  unfold Goal.IntList_rev_loop_entail_wit_1.
  right.
  intros y Hmax Hmin Hy.
  Exists (cons 1 (@nil Z)).
  simpl sll.
  Exists 0.
  entailer!.
  all: try reflexivity.
  all: try (simpl in *; lia).
Qed.

Lemma proof_of_IntList_rev_loop_precondition_wit_1 : Goal.IntList_rev_loop_precondition_wit_1.
Proof.
Abort.

End Proofs.
