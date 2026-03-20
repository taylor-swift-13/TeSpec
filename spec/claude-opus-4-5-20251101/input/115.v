
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.QArith.QArith.
Require Import Coq.QArith.Qround.

Open Scope Z_scope.

Definition sum_list (l : list Z) : Z :=
  fold_right Z.add 0 l.

Definition ceil_div (a b : Z) : Z :=
  (a + b - 1) / b.

Definition max_fill_spec (grid : list (list Z)) (capacity : Z) (result : Z) : Prop :=
  capacity > 0 /\
  (forall row, In row grid -> forall x, In x row -> x = 0 \/ x = 1) /\
  result = fold_right (fun row acc => acc + ceil_div (sum_list row) capacity) 0 grid.
