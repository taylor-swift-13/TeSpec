(* Generic concrete witnesses for initialized byte resources, independent of
   any program or benchmark input. *)
Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.micromega.Lia.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope Z_scope.
Local Open Scope sac.

Definition memory_state (m : Mem.mem) : @ConAssertion.Lstate ConAssertion.naive_S :=
  {| ConAssertion.s_mem := m; ConAssertion.s_STS := Sets.full;
     ConAssertion.s_token := Sets.empty |}.
Fixpoint byte_memory (p : Z) (bytes : list Z) : Mem.mem :=
  match bytes with
  | [] => Mem.empty_mem
  | element :: tail => Mem.mem_byte_update (byte_memory (p + 1) tail) p element
  end.
Fixpoint byte_resources (p : Z) (bytes : list Z) :=
  match bytes with
  | [] => emp
  | element :: tail => store_byte p element ** byte_resources (p + 1) tail
  end.

Lemma byte_memory_omits_lower_addresses : forall bytes p q,
  q < p -> byte_memory p bytes q = Mem.Noperm.
Proof.
  induction bytes as [|element tail IH]; intros p q H.
  - reflexivity.
  - cbn [byte_memory]. unfold Mem.mem_byte_update.
    destruct (Mem.addr_eqb q p) eqn:Heq.
    + apply Mem.addr_eqb_eq in Heq. lia.
    + apply IH. lia.
Qed.

Lemma memory_state_join_byte : forall p element m,
  m p = Mem.Noperm ->
  ConAssertion.state_join
    (memory_state (Mem.single_byte_mem p element)) (memory_state m)
    (memory_state (Mem.mem_byte_update m p element)).
Proof.
  intros p element m H. unfold ConAssertion.state_join.
  split.
  - cbn [memory_state]. apply Mem.mem_join_comm.
    apply Mem.mem_join_single_mem_update_l. exact H.
  - unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join.
    cbn [memory_state]. sets_unfold. firstorder.
Qed.

Lemma single_byte_state_holds : forall p element,
  store_byte p element (memory_state (Mem.single_byte_mem p element)).
Proof.
  intros. unfold store_byte, naive_C_Rules.mstore.
  exists element. split; [apply Byte.eqm_refl |].
  cbn [memory_state]. repeat split; auto.
Qed.

Theorem concrete_byte_resources_have_witness : forall bytes p,
  byte_resources p bytes (memory_state (byte_memory p bytes)).
Proof.
  induction bytes as [|element tail IH]; intro p.
  - apply ConAssertion.empty_state_is_empty.
  - cbn [byte_resources byte_memory].
    exists (memory_state (Mem.single_byte_mem p element)),
           (memory_state (byte_memory (p + 1) tail)).
    split.
    + apply memory_state_join_byte. apply byte_memory_omits_lower_addresses. lia.
    + split; [apply single_byte_state_holds | apply IH].
Qed.

Theorem byte_resources_append : forall prefix p suffix,
  byte_resources p (prefix ++ suffix) |--
  byte_resources p prefix ** byte_resources (p + Z.of_nat (length prefix)) suffix.
Proof.
  induction prefix as [|element tail IH]; intros p suffix.
  - cbn [byte_resources length app]. replace (p + Z.of_nat 0) with p by lia. entailer!.
  - cbn [byte_resources length app].
    replace (p + Z.of_nat (S (length tail))) with
      ((p + 1) + Z.of_nat (length tail)) by lia.
    sep_apply (IH (p + 1) suffix). entailer!.
Qed.

Theorem four_byte_resources_encode_word : forall p b1 b2 b3 b4 word,
  merge_int b1 b2 b3 b4 word ->
  byte_resources p [b1;b2;b3;b4] |-- store_4byte p word.
Proof.
  intros. cbn [byte_resources]. unfold store_4byte.
  replace (p + 1 + 1) with (p + 2) by lia.
  replace (p + 2 + 1) with (p + 3) by lia.
  Exists b1 b2 b3 b4. entailer!.
Qed.

Print Assumptions concrete_byte_resources_have_witness.
Print Assumptions byte_resources_append.
Print Assumptions four_byte_resources_encode_word.
(* Concrete witnesses for finite byte heaps at arbitrary distinct addresses. *)
Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.micromega.Lia.
From SimpleC.SL Require Import Mem SeparationLogic.
Import naive_C_Rules ListNotations.
Local Open Scope Z_scope.
Local Open Scope sac.

