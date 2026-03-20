Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Structures.OrderedTypeEx.

Fixpoint chars_of_string (s : string) : list ascii :=
  match s with
  | EmptyString => nil
  | String a s' => a :: chars_of_string s'
  end.

Definition unique_char_count (s : string) (n : nat) : Prop :=
  exists l : list ascii,
    NoDup l /\
    (forall a : ascii, In a l <-> In a (chars_of_string s)) /\
    length l = n.

Definition find_max_spec (words : list string) (ans : string) : Prop :=
  match words with
  | nil => ans = EmptyString
  | _ =>
    In ans words /\
    exists n : nat,
      unique_char_count ans n /\
      (forall w n', In w words -> unique_char_count w n' -> n' <= n) /\
      (forall w, In w words -> unique_char_count w n -> ~ String_as_OT.lt w ans)
  end.