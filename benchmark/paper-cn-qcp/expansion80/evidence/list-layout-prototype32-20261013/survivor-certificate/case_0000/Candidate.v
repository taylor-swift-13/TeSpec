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

Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Require Import Goal.
Module Proofs.
Lemma node_bytes_encode_entry :
  byte_resources 4096 [128;0;0;0;0;0;0;0] |-- sll32 4096 [INT_MIN].
Proof.
  assert (Hdata : byte_resources 4096 [128;0;0;0] |-- store_int 4096 INT_MIN).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources 4100 [0;0;0;0] |-- store_ptr 4100 0).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans.
  - apply (byte_resources_append [128;0;0;0] 4096 [0;0;0;0]).
  - eapply derivable1_trans.
    + apply derivable1_sepcon_mono; [exact Hdata | exact Hnext].
    + cbn [sll32]. Exists 0. entailer!.
Qed.
Lemma proof_of_reverse_safety_wit_1 : Goal.reverse_safety_wit_1.
Proof. unfold Goal.reverse_safety_wit_1. intros y Hy. entailer!. Qed.
Lemma proof_of_reverse_safety_wit_2 : Goal.reverse_safety_wit_2.
Proof. unfold Goal.reverse_safety_wit_2. entailer!. Qed.
Lemma proof_of_reverse_return_wit_1 : Goal.reverse_return_wit_1.
Proof.
  unfold Goal.reverse_return_wit_1. intros y Hy. subst y.
  cbn [sll32]. Exists 0. entailer!.
Qed.
Lemma proof_of_reverse_partial_solve_wit_1 : Goal.reverse_partial_solve_wit_1.
Proof.
  unfold Goal.reverse_partial_solve_wit_1. cbn [sll32].
  Intros next. subst next. Exists 0. entailer!.
Qed.
Lemma proof_of_reverse_precondition_wit_1 : Goal.reverse_precondition_wit_1.
Proof.
  unfold Goal.reverse_precondition_wit_1. intro Hfalse.
  pose proof (node_bytes_encode_entry
    (memory_state (byte_memory 4096 [128;0;0;0;0;0;0;0]))
    (concrete_byte_resources_have_witness [128;0;0;0;0;0;0;0] 4096)) as Hnode.
  apply (Hfalse (memory_state (byte_memory 4096 [128;0;0;0;0;0;0;0]))).
  cbn [naive_C_Rules.andp naive_C_Rules.coq_prop].
  repeat first [exact Hnode | reflexivity | split].
Qed.
End Proofs.
