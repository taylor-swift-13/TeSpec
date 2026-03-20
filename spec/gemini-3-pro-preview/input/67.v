
Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Import ListNotations.
Open Scope Z_scope.
Open Scope string_scope.

Definition int := Z.

(* Abstracting Python's string splitting and integer conversion *)
Parameter split : string -> string -> list string.
Parameter to_int : string -> int.

Definition fruit_distribution_spec (s : string) (n : int) (res : int) : Prop :=
  let words := split s " " in
  let c1 := to_int (nth 0 words "") in
  let c2 := to_int (nth 3 words "") in
  n - c1 - c2 >= 0 /\ res = n - c1 - c2.
