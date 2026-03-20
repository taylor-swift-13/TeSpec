
Require Import List.
Import ListNotations.
Require Import String.
Open Scope string_scope.
Require Import Nat.

Fixpoint total_length (lst : list string) : nat :=
  match lst with
  | [] => 0
  | s :: rest => String.length s + total_length rest
  end.

Definition total_match_spec (lst1 lst2 result : list string) : Prop :=
  let c1 := total_length lst1 in
  let c2 := total_length lst2 in
  (if Nat.leb c1 c2 then result = lst1 else result = lst2).
