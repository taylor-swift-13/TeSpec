Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.

Inductive num := NumInt (z : Z) | NumOther.

Definition any_int_spec (x y z : num) (res : bool) : Prop :=
  match x, y, z with
  | NumInt xi, NumInt yi, NumInt zi =>
      res =
        orb (Z.eqb xi (Z.add yi zi))
            (orb (Z.eqb yi (Z.add xi zi)) (Z.eqb zi (Z.add yi xi)))
  | _, _, _ => res = false
  end.