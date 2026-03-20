Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.

Local Open Scope char_scope.
Local Open Scope bool_scope.

Definition ascii_eqb (a b : ascii) : bool :=
  if ascii_dec a b then true else false.

Definition vowelb (c : ascii) : bool :=
  ascii_eqb c "a"%char || ascii_eqb c "e"%char || ascii_eqb c "i"%char || ascii_eqb c "o"%char || ascii_eqb c "u"%char ||
  ascii_eqb c "A"%char || ascii_eqb c "E"%char || ascii_eqb c "I"%char || ascii_eqb c "O"%char || ascii_eqb c "U"%char.

Definition yb (c : ascii) : bool :=
  ascii_eqb c "y"%char || ascii_eqb c "Y"%char.

Fixpoint count_vowels_excluding_y (s : string) : nat :=
  match s with
  | EmptyString => 0
  | String c s' => (if vowelb c then 1 else 0) + count_vowels_excluding_y s'
  end.

Fixpoint last_is_y (s : string) : bool :=
  match s with
  | EmptyString => false
  | String c EmptyString => yb c
  | String _ s' => last_is_y s'
  end.

Definition vowels_count_spec (s : string) (n : nat) : Prop :=
  n = count_vowels_excluding_y s + (if last_is_y s then 1 else 0).