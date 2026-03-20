
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.
Require Import Coq.Bool.Bool.

Definition is_vowel (ch : ascii) : bool :=
  Ascii.eqb ch "a"%char || Ascii.eqb ch "e"%char || Ascii.eqb ch "i"%char || Ascii.eqb ch "o"%char || Ascii.eqb ch "u"%char
  || Ascii.eqb ch "A"%char || Ascii.eqb ch "E"%char || Ascii.eqb ch "I"%char || Ascii.eqb ch "O"%char || Ascii.eqb ch "U"%char.

Fixpoint rev_string (s : string) : string :=
  match s with
  | String.EmptyString => String.EmptyString
  | String.String ch rest => String.append (rev_string rest) (String.String ch String.EmptyString)
  end.

Fixpoint count_consonants (w : string) : nat :=
  match w with
  | String.EmptyString => 0
  | String.String ch rest =>
      let cnt := count_consonants rest in
      if is_vowel ch then cnt else S cnt
  end.

Definition space_char : ascii := Ascii.ascii_of_nat 32.

Fixpoint split_spaces_nonempty_acc (s : string) (acc_rev : string) : list string :=
  match s with
  | String.EmptyString =>
      match acc_rev with
      | String.EmptyString => List.nil
      | _ => rev_string acc_rev :: List.nil
      end
  | String.String ch rest =>
      if Ascii.eqb ch space_char
      then match acc_rev with
           | String.EmptyString => split_spaces_nonempty_acc rest String.EmptyString
           | _ => List.app (rev_string acc_rev :: List.nil) (split_spaces_nonempty_acc rest String.EmptyString)
           end
      else split_spaces_nonempty_acc rest (String.String ch acc_rev)
  end.

Definition split_spaces_nonempty (s : string) : list string :=
  split_spaces_nonempty_acc s String.EmptyString.

Definition select_words_spec (s : string) (n : nat) (ans : list string) : Prop :=
  ans = List.filter (fun w : string => Nat.eqb (count_consonants w) n) (split_spaces_nonempty s).
