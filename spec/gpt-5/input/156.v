
Require Import Coq.Strings.String.
Require Import Coq.Arith.PeanoNat.

Definition roman_m (d : nat) : string :=
  match d with
  | 0 => ""
  | 1 => "m"
  | _ => ""
  end.

Definition roman_c (d : nat) : string :=
  match d with
  | 0 => ""
  | 1 => "c"
  | 2 => "cc"
  | 3 => "ccc"
  | 4 => "cd"
  | 5 => "d"
  | 6 => "dc"
  | 7 => "dcc"
  | 8 => "dccc"
  | 9 => "cm"
  | _ => ""
  end.

Definition roman_x (d : nat) : string :=
  match d with
  | 0 => ""
  | 1 => "x"
  | 2 => "xx"
  | 3 => "xxx"
  | 4 => "xl"
  | 5 => "l"
  | 6 => "lx"
  | 7 => "lxx"
  | 8 => "lxxx"
  | 9 => "xc"
  | _ => ""
  end.

Definition roman_i (d : nat) : string :=
  match d with
  | 0 => ""
  | 1 => "i"
  | 2 => "ii"
  | 3 => "iii"
  | 4 => "iv"
  | 5 => "v"
  | 6 => "vi"
  | 7 => "vii"
  | 8 => "viii"
  | 9 => "ix"
  | _ => ""
  end.

Definition int_to_mini_roman_spec (number : nat) (res : string) : Prop :=
  Nat.le 1 number /\ Nat.le number 1000 /\
  res =
    String.append
      (roman_m (Nat.div number 1000))
      (String.append
        (roman_c (Nat.div (Nat.modulo number 1000) 100))
        (String.append
          (roman_x (Nat.div (Nat.modulo number 100) 10))
          (roman_i (Nat.modulo number 10)))).
