Require Import Coq.Strings.Ascii.
Require Import Coq.Strings.String.
Require Import Coq.Bool.Bool.

Fixpoint InStr (a : ascii) (s : string) : Prop :=
  match s with
  | EmptyString => False
  | String b s' => a = b \/ InStr a s'
  end.

Definition same_char_sets (s0 s1 : string) : Prop :=
  forall a : ascii, InStr a s0 <-> InStr a s1.

Definition same_chars_spec (s0 s1 : string) (res : bool) : Prop :=
  (res = true <-> same_char_sets s0 s1) /\
  (res = false <-> ~ same_char_sets s0 s1).