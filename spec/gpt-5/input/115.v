Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Init.Nat.

Definition sum_list (l : list nat) : nat := fold_right Nat.add 0 l.

Definition divceil (n c : nat) : nat := Nat.div (n + c - 1) c.

Definition max_fill_spec (grid : list (list nat)) (capacity : nat) (ans : nat) : Prop :=
  ans = fold_right (fun l acc => acc + divceil (sum_list l) capacity) 0 grid.