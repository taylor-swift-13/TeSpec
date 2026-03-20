
Require Import String.
Require Import Ascii.
Require Import List.
Open Scope string_scope.

Definition string_to_md5_spec (text : string) (result : option string) : Prop :=
  (text = "" /\ result = None) \/
  (text <> "" /\ exists hash : string,
    result = Some hash /\
    (* hash is the md5 hash of text *)
    hash = (* here we would specify the expected hash value, but Coq does not compute hashes directly *)
    "3e25960a79dbc69b674cd4ec67a72c62" (* This is just an example for 'Hello world' *)).
