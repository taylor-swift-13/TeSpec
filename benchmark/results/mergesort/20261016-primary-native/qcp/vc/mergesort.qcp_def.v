Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Classes.RelationClasses.
Require Import Coq.Classes.Morphisms.
Require Import Coq.micromega.Psatz.
Require Import Coq.Sorting.Permutation.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Record Recordint_list_pair : Type := make_record_int_list_pair {
  int_list_pair_fst : Z;
  int_list_pair_snd : Z
}.

Definition zero_record_int_list_pair : Recordint_list_pair :=
  make_record_int_list_pair 0 0.

Definition StructPredint_list_pair (x : Z) (v : Recordint_list_pair) : Assertion :=
  ((&(x # "int_list_pair" ->ₛ "fst")) # Ptr  |-> v.(int_list_pair_fst)) **
  ((&(x # "int_list_pair" ->ₛ "snd")) # Ptr  |-> v.(int_list_pair_snd)).

Definition UndefStructPredint_list_pair (x : Z) : Assertion :=
  ((&(x # "int_list_pair" ->ₛ "fst")) # Ptr  |->_) **
  ((&(x # "int_list_pair" ->ₛ "snd")) # Ptr  |->_).

Lemma store_Predint_list_pair_to_undef : forall x v,
  StructPredint_list_pair x v |-- UndefStructPredint_list_pair x.
Proof.
  intros.
  unfold StructPredint_list_pair, UndefStructPredint_list_pair.
  sep_apply store_ptr_undef_store_ptr.
  sep_apply store_ptr_undef_store_ptr.
  cancel.
Qed.

Lemma undefstore_Predint_list_pair_to_align : forall x,
  UndefStructPredint_list_pair x |-- store_align_n ((0 + sizeof(PTR)) + sizeof(PTR)).
Proof.
  intros.
  unfold UndefStructPredint_list_pair.
  sep_apply undef_store_ptr_align4.
  sep_apply undef_store_ptr_align4.
  sep_apply store_align4_to_store_align.
  sep_apply (store_align_merge (4 * 1)).
  try rewrite sizeof_ptr.
  try rewrite sizeof_ptr.
  replace (((0 + 4) + 4)) with 8 by lia.
  replace ((4 * 1 + 4 * 1)) with 8 by lia.
  cancel.
Qed.

Lemma store_Predint_list_pair_to_align : forall x v,
  StructPredint_list_pair x v |-- store_align_n ((0 + sizeof(PTR)) + sizeof(PTR)).
Proof.
  intros.
  sep_apply store_Predint_list_pair_to_undef.
  sep_apply undefstore_Predint_list_pair_to_align.
  cancel.
Qed.

Module StoreStructint_list_pairAsElement <: ELEMENT_STORE.
  Definition A := Recordint_list_pair.
  Definition sizeA := ((0 + sizeof(PTR)) + sizeof(PTR)).
  Definition storeA (x: addr) (lo: Z) (a: Recordint_list_pair): Assertion :=
    (StructPredint_list_pair (x + lo * sizeA) a).
  Definition undefstoreA (x: addr) (lo: Z): Assertion :=
    (UndefStructPredint_list_pair (x + lo * sizeA)).

  Lemma store_to_undefstore : forall x lo a,
    storeA x lo a |-- undefstoreA x lo.
  Proof.
    intros.
    unfold storeA, undefstoreA.
    sep_apply store_Predint_list_pair_to_undef.
    cancel.
  Qed.

  Lemma storeA_shift : forall x n lo a,
    storeA (x + n * sizeA) lo a --||-- storeA x (lo + n) a.
  Proof.
    intros.
    unfold storeA.
    replace (x + n * sizeA + lo * sizeA) with (x + (lo + n) * sizeA) by lia.
    reflexivity.
  Qed.

  Lemma undefstoreA_shift : forall x n lo,
    undefstoreA (x + n * sizeA) lo --||-- undefstoreA x (lo + n).
  Proof.
    intros.
    unfold undefstoreA.
    replace (x + n * sizeA + lo * sizeA) with (x + (lo + n) * sizeA) by lia.
    reflexivity.
  Qed.

  Lemma store_to_align : forall x lo a, storeA x lo a |-- store_align_n sizeA.
  Proof.
    intros.
    unfold storeA, sizeA.
    sep_apply store_Predint_list_pair_to_align.
    cancel.
  Qed.

  Lemma undefstore_to_align : forall x lo, undefstoreA x lo |-- store_align_n sizeA.
  Proof.
    intros.
    unfold undefstoreA, sizeA.
    sep_apply undefstore_Predint_list_pair_to_align.
    cancel.
  Qed.

  Lemma sizeA_valid : 0 < sizeA < Int.max_unsigned.
  Proof.
    unfold sizeA.
  try rewrite sizeof_ptr.
  try rewrite sizeof_ptr.
    replace Int.max_unsigned with 4294967295 by reflexivity.
    lia.
  Qed.

End StoreStructint_list_pairAsElement.

Module Structint_list_pairArray := ArrayLib (StoreStructint_list_pairAsElement).

