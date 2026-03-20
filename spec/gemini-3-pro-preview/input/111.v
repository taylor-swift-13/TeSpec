
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.
Import ListNotations.
Open Scope string_scope.
Open Scope list_scope.

Fixpoint split_aux (s : string) (acc : string) : list string :=
  match s with
  | EmptyString => if string_dec acc "" then [] else [acc]
  | String c s' =>
    if Ascii.eqb c " "
    then (if string_dec acc "" then [] else [acc]) ++ split_aux s' ""
    else split_aux s' (acc ++ String c EmptyString)
  end.

Definition split_spaces (s : string) : list string := 
  split_aux s "".

Definition count_occurrences (target : string) (l : list string) : nat :=
  length (filter (fun s => if string_dec s target then true else false) l).

Definition get_max_count (l : list string) : nat :=
  fold_right (fun s acc => max (count_occurrences s l) acc) 0 l.

Fixpoint lookup (k : string) (l : list (string * nat)) : option nat :=
  match l with
  | [] => None
  | (k', v) :: t => if string_dec k k' then Some v else lookup k t
  end.

Definition histogram_spec (test : string) (result : list (string * nat)) : Prop :=
  let words := split_spaces test in
  let mx := get_max_count words in
  (words = [] -> result = []) /\
  (words <> [] ->
    NoDup (map fst result) /\
    (forall k v, lookup k result = Some v -> v = mx /\ count_occurrences k words = mx) /\
    (forall k, In k words -> count_occurrences k words = mx -> lookup k result = Some mx)).
