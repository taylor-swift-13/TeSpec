Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.

Definition generate_integers_spec (a b : nat) (res : list nat) : Prop :=
  let lo := Nat.min a b in
  let hi := Nat.min (Nat.max a b) 9 in
  res =
    (if Nat.leb lo hi then
       List.filter (fun i => Nat.even i) (List.seq lo (S (Nat.sub hi lo)))
     else
       nil).