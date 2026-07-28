Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.micromega.Lia.
Require Import AUXLib.ListLib.

Import ListNotations.
Local Open Scope Z_scope.

Definition xizi_double_link_insert_after_nodes
  (prefix : list Z) (anchor inserted : Z) (suffix : list Z) : list Z :=
  prefix ++ anchor :: inserted :: suffix.
