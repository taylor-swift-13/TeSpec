
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.

Parameter string_to_md5 : string -> option string.

Definition string_to_md5_spec (text : string) (result : option string) : Prop :=
  if string_dec text "" then
    result = None
  else
    exists hash : string, result = Some hash.
