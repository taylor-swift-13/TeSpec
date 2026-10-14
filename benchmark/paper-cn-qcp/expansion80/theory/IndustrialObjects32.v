(* Candidate object layer for the original allocator's measured 32-bit ABI.
   CN ownership/provenance and the full pool invariant are not yet translated. *)
Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.micromega.Lia.
From compcert.lib Require Import Integers.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Require Import IndustrialTypedPage32 IndustrialGuardedPages32.
Local Open Scope Z_scope.
Import naive_C_Rules.
Local Open Scope sac.
Import ListNotations.

Record page_metadata32 := { page_refcount32 : Z; page_order32 : Z; page_flags32 : Z }.
Definition HypPageObject32 (p : Z) (page : page_metadata32) :=
  store_ushort p (page_refcount32 page) **
  (store_uchar (p + 2) (page_order32 page) ** store_uchar (p + 3) (page_flags32 page)).
Fixpoint list_heads32 (p : Z) (heads : list (Z * Z)) :=
  match heads with
  | [] => emp
  | (next, prev) :: rest => ListHead32 p next prev ** list_heads32 (p + 8) rest
  end.
Record pool_fields32 := {
  pool_heads32 : list (Z * Z);
  pool_start32 : Z;
  pool_end32 : Z;
  pool_max_order32 : Z
}.
Definition HypPoolObject32 (p : Z) (pool : pool_fields32) :=
  “ length (pool_heads32 pool) = 11%nat ” &&
  (list_heads32 p (pool_heads32 pool) **
   (store_uint64 (p + 88) (pool_start32 pool) **
    (store_uint64 (p + 96) (pool_end32 pool) **
     (store_uchar (p + 104) (pool_max_order32 pool) ** untyped_bytes32 (p + 105) 3)))).

Theorem metadata32_has_original_unsigned_ranges : forall p page,
  HypPageObject32 p page |--
  “ 0 <= page_refcount32 page <= 65535 /\
    0 <= page_order32 page <= 255 /\
    0 <= page_flags32 page <= 255 ”.
Proof.
  intros. unfold HypPageObject32.
  sep_apply (valid_store_ushort p (page_refcount32 page)).
  Intros.
  sep_apply (valid_store_uchar (p + 2) (page_order32 page)).
  Intros.
  sep_apply (valid_store_uchar (p + 3) (page_flags32 page)).
  Intros.
  change Byte.max_unsigned with 255 in *.
  entailer!.
Qed.

Theorem pool32_has_original_unsigned_ranges : forall p pool,
  HypPoolObject32 p pool |--
  “ 0 <= pool_start32 pool <= Int64.max_unsigned /\
    0 <= pool_end32 pool <= Int64.max_unsigned /\
    0 <= pool_max_order32 pool <= 255 ”.
Proof.
  intros. unfold HypPoolObject32. Intros.
  sep_apply (valid_store_uint64 (p + 88) (pool_start32 pool)).
  Intros.
  sep_apply (valid_store_uint64 (p + 96) (pool_end32 pool)).
  Intros.
  sep_apply (valid_store_uchar (p + 104) (pool_max_order32 pool)).
  Intros.
  change Byte.max_unsigned with 255 in *.
  entailer!.
Qed.

Theorem free_area32_cells_do_not_overlap : forall p i j,
  0 <= i < 11 -> 0 <= j < 11 -> i <> j ->
  p + 8*i + 8 <= p + 8*j \/ p + 8*j + 8 <= p + 8*i.
Proof. intros; lia. Qed.

Print Assumptions metadata32_has_original_unsigned_ranges.
Print Assumptions pool32_has_original_unsigned_ranges.
Print Assumptions free_area32_cells_do_not_overlap.
