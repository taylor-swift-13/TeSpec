Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Reals.Reals.
Require Import Coq.micromega.Psatz.
From Coq Require Import SpecFloat.
From SimpleC.SL Require Export FloatLib.
From Flocq.Core Require Import Raux.

Local Open Scope Z_scope.
Local Open Scope R_scope.

(* ============================================================
 * Minimal spec for float_clamp / double_clamp under QCP v2.0.4
 *
 * Under v2.0.4 fp32/fp64 are native types provided by SimpleC.SL.FloatLib.
 * The case-specific library only needs the predicates below.
 * ============================================================ *)

Definition clampFloatSafe (x lo hi : fp32) : Prop :=
  fp32_isFinite x /\ fp32_isFinite lo /\ fp32_isFinite hi /\ fp32_le lo hi.

Definition clampFloatPost (x lo hi ret : fp32) : Prop :=
  fp32_ge ret lo /\ fp32_le ret hi.

Definition clampSafe (x lo hi : fp64) : Prop :=
  fp64_isFinite x /\ fp64_isFinite lo /\ fp64_isFinite hi /\ fp64_le lo hi.

Definition clampPost (x lo hi ret : fp64) : Prop :=
  fp64_ge ret lo /\ fp64_le ret hi.

(* Helper lemmas for finite comparisons. *)
Lemma fp32_compare_refl : forall x, fp32_isFinite x -> fp32_compare x x = Some Datatypes.Eq.
Proof.
  intros x Hfin. unfold fp32_compare, fp32_isFinite in *.
  rewrite Binary.Bcompare_correct; auto.
  assert (H: Rcompare (Binary.B2R 24 128 x) (Binary.B2R 24 128 x) = Eq).
  { apply Rcompare_Eq. reflexivity. }
  rewrite H. reflexivity.
Qed.

Lemma fp32_le_refl : forall x, fp32_isFinite x -> fp32_le x x.
Proof.
  intros x Hfin. unfold fp32_le. rewrite fp32_compare_refl; auto.
Qed.

Lemma fp32_compare_opp : forall x y,
    fp32_isFinite x -> fp32_isFinite y ->
    fp32_compare y x = match fp32_compare x y with
                       | Some Datatypes.Lt => Some Datatypes.Gt
                       | Some Datatypes.Eq => Some Datatypes.Eq
                       | Some Datatypes.Gt => Some Datatypes.Lt
                       | None => None
                       end.
Proof.
  intros x y Hx Hy. unfold fp32_compare, fp32_isFinite in *.
  rewrite 2 Binary.Bcompare_correct; auto.
  destruct (Rcompare_spec (Binary.B2R 24 128 x) (Binary.B2R 24 128 y))
    as [Hlt | Heq | Hgt].
  - assert (Rcompare (Binary.B2R 24 128 y) (Binary.B2R 24 128 x) = Gt)
      by (apply Rcompare_Gt; lra).
    simpl. rewrite H. reflexivity.
  - assert (Rcompare (Binary.B2R 24 128 y) (Binary.B2R 24 128 x) = Eq)
      by (apply Rcompare_Eq; lra).
    simpl. rewrite H. reflexivity.
  - assert (Rcompare (Binary.B2R 24 128 y) (Binary.B2R 24 128 x) = Lt)
      by (apply Rcompare_Lt; lra).
    simpl. rewrite H. reflexivity.
Qed.

Lemma fp32_le_ge : forall x y, fp32_isFinite x -> fp32_isFinite y ->
    fp32_le x y -> fp32_ge y x.
Proof.
  intros x y Hx Hy H. unfold fp32_le in H.
  destruct (fp32_compare x y) as [c | ] eqn:Hc; simpl in H; try contradiction.
  destruct c; simpl in H; try contradiction.
  all: unfold fp32_ge; rewrite fp32_compare_opp; auto; rewrite Hc; reflexivity.
Qed.

Lemma fp64_compare_refl : forall x, fp64_isFinite x -> fp64_compare x x = Some Datatypes.Eq.
Proof.
  intros x Hfin. unfold fp64_compare, fp64_isFinite in *.
  rewrite Binary.Bcompare_correct; auto.
  assert (H: Rcompare (Binary.B2R 53 1024 x) (Binary.B2R 53 1024 x) = Eq).
  { apply Rcompare_Eq. reflexivity. }
  rewrite H. reflexivity.
Qed.

Lemma fp64_le_refl : forall x, fp64_isFinite x -> fp64_le x x.
Proof.
  intros x Hfin. unfold fp64_le. rewrite fp64_compare_refl; auto.
Qed.

Lemma fp64_compare_opp : forall x y,
    fp64_isFinite x -> fp64_isFinite y ->
    fp64_compare y x = match fp64_compare x y with
                       | Some Datatypes.Lt => Some Datatypes.Gt
                       | Some Datatypes.Eq => Some Datatypes.Eq
                       | Some Datatypes.Gt => Some Datatypes.Lt
                       | None => None
                       end.
Proof.
  intros x y Hx Hy. unfold fp64_compare, fp64_isFinite in *.
  rewrite 2 Binary.Bcompare_correct; auto.
  destruct (Rcompare_spec (Binary.B2R 53 1024 x) (Binary.B2R 53 1024 y))
    as [Hlt | Heq | Hgt].
  - assert (Rcompare (Binary.B2R 53 1024 y) (Binary.B2R 53 1024 x) = Gt)
      by (apply Rcompare_Gt; lra).
    simpl. rewrite H. reflexivity.
  - assert (Rcompare (Binary.B2R 53 1024 y) (Binary.B2R 53 1024 x) = Eq)
      by (apply Rcompare_Eq; lra).
    simpl. rewrite H. reflexivity.
  - assert (Rcompare (Binary.B2R 53 1024 y) (Binary.B2R 53 1024 x) = Lt)
      by (apply Rcompare_Lt; lra).
    simpl. rewrite H. reflexivity.
Qed.

Lemma fp64_le_ge : forall x y, fp64_isFinite x -> fp64_isFinite y ->
    fp64_le x y -> fp64_ge y x.
Proof.
  intros x y Hx Hy H. unfold fp64_le in H.
  destruct (fp64_compare x y) as [c | ] eqn:Hc; simpl in H; try contradiction.
  destruct c; simpl in H; try contradiction.
  all: unfold fp64_ge; rewrite fp64_compare_opp; auto; rewrite Hc; reflexivity.
Qed.
