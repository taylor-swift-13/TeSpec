Require Import Coq.Strings.Ascii.
Require Import Coq.Strings.String.
Require Import Coq.Arith.PeanoNat.
Require Import Coq.Bool.Bool.

Definition uppercaseb (n : nat) : bool :=
  Nat.leb 65 n && Nat.leb n 90.

Definition lowercaseb (n : nat) : bool :=
  Nat.leb 97 n && Nat.leb n 122.

Definition swap_case (c : ascii) : ascii :=
  let n := nat_of_ascii c in
  if uppercaseb n then ascii_of_nat (n + 32)
  else if lowercaseb n then ascii_of_nat (Nat.sub n 32)
  else c.

Definition vowelb (n : nat) : bool :=
  Nat.eqb n 65 || Nat.eqb n 69 || Nat.eqb n 73 || Nat.eqb n 79 || Nat.eqb n 85 ||
  Nat.eqb n 97 || Nat.eqb n 101 || Nat.eqb n 105 || Nat.eqb n 111 || Nat.eqb n 117.

Definition vowel_change (c : ascii) : ascii :=
  let n := nat_of_ascii c in
  if vowelb n then ascii_of_nat (n + 2) else c.

Definition encode_char (c : ascii) : ascii :=
  vowel_change (swap_case c).

Fixpoint string_map (f : ascii -> ascii) (s : string) : string :=
  match s with
  | EmptyString => EmptyString
  | String c s' => String (f c) (string_map f s')
  end.

Definition encode_fun (message : string) : string :=
  string_map encode_char message.

Definition encode_spec (message : string) (encoded : string) : Prop :=
  encoded = encode_fun message.