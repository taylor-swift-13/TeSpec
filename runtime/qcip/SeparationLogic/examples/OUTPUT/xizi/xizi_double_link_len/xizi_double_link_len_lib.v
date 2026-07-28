Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.micromega.Lia.
Require Import AUXLib.ListLib.

Import ListNotations.
Local Open Scope Z_scope.

(** Mathematical size of the abstract data-node sequence.  Keeping this
    observation separate from the concrete link layout lets clients reuse the
    same contract when the intrusive node representation is extended. *)
Definition xizi_double_link_size (nodes : list Z) : Z := Zlength nodes.
