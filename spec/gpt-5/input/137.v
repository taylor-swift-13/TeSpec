Require Import Coq.Strings.String.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Reals.Reals.

Inductive value : Type :=
| VInt : Z -> value
| VFloat : R -> value
| VStr : string -> value.

Parameter replace_commas_with_dots : string -> string.
Parameter R_of_string : string -> R.

Definition num_of (v : value) : R :=
  match v with
  | VInt z => IZR z
  | VFloat r => r
  | VStr s => R_of_string (replace_commas_with_dots s)
  end.

Definition compare_one_spec (a : value) (b : value) (res : option value) : Prop :=
  let ra := num_of a in
  let rb := num_of b in
  (ra = rb /\ res = None) \/
  (Rlt rb ra /\ res = Some a) \/
  (Rlt ra rb /\ res = Some b).