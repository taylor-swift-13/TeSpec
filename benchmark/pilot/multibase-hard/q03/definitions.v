Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Open Scope Z_scope.

Definition elem (i : nat) (l : list Z) : Z := nth i l 0.

Definition CandidateSFExact
  (x c pid : list Z) (ang dang prd : Z)
  (n : list Z) (ret : Z) : Prop :=
  let kp := elem 0 pid in
  let ki := elem 1 pid in
  let kd := elem 2 pid in
  let nx0 := elem 0 c * elem 0 x + elem 1 c * kp * ang in
  let y1 := nx0 + elem 2 c * kp * ang in
  let u2 := y1 + kd * dang in
  let y2 := elem 1 x + elem 7 c * u2 in
  let nx1 := elem 2 x + elem 5 c * u2 in
  let nx2 := elem 3 c * elem 1 x + elem 4 c * elem 2 x + elem 6 c * u2 in
  let y3 := elem 3 x + elem 12 c * y2 in
  let nx3 := elem 4 x + elem 10 c * y2 in
  let nx4 := elem 8 c * elem 3 x + elem 9 c * elem 4 x + elem 11 c * y2 in
  let y4 := elem 5 x + elem 17 c * y3 in
  let nx5 := elem 6 x + elem 15 c * y3 in
  let nx6 := elem 13 c * elem 5 x + elem 14 c * elem 6 x + elem 16 c * y3 in
  let nx7 := elem 7 x + prd * ki * ang in
  length n = 8%nat /\
  elem 0 n = nx0 /\ elem 1 n = nx1 /\ elem 2 n = nx2 /\
  elem 3 n = nx3 /\ elem 4 n = nx4 /\ elem 5 n = nx5 /\
  elem 6 n = nx6 /\ elem 7 n = nx7 /\ ret = y4.
