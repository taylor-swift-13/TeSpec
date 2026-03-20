
Require Import ZArith.
Require Import List.
Require Import Coq.Init.Datatypes.

Open Scope Z_scope.

Definition is_negative (x : Z) : bool := x <? 0.
Definition is_positive (x : Z) : bool := x >? 0.

Definition largest_negative (lst : list Z) : option Z :=
  let negatives := filter (fun x => is_negative x) lst in
  match negatives with
  | nil => None
  | h :: t => Some (fold_left Z.max t h)
  end.

Definition smallest_positive (lst : list Z) : option Z :=
  let positives := filter (fun x => is_positive x) lst in
  match positives with
  | nil => None
  | h :: t => Some (fold_left Z.min t h)
  end.

Definition largest_smallest_integers_spec (lst : list Z) (result : option Z * option Z) : Prop :=
  let negatives := filter (fun x => is_negative x) lst in
  let positives := filter (fun x => is_positive x) lst in
  (fst result = match negatives with
                | nil => None
                | h :: t => Some (fold_left Z.max t h)
                end) /\
  (snd result = match positives with
                | nil => None
                | h :: t => Some (fold_left Z.min t h)
                end) /\
  (match fst result with
   | None => negatives = nil
   | Some a => In a negatives /\ a < 0 /\ (forall x, In x negatives -> x <= a)
   end) /\
  (match snd result with
   | None => positives = nil
   | Some b => In b positives /\ b > 0 /\ (forall x, In x positives -> b <= x)
   end).
