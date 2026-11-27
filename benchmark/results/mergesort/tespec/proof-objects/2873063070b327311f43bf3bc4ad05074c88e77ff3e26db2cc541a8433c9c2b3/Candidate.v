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
  entailer!; lia.
Qed.

Lemma proof_of_IntList_split_return_wit_1 : Goal.IntList_split_return_wit_1.
Proof.
  unfold Goal.IntList_split_return_wit_1.
  right.
  intros l xs y y2 H1 H2 H3 H4 H5 H6 H7 H8 H9.
  subst l.
  cbn [cn_split_fst cn_split_snd cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_split_precondition_wit_1 : Goal.IntList_split_precondition_wit_1.
Proof.
Abort.

End Proofs.
