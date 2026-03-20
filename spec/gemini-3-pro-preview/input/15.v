
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.

Parameter nat_to_string : nat -> string.

Definition string_sequence_spec (n : nat) (result : string) : Prop :=
  result = String.concat " " (map nat_to_string (seq 0 (S n))).
