Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Classes.RelationClasses.
Require Import Coq.Classes.Morphisms.
Require Import Coq.micromega.Psatz.
Require Import Coq.Sorting.Permutation.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
From SimpleC.EE.LLM_bench.Engineering.STSUseFlag Require Import IP_STSUseFlag_goal.
From SimpleC.EE.LLM_bench.Engineering.STSUseFlag Require Import IP_STSUseFlag_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Require Import SimpleC.EE.LLM_bench.Engineering.STSUseFlag.IP_STSUseFlag_lib.
Local Open Scope sac.

Lemma proof_of_STSUseFlag_return_wit_1 : STSUseFlag_return_wit_1.
Proof.
  right.
  pre_process.
  unfold STSUseFlagPost, STSUseFlagMappedStatus, STSUseFlag_TRUE32.
  split_pure_spatial.
  - entailer!.
  - dump_pre_spatial.
    split.
    + reflexivity.
    + right. left.
      split; [assumption |].
      split; [assumption |].
      split; [reflexivity |].
      split.
      * left. split; [assumption | reflexivity].
      * reflexivity.
Qed.

Lemma proof_of_STSUseFlag_return_wit_2 : STSUseFlag_return_wit_2.
Proof.
  right.
  pre_process.
  unfold STSUseFlagPost, STSUseFlagMappedStatus, STSUseFlag_TRUE32.
  split_pure_spatial.
  - entailer!.
  - dump_pre_spatial.
    split.
    + reflexivity.
    + right. left.
      split; [assumption |].
      split; [assumption |].
      split; [reflexivity |].
      split.
      * right. left. split; [assumption | reflexivity].
      * reflexivity.
Qed.

Lemma proof_of_STSUseFlag_return_wit_3 : STSUseFlag_return_wit_3.
Proof.
  right.
  pre_process.
  unfold STSUseFlagPost, STSUseFlagMappedStatus, STSUseFlag_TRUE32.
  split_pure_spatial.
  - entailer!.
  - dump_pre_spatial.
    split.
    + reflexivity.
    + right. left.
      split; [assumption |].
      split; [assumption |].
      split; [reflexivity |].
      split.
      * right. right. left. split; [assumption | reflexivity].
      * reflexivity.
Qed.

Lemma proof_of_STSUseFlag_return_wit_4 : STSUseFlag_return_wit_4.
Proof.
  right.
  pre_process.
  unfold STSUseFlagPost, STSUseFlagMappedStatus, STSUseFlag_TRUE32.
  split_pure_spatial.
  - entailer!.
  - dump_pre_spatial.
    split.
    + reflexivity.
    + right. left.
      split; [assumption |].
      split; [assumption |].
      split; [reflexivity |].
      split.
      * right. right. right.
        split; [assumption |].
        split; [assumption |].
        split; [assumption | reflexivity].
      * reflexivity.
Qed.

Lemma proof_of_STSUseFlag_return_wit_5 : STSUseFlag_return_wit_5.
Proof.
  right.
  pre_process.
  unfold STSUseFlagPost, STSUseFlag_TRUE32.
  split_pure_spatial.
  - entailer!.
  - dump_pre_spatial.
    split.
    + reflexivity.
    + right. right. left.
      split; [assumption |].
      split; [assumption |].
      split; [assumption |].
      split; [reflexivity |].
      split; reflexivity.
Qed.

Lemma proof_of_STSUseFlag_return_wit_6 : STSUseFlag_return_wit_6.
Proof.
  right.
  pre_process.
  unfold STSUseFlagPost, STSUseFlag_TRUE32.
  split_pure_spatial.
  - entailer!.
  - dump_pre_spatial.
    split.
    + reflexivity.
    + right. right. right.
      split; [assumption |].
      split; [assumption |].
      split; [assumption |].
      split; [reflexivity |].
      split; reflexivity.
Qed.

Lemma proof_of_STSUseFlag_return_wit_7 : STSUseFlag_return_wit_7.
Proof.
  right.
  pre_process.
  unfold STSUseFlagPost, STSUseFlag_FALSE32.
  split_pure_spatial.
  - entailer!.
  - dump_pre_spatial.
    split.
    + reflexivity.
    + left.
      split; [assumption |].
      split; [reflexivity |].
      split; reflexivity.
Qed.
