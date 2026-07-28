Require Import Coq.ZArith.ZArith.

Local Open Scope Z_scope.

Definition WheelFricComp (kf cut vf0 : Z) : Z := 0.

Definition TRUE32_VAL : Z := 3952088175.

(* Per-wheel post-condition *)
Definition WheelFricPost1 (fv kf cut vf0 vf_new : Z) : Prop :=
  (fv = TRUE32_VAL -> vf_new = WheelFricComp kf cut vf0) /\
  (fv <> TRUE32_VAL -> vf_new = 0).

(* Combined 4-wheel post-condition *)
Definition WheelFricPost
    (fv0 fv1 fv2 fv3 : Z)
    (kf0 kf1 kf2 kf3 : Z)
    (cut0 cut1 cut2 cut3 : Z)
    (vf00 vf01 vf02 vf03 : Z)
    (vf0' vf1' vf2' vf3' : Z) : Prop :=
  WheelFricPost1 fv0 kf0 cut0 vf00 vf0' /\
  WheelFricPost1 fv1 kf1 cut1 vf01 vf1' /\
  WheelFricPost1 fv2 kf2 cut2 vf02 vf2' /\
  WheelFricPost1 fv3 kf3 cut3 vf03 vf3'.
