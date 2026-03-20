
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.

Fixpoint nat_to_string (n : nat) : string :=
  match n with
  | 0 => "0"
  | 1 => "1"
  | 2 => "2"
  | 3 => "3"
  | 4 => "4"
  | 5 => "5"
  | 6 => "6"
  | 7 => "7"
  | 8 => "8"
  | 9 => "9"
  | _ => "?"
  end.

Fixpoint range (n : nat) : list nat :=
  match n with
  | 0 => []
  | S m => range m ++ [m]
  end.

Definition range_inclusive (n : nat) : list nat :=
  range (S n).

Fixpoint join_with_space (l : list string) : string :=
  match l with
  | [] => ""
  | [x] => x
  | x :: xs => (x ++ " " ++ join_with_space xs)%string
  end.

Definition string_sequence_spec (n : nat) (result : string) : Prop :=
  result = join_with_space (map nat_to_string (range_inclusive n)).
