Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Init.Nat.
Require Import Coq.Bool.Bool.

Definition a_code : nat := nat_of_ascii (ascii_of_nat 97).
Definition z_code : nat := nat_of_ascii (ascii_of_nat 122).

Definition is_lowercase_ascii (c : ascii) : bool :=
  let n := nat_of_ascii c in Nat.leb a_code n && Nat.leb n z_code.

Definition rot4_ascii (c : ascii) : ascii :=
  let n := nat_of_ascii c in
  if is_lowercase_ascii c
  then ascii_of_nat (Nat.add a_code (Nat.modulo (Nat.add (Nat.sub n a_code) 4) 26))
  else c.

Fixpoint map_string (f : ascii -> ascii) (s : string) : string :=
  match s with
  | EmptyString => EmptyString
  | String c rest => String (f c) (map_string f rest)
  end.

Definition encrypt_spec (s : string) (res : string) : Prop :=
  res = map_string rot4_ascii s.