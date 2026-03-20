Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Arith.PeanoNat.
Require Import Coq.Bool.Bool.

Open Scope string_scope.

Fixpoint last_ascii (s : string) : option ascii :=
  match s with
  | EmptyString => None
  | String c EmptyString => Some c
  | String _ s' => last_ascii s'
  end.

Fixpoint second_last_ascii (s : string) : option ascii :=
  match s with
  | EmptyString => None
  | String _ EmptyString => None
  | String c (String _ EmptyString) => Some c
  | String _ s' => second_last_ascii s'
  end.

Definition is_alpha (c : ascii) : bool :=
  let n := Ascii.nat_of_ascii c in
  ((Nat.leb 65 n) && (Nat.leb n 90)) || ((Nat.leb 97 n) && (Nat.leb n 122)).

Definition is_space (c : ascii) : bool :=
  Nat.eqb (Ascii.nat_of_ascii c) 32.

Definition check_if_last_char_is_a_letter_spec (txt : string) (res : bool) : Prop :=
  res =
    match String.length txt with
    | 0 => false
    | S 0 =>
        match last_ascii txt with
        | Some c => is_alpha c
        | None => false
        end
    | _ =>
        match last_ascii txt, second_last_ascii txt with
        | Some c, Some p => andb (is_alpha c) (is_space p)
        | _, _ => false
        end
    end.