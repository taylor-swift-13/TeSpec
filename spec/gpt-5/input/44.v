
Require Import Coq.ZArith.ZArith.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.

Open Scope Z_scope.

Fixpoint foldl_Z (f : Z -> Z -> Z) (acc : Z) (l : list Z) : Z :=
  match l with
  | nil => acc
  | x :: xs => foldl_Z f (f acc x) xs
  end.

Definition eval_digits (base : Z) (ds : list Z) : Z :=
  foldl_Z (fun acc d => acc * base + d) 0 ds.

Fixpoint string_of_digits (ds : list Z) : string :=
  match ds with
  | nil => EmptyString
  | d :: tl => String (ascii_of_nat (48 + Z.to_nat d)) (string_of_digits tl)
  end.

Definition digits_range (base : Z) (ds : list Z) : Prop :=
  Forall (fun t => 0 <= t /\ t < base) ds.

Definition change_base_spec (x base : Z) (ret : string) : Prop :=
  0 <= x /\ 2 <= base /\ base <= 9 /\
  (x = 0 /\ ret = String (ascii_of_nat 48) EmptyString \/
   x <> 0 /\ exists d ds,
     ret = string_of_digits (d :: ds) /\
     1 <= d /\ d < base /\
     digits_range base ds /\
     eval_digits base (d :: ds) = x).
