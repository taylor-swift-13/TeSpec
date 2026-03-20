Require Import Coq.Strings.String.
Require Import Coq.Init.Datatypes.

Parameter md5_hex_utf8 : string -> string.

Definition string_to_md5_spec (text : string) (res : option string) : Prop :=
  (text = EmptyString /\ res = None) \/
  (text <> EmptyString /\ res = Some (md5_hex_utf8 text)).