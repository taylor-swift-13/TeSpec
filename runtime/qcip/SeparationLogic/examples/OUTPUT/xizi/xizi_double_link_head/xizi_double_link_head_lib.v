Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.micromega.Lia.
Require Import AUXLib.ListLib.

Import ListNotations.
Local Open Scope Z_scope.

(** The abstract observation returned by [xizi_double_link_head].

    This definition depends only on the logical node sequence, not on the C
    implementation or on the representation predicate.  It is therefore a
    stable client-facing specification: alternative intrusive-list layouts
    can reuse the same observation unchanged. *)
Definition xizi_double_link_head_value (nodes : list Z) : Z :=
  match nodes with
  | nil => 0
  | first :: _ => first
  end.
