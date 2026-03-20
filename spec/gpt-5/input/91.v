
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.

Import ListNotations.

Local Open Scope string_scope.

Definition is_whitespace (a : ascii) : Prop :=
  let n := Ascii.nat_of_ascii a in
  n = 9 \/ n = 10 \/ n = 11 \/ n = 12 \/ n = 13 \/ n = 32.

Fixpoint all_whitespace (s : string) : Prop :=
  match s with
  | EmptyString => True
  | String a rest => is_whitespace a /\ all_whitespace rest
  end.

Definition begins_non_ws (s : string) : Prop :=
  match s with
  | EmptyString => False
  | String a _ => ~ is_whitespace a
  end.

Fixpoint ends_non_ws (s : string) : Prop :=
  match s with
  | EmptyString => False
  | String a rest =>
      match rest with
      | EmptyString => ~ is_whitespace a
      | _ => ends_non_ws rest
      end
  end.

Definition strip_rel (s t : string) : Prop :=
  exists l r,
    s = l ++ t ++ r /\
    all_whitespace l /\
    all_whitespace r /\
    (t = EmptyString \/ (begins_non_ws t /\ ends_non_ws t)).

Inductive replace_rel : string -> string -> Prop :=
| rr_empty : replace_rel EmptyString EmptyString
| rr_q r1 r2 (H : replace_rel r1 r2) :
    replace_rel (String (Ascii.ascii_of_nat 63) r1) (String (Ascii.ascii_of_nat 46) r2)
| rr_excl r1 r2 (H : replace_rel r1 r2) :
    replace_rel (String (Ascii.ascii_of_nat 33) r1) (String (Ascii.ascii_of_nat 46) r2)
| rr_other a r1 r2 (H : replace_rel r1 r2)
    (Hneq_q : Ascii.nat_of_ascii a <> 63)
    (Hneq_excl : Ascii.nat_of_ascii a <> 33) :
    replace_rel (String a r1) (String a r2).

Fixpoint no_dot (s : string) : Prop :=
  match s with
  | EmptyString => True
  | String a rest => Ascii.nat_of_ascii a <> 46 /\ no_dot rest
  end.

Definition dot_str : string := String (Ascii.ascii_of_nat 46) EmptyString.

Fixpoint intercalate_dot (parts : list string) : string :=
  match parts with
  | nil => EmptyString
  | cons p nil => p
  | cons p ps => p ++ dot_str ++ intercalate_dot ps
  end.

Definition split_on_dot (parts : list string) (s : string) : Prop :=
  s = intercalate_dot parts /\ Forall no_dot parts.

Definition boredom_on_part (p : string) : Prop :=
  exists t rest, strip_rel p t /\ t = "I " ++ rest.

Fixpoint count_sat (parts : list string) (n : nat) : Prop :=
  match parts with
  | nil => n = 0
  | cons h t =>
      (boredom_on_part h /\ exists m, count_sat t m /\ n = S m) \/
      (~ boredom_on_part h /\ count_sat t n)
  end.

Definition is_bored_spec (S : string) (count : nat) : Prop :=
  exists S1 parts,
    replace_rel S S1 /\
    split_on_dot parts S1 /\
    count_sat parts count.
