(* Preserve the page remainder when converting a zero-filled header.
   The original CN predicate and provenance bridge are still required. *)
Require Import Coq.ZArith.ZArith Coq.micromega.Psatz.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Require Import IndustrialHeaderResources32.
Local Open Scope Z_scope.
Import naive_C_Rules.
Local Open Scope sac.

Fixpoint zero_bytes (p : Z) (count : nat) :=
  match count with
  | O => emp
  | S rest => store_byte p 0 ** zero_bytes (p + 1) rest
  end.

Theorem zero_bytes_split : forall prefix p suffix,
  zero_bytes p (prefix + suffix)%nat |--
  zero_bytes p prefix ** zero_bytes (p + Z.of_nat prefix) suffix.
Proof.
  induction prefix; intros p suffix.
  - simpl. replace (p + 0) with p by lia. entailer!.
  - cbn [zero_bytes Nat.add].
    replace (p + Z.of_nat (S prefix)) with ((p + 1) + Z.of_nat prefix) by lia.
    sep_apply (IHprefix (p + 1) suffix). entailer!.
Qed.

Theorem zero_eight_bytes_to_header : forall p,
  zero_bytes p 8 |-- zero_header32 p.
Proof.
  intros. unfold zero_header32, zero_word32.
  cbn [zero_bytes].
  replace (p + 1 + 1) with (p + 2) by lia.
  replace (p + 2 + 1) with (p + 3) by lia.
  replace (p + 3 + 1) with (p + 4) by lia.
  replace (p + 4 + 1 + 1) with (p + 4 + 2) by lia.
  replace (p + 4 + 2 + 1) with (p + 4 + 3) by lia.
  entailer!.
Qed.

Theorem zero_page_to_header_and_remainder : forall p remaining,
  isvalidptr p -> isvalidptr (p + 4) ->
  zero_bytes p (8 + remaining)%nat |--
  header32 p 0 0 ** zero_bytes (p + 8) remaining.
Proof.
  intros p remaining Hp Hnext.
  eapply derivable1_trans; [apply (zero_bytes_split 8 p remaining) |].
  change (zero_bytes p 8 ** zero_bytes (p + 8) remaining |--
          header32 p 0 0 ** zero_bytes (p + 8) remaining).
  apply derivable1_sepcon_mono; [| apply derivable1_refl].
  eapply derivable1_trans; [apply zero_eight_bytes_to_header |].
  apply zero_header32_to_typed_header; assumption.
Qed.

Print Assumptions zero_bytes_split.
Print Assumptions zero_eight_bytes_to_header.
Print Assumptions zero_page_to_header_and_remainder.
