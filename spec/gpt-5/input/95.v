Require Import Coq.Lists.List.
Require Import Coq.Strings.String.

Parameter Dict : Type.
Parameter Key : Type.
Parameter keys : Dict -> list Key.
Parameter KeyStr : Key -> string -> Prop.
Parameter IsLower : string -> Prop.
Parameter IsUpper : string -> Prop.

Definition check_dict_case_spec (d : Dict) (res : bool) : Prop :=
  res = true <->
  keys d <> nil /\
  ( (forall k, In k (keys d) -> exists s, KeyStr k s /\ IsLower s) \/
    (forall k, In k (keys d) -> exists s, KeyStr k s /\ IsUpper s) ).