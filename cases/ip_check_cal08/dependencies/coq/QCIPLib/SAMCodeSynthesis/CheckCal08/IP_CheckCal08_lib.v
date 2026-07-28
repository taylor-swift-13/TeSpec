(* ============================================================
 * CheckCal08 的 Rocq spec
 *
 * C 函数 CheckCal08Fun 计算 pIp->pkv[0..len-1] 的 8 位累加和：
 *   chksum = (Σ pkv[i]) mod 256
 *
 * 本文件定义 annotation 中用到的数学谓词：
 *   - sum_mod256      : 列表元素之和对 256 取模
 *   - CheckCal08Post  : 函数最终应满足的后置条件
 *   - CheckCal08Inv   : for 循环不变式
 * ============================================================ *)

Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.Bool.Bool.
Require Import Coq.micromega.Lia.
From AUXLib Require Import ListLib.

Import ListNotations.
Local Open Scope Z_scope.

(* 列表元素之和对 256 取模。 *)
Fixpoint sum_mod256 (l: list Z) : Z :=
  match l with
  | nil => 0
  | x :: l' => (x + sum_mod256 l') mod 256
  end.

(* 后置条件：
 *   - pkv 的长度等于 len（输入数组合法）
 *   - chksum 等于 pkv[0..len-1] 的 8 位累加和
 *)
Definition CheckCal08Post (pkv: list Z) (len: Z) (chksum: Z) : Prop :=
  0 <= len /\
  Zlength pkv = len /\
  chksum = sum_mod256 (sublist 0 len pkv).

(* 循环不变式：
 *   - 计数器 i 在 [0, len] 范围内
 *   - pkv 长度等于 len（数组维度保持）
 *   - 当前 chksum 等于 pkv[0..i-1] 的 8 位累加和
 *)
Definition CheckCal08Inv (pkv: list Z) (len: Z) (i: Z) (chksum: Z) : Prop :=
  0 <= i <= len /\
  Zlength pkv = len /\
  chksum = sum_mod256 (sublist 0 i pkv).

(* ------------------------------------------------------------------ *)
(* 以下为证明 helpers：关于 sum_mod256 和 sublist 的基本性质。           *)

Lemma sum_mod256_range (l: list Z) :
  0 <= sum_mod256 l <= 255.
Proof.
  induction l; simpl.
  - lia.
  - pose proof (Z.mod_pos_bound (a + sum_mod256 l) 256 ltac:(lia)).
    lia.
Qed.

Lemma sum_mod256_app (l1 l2: list Z) :
  sum_mod256 (l1 ++ l2) = (sum_mod256 l1 + sum_mod256 l2) mod 256.
Proof.
  induction l1; simpl.
  - replace (0 + sum_mod256 l2) with (sum_mod256 l2) by lia.
    pose proof (sum_mod256_range l2) as Hr.
    rewrite Z.mod_small by lia.
    reflexivity.
  - rewrite IHl1.
    assert (H1: (a + (sum_mod256 l1 + sum_mod256 l2) mod 256) mod 256 =
               (a + (sum_mod256 l1 + sum_mod256 l2)) mod 256).
    { apply Zplus_mod_idemp_r. }
    assert (H2: ((a + sum_mod256 l1) mod 256 + sum_mod256 l2) mod 256 =
               ((a + sum_mod256 l1) + sum_mod256 l2) mod 256).
    { apply Zplus_mod_idemp_l. }
    rewrite H1. rewrite H2.
    rewrite Z.add_assoc. reflexivity.
Qed.

Lemma sum_mod256_singleton (x: Z) :
  sum_mod256 (x :: nil) = x mod 256.
Proof.
  simpl. rewrite Z.add_0_r. reflexivity.
Qed.

Lemma sum_mod256_sublist_succ (l: list Z) (i: Z) :
  0 <= i < Zlength l ->
  sum_mod256 (sublist 0 (i + 1) l) =
    (sum_mod256 (sublist 0 i l) + Znth i l 0) mod 256.
Proof.
  intros Hi.
  assert (Hsub: sublist 0 (i + 1) l = sublist 0 i l ++ (Znth i l 0 :: nil)).
  { assert (H1: 0 <= 0 <= i) by lia.
    assert (H2: i <= i + 1 <= Zlength l) by lia.
    rewrite (sublist_split 0 (i + 1) i l H1 H2).
    rewrite (@sublist_single Z 0 i l) by lia.
    reflexivity. }
  rewrite Hsub.
  rewrite sum_mod256_app, sum_mod256_singleton.
  rewrite Zplus_mod_idemp_r.
  reflexivity.
Qed.

Lemma CheckCal08Inv_init (pkv: list Z) (len: Z) :
  0 <= len -> Zlength pkv = len -> CheckCal08Inv pkv len 0 0.
Proof.
  intros Hlen Hlen2.
  unfold CheckCal08Inv.
  split; [lia |].
  split; [auto |].
  simpl. reflexivity.
Qed.

Lemma CheckCal08Inv_step (pkv: list Z) (len: Z) (i: Z) (chksum: Z) :
  0 <= i < len ->
  CheckCal08Inv pkv len i chksum ->
  CheckCal08Inv pkv len (i + 1) ((chksum + Znth i pkv 0) mod 256).
Proof.
  intros Hi [Hib [Hlen Hsum]].
  unfold CheckCal08Inv.
  split; [lia |].
  split; [auto |].
  rewrite sum_mod256_sublist_succ by lia.
  rewrite Hsum.
  reflexivity.
Qed.

Lemma CheckCal08Inv_implies_post (pkv: list Z) (len: Z) (i: Z) (chksum: Z) :
  i = len ->
  CheckCal08Inv pkv len i chksum ->
  CheckCal08Post pkv len chksum.
Proof.
  intros Heq [Hib [Hlen Hsum]].
  unfold CheckCal08Post.
  split; [lia |].
  split; [auto |].
  subst. auto.
Qed.


