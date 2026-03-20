
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.

Definition is_lowercase (c : ascii) : bool :=
  let n := nat_of_ascii c in
  andb (97 <=? n) (n <=? 122).

Definition rotate_char (c : ascii) : ascii :=
  if is_lowercase c then
    let n := nat_of_ascii c in
    let shifted := (n - 97 + 4) mod 26 + 97 in
    ascii_of_nat shifted
  else
    c.

Fixpoint encrypt_aux (s : list ascii) : list ascii :=
  match s with
  | [] => []
  | c :: rest => rotate_char c :: encrypt_aux rest
  end.

Definition string_to_list (s : string) : list ascii :=
  list_ascii_of_string s.

Definition list_to_string (l : list ascii) : string :=
  string_of_list_ascii l.

Definition encrypt_spec (s : string) (result : string) : Prop :=
  result = list_to_string (encrypt_aux (string_to_list s)).
