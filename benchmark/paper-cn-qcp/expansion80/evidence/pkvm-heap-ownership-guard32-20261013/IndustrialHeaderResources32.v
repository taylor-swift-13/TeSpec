(* Resource conversions in the actual QCP 32-bit heap model. These are
   prerequisites for translating the upstream CN lemmas, not that translation. *)
Require Import Coq.ZArith.ZArith Coq.micromega.Psatz.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Import naive_C_Rules.
Local Open Scope sac.

Definition header32 (p prev next : Z) :=
  store_ptr p prev ** store_ptr (p + 4) next.
Definition header_bytes32 (p : Z) :=
  store_4byte_noninit p ** store_4byte_noninit (p + 4).
Definition zero_word32 (p : Z) :=
  store_byte p 0 ** (store_byte (p + 1) 0 **
  (store_byte (p + 2) 0 ** store_byte (p + 3) 0)).
Definition zero_header32 (p : Z) := zero_word32 p ** zero_word32 (p + 4).

Theorem typed_header32_to_untyped_bytes : forall p prev next,
  header32 p prev next |-- header_bytes32 p.
Proof.
  intros. unfold header32, header_bytes32.
  apply derivable1_sepcon_mono.
  all: eapply derivable1_trans; [apply store_ptr_undef_store_ptr |].
  all: unfold undef_store_ptr; entailer!.
Qed.

Theorem zero_word32_to_null_pointer : forall p,
  isvalidptr p -> zero_word32 p |-- store_ptr p 0.
Proof.
  intros p Hp. unfold zero_word32, store_ptr, store_4byte.
  Exists 0 0 0 0. entailer!.
  all: vm_compute; auto; discriminate.
Qed.

Theorem zero_header32_to_typed_header : forall p,
  isvalidptr p -> isvalidptr (p + 4) ->
  zero_header32 p |-- header32 p 0 0.
Proof.
  intros p Hp Hnext. unfold zero_header32, header32.
  apply derivable1_sepcon_mono; apply zero_word32_to_null_pointer; assumption.
Qed.

Print Assumptions typed_header32_to_untyped_bytes.
Print Assumptions zero_word32_to_null_pointer.
Print Assumptions zero_header32_to_typed_header.
