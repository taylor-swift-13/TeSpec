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
(* Read a pointer value from a concrete byte heap without an SMT assumption. *)
Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
From SimpleC.SL Require Import Mem SeparationLogic.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.

Lemma memory_inclusion_transitive : forall m1 m2 m3,
  Mem.mem_incl m1 m2 -> Mem.mem_incl m2 m3 -> Mem.mem_incl m1 m3.
Proof.
  unfold Mem.mem_incl. intros m1 m2 m3 H12 H23 p Howned.
  pose proof (H12 p Howned) as Hmid.
  rewrite (H23 p ltac:(rewrite Hmid; exact Howned)). exact Hmid.
Qed.

Lemma state_join_includes_left : forall (left right whole : model),
  ConAssertion.state_join left right whole ->
  Mem.mem_incl left.(ConAssertion.s_mem) whole.(ConAssertion.s_mem).
Proof. intros. apply (Mem.mem_join_incl_l _ _ _ (proj1 H)). Qed.
Lemma state_join_includes_right : forall (left right whole : model),
  ConAssertion.state_join left right whole ->
  Mem.mem_incl right.(ConAssertion.s_mem) whole.(ConAssertion.s_mem).
Proof. intros. apply (Mem.mem_join_incl_r _ _ _ (proj1 H)). Qed.

Lemma byte_mod_from_zero_memory : forall p b (inner whole : model),
  Mem.mem_incl inner.(ConAssertion.s_mem) whole.(ConAssertion.s_mem) ->
  store_byte p b inner -> whole.(ConAssertion.s_mem) p = Mem.value 0 ->
  b mod 256 = 0.
Proof.
  intros p b inner whole Hincl Hbyte Hzero.
  unfold store_byte, naive_C_Rules.mstore in Hbyte.
  destruct Hbyte as [actual [Heqm [Hmem Hrest]]].
  assert (Hcell : inner.(ConAssertion.s_mem) p = Mem.value actual).
  { rewrite Hmem. apply Mem.single_mem_get_eq. }
  specialize (Hincl p ltac:(rewrite Hcell; discriminate)).
  rewrite Hcell, Hzero in Hincl. inversion Hincl; subst actual.
  apply Byte.eqm_mod_eq in Heqm. exact Heqm.
Qed.

Theorem zero_pointer_bytes_force_null : forall p pointer (inner whole : model),
  Mem.mem_incl inner.(ConAssertion.s_mem) whole.(ConAssertion.s_mem) ->
  store_ptr p pointer inner ->
  (forall offset, 0 <= offset < 4 ->
      whole.(ConAssertion.s_mem) (p + offset) = Mem.value 0) -> pointer = 0.
Proof.
  intros p pointer inner whole Hincl Hptr Hzero.
  unfold store_ptr in Hptr. destruct Hptr as [[Hvalid [Hlow Hhigh]] Hword].
  unfold store_4byte in Hword.
  destruct Hword as [b1 [b2 [b3 [b4 [Hmerge Hbytes]]]]].
  destruct Hbytes as [s1 [s234 [J1 [B1 B234]]]].
  destruct B234 as [s2 [s34 [J2 [B2 B34]]]].
  destruct B34 as [s3 [s4 [J3 [B3 B4]]]].
  assert (I234 : Mem.mem_incl s234.(ConAssertion.s_mem) whole.(ConAssertion.s_mem)).
  { eapply memory_inclusion_transitive; [eapply state_join_includes_right; exact J1 | exact Hincl]. }
  assert (I34 : Mem.mem_incl s34.(ConAssertion.s_mem) whole.(ConAssertion.s_mem)).
  { eapply memory_inclusion_transitive; [eapply state_join_includes_right; exact J2 | exact I234]. }
  assert (M1 : b1 mod 256 = 0).
  { eapply byte_mod_from_zero_memory; [|exact B1|].
    - eapply memory_inclusion_transitive; [eapply state_join_includes_left; exact J1|exact Hincl].
    - replace p with (p + 0) by lia. apply Hzero. lia. }
  assert (M2 : b2 mod 256 = 0).
  { eapply byte_mod_from_zero_memory; [|exact B2|].
    - eapply memory_inclusion_transitive; [eapply state_join_includes_left; exact J2|exact I234].
    - apply Hzero. lia. }
  assert (M3 : b3 mod 256 = 0).
  { eapply byte_mod_from_zero_memory; [|exact B3|].
    - eapply memory_inclusion_transitive; [eapply state_join_includes_left; exact J3|exact I34].
    - apply Hzero. lia. }
  assert (M4 : b4 mod 256 = 0).
  { eapply byte_mod_from_zero_memory; [|exact B4|].
    - eapply memory_inclusion_transitive; [eapply state_join_includes_right; exact J3|exact I34].
    - apply Hzero. lia. }
  unfold merge_int in Hmerge.
  change (pointer mod 4294967296 =
    b1 mod 256 * 16777216 + b2 mod 256 * 65536 + b3 mod 256 * 256 + b4 mod 256) in Hmerge.
  rewrite M1, M2, M3, M4 in Hmerge.
  change (pointer <= 4294967295) in Hhigh.
  rewrite Z.mod_small in Hmerge by lia. lia.
Qed.
Print Assumptions zero_pointer_bytes_force_null.
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
Lemma node_bytes_encode_source :
 byte_resources 4096 [128;0;0;0;0;0;0;0] |-- store_ptr 4100 0 ** store_int 4096 INT_MIN.
Proof.
 eapply derivable1_trans; [apply node_bytes_encode_entry|].
 cbn [sll32]. Intros next. subst next. entailer!.
Qed.
Lemma proof_of_reverse_return_wit_1 : ~ Goal.reverse_return_wit_1.
Proof.
 unfold Goal.reverse_return_wit_1. intros [Hspatial|Hpure].
 - pose (whole := memory_state (byte_memory 4096 [128;0;0;0;0;0;0;0])).
   pose proof (Hspatial 0 eq_refl whole (node_bytes_encode_source whole
     (concrete_byte_resources_have_witness [128;0;0;0;0;0;0;0] 4096))) as Htarget.
   cbn [sll32] in Htarget.
   destruct Htarget as [Hnonzero [next [pair [tail [Jwhole [[data [pointer [Jpair [Hdata Hpointer]]]] Htail]]]]]].
   assert (Hnext : next = 0).
   { eapply zero_pointer_bytes_force_null with (inner:=pointer) (whole:=whole).
     - eapply memory_inclusion_transitive; [eapply state_join_includes_right; exact Jpair|].
       eapply state_join_includes_left; exact Jwhole.
     - exact Hpointer.
     - intros offset Hrange. unfold whole, memory_state. simpl.
       assert (offset = 0 \/ offset = 1 \/ offset = 2 \/ offset = 3) by lia.
       destruct H as [Hz | [Hz | [Hz | Hz]]]; subst offset; vm_compute; reflexivity. }
   subst next. destruct Htail as [Hcontra _]. apply Hcontra. reflexivity.
 - pose proof (Hpure 0 eq_refl ConAssertion.empty_state
     (conj I ConAssertion.empty_state_is_empty)) as Hbad.
   destruct Hbad as [[Hbad _] _]. discriminate.
Qed.
End Proofs.
