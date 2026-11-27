From SimpleC.Verification Require Import VCPrelude.
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
  sep_apply undef_store_ptr_align.
  sep_apply undef_store_ptr_align.
  sep_apply (store_align_merge (sizeof(PTR)) (sizeof(PTR))).
  replace (((0 + sizeof(PTR)) + sizeof(PTR))) with ((sizeof(PTR) + sizeof(PTR))) by
    (simpl_nonptr_sizeof; ring).
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

