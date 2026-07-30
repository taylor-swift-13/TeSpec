Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Inductive FVal : Type :=
| FNaN (payload : Z)
| FNegZero
| FPosZero
| FFinite (value : Z).

Definition WellFormedFVal (x : FVal) : Prop :=
  match x with
  | FFinite value => value <> 0
  | _ => True
  end.

Definition NumericEq (x y : FVal) : Prop :=
  x = y \/
  (x = FNegZero /\ y = FPosZero) \/
  (x = FPosZero /\ y = FNegZero).

Definition ClampModel (x : FVal) (lower upper : Z) : FVal :=
  match x with
  | FNaN payload => FNaN payload
  | FNegZero =>
      if 0 <? lower then FFinite lower
      else if upper <? 0 then FFinite upper
      else FNegZero
  | FPosZero =>
      if 0 <? lower then FFinite lower
      else if upper <? 0 then FFinite upper
      else FPosZero
  | FFinite value =>
      if value <? lower then FFinite lower
      else if upper <? value then FFinite upper
      else FFinite value
  end.

Fixpoint BatchDomain
  (inputs : list FVal) (lowers uppers : list Z) : Prop :=
  match inputs, lowers, uppers with
  | [], [], [] => True
  | x :: xs, lo :: los, hi :: his =>
      WellFormedFVal x /\ lo <= hi /\ BatchDomain xs los his
  | _, _, _ => False
  end.

Fixpoint ClampBatchNumeric
  (inputs : list FVal) (lowers uppers : list Z)
  (outputs : list FVal) : Prop :=
  match inputs, lowers, uppers, outputs with
  | [], [], [], [] => True
  | x :: xs, lo :: los, hi :: his, y :: ys =>
      NumericEq y (ClampModel x lo hi) /\
      ClampBatchNumeric xs los his ys
  | _, _, _, _ => False
  end.

Definition NonNaN (x : FVal) : Prop :=
  match x with
  | FNaN _ => False
  | _ => True
  end.

Definition AllNonNaN (outputs : list FVal) : Prop :=
  Forall NonNaN outputs.

Definition WasClipped (x : FVal) (lower upper : Z) : bool :=
  match x with
  | FNaN _ => false
  | FNegZero | FPosZero => (0 <? lower) || (upper <? 0)
  | FFinite value => (value <? lower) || (upper <? value)
  end.

Fixpoint ClampCount
  (inputs : list FVal) (lowers uppers : list Z) : Z :=
  match inputs, lowers, uppers with
  | x :: xs, lo :: los, hi :: his =>
      (if WasClipped x lo hi then 1 else 0) +
      ClampCount xs los his
  | _, _, _ => 0
  end.
