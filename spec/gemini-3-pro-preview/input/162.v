
Require Import Coq.Strings.String.

Parameter md5_hexdigest : string -> string.

Definition string_to_md5_spec (text : string) (result : option string) : Prop :=
  match text with
  | EmptyString => result = None
  | _ => result = Some (md5_hexdigest text)
  end.
