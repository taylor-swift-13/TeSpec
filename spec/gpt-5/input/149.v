Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Sorting.Sorted.
Require Import Coq.Arith.Arith.

Import ListNotations.

Fixpoint count (x : string) (l : list string) : nat :=
  match l with
  | [] => 0
  | y :: ys => if string_dec x y then S (count x ys) else count x ys
  end.

Definition ascii_lt (a b : ascii) : Prop :=
  nat_of_ascii a < nat_of_ascii b.

Fixpoint string_lex_lt (s t : string) : Prop :=
  match s, t with
  | EmptyString, EmptyString => False
  | EmptyString, String _ _ => True
  | String _ _, EmptyString => False
  | String a s', String b t' =>
      ascii_lt a b \/ (a = b /\ string_lex_lt s' t')
  end.

Definition string_lex_le (s t : string) : Prop :=
  s = t \/ string_lex_lt s t.

Definition even_length (s : string) : Prop :=
  exists k : nat, String.length s = 2 * k.

Definition orderR (s t : string) : Prop :=
  String.length s < String.length t \/
  (String.length s = String.length t /\ string_lex_le s t).

Definition sorted_list_sum_spec (lst res : list string) : Prop :=
  (forall s : string, even_length s -> count s res = count s lst) /\
  (forall s : string, ~ even_length s -> count s res = 0) /\
  Sorted orderR res.