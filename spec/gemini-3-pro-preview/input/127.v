
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Require Import Coq.ZArith.Znumtheory.

Open Scope Z_scope.
Open Scope string_scope.

Definition intersection_spec (interval1 interval2 : Z * Z) (result : string) : Prop :=
  let (s1, e1) := interval1 in
  let (s2, e2) := interval2 in
  let inter_l := Z.max s1 s2 in
  let inter_r := Z.min e1 e2 in
  let len := inter_r - inter_l in
  (prime len -> result = "YES") /\
  (~ prime len -> result = "NO").
