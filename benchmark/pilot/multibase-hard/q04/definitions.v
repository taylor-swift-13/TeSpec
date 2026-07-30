Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Fixpoint sum_Z (xs : list Z) : Z :=
  match xs with
  | [] => 0
  | x :: rest => x + sum_Z rest
  end.

Definition AllBytes (xs : list Z) : Prop :=
  Forall (fun x => 0 <= x < 256) xs.

Definition ChecksumMod16 (xs : list Z) (out : Z) : Prop :=
  0 <= out < 256 /\ out mod 16 = sum_Z xs mod 16.
