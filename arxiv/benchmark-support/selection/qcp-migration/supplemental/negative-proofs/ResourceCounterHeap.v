Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
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
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Definition st (m:mem) : naive_C_Rules.model := {|ConAssertion.s_mem:=m;ConAssertion.s_STS:=Sets.full;ConAssertion.s_token:=Sets.empty|}.
Definition m67 (v:Z) : mem := fun x=>if Z.eqb x 6 then value 0 else if Z.eqb x 7 then value v else Noperm.
Definition m567 (v:Z) : mem := fun x=>if Z.eqb x 5 then value 0 else m67 v x.
Definition m4567 (v:Z) : mem := fun x=>if Z.eqb x 4 then value 0 else m567 v x.
Lemma st_join : forall a b c, mem_join a b c -> naive_C_Rules.join (st a) (st b) (st c).
Proof. intros; unfold naive_C_Rules.join, ConAssertion.state_join, st; cbn; split; [assumption|]. unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join; sets_unfold; tauto. Qed.
Ltac byte_join := unfold mem_join, single_byte_mem, m4567, m567, m67, addr_eqb; intro x;
 repeat match goal with |- context[Z.eqb ?y ?k] => let E:=fresh in destruct (Z.eqb y k) eqn:E; [apply Z.eqb_eq in E|apply Z.eqb_neq in E] end; try lia; eauto 12.
Lemma join67 : forall v, mem_join (single_byte_mem 6 0) (single_byte_mem 7 v) (m67 v).
Proof. intros; byte_join. Qed.
Lemma join567 : forall v, mem_join (single_byte_mem 5 0) (m67 v) (m567 v).
Proof. intros; byte_join. Qed.
Lemma join4567 : forall v, mem_join (single_byte_mem 4 0) (m567 v) (m4567 v).
Proof. intros; byte_join. Qed.
Lemma byte_at : forall p v, naive_C_Rules.mstore p v (st (single_byte_mem p v)).
Proof. intros; unfold naive_C_Rules.mstore,st; exists v; split; [apply Byte.eqm_refl|]; repeat split; try reflexivity; sets_unfold; tauto. Qed.
Lemma uint_witness : forall v, 0<=v<=255 -> (4 # UInt |-> v) (st (m4567 v)).
Proof.
 intros v H; unfold store_uint,store_4byte,store_byte,naive_C_Rules.andp,naive_C_Rules.coq_prop,naive_C_Rules.exp; split.
 - unfold isvalidptr_int,aligned_4; change (Int.max_unsigned) with 4294967295; repeat split; try lia; reflexivity.
 - exists 0,0,0,v; split.
   + unfold merge_int; change (2^32) with 4294967296; change (2^8) with 256; rewrite !Z.mod_small by lia; ring.
   + unfold naive_C_Rules.sepcon; exists (st (single_byte_mem 4 0)),(st (m567 v)); split; [apply st_join; apply join4567|]; split; [apply byte_at|].
     exists (st (single_byte_mem 5 0)),(st (m67 v)); split; [apply st_join; apply join567|]; split; [apply byte_at|].
     exists (st (single_byte_mem 6 0)),(st (single_byte_mem 7 v)); split; [apply st_join; apply join67|]; split; apply byte_at.
Qed.
Lemma witness_not_emp : forall v, ~ emp (st (m4567 v)).
Proof. intros v H; unfold naive_C_Rules.emp,naive_C_Rules.is_unit,ConAssertion.state_empty,st in H; cbn in H; destruct H as [H _]; unfold mem_empty in H; specialize (H 4); cbn [m4567] in H; discriminate. Qed.

Lemma int_zero_witness : (4 # Int |-> 0) (st (m4567 0)).
Proof. pose proof (uint_witness 0 ltac:(lia)) as H; unfold store_uint,naive_C_Rules.andp,naive_C_Rules.coq_prop in H; destruct H as [Hsafe Hbody]; unfold store_int,naive_C_Rules.andp,naive_C_Rules.coq_prop; split; [|exact Hbody]. destruct Hsafe as [Hp _]; split; [exact Hp|]; vm_compute; intuition congruence. Qed.
