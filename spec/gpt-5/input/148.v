Require Import Coq.Strings.String.
Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.

Import ListNotations.

Open Scope string_scope.
Open Scope nat_scope.

Definition planets : list string :=
  ["Mercury"; "Venus"; "Earth"; "Mars"; "Jupiter"; "Saturn"; "Uranus"; "Neptune"].

Definition bf_spec (planet1 planet2 : string) (res : list string) : Prop :=
  (In planet1 planets /\ In planet2 planets ->
    exists i1 i2,
      nth_error planets i1 = Some planet1 /\
      nth_error planets i2 = Some planet2 /\
      res =
        let lo := Nat.min i1 i2 in
        let hi := Nat.max i1 i2 in
        firstn (hi - S lo) (skipn (S lo) planets)) /\
  ((~ In planet1 planets \/ ~ In planet2 planets) -> res = []).