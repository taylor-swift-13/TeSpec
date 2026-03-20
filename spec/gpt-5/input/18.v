
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.

Local Open Scope string_scope.

Fixpoint drop (n : nat) (s : string) : string :=
  match n, s with
  | 0, _ => s
  | S n', EmptyString => EmptyString
  | S n', String _ s' => drop n' s'
  end.

Fixpoint is_prefixb (t u : string) : bool :=
  match t, u with
  | EmptyString, _ => true
  | String ct rt, String cu ru =>
      if ascii_dec ct cu then is_prefixb rt ru else false
  | String _ _, EmptyString => false
  end.

Definition how_many_times_spec (s substring : string) (res : nat) : Prop :=
  res = List.length (List.filter (fun i => is_prefixb substring (drop i s))
                                 (List.seq 0 (String.length s))).
