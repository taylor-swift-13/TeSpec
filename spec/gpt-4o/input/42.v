
Require Import List.
Require Import Nat.

Definition incr_list_spec (l : list nat) (result : list nat) : Prop :=
result = map (fun x => x + 1) l.
