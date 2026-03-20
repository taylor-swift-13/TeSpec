
Require Import Coq.Strings.Ascii.
Require Import Coq.Strings.String.
Require Import Coq.Arith.Arith.
Require Import Coq.Init.Nat.

Fixpoint nth_char (n : nat) (s : string) : option ascii :=
  match s, n with
  | EmptyString, _ => None
  | String a s', 0 => Some a
  | String _ s', S n' => nth_char n' s'
  end.

Definition is_vowel (c : ascii) : Prop :=
  c = ascii_of_nat 97 \/
  c = ascii_of_nat 101 \/
  c = ascii_of_nat 105 \/
  c = ascii_of_nat 111 \/
  c = ascii_of_nat 117 \/
  c = ascii_of_nat 65 \/
  c = ascii_of_nat 69 \/
  c = ascii_of_nat 73 \/
  c = ascii_of_nat 79 \/
  c = ascii_of_nat 85.

Definition between_consonants (w : string) (i : nat) (ch : ascii) : Prop :=
  nth_char i w = Some ch /\
  is_vowel ch /\
  (exists a, nth_char (Nat.pred i) w = Some a /\ ~ is_vowel a) /\
  (exists c, nth_char (S i) w = Some c /\ ~ is_vowel c).

Definition get_closest_vowel_spec (word res : string) : Prop :=
  (exists i ch,
      between_consonants word i ch /\
      (forall j, i < j -> forall cj, ~ between_consonants word j cj) /\
      res = String ch EmptyString)
  \/
  ((forall i ch, ~ between_consonants word i ch) /\ res = EmptyString).
