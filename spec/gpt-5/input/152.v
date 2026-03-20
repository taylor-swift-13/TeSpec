Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.

Definition compare_spec (game guess out : list Z) : Prop :=
  List.length game = List.length guess /\
  out = List.map (fun p => match p with (a, b) => Z.abs (Z.sub a b) end) (List.combine game guess).