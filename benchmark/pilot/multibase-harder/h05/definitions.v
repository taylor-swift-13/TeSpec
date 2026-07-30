Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.
Import ListNotations.
Open Scope Z_scope.

Record ItemModel := {
  item_key : Z;
  item_payload0 : Z;
  item_payload1 : Z;
  item_origin : Z;
  item_serial : Z
}.

Definition KeyLe (left right : ItemModel) : Prop :=
  item_key left <= item_key right.

Definition SortedByKey (items : list ItemModel) : Prop :=
  StronglySorted KeyLe items.

Definition OriginBit (item : ItemModel) : Prop :=
  item_origin item = 0 \/ item_origin item = 1.

Definition ItemOrigins (items : list ItemModel) : Prop :=
  Forall OriginBit items.

Definition TraceBits (trace : list Z) : Prop :=
  Forall (fun bit => bit = 0 \/ bit = 1) trace.

Fixpoint KeySum (items : list ItemModel) : Z :=
  match items with
  | [] => 0
  | item :: rest => item_key item + KeySum rest
  end.
