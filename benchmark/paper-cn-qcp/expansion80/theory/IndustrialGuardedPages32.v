(* Guarded page-resource candidates retain the original wrapped page length.
   Full CN quantified-byte and pointer-provenance correspondence is open. *)
Require Import Coq.ZArith.ZArith Coq.Bool.Bool Coq.micromega.Lia.
From compcert.lib Require Import Integers.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Require Import IndustrialIntegerCasts IndustrialTypedPage32 IndustrialPageDomain32.
Local Open Scope Z_scope.
Import naive_C_Rules.
Local Open Scope sac.

Definition original_page_length (order : Z) := u64 (Z.shiftl 1 (order + 12)).
Fixpoint untyped_bytes32 (p : Z) (count : nat) :=
  match count with
  | O => emp
  | S rest => Byte32 p ** untyped_bytes32 (p + 1) rest
  end.
Definition Page32 (p : Z) (guard : bool) (order : Z) :=
  if guard then untyped_bytes32 p (Z.to_nat (original_page_length order)) else emp.
Definition ZeroPage32 (p : Z) (guard : bool) (order : Z) :=
  if guard then zero_typed_bytes32 p (Z.to_nat (original_page_length order)) else emp.
Definition AllocatorPageZeroPart32 (start order : Z) :=
  zero_typed_bytes32 start (Z.to_nat (u64 (original_page_length order - 8))).
Definition GuardedAllocatorPage32 (p : Z) (guard : bool) (order next prev : Z) :=
  if guard then ListHead32 p next prev ** AllocatorPageZeroPart32 (p + 8) order
  else “ next = 0 /\ prev = 0 ” && emp.

Theorem typed_zero_page_forgets_values : forall count p,
  zero_typed_bytes32 p count |-- untyped_bytes32 p count.
Proof.
  induction count; intros p; cbn [zero_typed_bytes32 untyped_bytes32].
  - apply derivable1_refl.
  - apply derivable1_sepcon_mono.
    + unfold ByteV32, Byte32. apply store_char_undef_store_char.
    + apply IHcount.
Qed.

Theorem guarded_zero_page_implies_page : forall p guard order,
  ZeroPage32 p guard order |-- Page32 p guard order.
Proof.
  intros. unfold ZeroPage32, Page32. destruct guard.
  - apply typed_zero_page_forgets_values.
  - apply derivable1_refl.
Qed.

Theorem guarded_zero_page_to_allocator_page : forall p guard order,
  (guard = true -> 0 <= order < 11 /\ 0 <= p /\
                  p + 4095 <= Int.max_unsigned /\ p mod 4096 = 0) ->
  ZeroPage32 p guard order |-- GuardedAllocatorPage32 p guard order 0 0.
Proof.
  intros p guard order Hdomain. destruct guard.
  - specialize (Hdomain eq_refl). destruct Hdomain as [Horder [Hlow [Hhigh Halign]]].
    pose proof (admitted_page_header_addresses_valid p Hlow Hhigh Halign) as [Hp Hnext].
    pose proof (admitted_page_length_bounds order Horder) as Hlen.
    unfold ZeroPage32, GuardedAllocatorPage32, AllocatorPageZeroPart32, original_page_length.
    rewrite (admitted_page_shift_matches_length order Horder).
    rewrite u64_nonnegative_in_range by lia.
    assert (Hcount : Z.to_nat (allocator_page_length order) =
                    (8 + Z.to_nat (allocator_page_length order - 8))%nat).
    { replace (allocator_page_length order) with
        (8 + (allocator_page_length order - 8)) at 1 by lia.
      rewrite Z2Nat.inj_add by lia. reflexivity. }
    rewrite Hcount.
    change (zero_typed_bytes32 p (8 + Z.to_nat (allocator_page_length order - 8)) |--
            AllocatorPage32 p (Z.to_nat (allocator_page_length order - 8))).
    apply typed_zero_page32_to_allocator_page; assumption.
  - unfold ZeroPage32, GuardedAllocatorPage32. entailer!.
Qed.

Print Assumptions typed_zero_page_forgets_values.
Print Assumptions guarded_zero_page_implies_page.
Print Assumptions guarded_zero_page_to_allocator_page.
