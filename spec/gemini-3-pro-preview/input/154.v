
Require Import Coq.Strings.String.
Require Import Coq.Bool.Bool.

Open Scope string_scope.

Definition is_substring (part whole : string) : Prop :=
  exists prefix suffix : string, whole = prefix ++ part ++ suffix.

Definition is_rotation (s r : string) : Prop :=
  exists u v : string, s = u ++ v /\ r = v ++ u.

Definition cycpattern_check_spec (a b : string) (res : bool) : Prop :=
  res = true <-> (exists r : string, is_rotation b r /\ is_substring r a).
