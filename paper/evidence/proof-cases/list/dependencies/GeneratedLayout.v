(* target-layout canonical JSON SHA256: cc9181aba785651a0a47d4dda154eb7db396ea6261ed92032ae22ab110453d22 *)
From Coq Require Import ZArith String List.
From SimpleC.SL Require Import CNotation.
Require Import LayoutAddress.
Local Open Scope Z_scope.
Local Open Scope string_scope.
Definition resolve_struct (name : string) : option layout_type :=
  if String.eqb name "list" then Some (Laggregate 369%nat) else
  None.
Definition resolve_union (name : string) : option layout_type :=
  None.
Definition resolve_alias (name : string) : option layout_type :=
  if String.eqb name "list" then Some (Laggregate 369%nat) else
  None.
Definition resolve_type (ty : front_end_type) : option layout_type :=
  match ty with
  | FET_struct name => resolve_struct name
  | FET_union name => resolve_union name
  | FET_alias name => resolve_alias name
  | FET_ptr => Some Lpointer
  | FET_char | FET_uchar => Some (Lprimitive 1)
  | FET_short | FET_ushort => Some (Lprimitive 2)
  | FET_int | FET_uint | FET_float => Some (Lprimitive 4)
  | FET_int64 | FET_uint64 | FET_double => Some (Lprimitive 8)
  | _ => None
  end.
Definition resolve_size (id : nat) : option Z :=
  if Nat.eqb id 369%nat then Some 8 else
  None.
Definition resolve_field (id : nat) (name : string) : option field_record :=
  if andb (Nat.eqb id 369%nat) (String.eqb name "data") then
    Some {| fl_offset := 0; fl_type := (Lprimitive 4) |} else
  if andb (Nat.eqb id 369%nat) (String.eqb name "next") then
    Some {| fl_offset := 4; fl_type := Lpointer |} else
  None.
Definition target_layout : layout_env :=
  {| lookup_type := resolve_type; lookup_size := resolve_size;
     lookup_field := resolve_field; pointer_bytes := 4 |}.
Module AddressNotations.
Notation "&( x )" :=
  (ltac:(let x' := get_lvalue_expr x in
          let e := constr:(eval_l target_layout x') in
          let v := (eval cbv -[Z.add Z.mul Z.sub Z.opp] in e) in
          lazymatch v with
          | Some (?a, ?t) => exact a
          | _ => fail "unresolved target-layout address"
          end))
  (at level 0, x custom lvalue_expr_entry at level 99, only parsing).
End AddressNotations.
