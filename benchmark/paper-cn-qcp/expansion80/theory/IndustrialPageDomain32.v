(* Derive the explicit resource-conversion side conditions on admitted pages. *)
Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
From SimpleC.SL Require Import CommonAssertion.
From compcert.lib Require Import Integers.
Require Import IndustrialIntegerCasts IndustrialPowerShift.
Local Open Scope Z_scope.
Definition allocator_page_length (order : Z) := 2 ^ (12 + order).

Theorem admitted_page_length_bounds : forall order,
  0 <= order < 11 -> 4096 <= allocator_page_length order <= 4194304.
Proof.
  intros order H. unfold allocator_page_length. split.
  - change (2 ^ 12 <= 2 ^ (12 + order)). apply Z.pow_le_mono_r; lia.
  - change (2 ^ (12 + order) <= 2 ^ 22). apply Z.pow_le_mono_r; lia.
Qed.

Theorem admitted_page_shift_matches_length : forall order,
  0 <= order < 11 ->
  u64 (Z.shiftl 1 (order + 12)) = allocator_page_length order.
Proof.
  intros order H. rewrite power_two_shift_u64 by lia.
  unfold allocator_page_length. f_equal. lia.
Qed.

Theorem admitted_page_has_header_and_remainder : forall order,
  0 <= order < 11 ->
  0 <= allocator_page_length order - 8 /\
  allocator_page_length order = 8 + (allocator_page_length order - 8).
Proof. intros. pose proof (admitted_page_length_bounds order H). lia. Qed.

Theorem page_alignment_implies_pointer_alignment : forall p,
  p mod 4096 = 0 -> aligned_4 p.
Proof.
  intros p H. unfold aligned_4.
  apply Z.mod_divide; [lia |].
  apply Z.mod_divide in H; [|lia].
  eapply Z.divide_trans; [exists 1024; reflexivity | exact H].
Qed.

Theorem admitted_page_header_addresses_valid : forall p,
  0 <= p -> p + 4095 <= Int.max_unsigned -> p mod 4096 = 0 ->
  isvalidptr p /\ isvalidptr (p + 4).
Proof.
  intros p Hlow Hhigh Halign.
  pose proof (page_alignment_implies_pointer_alignment p Halign) as Hword.
  unfold isvalidptr. split; repeat split; try lia.
  - exact Hword.
  - unfold aligned_4 in *. rewrite Z.add_mod by lia.
    rewrite Hword. reflexivity.
Qed.

(* The u8 type alone does not establish the length needed by the conversion.
   This numeric counterexample is outside the industrial admitted order range. *)
Theorem unrestricted_order_can_have_zero_wrapped_length :
  0 <= 52 <= 255 /\ u64 (Z.shiftl 1 (52 + 12)) = 0.
Proof. vm_compute. split; [split; discriminate | reflexivity]. Qed.

Print Assumptions admitted_page_length_bounds.
Print Assumptions admitted_page_shift_matches_length.
Print Assumptions admitted_page_has_header_and_remainder.
Print Assumptions page_alignment_implies_pointer_alignment.
Print Assumptions admitted_page_header_addresses_valid.
Print Assumptions unrestricted_order_can_have_zero_wrapped_length.
