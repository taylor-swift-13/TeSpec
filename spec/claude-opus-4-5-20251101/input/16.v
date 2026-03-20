
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Sets.Ensembles.
Require Import Coq.Arith.Arith.

Import ListNotations.

Definition to_lower (c : ascii) : ascii :=
  let n := nat_of_ascii c in
  if (andb (65 <=? n) (n <=? 90))
  then ascii_of_nat (n + 32)
  else c.

Fixpoint string_to_list (s : string) : list ascii :=
  match s with
  | EmptyString => []
  | String c rest => c :: string_to_list rest
  end.

Fixpoint list_to_lower (l : list ascii) : list ascii :=
  match l with
  | [] => []
  | c :: rest => to_lower c :: list_to_lower rest
  end.

Fixpoint mem_ascii (c : ascii) (l : list ascii) : bool :=
  match l with
  | [] => false
  | x :: rest => if Ascii.eqb c x then true else mem_ascii c rest
  end.

Fixpoint distinct (l : list ascii) : list ascii :=
  match l with
  | [] => []
  | c :: rest => if mem_ascii c rest then distinct rest else c :: distinct rest
  end.

Definition count_distinct_characters_spec (s : string) (count : nat) : Prop :=
  count = length (distinct (list_to_lower (string_to_list s))).
