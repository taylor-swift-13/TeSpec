
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Import ListNotations.
Open Scope string_scope.
Open Scope list_scope.

Fixpoint string_to_list (s : string) : list ascii :=
  match s with
  | EmptyString => []
  | String c s' => c :: string_to_list s'
  end.

Fixpoint list_to_string (l : list ascii) : string :=
  match l with
  | [] => EmptyString
  | c :: l' => String c (list_to_string l')
  end.

Fixpoint encode_cyclic_list (l : list ascii) : list ascii :=
  match l with
  | c1 :: c2 :: c3 :: rest => c2 :: c3 :: c1 :: (encode_cyclic_list rest)
  | _ => l
  end.

Definition encode_cyclic_spec (s : string) (res : string) : Prop :=
  res = list_to_string (encode_cyclic_list (string_to_list s)).

Fixpoint decode_cyclic_list (l : list ascii) : list ascii :=
  match l with
  | c1 :: c2 :: c3 :: rest => c3 :: c1 :: c2 :: (decode_cyclic_list rest)
  | _ => l
  end.

Definition decode_cyclic_spec (s : string) (res : string) : Prop :=
  res = list_to_string (decode_cyclic_list (string_to_list s)).
