
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.

Import ListNotations.

Definition char := Ascii.ascii.

Fixpoint rev_list {A : Type} (l : list A) : list A :=
  match l with
  | [] => []
  | x :: xs => rev_list xs ++ [x]
  end.

Definition string_to_list (s : string) : list char :=
  list_ascii_of_string s.

Definition list_to_string (l : list char) : string :=
  string_of_list_ascii l.

Definition is_palindrome_list (l : list char) : bool :=
  if list_eq_dec Ascii.ascii_dec l (rev_list l) then true else false.

Definition is_palindrome (s : string) : bool :=
  is_palindrome_list (string_to_list s).

Definition is_palindrome_spec (s : string) : Prop :=
  string_to_list s = rev_list (string_to_list s).

Definition suffix (l : list char) (i : nat) : list char :=
  skipn i l.

Definition prefix (l : list char) (i : nat) : list char :=
  firstn i l.

Definition make_palindrome_spec (s : string) (result : string) : Prop :=
  let l := string_to_list s in
  let r := string_to_list result in
  (is_palindrome_spec s -> r = l) /\
  (~is_palindrome_spec s -> 
    exists i : nat, 
      i < length l /\
      (forall j : nat, j < i -> ~(suffix l j = rev_list (suffix l j))) /\
      suffix l i = rev_list (suffix l i) /\
      r = l ++ rev_list (prefix l i)) /\
  is_palindrome_spec result /\
  prefix (string_to_list result) (length l) = l /\
  (forall result' : string,
    let r' := string_to_list result' in
    is_palindrome_spec result' ->
    prefix r' (length l) = l ->
    length r <= length r').
