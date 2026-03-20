
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Arith.Div2.
Require Import Coq.Init.Nat.

Import ListNotations.

Definition sum_list (l : list nat) : nat :=
  fold_left Nat.add l 0.

Definition ceil_div (n d : nat) : nat :=
  (n + d - 1) / d.

Definition max_fill_spec (grid : list (list nat)) (capacity : nat) (ans : nat) : Prop :=
  (forall row, In row grid -> 
     forall x, In x row -> (x = 0 \/ x = 1)) /\
  capacity >= 1 /\ capacity <= 10 /\
  (length grid >= 1 /\ length grid <= 100) /\
  (forall r1 r2, In r1 grid -> In r2 grid -> length r1 = length r2) /\
  (forall row, In row grid -> length row >= 1 /\ length row <= 100) /\
  ans = fold_left (fun acc row => acc + ceil_div (sum_list row) capacity) grid 0.
