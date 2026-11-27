From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_merge_entail_wit_1 : Goal.IntList_merge_entail_wit_1.
Proof.
  unfold Goal.IntList_merge_entail_wit_1.
  right.
  intros.
  entailer!.
  all: vm_compute; reflexivity.
Qed.

Lemma proof_of_IntList_merge_entail_wit_2 : Goal.IntList_merge_entail_wit_2.
Proof.
  unfold Goal.IntList_merge_entail_wit_2.
  right.
  intros.
  entailer!.
  all: vm_compute; reflexivity.
Qed.

Lemma proof_of_IntList_merge_return_wit_1 : Goal.IntList_merge_return_wit_1.
Proof.
  unfold Goal.IntList_merge_return_wit_1.
  right.
  intros.
  subst l___tespec_entry r___tespec_entry.
  entailer!.
  all: vm_compute; reflexivity.
Qed.

Lemma proof_of_IntList_merge_precondition_wit_1 : Goal.IntList_merge_precondition_wit_1.
Proof.
Abort.

End Proofs.
