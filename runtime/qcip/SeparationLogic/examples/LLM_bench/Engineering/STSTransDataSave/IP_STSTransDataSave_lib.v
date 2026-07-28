Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.micromega.Psatz.
From AUXLib Require Import ListLib.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
From SimpleC.EE.QCP_demos_LLM Require Import char_array_strategy_goal.

Import naive_C_Rules.

Local Open Scope Z_scope.
Local Open Scope list_scope.
Local Open Scope sac.

(* Predicate-first byte-copy post-state relation for STSTransDataSave.
   It states the mathematical SRAM-window effect without mirroring C control
   flow or the Memcpyx implementation algorithm.  The scratch C uses
   CharArray because all available local examples use CharArray for byte
   buffers; unsigned-char signedness remains a review item for main. *)

Definition STS_PACKET_BASE : Z := 1074343936.
Definition STS_PACKET_WINDOW_LEN : Z := 1024.
Definition STS_COPY_LEN : Z := 248.
Definition STS_DATABUF_LEN : Z := 256.
Definition STS_PTR_LIMIT : Z := 776.

Definition STSTransDataSavePost
    (old_ptr new_ptr copy_len : Z) : Prop :=
  copy_len = STS_COPY_LEN /\
  ((old_ptr < STS_PTR_LIMIT /\ new_ptr = old_ptr + copy_len) \/
   (old_ptr >= STS_PTR_LIMIT /\ new_ptr = old_ptr)).

Definition STSSramAfterCopy
    (old_ptr : Z) (data_buf old_sram new_sram : list Z) : Prop :=
  Zlength data_buf = STS_DATABUF_LEN /\
  Zlength old_sram = STS_PACKET_WINDOW_LEN /\
  Zlength new_sram = STS_PACKET_WINDOW_LEN /\
  0 <= old_ptr /\ old_ptr <= STS_PACKET_WINDOW_LEN /\
  ((old_ptr < STS_PTR_LIMIT /\
    new_sram =
      sublist 0 old_ptr old_sram ++
      sublist 0 STS_COPY_LEN data_buf ++
      sublist (old_ptr + STS_COPY_LEN) STS_PACKET_WINDOW_LEN old_sram) \/
   (old_ptr >= STS_PTR_LIMIT /\ new_sram = old_sram)).

Definition STSTransDataSaveBytePost
    (old_ptr new_ptr : Z) (data_buf old_sram new_sram : list Z) : Prop :=
  STSTransDataSavePost old_ptr new_ptr STS_COPY_LEN /\
  STSSramAfterCopy old_ptr data_buf old_sram new_sram.

Lemma STS_Zlength_three_app :
  forall (l1 l2 l3 : list Z) (n1 n2 n3 : Z),
    Zlength l1 = n1 ->
    Zlength l2 = n2 ->
    Zlength l3 = n3 ->
    Zlength (l1 ++ l2 ++ l3) = n1 + n2 + n3.
Proof.
  intros.
  repeat rewrite Zlength_app.
  lia.
Qed.

Lemma STS_sublist_three_app_first :
  forall (l1 l2 l3 : list Z) (n1 n2 n3 : Z),
    0 <= n1 ->
    0 <= n2 ->
    0 <= n3 ->
    Zlength l1 = n1 ->
    Zlength l2 = n2 ->
    Zlength l3 = n3 ->
    sublist 0 n1 (l1 ++ l2 ++ l3) = l1.
Proof.
  intros.
  replace n1 with (Zlength l1) by lia.
  rewrite sublist_app_exact1.
  reflexivity.
Qed.

Lemma STS_sublist_three_app_middle :
  forall (l1 l2 l3 : list Z) (n1 n2 n3 : Z),
    0 <= n1 ->
    0 <= n2 ->
    0 <= n3 ->
    Zlength l1 = n1 ->
    Zlength l2 = n2 ->
    Zlength l3 = n3 ->
    sublist n1 (n1 + n2) (l1 ++ l2 ++ l3) = l2.
Proof.
  intros.
  rewrite sublist_split_app_r with (len := Zlength l1) by lia.
  replace (n1 - Zlength l1) with 0 by lia.
  replace (n1 + n2 - Zlength l1) with (Zlength l2) by lia.
  rewrite sublist_app_exact1.
  reflexivity.
Qed.

Lemma STS_sublist_three_app_suffix :
  forall (l1 l2 l3 : list Z) (n1 n2 n3 : Z),
    0 <= n1 ->
    0 <= n2 ->
    0 <= n3 ->
    Zlength l1 = n1 ->
    Zlength l2 = n2 ->
    Zlength l3 = n3 ->
    sublist (n1 + n2) (n1 + n2 + n3) (l1 ++ l2 ++ l3) = l3.
Proof.
  intros.
  rewrite sublist_split_app_r with (len := Zlength l1) by lia.
  replace (n1 + n2 - Zlength l1) with (Zlength l2) by lia.
  replace (n1 + n2 + n3 - Zlength l1) with (Zlength l2 + Zlength l3) by lia.
  rewrite sublist_split_app_r with (len := Zlength l2) by lia.
  replace (Zlength l2 - Zlength l2) with 0 by lia.
  replace (Zlength l2 + Zlength l3 - Zlength l2) with (Zlength l3) by lia.
  apply sublist_self.
  reflexivity.
