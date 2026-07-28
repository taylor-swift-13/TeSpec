Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.micromega.Lia.
Require Import AUXLib.ListLib.

Import ListNotations.
Local Open Scope Z_scope.

Definition xizi_double_link_next_value (suffix : list Z) : Z :=
  match suffix with
  | nil => 0
  | next :: _ => next
  end.
