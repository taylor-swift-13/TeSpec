
Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Import ListNotations.

Definition all_prefixes_spec (s : string) (res : list string) : Prop :=
  res = map (fun i => substring 0 (S i) s) (seq 0 (String.length s)).
