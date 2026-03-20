
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.

Open Scope string_scope.

Definition is_vowel (ch : ascii) : bool :=
  let vowels := ["a"; "e"; "i"; "o"; "u"; "A"; "E"; "I"; "O"; "U"]%char in
  existsb (fun v => Ascii.eqb ch v) vowels.

Definition is_consonant (ch : ascii) : bool :=
  negb (is_vowel ch).

Fixpoint string_to_list (s : string) : list ascii :=
  match s with
  | EmptyString => []
  | String c rest => c :: string_to_list rest
  end.

Definition string_length (s : string) : nat :=
  length (string_to_list s).

Definition nth_char (s : string) (n : nat) : option ascii :=
  nth_error (string_to_list s) n.

Definition valid_vowel_position (word : string) (i : nat) : Prop :=
  let chars := string_to_list word in
  let len := length chars in
  i > 0 /\ i < len - 1 /\
  exists ch_prev ch ch_next,
    nth_error chars (i - 1) = Some ch_prev /\
    nth_error chars i = Some ch /\
    nth_error chars (i + 1) = Some ch_next /\
    is_vowel ch = true /\
    is_consonant ch_prev = true /\
    is_consonant ch_next = true.

Definition no_valid_vowel_after (word : string) (i : nat) : Prop :=
  forall j, j > i -> j < string_length word - 1 -> ~ valid_vowel_position word j.

Definition get_closest_vowel_spec (word : string) (result : string) : Prop :=
  let len := string_length word in
  (len < 3 -> result = EmptyString) /\
  (len >= 3 ->
    (exists i ch,
      valid_vowel_position word i /\
      no_valid_vowel_after word i /\
      nth_char word i = Some ch /\
      result = String ch EmptyString) \/
    ((forall i, ~ valid_vowel_position word i) /\ result = EmptyString)).