Fixpoint cell_memory (cells : list (Z * Z)) : Mem.mem :=
  match cells with
  | [] => Mem.empty_mem
  | (address, byte_value) :: tail =>
      Mem.mem_byte_update (cell_memory tail) address byte_value
  end.
Fixpoint cell_resources (cells : list (Z * Z)) :=
  match cells with
  | [] => emp
  | (address, byte_value) :: tail => store_byte address byte_value ** cell_resources tail
  end.
Fixpoint indexed_bytes (address : Z) (bytes : list Z) : list (Z * Z) :=
  match bytes with
  | [] => []
  | byte_value :: tail => (address, byte_value) :: indexed_bytes (address + 1) tail
  end.

Lemma cell_memory_absent : forall cells address,
  ~ In address (map fst cells) -> cell_memory cells address = Mem.Noperm.
Proof.
  induction cells as [|[p byte_value] tail IH]; intros address Habsent.
  - reflexivity.
  - cbn [cell_memory]. unfold Mem.mem_byte_update.
    destruct (Mem.addr_eqb address p) eqn:Heq.
    + apply Mem.addr_eqb_eq in Heq. subst address. exfalso.
      apply Habsent. cbn. left. reflexivity.
    + apply IH. intro Hin. apply Habsent. cbn. right. exact Hin.
Qed.

Theorem distinct_byte_cells_have_witness : forall cells,
  NoDup (map fst cells) -> cell_resources cells (memory_state (cell_memory cells)).
Proof.
  induction cells as [|[address byte_value] tail IH]; intro Hdistinct.
  - apply ConAssertion.empty_state_is_empty.
  - inversion Hdistinct as [|head rest Habsent Htail]; subst.
    cbn [cell_resources cell_memory].
    exists (memory_state (Mem.single_byte_mem address byte_value)),
           (memory_state (cell_memory tail)).
    split.
    + apply memory_state_join_byte. apply cell_memory_absent. exact Habsent.
    + split; [apply single_byte_state_holds | apply IH; exact Htail].
Qed.

Theorem cell_resources_append : forall prefix suffix,
  cell_resources (prefix ++ suffix) |-- cell_resources prefix ** cell_resources suffix.
Proof.
  induction prefix as [|[address byte_value] tail IH]; intro suffix.
  - cbn [cell_resources app]. entailer!.
  - cbn [cell_resources app]. sep_apply (IH suffix). entailer!.
Qed.

Theorem indexed_bytes_are_byte_resources : forall bytes address,
  cell_resources (indexed_bytes address bytes) --||-- byte_resources address bytes.
Proof.
  induction bytes as [|byte_value tail IH]; intro address; cbn [cell_resources indexed_bytes byte_resources].
  - split; apply derivable1_refl.
  - destruct (IH (address + 1)) as [Hforward Hbackward]. split.
    + apply derivable1_sepcon_mono; [apply derivable1_refl | exact Hforward].
    + apply derivable1_sepcon_mono; [apply derivable1_refl | exact Hbackward].
Qed.

Lemma indexed_bytes_address_lower_bound : forall bytes address q,
  In q (map fst (indexed_bytes address bytes)) -> address <= q.
Proof.
  induction bytes as [|byte_value tail IH]; intros address q Hin.
  - contradiction.
  - cbn in Hin. destruct Hin as [Heq | Hin].
    + subst q. lia.
    + pose proof (IH (address + 1) q Hin). lia.
Qed.

Theorem indexed_bytes_have_distinct_addresses : forall bytes address,
  NoDup (map fst (indexed_bytes address bytes)).
Proof.
  induction bytes as [|byte_value tail IH]; intro address.
  - constructor.
  - cbn. constructor.
    + intro Hin. pose proof (indexed_bytes_address_lower_bound tail (address + 1) address Hin). lia.
    + apply IH.
Qed.

Print Assumptions distinct_byte_cells_have_witness.
Print Assumptions cell_resources_append.
Print Assumptions indexed_bytes_are_byte_resources.
Print Assumptions indexed_bytes_have_distinct_addresses.
Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.Bool.Bool.
Import ListNotations.

Fixpoint distinct_addresses (addresses : list Z) : bool :=
  match addresses with
  | [] => true
  | address :: tail =>
      negb (existsb (Z.eqb address) tail) && distinct_addresses tail
  end.