Qed.

Lemma STSTransDataSaveBytePost_true_segment :
  forall (ptr : Z) (data_head data_tail prefix old_dst suffix : list Z),
    ptr < STS_PTR_LIMIT ->
    0 <= ptr ->
    ptr <= STS_PTR_LIMIT ->
    Zlength data_head = STS_COPY_LEN ->
    Zlength data_tail = 8 ->
    Zlength prefix = ptr ->
    Zlength old_dst = STS_COPY_LEN ->
    Zlength suffix = STS_PACKET_WINDOW_LEN - ptr - STS_COPY_LEN ->
    STSTransDataSaveBytePost ptr (ptr + STS_COPY_LEN)
      (data_head ++ data_tail) (prefix ++ old_dst ++ suffix)
      (prefix ++ data_head ++ suffix).
Proof.
  intros.
  unfold STSTransDataSaveBytePost, STSTransDataSavePost, STSSramAfterCopy.
  unfold STS_PACKET_WINDOW_LEN, STS_COPY_LEN, STS_DATABUF_LEN, STS_PTR_LIMIT in *.
  split.
  - split.
    + reflexivity.
    + left; split; [lia | reflexivity].
  - repeat split.
    + rewrite Zlength_app. lia.
    + repeat rewrite Zlength_app; lia.
    + repeat rewrite Zlength_app; lia.
    + lia.
    + lia.
    + left.
      split; [lia |].
      replace ptr with (Zlength prefix) by lia.
      rewrite sublist_app_exact1.
      replace 248 with (Zlength data_head) by lia.
      rewrite sublist_app_exact1.
      replace (Zlength prefix + Zlength data_head) with
        (Zlength prefix + Zlength old_dst) by lia.
      replace 1024 with
        (Zlength prefix + Zlength old_dst + Zlength suffix) by lia.
      rewrite STS_sublist_three_app_suffix
        with (l1 := prefix) (l2 := old_dst) (l3 := suffix)
             (n1 := Zlength prefix) (n2 := Zlength old_dst)
             (n3 := Zlength suffix) by lia.
      reflexivity.
Qed.

Lemma STSTransDataSaveBytePost_false_segment :
  forall (ptr : Z) (data_head data_tail prefix old_dst suffix : list Z),
    ptr >= STS_PTR_LIMIT ->
    0 <= ptr ->
    ptr <= STS_PTR_LIMIT ->
    Zlength data_head = STS_COPY_LEN ->
    Zlength data_tail = 8 ->
    Zlength prefix = ptr ->
    Zlength old_dst = STS_COPY_LEN ->
    Zlength suffix = STS_PACKET_WINDOW_LEN - ptr - STS_COPY_LEN ->
    STSTransDataSaveBytePost ptr ptr
      (data_head ++ data_tail) (prefix ++ old_dst ++ suffix)
      (prefix ++ old_dst ++ suffix).
Proof.
  intros.
  unfold STSTransDataSaveBytePost, STSTransDataSavePost, STSSramAfterCopy.
  unfold STS_PACKET_WINDOW_LEN, STS_COPY_LEN, STS_DATABUF_LEN, STS_PTR_LIMIT in *.
  split.
  - split.
    + reflexivity.
    + right; split; [lia | reflexivity].
  - repeat split.
    + rewrite Zlength_app. lia.
    + repeat rewrite Zlength_app; lia.
    + repeat rewrite Zlength_app; lia.
    + lia.
    + lia.
    + right; split; [lia | reflexivity].
Qed.


Lemma STS_CharArray_full_merge3 :
  forall (base n1 n2 n3 : Z) (l1 l2 l3 : list Z),
    0 <= n1 ->
    0 <= n2 ->
    0 <= n3 ->
    CharArray.full base n1 l1 **
    (CharArray.full (base + n1) n2 l2 **
     CharArray.full (base + n1 + n2) n3 l3)
    |-- CharArray.full base (n1 + n2 + n3) (l1 ++ l2 ++ l3).
Proof.
  intros.
  replace (base + n1) with (base + n1 * sizeof(CHAR)) by (rewrite sizeof_char; lia).
  replace n2 with (n1 + n2 - n1) by lia.
  replace (base + n1 * sizeof(CHAR) + (n1 + n2 - n1))
    with (base + (n1 + n2) * sizeof(CHAR)) by (rewrite sizeof_char; lia).
  replace n3 with (n1 + n2 + n3 - (n1 + n2)) by lia.
  sep_apply (CharArray.full_merge_to_full base n1 (n1 + n2) l1 l2); try lia.
  sep_apply (CharArray.full_merge_to_full base (n1 + n2) (n1 + n2 + n3) (l1 ++ l2) l3); try lia.
  rewrite app_assoc.
  replace (n1 + (n1 + n2 - n1) + (n1 + n2 + n3 - (n1 + n2)))
    with (n1 + n2 + n3) by lia.
  cancel.
Qed.
