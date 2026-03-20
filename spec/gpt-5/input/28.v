Require Import Coq.Lists.List.
Require Import Coq.Strings.String.

Definition concatenate_spec (strings : list string) (res : string) : Prop :=
  res = fold_right String.append EmptyString strings.