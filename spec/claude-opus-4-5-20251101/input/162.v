
Require Import String.
Require Import List.

Definition string_to_md5_spec (text : string) (result : option string) : Prop :=
  (text = EmptyString -> result = None) /\
  (text <> EmptyString -> exists hash : string, result = Some hash).
