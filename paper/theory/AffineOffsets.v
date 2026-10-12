From Coq Require Import ZArith Lia.
Local Open Scope Z_scope.

(* Addresses and annotation arithmetic use mathematical integers. Defined C
   execution retains its separate overflow and memory-safety obligations. *)
Definition byte_disjoint (a size_a b size_b : Z) : Prop :=
  a + size_a <= b \/ b + size_b <= a.

Lemma add_offset_eq : forall base left right,
  base + left = base + right <-> left = right.
Proof. intros; lia. Qed.

Lemma add_offset_neq : forall base left right,
  base + left <> base + right <-> left <> right.
Proof. intros; lia. Qed.

Lemma add_offset_lt : forall base left right,
  base + left < base + right <-> left < right.
Proof. intros; lia. Qed.

Lemma add_offset_le : forall base left right,
  base + left <= base + right <-> left <= right.
Proof. intros; lia. Qed.

Lemma typed_offset_le : forall base i size_i j size_j,
  base + i * size_i <= base + j * size_j <->
  i * size_i <= j * size_j.
Proof. intros; lia. Qed.

Lemma disjoint_offsets : forall base left size_left right size_right,
  byte_disjoint (base + left) size_left (base + right) size_right <->
  byte_disjoint left size_left right size_right.
Proof. intros; unfold byte_disjoint; lia. Qed.

Lemma overlap_false : forall base left size_left right size_right,
  left < right + size_right -> right < left + size_left ->
  ~ byte_disjoint (base + left) size_left (base + right) size_right.
Proof. intros; unfold byte_disjoint; lia. Qed.

Lemma framed_disjoint_offsets : forall (rest : Prop) base left size_left right size_right,
  (rest /\ byte_disjoint (base + left) size_left (base + right) size_right) <->
  (rest /\ byte_disjoint left size_left right size_right).
Proof. intros; rewrite disjoint_offsets; reflexivity. Qed.

Lemma shared_base_difference : forall base left right,
  (base + left) - (base + right) = left - right.
Proof. intros; lia. Qed.

Lemma typed_pointer_difference : forall base i j size,
  size <> 0 ->
  Z.quot ((base + i * size) - (base + j * size)) size = i - j.
Proof.
  intros base i j size Hsize.
  replace ((base + i * size) - (base + j * size))
    with ((i - j) * size) by ring.
  apply Z.quot_mul. exact Hsize.
Qed.

Print Assumptions add_offset_eq.
Print Assumptions add_offset_neq.
Print Assumptions add_offset_lt.
Print Assumptions add_offset_le.
Print Assumptions typed_offset_le.
Print Assumptions disjoint_offsets.
Print Assumptions overlap_false.
Print Assumptions framed_disjoint_offsets.

Print Assumptions shared_base_difference.
Print Assumptions typed_pointer_difference.
