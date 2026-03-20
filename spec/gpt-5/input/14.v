Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
Require Import Coq.Arith.PeanoNat.

Definition all_prefixes_spec (s : string) (res : list string) : Prop :=
List.length res = String.length s /\
forall i, i < String.length s ->
  nth_error res i = Some (String.substring 0 (S i) s).