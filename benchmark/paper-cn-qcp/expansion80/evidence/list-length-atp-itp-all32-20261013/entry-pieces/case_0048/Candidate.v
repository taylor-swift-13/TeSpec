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
Lemma encode_node_0 : cell_resources (indexed_bytes 4096 [127;255;255;255;0;0;0;0]) |--
  store_int 4096 (2147483647) ** store_ptr (4096 + 4) 0.
Proof.
  assert (Hdata : byte_resources 4096 [127;255;255;255] |-- store_int 4096 (2147483647)).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources (4096 + 4) [0;0;0;0] |-- store_ptr (4096 + 4) 0).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append [127;255;255;255] 4096 [0;0;0;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
Lemma encode_suffix_0_1 : cell_resources (@nil (Z * Z)) |-- sll32 0 [].
Proof. cbn [cell_resources sll32]. entailer!. Qed.
Lemma encode_suffix_0_0 : cell_resources ((indexed_bytes 4096 [127;255;255;255;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 4096 [2147483647].
Proof.
  eapply derivable1_trans; [apply (cell_resources_append (indexed_bytes 4096 [127;255;255;255;0;0;0;0]) ((@nil (Z * Z))))|].
  eapply derivable1_trans; [apply derivable1_sepcon_mono; [apply encode_node_0|apply encode_suffix_0_1]|].
  apply node_and_tail_form_list. discriminate.
Qed.
Lemma encode_head_0 : cell_resources ((indexed_bytes 4096 [127;255;255;255;0;0;0;0]) ++ (@nil (Z * Z))) |-- sll32 4096 [2147483647].
Proof. apply encode_suffix_0_0. Qed.
Lemma encode_entry : cell_resources (((indexed_bytes 4096 [127;255;255;255;0;0;0;0]) ++ (@nil (Z * Z))) ++ (@nil (Z * Z))) |-- (sll32 4096 [2147483647]).
Proof.
  sep_apply (cell_resources_append ((indexed_bytes 4096 [127;255;255;255;0;0;0;0]) ++ (@nil (Z * Z))) ((@nil (Z * Z)))).
  sep_apply encode_head_0.
  cbn [cell_resources]. entailer!.
  all: try (cbn [sll32]; entailer!).
Qed.
Lemma proof_of_length_precondition_wit_1 : Goal.length_precondition_wit_1.
Proof.
  unfold Goal.length_precondition_wit_1. intro Hfalse.
  assert (Hdistinct : NoDup (map fst (((indexed_bytes 4096 [127;255;255;255;0;0;0;0]) ++ (@nil (Z * Z))) ++ (@nil (Z * Z))))).
  { apply distinct_addresses_sound. vm_compute. reflexivity. }
  pose (whole := memory_state (cell_memory (((indexed_bytes 4096 [127;255;255;255;0;0;0;0]) ++ (@nil (Z * Z))) ++ (@nil (Z * Z))))).
  pose proof (encode_entry whole (distinct_byte_cells_have_witness _ Hdistinct)) as Howned.
  apply (Hfalse whole).
  cbn [naive_C_Rules.andp naive_C_Rules.coq_prop].
  repeat first [exact Howned | reflexivity | split | (vm_compute; intuition discriminate)].
Qed.
End Proofs.
