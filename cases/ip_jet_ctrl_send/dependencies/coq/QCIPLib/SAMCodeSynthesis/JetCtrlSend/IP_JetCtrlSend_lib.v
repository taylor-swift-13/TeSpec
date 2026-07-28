(* ============================================================
 * JetCtrlSend 的 Rocq spec
 *
 * C 函数 JetCtrlSendFun 根据 12 路推力器脉冲输入 pulse[0..11]，
 * 计算软件喷气字节 wPulse 并组帧发送：
 *   - 第 k 对 (pulse[2k], pulse[2k+1])（k = 0..5）中任意一路等于 1，
 *     则 wPulse 置位 (0x04 << k)；
 *   - 发送帧为 [0xEB, 0x93, wPulse]，经 UartSend 发出。
 *
 * 本文件定义 annotation 中用到的数学对象：
 *   - jet_step         : 单对脉冲信号的置位（对应 helper 函数
 *                        JetCtrlSendPairStep 的函数体行为）
 *   - pack_wPulse      : 12 路 pulse 打包出的 wPulse 字节
 *   - JetCtrlSendPost  : 函数后置条件（发送帧内容 == [0xEB, 0x93, wPulse]）
 *   - UartSendRecord   : UartSend 调用记录（外部驱动占位谓词）
 * ============================================================ *)

Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.Bool.Bool.
Require Import Coq.micromega.Lia.
From AUXLib Require Import ListLib.
From SimpleC.SL Require Import IntLib.

Import ListNotations.
Local Open Scope Z_scope.

(* 单对脉冲信号的置位：p0 或 p1 等于 1 时返回 Z.lor w mask，否则返回 w。
 * 与验证用 C 中 JetCtrlSendPairStep 的函数体一一对应。 *)
Definition jet_step (p0 p1 w mask : Z) : Z :=
  if (p0 =? 1) || (p1 =? 1) then Z.lor w mask else w.

(* 12 路 pulse 打包出的 wPulse 字节。
 * 定义形状与 C 中 6 次 JetCtrlSendPairStep 调用的嵌套顺序一致：
 * 第 1 对置 0x04，结果依次送入下一对，直到第 6 对置 0x80。 *)
Definition pack_wPulse (pulse : list Z) : Z :=
  jet_step (Znth 10 pulse 0) (Znth 11 pulse 0)
    (jet_step (Znth 8 pulse 0) (Znth 9 pulse 0)
      (jet_step (Znth 6 pulse 0) (Znth 7 pulse 0)
        (jet_step (Znth 4 pulse 0) (Znth 5 pulse 0)
          (jet_step (Znth 2 pulse 0) (Znth 3 pulse 0)
            (jet_step (Znth 0 pulse 0) (Znth 1 pulse 0) 0 4)
            8)
          16)
        32)
      64)
    128.

(* 后置条件：交给 UartSend 的字节序列正好是帧头 0xEB 0x93 加打包字节。
 * （0xEB = 235，0x93 = 147。） *)
Definition JetCtrlSendPost (pulse sent : list Z) : Prop :=
  sent = [235; 147; pack_wPulse pulse].

(* UartSend 发送记录：占位谓词，表示"uartno 口发出了字节序列 l"这一事件。
 * 当前对底层驱动不假设更多语义，故定义为 True；
 * 发送内容的具体性质由 JetCtrlSendPost 与缓冲区断言共同刻画。 *)
Definition UartSendRecord (uartno : Z) (l : list Z) : Prop := True.

(* ------------------------------------------------------------------ *)
(* 证明 helpers                                                       *)

(* 长度为 3 的列表连续 replace_Znth 0/1/2 后等于显式三元素列表。 *)
Lemma replace3 : forall (l : list Z) (a b c : Z),
  Zlength l = 3 ->
  replace_Znth 2 c (replace_Znth 1 b (replace_Znth 0 a l)) = [a; b; c].
Proof.
  intros l a b c Hlen.
  rewrite Zlength_correct in Hlen.
  destruct l as [| x [| y [| z [| w l']]]]; simpl in Hlen; try lia.
  unfold replace_Znth. simpl. reflexivity.
Qed.

(* 两个字节的按位或仍是字节。
 * 证明经由 IntLib 的 unsigned_last_nbits_lor_distr：
 *   (Z.lor w m) mod 256 = Z.lor (w mod 256) (m mod 256) = Z.lor w m。 *)
Lemma lor_byte_bound : forall (w m : Z),
  0 <= w < 256 -> 0 <= m < 256 -> 0 <= Z.lor w m < 256.
Proof.
  intros w m Hw Hm.
  pose proof (unsigned_last_nbits_lor_distr w m 8 ltac:(lia)) as Hd.
  unfold unsigned_last_nbits in Hd.
  rewrite (Z.mod_small w (2 ^ 8)) in Hd by lia.
  rewrite (Z.mod_small m (2 ^ 8)) in Hd by lia.
  rewrite <- Hd.
  apply Z.mod_pos_bound. lia.
Qed.

(* jet_step 保持字节范围：结果仍在 [0, 256)。 *)
Lemma jet_step_byte_bound : forall (p q w m : Z),
  0 <= w < 256 -> 0 <= m < 256 -> 0 <= jet_step p q w m < 256.
Proof.
  intros p q w m Hw Hm.
  unfold jet_step.
  destruct ((p =? 1) || (q =? 1))%bool.
  - apply lor_byte_bound; assumption.
  - assumption.
Qed.
