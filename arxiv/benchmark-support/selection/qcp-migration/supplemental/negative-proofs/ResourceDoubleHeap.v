Require Import ResourceCounterHeap.
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

Module PointerHeap.
Definition st (m:mem) : naive_C_Rules.model := {|ConAssertion.s_mem:=m;ConAssertion.s_STS:=Sets.full;ConAssertion.s_token:=Sets.empty|}.
Definition m1415 (v:Z) : mem := fun x=>if Z.eqb x 14 then value 0 else if Z.eqb x 15 then value v else Noperm.
Definition m131415 (v:Z) : mem := fun x=>if Z.eqb x 13 then value 0 else m1415 v x.
Definition m12131415 (v:Z) : mem := fun x=>if Z.eqb x 12 then value 0 else m131415 v x.
Lemma st_join : forall a b c, mem_join a b c -> naive_C_Rules.join (st a) (st b) (st c).
Proof. intros; unfold naive_C_Rules.join, ConAssertion.state_join, st; cbn; split; [assumption|]. unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join; sets_unfold; tauto. Qed.
Ltac byte_join := unfold mem_join, single_byte_mem, m12131415, m131415, m1415, addr_eqb; intro x;
 repeat match goal with |- context[Z.eqb ?y ?k] => let E:=fresh in destruct (Z.eqb y k) eqn:E; [apply Z.eqb_eq in E|apply Z.eqb_neq in E] end; try lia; eauto 12.
Lemma join67 : forall v, mem_join (single_byte_mem 14 0) (single_byte_mem 15 v) (m1415 v).
Proof. intros; byte_join. Qed.
Lemma join567 : forall v, mem_join (single_byte_mem 13 0) (m1415 v) (m131415 v).
Proof. intros; byte_join. Qed.
Lemma join4567 : forall v, mem_join (single_byte_mem 12 0) (m131415 v) (m12131415 v).
Proof. intros; byte_join. Qed.
Lemma byte_at : forall p v, naive_C_Rules.mstore p v (st (single_byte_mem p v)).
Proof. intros; unfold naive_C_Rules.mstore,st; exists v; split; [apply Byte.eqm_refl|]; repeat split; try reflexivity; sets_unfold; tauto. Qed.
Lemma ptr_witness : forall v, 0<=v<=255 -> (12 # Ptr |-> v) (st (m12131415 v)).
Proof.
 intros v H; unfold store_ptr,store_4byte,store_byte,naive_C_Rules.andp,naive_C_Rules.coq_prop,naive_C_Rules.exp; split.
 - unfold isvalidptr,aligned_4; change (Int.max_unsigned) with 4294967295; repeat split; try lia; reflexivity.
 - exists 0,0,0,v; split.
   + unfold merge_int; change (2^32) with 4294967296; change (2^8) with 256; rewrite !Z.mod_small by lia; ring.
   + unfold naive_C_Rules.sepcon; exists (st (single_byte_mem 12 0)),(st (m131415 v)); split; [apply st_join; apply join4567|]; split; [apply byte_at|].
     exists (st (single_byte_mem 13 0)),(st (m1415 v)); split; [apply st_join; apply join567|]; split; [apply byte_at|].
     exists (st (single_byte_mem 14 0)),(st (single_byte_mem 15 v)); split; [apply st_join; apply join67|]; split; apply byte_at.
Qed.
Lemma witness_not_emp : forall v, ~ emp (st (m12131415 v)).
Proof. intros v H; unfold naive_C_Rules.emp,naive_C_Rules.is_unit,ConAssertion.state_empty,st in H; cbn in H; destruct H as [H _]; unfold mem_empty in H; specialize (H 12); cbn [m12131415] in H; discriminate. Qed.

End PointerHeap.

Definition two_words : mem := fun x => match m4567 6 x with Noperm => PointerHeap.m12131415 4 x | v=>v end.
Lemma two_words_join : mem_join (m4567 6) (PointerHeap.m12131415 4) two_words.
Proof. unfold mem_join,two_words,m4567,m567,m67,PointerHeap.m12131415,PointerHeap.m131415,PointerHeap.m1415; intro x;
 repeat match goal with |-context[Z.eqb ?y ?k] => let E:=fresh in destruct (Z.eqb y k) eqn:E; [apply Z.eqb_eq in E|apply Z.eqb_neq in E] end; try lia; eauto 12.
Qed.
Lemma two_word_witness : ((4 # UInt |-> 6) ** (12 # Ptr |-> 4)) (st two_words).
Proof. unfold naive_C_Rules.sepcon; exists (st (m4567 6)),(PointerHeap.st (PointerHeap.m12131415 4)); split; [apply st_join; apply two_words_join|]; split; [apply uint_witness; lia|apply PointerHeap.ptr_witness; lia]. Qed.
Lemma two_words_not_emp : ~ emp (st two_words).
Proof. intros H; unfold naive_C_Rules.emp,naive_C_Rules.is_unit,ConAssertion.state_empty,st in H; cbn in H; destruct H as [H _]; unfold mem_empty in H; specialize (H 4); cbn [two_words m4567] in H; discriminate. Qed.
