
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.
Import ListNotations.

Definition even (n : nat) : Prop :=
  Nat.even n = true.

Definition generate_integers_spec (a b : nat) (res : list nat) : Prop :=
  a > 0 /\ b > 0 /\
  res = 
    filter (fun i => Nat.even i)
           (List.filter (fun i => (a <=? i) && (i <=? (Nat.min b 9))) (seq a (S (Nat.min b 9 - a)) )) /\
  NoDup res /\
  (forall x, In x res -> a <= x <= b \/ b <= x <= a) /\
  (forall x, In x res -> even x) /\
  (forall x, even x ->
             (a <= x <= b \/ b <= x <= a) ->
             x <= 9 ->
             In x res).
