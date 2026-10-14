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
