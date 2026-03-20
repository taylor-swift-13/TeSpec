
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.

Definition concatenate_spec (strings : list string) (result : string) : Prop :=
  result = String.concat "" strings.
