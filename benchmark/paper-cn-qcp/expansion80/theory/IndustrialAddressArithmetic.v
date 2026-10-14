Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
Require Import IndustrialIntegerCasts.
Local Open Scope Z_scope.

Definition modulus64 : Z := 18446744073709551616.
Definition i64 (x : Z) : Z :=
  if Z.geb (u64 x) 9223372036854775808
  then u64 x - modulus64 else u64 x.
Definition physical_address (offset virtual : Z) : Z := u64 (i64 virtual + offset).
Definition virtual_address (offset physical : Z) : Z := u64 (i64 physical - offset).

Lemma signed64_has_same_residue : forall x, u64 (i64 x) = u64 x.
Proof.
  intros x. unfold i64. destruct (Z.geb (u64 x) 9223372036854775808).
  - unfold u64, wrap, modulus64.
    rewrite Zminus_mod. rewrite Z.mod_same by lia.
    rewrite Z.sub_0_r. repeat rewrite Z.mod_mod by lia. reflexivity.
  - unfold u64, wrap. apply Z.mod_mod. lia.
Qed.

Lemma wrapped_add_same_residue : forall x y,
  u64 (u64 x + y) = u64 (x + y).
Proof. intros. unfold u64, wrap. apply Z.add_mod_idemp_l. lia. Qed.

Lemma wrapped_subtraction_same_residue : forall x y,
  u64 (u64 x - u64 y) = u64 (x - y).
Proof.
  intros. unfold u64, wrap.
  rewrite (Zminus_mod (x mod 18446744073709551616)
                     (y mod 18446744073709551616) 18446744073709551616).
  repeat rewrite Z.mod_mod by lia. symmetry. apply Zminus_mod.
Qed.

Lemma signed64_add_same_residue : forall x y,
  u64 (i64 x + y) = u64 (x + y).
Proof.
  intros x y. rewrite <- (wrapped_add_same_residue (i64 x) y).
  rewrite signed64_has_same_residue. apply wrapped_add_same_residue.
Qed.

Theorem physical_address_integer_formula : forall offset virtual,
  physical_address offset virtual = u64 (virtual + offset).
Proof. intros. unfold physical_address. apply signed64_add_same_residue. Qed.

Theorem virtual_address_integer_formula : forall offset physical,
  virtual_address offset physical = u64 (physical - offset).
Proof.
  intros. unfold virtual_address. rewrite <- Z.add_opp_r.
  apply signed64_add_same_residue.
Qed.

Theorem physical_virtual_roundtrip : forall offset virtual,
  virtual_address offset (physical_address offset virtual) = u64 virtual.
Proof.
  intros. rewrite virtual_address_integer_formula, physical_address_integer_formula.
  rewrite <- Z.add_opp_r, wrapped_add_same_residue.
  replace (virtual + offset + - offset) with virtual by lia. reflexivity.
Qed.

Theorem virtual_physical_roundtrip : forall offset physical,
  physical_address offset (virtual_address offset physical) = u64 physical.
Proof.
  intros. rewrite physical_address_integer_formula, virtual_address_integer_formula.
  rewrite wrapped_add_same_residue.
  replace (physical - offset + offset) with physical by lia. reflexivity.
Qed.

Theorem unsigned_address_difference : forall base pointer,
  0 <= pointer - base < modulus64 -> u64 (pointer - base) = pointer - base.
Proof. intros. unfold u64, wrap. apply Z.mod_small. exact H. Qed.

Theorem metadata_index_integer_formula : forall base pointer metadata_bytes,
  0 <= pointer - base < modulus64 -> 0 < metadata_bytes ->
  u64 (pointer - base) / metadata_bytes = (pointer - base) / metadata_bytes.
Proof. intros. rewrite unsigned_address_difference by assumption. reflexivity. Qed.

Theorem original_metadata_index_integer_formula : forall base pointer metadata_bytes,
  0 <= pointer - base < modulus64 -> 0 < metadata_bytes ->
  u64 (u64 pointer - u64 base) / metadata_bytes =
  (pointer - base) / metadata_bytes.
Proof.
  intros. rewrite wrapped_subtraction_same_residue.
  apply metadata_index_integer_formula; assumption.
Qed.

(* The original cellPointer uses base-pointer, which normally underflows.
   Removing the wrap is valid for its remainder only if the element size
   divides the modulus. This is not true for arbitrary struct sizes. *)
Theorem wrapped_difference_remainder : forall base pointer element_bytes,
  0 < element_bytes -> modulus64 mod element_bytes = 0 ->
  u64 (base - pointer) mod element_bytes = (base - pointer) mod element_bytes.
Proof.
  intros. change (wrap element_bytes (wrap modulus64 (base-pointer)) =
                 wrap element_bytes (base-pointer)).
  apply nested_wrap; try assumption. unfold modulus64. lia.
Qed.

Theorem removing_wrap_can_change_alignment :
  u64 (0 - 1) mod 3 <> (0 - 1) mod 3.
Proof. change (0 <> 2). discriminate. Qed.

Print Assumptions physical_address_integer_formula.
Print Assumptions virtual_address_integer_formula.
Print Assumptions physical_virtual_roundtrip.
Print Assumptions virtual_physical_roundtrip.
Print Assumptions metadata_index_integer_formula.
Print Assumptions original_metadata_index_integer_formula.
Print Assumptions wrapped_difference_remainder.
Print Assumptions removing_wrap_can_change_alignment.
