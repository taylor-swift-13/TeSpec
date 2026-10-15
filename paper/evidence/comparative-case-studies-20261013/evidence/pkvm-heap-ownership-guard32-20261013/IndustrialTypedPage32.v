(* Candidate QCP counterparts of the CN ByteV/ZeroPage resource layer.
   Absolute-address/provenance correspondence and pool translation remain open. *)
Require Import Coq.ZArith.ZArith Coq.micromega.Psatz.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Require Import IndustrialHeaderResources32 IndustrialPageResources32.
Local Open Scope Z_scope.
Import naive_C_Rules.
Local Open Scope sac.

Definition Byte32 (p : Z) := undef_store_char p.
Definition ByteV32 (p value : Z) := store_char p value.
Fixpoint zero_typed_bytes32 (p : Z) (count : nat) :=
  match count with
  | O => emp
  | S rest => ByteV32 p 0 ** zero_typed_bytes32 (p + 1) rest
  end.
(* The C layout is next at offset zero, prev at offset four. *)
Definition ListHead32 (p next prev : Z) := header32 p next prev.
Definition AllocatorPage32 (p : Z) (remaining : nat) :=
  ListHead32 p 0 0 ** zero_typed_bytes32 (p + 8) remaining.

Theorem zero_typed_bytes32_split : forall prefix p suffix,
  zero_typed_bytes32 p (prefix + suffix)%nat |--
  zero_typed_bytes32 p prefix ** zero_typed_bytes32 (p + Z.of_nat prefix) suffix.
Proof.
  induction prefix; intros p suffix.
  - simpl. replace (p + 0) with p by lia. entailer!.
  - cbn [zero_typed_bytes32 Nat.add].
    replace (p + Z.of_nat (S prefix)) with ((p + 1) + Z.of_nat prefix) by lia.
    sep_apply (IHprefix (p + 1) suffix). entailer!.
Qed.

Theorem typed_zero_bytes32_to_raw : forall count p,
  zero_typed_bytes32 p count |-- zero_bytes p count.
Proof.
  induction count; intros p; cbn [zero_typed_bytes32 zero_bytes].
  - apply derivable1_refl.
  - apply derivable1_sepcon_mono.
    + unfold ByteV32, store_char. entailer!.
    + apply IHcount.
Qed.

Theorem typed_zero_page32_to_allocator_page : forall p remaining,
  isvalidptr p -> isvalidptr (p + 4) ->
  zero_typed_bytes32 p (8 + remaining)%nat |-- AllocatorPage32 p remaining.
Proof.
  intros p remaining Hp Hnext. unfold AllocatorPage32, ListHead32.
  eapply derivable1_trans; [apply (zero_typed_bytes32_split 8 p remaining) |].
  change (zero_typed_bytes32 p 8 ** zero_typed_bytes32 (p + 8) remaining |--
          header32 p 0 0 ** zero_typed_bytes32 (p + 8) remaining).
  apply derivable1_sepcon_mono; [| apply derivable1_refl].
  eapply derivable1_trans; [apply typed_zero_bytes32_to_raw |].
  eapply derivable1_trans; [apply zero_eight_bytes_to_header |].
  apply zero_header32_to_typed_header; assumption.
Qed.

Print Assumptions zero_typed_bytes32_split.
Print Assumptions typed_zero_bytes32_to_raw.
Print Assumptions typed_zero_page32_to_allocator_page.
