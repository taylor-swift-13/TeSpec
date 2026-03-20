
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.
Import ListNotations.

Definition string_length (s : string) : nat := String.length s.

Definition max_length (strings : list string) : nat :=
  fold_right (fun s acc => Nat.max (string_length s) acc) 0 strings.

Fixpoint find_first_with_length (strings : list string) (len : nat) : option string :=
  match strings with
  | [] => None
  | s :: rest => if Nat.eqb (string_length s) len then Some s
                 else find_first_with_length rest len
  end.

Definition longest_spec (strings : list string) (result : option string) : Prop :=
  match strings with
  | [] => result = None
  | _ => 
    let maxlen := max_length strings in
    exists s, result = Some s /\
              In s strings /\
              string_length s = maxlen /\
              forall s', In s' strings -> string_length s' <= maxlen /\
              (forall s'' idx1 idx2, 
                In s'' strings -> 
                string_length s'' = maxlen ->
                nth_error strings idx1 = Some s ->
                nth_error strings idx2 = Some s'' ->
                idx1 <= idx2)
  end.
