From SimpleC.Verification Require Import VCPrelude.
Require Import Goal.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.micromega.Psatz.
Require Import SetsClass.SetsClass.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Import SetsNotation.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope sac.

Module Proofs.

Definition st (m : mem) : naive_C_Rules.model :=
  {| ConAssertion.s_mem := m;
     ConAssertion.s_STS := Sets.full;
     ConAssertion.s_token := Sets.empty |}.
Definition tail2 (b2 b3 : Z) : mem :=
  fun x => if Z.eqb x 4098 then value b2
           else if Z.eqb x 4099 then value b3 else Noperm.
Definition tail1 (b1 b2 b3 : Z) : mem :=
  fun x => if Z.eqb x 4097 then value b1 else tail2 b2 b3 x.
Definition cell (b0 b1 b2 b3 : Z) : mem :=
  fun x => if Z.eqb x 4096 then value b0 else tail1 b1 b2 b3 x.

Lemma st_join : forall a b c,
  mem_join a b c -> naive_C_Rules.join (st a) (st b) (st c).
Proof.
  intros; unfold naive_C_Rules.join, ConAssertion.state_join, st;
  cbn; split; [assumption |].
  unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join;
  sets_unfold; tauto.
Qed.

Ltac byte_join :=
  unfold mem_join, single_byte_mem, cell, tail1, tail2, addr_eqb;
  intro x;
  repeat match goal with
  | |- context [Z.eqb ?y ?k] =>
      let E := fresh in destruct (Z.eqb y k) eqn:E;
      [apply Z.eqb_eq in E | apply Z.eqb_neq in E]
  end;
  try lia; eauto 12.

Lemma join2 : forall a b,
  mem_join (single_byte_mem 4098 a) (single_byte_mem 4099 b) (tail2 a b).
Proof. intros; byte_join. Qed.
Lemma join1 : forall a b c,
  mem_join (single_byte_mem 4097 a) (tail2 b c) (tail1 a b c).
Proof. intros; byte_join. Qed.
Lemma join0 : forall a b c d,
  mem_join (single_byte_mem 4096 a) (tail1 b c d) (cell a b c d).
Proof. intros; byte_join. Qed.

Lemma byte_at : forall p v,
  naive_C_Rules.mstore p v (st (single_byte_mem p v)).
Proof.
  intros; unfold naive_C_Rules.mstore, st;
  exists v; split; [apply Byte.eqm_refl |];
  repeat split; try reflexivity; sets_unfold; tauto.
Qed.

Lemma cell_not_emp : forall a b c d, ~ emp (st (cell a b c d)).
Proof.
  intros a b c d H.
  unfold naive_C_Rules.emp, naive_C_Rules.is_unit,
    ConAssertion.state_empty, st in H.
  cbn in H; destruct H as [H _].
  unfold mem_empty in H; specialize (H 4096).
  cbn [cell] in H; discriminate.
Qed.

Lemma cell_value_5 :
  (4096 # Int |-> 2147483647) (st (cell 127 255 255 255)).
Proof.
  unfold store_int, naive_C_Rules.andp, naive_C_Rules.coq_prop; split.
  - vm_compute; intuition congruence.
  - unfold store_4byte, naive_C_Rules.exp,
      naive_C_Rules.andp, naive_C_Rules.coq_prop.
    exists 127, 255, 255, 255; split.
    + unfold merge_int; vm_compute; reflexivity.
    + unfold naive_C_Rules.sepcon.
      exists (st (single_byte_mem 4096 127)), (st (tail1 255 255 255)).
      split; [apply st_join; apply join0 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4097 255)), (st (tail2 255 255)).
      split; [apply st_join; apply join1 |].
      split; [apply byte_at |].
      exists (st (single_byte_mem 4098 255)),
        (st (single_byte_mem 4099 255)).
      split; [apply st_join; apply join2 |].
      split; apply byte_at.
Qed.

Lemma proof_of_read_return_wit_1 : ~ Goal.read_return_wit_1.
Proof.
  unfold Goal.read_return_wit_1.
  intros [H | H].
  - assert (Heq : 2147483647 = INT_MAX) by (vm_compute; reflexivity).
    pose proof (H 2147483647 4096 eq_refl Heq
      (st (cell 127 255 255 255)) cell_value_5) as Hout.
    destruct Hout as [_ Hemp].
    exact (cell_not_emp 127 255 255 255 Hemp).
  - assert (Hmax : 2147483647 <= INT_MAX) by (vm_compute; congruence).
    assert (Hmin : 2147483647 >= INT_MIN) by (vm_compute; congruence).
    assert (Heq : 2147483647 = INT_MAX) by (vm_compute; reflexivity).
    pose proof (H 2147483647 4096 Hmax Hmin eq_refl Heq
      (st (cell 127 255 255 255)) cell_value_5) as Hout.
    destruct Hout as [_ Hemp].
    exact (cell_not_emp 127 255 255 255 Hemp).
Qed.

End Proofs.