Theorem distinct_addresses_sound : forall addresses,
  distinct_addresses addresses = true -> NoDup addresses.
Proof.
  induction addresses as [|address tail IH]; intro Hcheck.
  - constructor.
  - cbn in Hcheck. apply andb_true_iff in Hcheck.
    destruct Hcheck as [Habsent Htail]. apply negb_true_iff in Habsent.
    constructor.
    + intro Hin.
      assert (Hpresent : existsb (Z.eqb address) tail = true).
      { apply existsb_exists. exists address. split; [exact Hin|apply Z.eqb_refl]. }
      rewrite Hpresent in Habsent. discriminate.
    + apply IH. exact Htail.
Qed.

Print Assumptions distinct_addresses_sound.
Require Import Coq.ZArith.ZArith Coq.Lists.List.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Import naive_C_Rules ListNotations.
Local Open Scope Z_scope.
Local Open Scope sac.

Theorem node_and_tail_form_list : forall p element next tail,
  p <> 0 ->
  (store_int p element ** store_ptr (p + 4) next) ** sll32 next tail
  |-- sll32 p (element :: tail).
Proof. intros. cbn [sll32]. Exists next. entailer!. Qed.

Require Import Goal SimpleC.EE.QCP_demos_human.sll_layout32.
Module Proofs.
Lemma encode_node_0 : cell_resources (indexed_bytes 4096 [127;255;255;255;0;0;32;0]) |--
  store_int 4096 (2147483647) ** store_ptr (4096 + 4) 8192.
