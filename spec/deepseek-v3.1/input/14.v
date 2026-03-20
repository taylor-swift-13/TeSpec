
Require Import List.
Require Import String.
Import ListNotations.

Definition all_prefixes_spec (s : string) (prefixes : list string) : Prop :=
  prefixes = map (fun i => substring 0 (i + 1) s) (seq 0 (String.length s)).
