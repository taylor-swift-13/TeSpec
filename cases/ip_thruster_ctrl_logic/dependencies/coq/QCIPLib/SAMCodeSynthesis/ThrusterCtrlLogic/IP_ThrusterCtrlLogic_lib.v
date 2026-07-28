(* ============================================================
 * ThrusterCtrlLogic 的 Rocq spec
 *
 * C 函数 ThrusterCtrlLogicFun 根据 6 个输入标志：
 *   Yp[0..2], Yn[0..2]
 * 计算 12 个推力器脉冲输出 wPulse[0..11]：
 *   - 先把所有 wPulse[i] 清零
 *   - 若 Yp[i] != 0，则 wPulse[4i] = wPulse[4i+1] = 1
 *   - 若 Yn[i] != 0，则 wPulse[4i+2] = wPulse[4i+3] = 1
 * ============================================================ *)

Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
From AUXLib Require Import ListLib.

Import ListNotations.
Local Open Scope Z_scope.

(* 由单个标志得到 0/1 输出。 *)
Definition bit_of_flag (flag: Z) : Z :=
  if Z.eqb flag 0 then 0 else 1.

(* 由 Yp、Yn 两个长度为 3 的列表构造 12 位 wPulse 输出。 *)
Definition thruster_wPulse (yp yn: list Z) : list Z :=
  [bit_of_flag (Znth 0 yp 0); bit_of_flag (Znth 0 yp 0);
   bit_of_flag (Znth 0 yn 0); bit_of_flag (Znth 0 yn 0);
   bit_of_flag (Znth 1 yp 0); bit_of_flag (Znth 1 yp 0);
   bit_of_flag (Znth 1 yn 0); bit_of_flag (Znth 1 yn 0);
   bit_of_flag (Znth 2 yp 0); bit_of_flag (Znth 2 yp 0);
   bit_of_flag (Znth 2 yn 0); bit_of_flag (Znth 2 yn 0)].

(* 后置条件：输入列表长度均为 3，且 wPulse 等于 thruster_wPulse yp yn。 *)
Definition ThrusterCtrlLogicPost (yp yn wPulse: list Z) : Prop :=
  Zlength yp = 3 /\
  Zlength yn = 3 /\
  wPulse = thruster_wPulse yp yn.
