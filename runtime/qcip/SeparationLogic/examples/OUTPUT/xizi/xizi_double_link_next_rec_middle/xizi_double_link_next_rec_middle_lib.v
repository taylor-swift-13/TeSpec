Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.micromega.Lia.
Require Import AUXLib.ListLib.

Import ListNotations.
Local Open Scope Z_scope.

Definition xizi_double_link_next_value (nodes_after : list Z) : Z :=
  match nodes_after with
  | nil => 0
  | next :: _ => next
  end.
