From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Import naive_C_Rules.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_split_entail_wit_1 : Goal.IntList_split_entail_wit_1.
Proof.
  unfold Goal.IntList_split_entail_wit_1.
  right.
  intros.
  cbn [cn_split_fst cn_split_snd cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_split_return_wit_1 : Goal.IntList_split_return_wit_1.
Proof.
  unfold Goal.IntList_split_return_wit_1.
  right.
  intros.
  subst l___tespec_entry.
  cbn [cn_split_fst cn_split_snd cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_split_return_wit_2 : Goal.IntList_split_return_wit_2.
Proof.
Abort.

Lemma proof_of_IntList_split_precondition_wit_1 : Goal.IntList_split_precondition_wit_1.
Proof.
Abort.

End Proofs.
