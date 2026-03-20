Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.

Import ListNotations.

Local Open Scope string_scope.

Definition count_beats_spec (note : string) (b : nat) : Prop :=
(note = "o" /\ b = 4) \/ (note = "o|" /\ b = 2) \/ (note = ".|" /\ b = 1).

Fixpoint join_spaces (tokens : list string) : string :=
  match tokens with
  | [] => EmptyString
  | x :: xs =>
    match xs with
    | [] => x
    | _ => String.append x (String.append " " (join_spaces xs))
    end
  end.

Definition parse_music_spec (music_string : string) (beats : list nat) : Prop :=
  exists tokens : list string,
    join_spaces tokens = music_string /\ Forall2 count_beats_spec tokens beats.