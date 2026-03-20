
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.

Open Scope string_scope.

Definition is_vowel (ch : ascii) : bool :=
  let c := nat_of_ascii ch in
  match c with
  | 97 => true   (* a *)
  | 101 => true  (* e *)
  | 105 => true  (* i *)
  | 111 => true  (* o *)
  | 117 => true  (* u *)
  | 65 => true   (* A *)
  | 69 => true   (* E *)
  | 73 => true   (* I *)
  | 79 => true   (* O *)
  | 85 => true   (* U *)
  | _ => false
  end.

Definition is_y (ch : ascii) : bool :=
  let c := nat_of_ascii ch in
  match c with
  | 121 => true  (* y *)
  | 89 => true   (* Y *)
  | _ => false
  end.

Fixpoint string_to_list (s : string) : list ascii :=
  match s with
  | EmptyString => []
  | String c rest => c :: string_to_list rest
  end.

Fixpoint count_vowels_in_list (l : list ascii) : nat :=
  match l with
  | [] => 0
  | c :: rest => (if is_vowel c then 1 else 0) + count_vowels_in_list rest
  end.

Definition last_char (s : string) : option ascii :=
  match string_to_list s with
  | [] => None
  | l => Some (last l "000"%char)
  end.

Definition ends_with_y (s : string) : bool :=
  match last_char s with
  | None => false
  | Some c => is_y c
  end.

Definition vowels_count_spec (s : string) (result : nat) : Prop :=
  let base_count := count_vowels_in_list (string_to_list s) in
  let y_bonus := if ends_with_y s then 1 else 0 in
  result = base_count + y_bonus.
