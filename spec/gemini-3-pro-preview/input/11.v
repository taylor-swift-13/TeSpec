
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Bool.Bool.
Import ListNotations.

Local Open Scope char_scope.

Definition char_to_bool (c : ascii) : bool :=
  if ascii_dec c "1" then true else false.

Definition bool_to_char (b : bool) : ascii :=
  if b then "1" else "0".

Definition xor_ascii (c1 c2 : ascii) : ascii :=
  bool_to_char (xorb (char_to_bool c1) (char_to_bool c2)).

Definition string_xor_spec (a b result : string) : Prop :=
  let la := list_ascii_of_string a in
  let lb := list_ascii_of_string b in
  let lr := list_ascii_of_string result in
  length lr = length la /\
  forall i, (i < length la)%nat ->
    nth i lr "0" = xor_ascii (nth i la "0") (nth i lb "0").
