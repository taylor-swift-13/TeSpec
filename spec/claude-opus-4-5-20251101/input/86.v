
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Strings.Ascii.
Require Import Coq.Arith.Arith.
Import ListNotations.

Definition char_to_nat (c : ascii) : nat := nat_of_ascii c.

Definition sorted_by_ascii (l : list ascii) : list ascii :=
  let fix insert (c : ascii) (sorted : list ascii) : list ascii :=
    match sorted with
    | [] => [c]
    | h :: t => if Nat.leb (char_to_nat c) (char_to_nat h)
                then c :: sorted
                else h :: insert c t
    end
  in
  fold_right insert [] l.

Definition is_sorted_by_ascii (l : list ascii) : Prop :=
  forall i j, i < j -> j < length l ->
    char_to_nat (nth i l zero) <= char_to_nat (nth j l zero).

Definition is_permutation (l1 l2 : list ascii) : Prop :=
  forall c : ascii, count_occ ascii_dec l1 c = count_occ ascii_dec l2 c.

Definition string_to_list (s : string) : list ascii :=
  list_ascii_of_string s.

Definition list_to_string (l : list ascii) : string :=
  string_of_list_ascii l.

Fixpoint split_by_space (s : string) : list string :=
  match s with
  | EmptyString => [EmptyString]
  | String c rest =>
    if (nat_of_ascii c =? 32)%nat then
      EmptyString :: split_by_space rest
    else
      match split_by_space rest with
      | [] => [String c EmptyString]
      | h :: t => (String c h) :: t
      end
  end.

Fixpoint join_with_space (words : list string) : string :=
  match words with
  | [] => EmptyString
  | [w] => w
  | w :: rest => append w (String " "%char (join_with_space rest))
  end.

Definition sort_word (w : string) : string :=
  list_to_string (sorted_by_ascii (string_to_list w)).

Definition anti_shuffle_spec (s : string) (result : string) : Prop :=
  let input_words := split_by_space s in
  let output_words := split_by_space result in
  length input_words = length output_words /\
  (forall i, i < length input_words ->
    let in_word := nth i input_words EmptyString in
    let out_word := nth i output_words EmptyString in
    is_permutation (string_to_list in_word) (string_to_list out_word) /\
    is_sorted_by_ascii (string_to_list out_word)) /\
  result = join_with_space (map sort_word input_words).
