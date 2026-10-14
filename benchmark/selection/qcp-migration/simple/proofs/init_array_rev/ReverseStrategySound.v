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

Lemma empty_suffix : forall p i, emp |-- CharArray.seg p i i nil.
Proof. intros; rewrite CharArray.seg_empty; entailer!. Qed.
Lemma tail_remainder : forall p lo hi, lo < hi -> CharArray.undef_missing_i p (hi-1) lo hi |-- CharArray.undef_seg p lo (hi-1).
Proof. intros; apply CharArray.undef_missing_i_to_undef_seg_tail; lia. Qed.
Lemma prepend_cell : forall p i hi l v, (p+i*sizeof(CHAR)) # Char |-> v ** CharArray.seg p (i+1) hi l |-- CharArray.seg p i hi (v::l).
Proof. intros; rewrite CharArray.seg_unfold; entailer!. Qed.
Lemma empty_uninitialized : forall p i, CharArray.undef_seg p i i |-- emp.
Proof. intros; rewrite CharArray.undef_seg_empty; entailer!. Qed.
Lemma complete_suffix : forall p n l, CharArray.seg p 0 n l |-- CharArray.full p n l.
Proof. intros; sep_apply (CharArray.seg_to_full p 0 n l); simpl; rewrite Z.add_0_r,Z.sub_0_r; entailer!. Qed.
Lemma match_full : forall p n m, n=m -> CharArray.undef_full p n |-- CharArray.undef_full p m.
Proof. intros; subst; entailer!. Qed.
Lemma match_suffix : forall p lo hi lo2 hi2 l, lo=lo2 -> hi=hi2 -> CharArray.seg p lo hi l |-- CharArray.seg p lo2 hi2 l.
Proof. intros; subst; entailer!. Qed.
