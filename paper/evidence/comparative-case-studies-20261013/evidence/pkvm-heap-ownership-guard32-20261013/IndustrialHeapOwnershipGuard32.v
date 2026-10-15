(* Heap-resource consequence of the original buddy allocator's root guard.
   This lemma concerns the QCP counterpart resources; pool/provenance
   correspondence is a separate obligation. *)
Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import IndustrialHeaderResources32 IndustrialPageResources32 IndustrialTypedPage32.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.

Theorem zero_part_and_subsumed_header_conflict : forall prefix suffix start next prev,
  zero_typed_bytes32 start (prefix + S suffix)%nat **
  ListHead32 (start + Z.of_nat prefix) next prev |-- “ False ”.
Proof.
  intros prefix suffix start next prev.
  sep_apply (zero_typed_bytes32_split prefix start (S suffix)).
  cbn [zero_typed_bytes32].
  unfold ListHead32.
  sep_apply (typed_header32_to_untyped_bytes (start + Z.of_nat prefix) next prev).
  unfold header_bytes32, store_4byte_noninit, ByteV32.
  sep_apply (store_char_undef_store_char (start + Z.of_nat prefix) 0).
  unfold undef_store_char.
  sep_apply (dup_store_byte_noninit (start + Z.of_nat prefix)).
  entailer!.
Qed.

Theorem allocator_zero_part_and_subsumed_header_conflict :
  forall prefix suffix root next prev,
  AllocatorPage32 root (prefix + S suffix)%nat **
  ListHead32 (root + 8 + Z.of_nat prefix) next prev |-- “ False ”.
Proof.
  intros. unfold AllocatorPage32.
  sep_apply (zero_part_and_subsumed_header_conflict prefix suffix (root + 8) next prev).
  entailer!.
Qed.

Print Assumptions zero_part_and_subsumed_header_conflict.
Print Assumptions allocator_zero_part_and_subsumed_header_conflict.
