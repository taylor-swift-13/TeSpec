Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.

Definition substring (s sub : string) : Prop :=
  exists l r, s = String.append l (String.append sub r).

Definition rotation_of (b rot : string) : Prop :=
  exists x y, b = String.append x y /\ rot = String.append y x.

Definition cycpattern_check_spec (a b : string) (res : bool) : Prop :=
  res = true <->
    a = b \/
    b = EmptyString \/
    exists rot, rotation_of b rot /\ substring a rot.