Require Import Coq.Reals.Reals.
Require Import Coq.Reals.R_sqrt.
Require Import Coq.ZArith.ZArith.
Require Import Coq.ZArith.Znumtheory.

Open Scope R_scope.

Definition triangle_area_spec (a b c area : R) : Prop :=
((a + b <= c \/ a + c <= b \/ b + c <= a) /\ area = -1) \/
(~(a + b <= c \/ a + c <= b \/ b + c <= a) /\
 let p := (a + b + c) / 2 in
 let x := sqrt (p * (p - a) * (p - b) * (p - c)) in
 exists k : Z,
   area = IZR k / 100 /\
   forall n : Z,
     Rabs (x * 100 - IZR k) <= Rabs (x * 100 - IZR n) /\
     (n <> k -> Rabs (x * 100 - IZR k) = Rabs (x * 100 - IZR n) -> Zeven k)).