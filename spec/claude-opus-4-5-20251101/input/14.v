
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.

Import ListNotations.

Fixpoint substring (s : string) (start len : nat) : string :=
  match start, s with
  | 0, _ => match len with
            | 0 => EmptyString
            | S len' => match s with
                        | EmptyString => EmptyString
                        | String c s' => String c (substring s' 0 len')
                        end
            end
  | S start', String _ s' => substring s' start' len
  | S _, EmptyString => EmptyString
  end.

Definition prefix (s : string) (len : nat) : string :=
  substring s 0 len.

Fixpoint all_prefixes_helper (s : string) (n : nat) : list string :=
  match n with
  | 0 => []
  | S n' => all_prefixes_helper s n' ++ [prefix s n]
  end.

Definition all_prefixes_spec (s : string) (result : list string) : Prop :=
  let len := String.length s in
  result = all_prefixes_helper s len /\
  length result = len /\
  (forall i, i < len -> nth i result EmptyString = prefix s (i + 1)).