Proof.
  assert (Hdata : byte_resources 4096 [127;255;255;255] |-- store_int 4096 (2147483647)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (4096 + 4) [0;0;32;0] |-- store_ptr (4096 + 4) 8192).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;255] 4096 [0;0;32;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_1 : cell_resources (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) |--
  store_int 8192 (2147483646) ** store_ptr (8192 + 4) 12288.
Proof.
  assert (Hdata : byte_resources 8192 [127;255;255;254] |-- store_int 8192 (2147483646)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (8192 + 4) [0;0;48;0] |-- store_ptr (8192 + 4) 12288).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;254] 8192 [0;0;48;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_2 : cell_resources (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) |--
  store_int 12288 (2147483646) ** store_ptr (12288 + 4) 16384.
Proof.
  assert (Hdata : byte_resources 12288 [127;255;255;254] |-- store_int 12288 (2147483646)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (12288 + 4) [0;0;64;0] |-- store_ptr (12288 + 4) 16384).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;254] 12288 [0;0;64;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_3 : cell_resources (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) |--
  store_int 16384 (2147483646) ** store_ptr (16384 + 4) 20480.
Proof.
  assert (Hdata : byte_resources 16384 [127;255;255;254] |-- store_int 16384 (2147483646)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (16384 + 4) [0;0;80;0] |-- store_ptr (16384 + 4) 20480).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;254] 16384 [0;0;80;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_4 : cell_resources (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) |--
  store_int 20480 (2147483646) ** store_ptr (20480 + 4) 24576.
Proof.
  assert (Hdata : byte_resources 20480 [127;255;255;254] |-- store_int 20480 (2147483646)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (20480 + 4) [0;0;96;0] |-- store_ptr (20480 + 4) 24576).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;254] 20480 [0;0;96;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_5 : cell_resources (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) |--
  store_int 24576 (2147483646) ** store_ptr (24576 + 4) 28672.
Proof.
  assert (Hdata : byte_resources 24576 [127;255;255;254] |-- store_int 24576 (2147483646)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (24576 + 4) [0;0;112;0] |-- store_ptr (24576 + 4) 28672).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;254] 24576 [0;0;112;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_6 : cell_resources (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) |--
  store_int 28672 (2147483646) ** store_ptr (28672 + 4) 32768.
Proof.
  assert (Hdata : byte_resources 28672 [127;255;255;254] |-- store_int 28672 (2147483646)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (28672 + 4) [0;0;128;0] |-- store_ptr (28672 + 4) 32768).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;254] 28672 [0;0;128;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_7 : cell_resources (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) |--
  store_int 32768 (100) ** store_ptr (32768 + 4) 36864.
Proof.
  assert (Hdata : byte_resources 32768 [0;0;0;100] |-- store_int 32768 (100)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (32768 + 4) [0;0;144;0] |-- store_ptr (32768 + 4) 36864).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;100] 32768 [0;0;144;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_8 : cell_resources (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) |--
  store_int 36864 (100) ** store_ptr (36864 + 4) 40960.
Proof.
  assert (Hdata : byte_resources 36864 [0;0;0;100] |-- store_int 36864 (100)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (36864 + 4) [0;0;160;0] |-- store_ptr (36864 + 4) 40960).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;100] 36864 [0;0;160;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_9 : cell_resources (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) |--
  store_int 40960 (100) ** store_ptr (40960 + 4) 45056.
Proof.
  assert (Hdata : byte_resources 40960 [0;0;0;100] |-- store_int 40960 (100)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (40960 + 4) [0;0;176;0] |-- store_ptr (40960 + 4) 45056).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;100] 40960 [0;0;176;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_10 : cell_resources (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) |--
  store_int 45056 (100) ** store_ptr (45056 + 4) 49152.
Proof.
  assert (Hdata : byte_resources 45056 [0;0;0;100] |-- store_int 45056 (100)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (45056 + 4) [0;0;192;0] |-- store_ptr (45056 + 4) 49152).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;100] 45056 [0;0;192;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_11 : cell_resources (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) |--
  store_int 49152 (1) ** store_ptr (49152 + 4) 53248.
Proof.
  assert (Hdata : byte_resources 49152 [0;0;0;1] |-- store_int 49152 (1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (49152 + 4) [0;0;208;0] |-- store_ptr (49152 + 4) 53248).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;1] 49152 [0;0;208;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_12 : cell_resources (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) |--
  store_int 53248 (1) ** store_ptr (53248 + 4) 57344.
Proof.
  assert (Hdata : byte_resources 53248 [0;0;0;1] |-- store_int 53248 (1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (53248 + 4) [0;0;224;0] |-- store_ptr (53248 + 4) 57344).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;1] 53248 [0;0;224;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_13 : cell_resources (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) |--
  store_int 57344 (1) ** store_ptr (57344 + 4) 61440.
Proof.
  assert (Hdata : byte_resources 57344 [0;0;0;1] |-- store_int 57344 (1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (57344 + 4) [0;0;240;0] |-- store_ptr (57344 + 4) 61440).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;1] 57344 [0;0;240;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_14 : cell_resources (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) |--
  store_int 61440 (1) ** store_ptr (61440 + 4) 65536.
Proof.
  assert (Hdata : byte_resources 61440 [0;0;0;1] |-- store_int 61440 (1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (61440 + 4) [0;1;0;0] |-- store_ptr (61440 + 4) 65536).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;1] 61440 [0;1;0;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_15 : cell_resources (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) |--
  store_int 65536 (0) ** store_ptr (65536 + 4) 69632.
Proof.
  assert (Hdata : byte_resources 65536 [0;0;0;0] |-- store_int 65536 (0)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (65536 + 4) [0;1;16;0] |-- store_ptr (65536 + 4) 69632).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;0] 65536 [0;1;16;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_16 : cell_resources (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) |--
  store_int 69632 (0) ** store_ptr (69632 + 4) 73728.
Proof.
  assert (Hdata : byte_resources 69632 [0;0;0;0] |-- store_int 69632 (0)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (69632 + 4) [0;1;32;0] |-- store_ptr (69632 + 4) 73728).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;0] 69632 [0;1;32;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_17 : cell_resources (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) |--
  store_int 73728 (0) ** store_ptr (73728 + 4) 77824.
Proof.
  assert (Hdata : byte_resources 73728 [0;0;0;0] |-- store_int 73728 (0)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (73728 + 4) [0;1;48;0] |-- store_ptr (73728 + 4) 77824).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;0] 73728 [0;1;48;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_18 : cell_resources (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) |--
  store_int 77824 (0) ** store_ptr (77824 + 4) 81920.
Proof.
  assert (Hdata : byte_resources 77824 [0;0;0;0] |-- store_int 77824 (0)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (77824 + 4) [0;1;64;0] |-- store_ptr (77824 + 4) 81920).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;0] 77824 [0;1;64;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_19 : cell_resources (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) |--
  store_int 81920 (-1) ** store_ptr (81920 + 4) 86016.
Proof.
  assert (Hdata : byte_resources 81920 [255;255;255;255] |-- store_int 81920 (-1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (81920 + 4) [0;1;80;0] |-- store_ptr (81920 + 4) 86016).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [255;255;255;255] 81920 [0;1;80;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_20 : cell_resources (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) |--
  store_int 86016 (-1) ** store_ptr (86016 + 4) 90112.
Proof.
  assert (Hdata : byte_resources 86016 [255;255;255;255] |-- store_int 86016 (-1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (86016 + 4) [0;1;96;0] |-- store_ptr (86016 + 4) 90112).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [255;255;255;255] 86016 [0;1;96;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_21 : cell_resources (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) |--
  store_int 90112 (-1) ** store_ptr (90112 + 4) 94208.
Proof.
  assert (Hdata : byte_resources 90112 [255;255;255;255] |-- store_int 90112 (-1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (90112 + 4) [0;1;112;0] |-- store_ptr (90112 + 4) 94208).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [255;255;255;255] 90112 [0;1;112;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_22 : cell_resources (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) |--
  store_int 94208 (-1) ** store_ptr (94208 + 4) 98304.
Proof.
  assert (Hdata : byte_resources 94208 [255;255;255;255] |-- store_int 94208 (-1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (94208 + 4) [0;1;128;0] |-- store_ptr (94208 + 4) 98304).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [255;255;255;255] 94208 [0;1;128;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_23 : cell_resources (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) |--
  store_int 98304 (-1) ** store_ptr (98304 + 4) 102400.
Proof.
  assert (Hdata : byte_resources 98304 [255;255;255;255] |-- store_int 98304 (-1)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (98304 + 4) [0;1;144;0] |-- store_ptr (98304 + 4) 102400).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [255;255;255;255] 98304 [0;1;144;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_24 : cell_resources (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) |--
  store_int 102400 (-100) ** store_ptr (102400 + 4) 106496.
Proof.
  assert (Hdata : byte_resources 102400 [255;255;255;156] |-- store_int 102400 (-100)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (102400 + 4) [0;1;160;0] |-- store_ptr (102400 + 4) 106496).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [255;255;255;156] 102400 [0;1;160;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_25 : cell_resources (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) |--
  store_int 106496 (-2147483647) ** store_ptr (106496 + 4) 110592.
Proof.
  assert (Hdata : byte_resources 106496 [128;0;0;1] |-- store_int 106496 (-2147483647)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (106496 + 4) [0;1;176;0] |-- store_ptr (106496 + 4) 110592).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [128;0;0;1] 106496 [0;1;176;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_26 : cell_resources (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) |--
  store_int 110592 (-2147483647) ** store_ptr (110592 + 4) 114688.
Proof.
  assert (Hdata : byte_resources 110592 [128;0;0;1] |-- store_int 110592 (-2147483647)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (110592 + 4) [0;1;192;0] |-- store_ptr (110592 + 4) 114688).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [128;0;0;1] 110592 [0;1;192;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_27 : cell_resources (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) |--
  store_int 114688 (-2147483647) ** store_ptr (114688 + 4) 118784.
Proof.
  assert (Hdata : byte_resources 114688 [128;0;0;1] |-- store_int 114688 (-2147483647)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (114688 + 4) [0;1;208;0] |-- store_ptr (114688 + 4) 118784).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [128;0;0;1] 114688 [0;1;208;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_28 : cell_resources (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) |--
  store_int 118784 (-2147483647) ** store_ptr (118784 + 4) 122880.
Proof.
  assert (Hdata : byte_resources 118784 [128;0;0;1] |-- store_int 118784 (-2147483647)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (118784 + 4) [0;1;224;0] |-- store_ptr (118784 + 4) 122880).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [128;0;0;1] 118784 [0;1;224;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_29 : cell_resources (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) |--
  store_int 122880 (-2147483647) ** store_ptr (122880 + 4) 126976.
Proof.
  assert (Hdata : byte_resources 122880 [128;0;0;1] |-- store_int 122880 (-2147483647)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (122880 + 4) [0;1;240;0] |-- store_ptr (122880 + 4) 126976).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [128;0;0;1] 122880 [0;1;240;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_30 : cell_resources (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) |--
  store_int 126976 (-2147483648) ** store_ptr (126976 + 4) 131072.
Proof.
  assert (Hdata : byte_resources 126976 [128;0;0;0] |-- store_int 126976 (-2147483648)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (126976 + 4) [0;2;0;0] |-- store_ptr (126976 + 4) 131072).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [128;0;0;0] 126976 [0;2;0;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_node_31 : cell_resources (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) |--
  store_int 131072 (-2147483648) ** store_ptr (131072 + 4) 0.
Proof.
  assert (Hdata : byte_resources 131072 [128;0;0;0] |-- store_int 131072 (-2147483648)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (131072 + 4) [0;0;0;0] |-- store_ptr (131072 + 4) 0).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [128;0;0;0] 131072 [0;0;0;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_suffix_0_32 : cell_resources (@nil (Z * Z)) |-- sll32 0 [].
Proof. cbn [cell_resources sll32]. entailer!. Qed.
Lemma encode_suffix_0_31 : cell_resources ((indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 131072 [(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ((@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_31|apply encode_suffix_0_32]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_30 : cell_resources ((indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 126976 [(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ((indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_30|apply encode_suffix_0_31]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_29 : cell_resources ((indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 122880 [(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ((indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_29|apply encode_suffix_0_30]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_28 : cell_resources ((indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 118784 [(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ((indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_28|apply encode_suffix_0_29]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_27 : cell_resources ((indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 114688 [(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ((indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_27|apply encode_suffix_0_28]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_26 : cell_resources ((indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 110592 [(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ((indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_26|apply encode_suffix_0_27]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_25 : cell_resources ((indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 106496 [(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ((indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_25|apply encode_suffix_0_26]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_24 : cell_resources ((indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 102400 [(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ((indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_24|apply encode_suffix_0_25]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_23 : cell_resources ((indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 98304 [(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ((indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_23|apply encode_suffix_0_24]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_22 : cell_resources ((indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 94208 [(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ((indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_22|apply encode_suffix_0_23]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_21 : cell_resources ((indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 90112 [(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ((indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_21|apply encode_suffix_0_22]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_20 : cell_resources ((indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 86016 [(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ((indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_20|apply encode_suffix_0_21]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_19 : cell_resources ((indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 81920 [(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ((indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_19|apply encode_suffix_0_20]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_18 : cell_resources ((indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 77824 [0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ((indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_18|apply encode_suffix_0_19]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_17 : cell_resources ((indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 73728 [0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ((indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_17|apply encode_suffix_0_18]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_16 : cell_resources ((indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 69632 [0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ((indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_16|apply encode_suffix_0_17]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_15 : cell_resources ((indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 65536 [0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ((indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_15|apply encode_suffix_0_16]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_14 : cell_resources ((indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 61440 [1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ((indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_14|apply encode_suffix_0_15]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_13 : cell_resources ((indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 57344 [1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ((indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_13|apply encode_suffix_0_14]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_12 : cell_resources ((indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 53248 [1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ((indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_12|apply encode_suffix_0_13]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_11 : cell_resources ((indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 49152 [1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ((indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_11|apply encode_suffix_0_12]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_10 : cell_resources ((indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 45056 [100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ((indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_10|apply encode_suffix_0_11]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_9 : cell_resources ((indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 40960 [100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ((indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_9|apply encode_suffix_0_10]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_8 : cell_resources ((indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 36864 [100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ((indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_8|apply encode_suffix_0_9]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_7 : cell_resources ((indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 32768 [100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ((indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_7|apply encode_suffix_0_8]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_6 : cell_resources ((indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 28672 [2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ((indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_6|apply encode_suffix_0_7]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_5 : cell_resources ((indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 24576 [2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ((indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_5|apply encode_suffix_0_6]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_4 : cell_resources ((indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 20480 [2147483646;2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ((indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_4|apply encode_suffix_0_5]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_3 : cell_resources ((indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 16384 [2147483646;2147483646;2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ((indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_3|apply encode_suffix_0_4]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_2 : cell_resources ((indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 12288 [2147483646;2147483646;2147483646;2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ((indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_2|apply encode_suffix_0_3]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_1 : cell_resources ((indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 8192 [2147483646;2147483646;2147483646;2147483646;2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ((indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_1|apply encode_suffix_0_2]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_suffix_0_0 : cell_resources ((indexed_bytes 4096 [127;255;255;255;0;0;32;0]) ++ (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 4096 [2147483647;2147483646;2147483646;2147483646;2147483646;2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 4096 [127;255;255;255;0;0;32;0]) ((indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_0|apply encode_suffix_0_1]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_head_0 : cell_resources ((indexed_bytes 4096 [127;255;255;255;0;0;32;0]) ++ (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 4096 [2147483647;2147483646;2147483646;2147483646;2147483646;2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)].
Proof. apply encode_suffix_0_0. Qed.
Lemma encode_entry : cell_resources (((indexed_bytes 4096 [127;255;255;255;0;0;32;0]) ++ (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) ++ (@nil (Z * Z))) |-- (sll32 4096 [2147483647;2147483646;2147483646;2147483646;2147483646;2147483646;2147483646;100;100;100;100;1;1;1;1;0;0;0;0;(-1);(-1);(-1);(-1);(-1);(-100);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483647);(-2147483648);(-2147483648)]).
Proof.
  sep_apply (cell_resources_append ((indexed_bytes 4096 [127;255;255;255;0;0;32;0]) ++ (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) ((@nil (Z * Z)))).
  sep_apply encode_head_0.
  cbn [cell_resources]. entailer!.
  all: try (cbn [sll32]; entailer!).
Qed.
Lemma proof_of_length_precondition_wit_1 : Goal.length_precondition_wit_1.
Proof.
  unfold Goal.length_precondition_wit_1. intro Hfalse.
  assert (Hdistinct : NoDup (map fst (((indexed_bytes 4096 [127;255;255;255;0;0;32;0]) ++ (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) ++ (@nil (Z * Z))))).
  { apply distinct_addresses_sound. vm_compute. reflexivity. }
  pose (whole := memory_state (cell_memory (((indexed_bytes 4096 [127;255;255;255;0;0;32;0]) ++ (indexed_bytes 8192 [127;255;255;254;0;0;48;0]) ++ (indexed_bytes 12288 [127;255;255;254;0;0;64;0]) ++ (indexed_bytes 16384 [127;255;255;254;0;0;80;0]) ++ (indexed_bytes 20480 [127;255;255;254;0;0;96;0]) ++ (indexed_bytes 24576 [127;255;255;254;0;0;112;0]) ++ (indexed_bytes 28672 [127;255;255;254;0;0;128;0]) ++ (indexed_bytes 32768 [0;0;0;100;0;0;144;0]) ++ (indexed_bytes 36864 [0;0;0;100;0;0;160;0]) ++ (indexed_bytes 40960 [0;0;0;100;0;0;176;0]) ++ (indexed_bytes 45056 [0;0;0;100;0;0;192;0]) ++ (indexed_bytes 49152 [0;0;0;1;0;0;208;0]) ++ (indexed_bytes 53248 [0;0;0;1;0;0;224;0]) ++ (indexed_bytes 57344 [0;0;0;1;0;0;240;0]) ++ (indexed_bytes 61440 [0;0;0;1;0;1;0;0]) ++ (indexed_bytes 65536 [0;0;0;0;0;1;16;0]) ++ (indexed_bytes 69632 [0;0;0;0;0;1;32;0]) ++ (indexed_bytes 73728 [0;0;0;0;0;1;48;0]) ++ (indexed_bytes 77824 [0;0;0;0;0;1;64;0]) ++ (indexed_bytes 81920 [255;255;255;255;0;1;80;0]) ++ (indexed_bytes 86016 [255;255;255;255;0;1;96;0]) ++ (indexed_bytes 90112 [255;255;255;255;0;1;112;0]) ++ (indexed_bytes 94208 [255;255;255;255;0;1;128;0]) ++ (indexed_bytes 98304 [255;255;255;255;0;1;144;0]) ++ (indexed_bytes 102400 [255;255;255;156;0;1;160;0]) ++ (indexed_bytes 106496 [128;0;0;1;0;1;176;0]) ++ (indexed_bytes 110592 [128;0;0;1;0;1;192;0]) ++ (indexed_bytes 114688 [128;0;0;1;0;1;208;0]) ++ (indexed_bytes 118784 [128;0;0;1;0;1;224;0]) ++ (indexed_bytes 122880 [128;0;0;1;0;1;240;0]) ++ (indexed_bytes 126976 [128;0;0;0;0;2;0;0]) ++ (indexed_bytes 131072 [128;0;0;0;0;0;0;0]) ++ (@nil (Z * Z))) ++ (@nil (Z * Z))))).
  pose proof (encode_entry whole (distinct_byte_cells_have_witness _ Hdistinct)) as Howned.
  apply (Hfalse whole).
  cbn [naive_C_Rules.andp naive_C_Rules.coq_prop].
  repeat first [exact Howned | reflexivity | split | (vm_compute; intuition discriminate)].
Qed.
End Proofs.
