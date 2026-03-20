
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.
Import ListNotations.
Open Scope string_scope.

Definition note_to_beats (s : string) : option nat :=
  if string_dec s "o" then Some 4
  else if string_dec s "o|" then Some 2
  else if string_dec s ".|" then Some 1
  else None.

Fixpoint join (sep : string) (l : list string) : string :=
  match l with
  | [] => ""
  | [x] => x
  | x :: xs => x ++ sep ++ (join sep xs)
  end.

Definition parse_music_spec (music_string : string) (result : list nat) : Prop :=
  (music_string = "" /\ result = []) \/
  (music_string <> "" /\
   exists notes : list string,
     join " " notes = music_string /\
     Forall2 (fun note beats => note_to_beats note = Some beats) notes result).
