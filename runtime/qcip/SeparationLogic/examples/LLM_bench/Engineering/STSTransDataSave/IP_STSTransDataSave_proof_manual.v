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
From SimpleC.EE.LLM_bench.Engineering.STSTransDataSave Require Import IP_STSTransDataSave_goal.
From SimpleC.EE.LLM_bench.Engineering.STSTransDataSave Require Import IP_STSTransDataSave_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Require Import SimpleC.EE.LLM_bench.Engineering.STSTransDataSave.IP_STSTransDataSave_lib.
Local Open Scope sac.

Lemma proof_of_STSTransDataSave_return_wit_1 : STSTransDataSave_return_wit_1.
Proof.
  right.
  pre_process_default.
  Exists (prefix ++ data_head ++ suffix).
  split_pure_spatial.
  - subst pDst.
    pose proof (STS_CharArray_full_merge3 1074343936 ptr 248 (1024 - ptr - 248) prefix data_head suffix) as Hm.
    specialize (Hm ltac:(lia) ltac:(lia) ltac:(lia)).
    replace (CharArray.full 1074343936 1024 (prefix ++ data_head ++ suffix))
      with (CharArray.full 1074343936 (ptr + 248 + (1024 - ptr - 248))
        (prefix ++ data_head ++ suffix)).
    + apply Hm.
    + f_equal; lia.
  - dump_pre_spatial.
    apply STSTransDataSaveBytePost_true_segment;
      unfold STS_PACKET_WINDOW_LEN, STS_COPY_LEN, STS_PTR_LIMIT in *; lia.
Qed.

Lemma proof_of_STSTransDataSave_return_wit_2 : STSTransDataSave_return_wit_2.
Proof.
  right.
  pre_process_default.
  Exists (prefix ++ old_dst ++ suffix).
  split_pure_spatial.
  - pose proof (STS_CharArray_full_merge3 1074343936 ptr 248 (1024 - ptr - 248) prefix old_dst suffix) as Hm.
    specialize (Hm ltac:(lia) ltac:(lia) ltac:(lia)).
    replace (CharArray.full 1074343936 1024 (prefix ++ old_dst ++ suffix))
      with (CharArray.full 1074343936 (ptr + 248 + (1024 - ptr - 248))
        (prefix ++ old_dst ++ suffix)).
    + apply Hm.
    + f_equal; lia.
  - dump_pre_spatial.
    apply STSTransDataSaveBytePost_false_segment;
      unfold STS_PACKET_WINDOW_LEN, STS_COPY_LEN, STS_PTR_LIMIT in *; lia.
Qed.
