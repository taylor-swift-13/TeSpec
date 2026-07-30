Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Definition Four {A : Type} (xs : list A) : Prop :=
  length xs = 4%nat.

Definition RotateTwo {A : Type} (before after : list A) : Prop :=
  exists a b c d,
    before = [a; b; c; d] /\
    after = [c; d; a; b].

Definition ReturnHeadTail (values : list Z) (ret : Z) : Prop :=
  exists head middle1 middle2 tail,
    values = [head; middle1; middle2; tail] /\
    ret = head + tail.

Definition HeadLeTail (values : list Z) : Prop :=
  exists head middle1 middle2 tail,
    values = [head; middle1; middle2; tail] /\
    head <= tail.
