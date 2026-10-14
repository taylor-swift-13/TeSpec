Require Import Coq.ZArith.ZArith Coq.Lists.List.
Require Import ConcreteByteWitness.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Import naive_C_Rules ListNotations.
Local Open Scope Z_scope.
Local Open Scope sac.

Theorem nonempty_list_unfold_retains_guard : forall p element tail,
  sll32 p (element :: tail) --||--
  “ p <> 0 ” && EX next : Z,
    store_int p element ** store_ptr (p + 4) next ** sll32 next tail.
Proof. intros. split; apply derivable1_refl. Qed.

Theorem nonempty_list_at_null_is_false : forall element tail,
  sll32 0 (element :: tail) |-- “ False ”.
Proof. intros. cbn [sll32]. Intros next. entailer!. Qed.

Lemma zero_bytes_encode_null_fields :
  byte_resources 0 [0;0;0;0;0;0;0;0] |-- store_int 0 0 ** store_ptr 4 0.
Proof.
  assert (Hdata : byte_resources 0 [0;0;0;0] |-- store_int 0 0).
  { unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  assert (Hnext : byte_resources 4 [0;0;0;0] |-- store_ptr 4 0).
  { unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }
  eapply derivable1_trans; [apply (byte_resources_append [0;0;0;0] 0 [0;0;0;0])|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.

Theorem guardless_unfold_has_a_null_heap_witness :
  ~ ((EX next : Z, store_int 0 0 ** store_ptr 4 next ** sll32 next []) |-- “ False ”).
Proof.
  assert (Hencode : byte_resources 0 [0;0;0;0;0;0;0;0] |--
    EX next : Z, store_int 0 0 ** store_ptr 4 next ** sll32 next []).
  { sep_apply zero_bytes_encode_null_fields. Exists 0. cbn [sll32]. entailer!. }
  intro Hfalse.
  apply (Hfalse (memory_state (byte_memory 0 [0;0;0;0;0;0;0;0]))).
  apply Hencode. apply concrete_byte_resources_have_witness.
Qed.

Print Assumptions nonempty_list_unfold_retains_guard.
Print Assumptions nonempty_list_at_null_is_false.
Print Assumptions guardless_unfold_has_a_null_heap_witness.
