
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.ZArith.ZArith.

Local Open Scope string_scope.
Local Open Scope Z_scope.

Definition char_to_digit (c : ascii) : Z :=
  Z.of_nat (nat_of_ascii c) - Z.of_nat (nat_of_ascii "0"%char).

Fixpoint string_to_val (s : string) (base : Z) : Z :=
  match s with
  | EmptyString => 0
  | String c s' => 
      char_to_digit c * (Z.pow base (Z.of_nat (length s'))) + string_to_val s' base
  end.

Fixpoint valid_digits (s : string) (base : Z) : Prop :=
  match s with
  | EmptyString => True
  | String c s' => 
      0 <= char_to_digit c < base /\ valid_digits s' base
  end.

Definition is_canonical (s : string) : Prop :=
  match s with
  | String "0"%char _ => False 
  | _ => True
  end.

Definition change_base_spec (x : Z) (base : Z) (ret : string) : Prop :=
  2 <= base < 10 ->
  x >= 0 ->
  (x = 0 -> ret = "0") /\
  (x > 0 -> 
    valid_digits ret base /\
    string_to_val ret base = x /\
    is_canonical ret).
