Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Definition IsBit (x : Z) : Prop := x = 0 \/ x = 1.

Definition AllBits (xs : list Z) : Prop := Forall IsBit xs.

Fixpoint BinaryValue (xs : list Z) : Z :=
  match xs with
  | [] => 0
  | x :: rest => x * 2 ^ Z.of_nat (length rest) + BinaryValue rest
  end.

Definition CanonicalBits (xs : list Z) : Prop :=
  AllBits xs /\
  (xs = [0] \/ exists rest, xs = 1 :: rest).

Definition Prefix {A : Type} (short whole : list A) : Prop :=
  firstn (length short) whole = short.

Definition BinaryAddition
  (left right output : list Z) : Prop :=
  CanonicalBits output /\
  BinaryValue output = BinaryValue left + BinaryValue right.
