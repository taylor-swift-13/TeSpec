
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Sorted.
Import ListNotations.
Open Scope Z_scope.

Definition collatz_next (n : Z) : Z :=
  if Z.even n then n / 2 else 3 * n + 1.

Inductive CollatzSeq (start : Z) : Z -> Prop :=
| Collatz_Base : CollatzSeq start start
| Collatz_Step : forall x, start <> 1 -> CollatzSeq (collatz_next start) x -> CollatzSeq start x.

Definition get_odd_collatz_spec (n : Z) (l : list Z) : Prop :=
  Sorted Z.le l /\
  (forall x, In x l <-> (CollatzSeq n x /\ Z.odd x)).
