Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Import ListNotations.

Definition open_paren : ascii := Ascii.ascii_of_nat 40.
Definition close_paren : ascii := Ascii.ascii_of_nat 41.
Definition space : ascii := Ascii.ascii_of_nat 32.

Definition is_open (a : ascii) : bool := Ascii.eqb a open_paren.
Definition is_close (a : ascii) : bool := Ascii.eqb a close_paren.
Definition is_space (a : ascii) : bool := Ascii.eqb a space.

Definition update_cnt (cnt : Z) (a : ascii) : Z :=
  if is_open a then cnt + 1
  else if is_close a then cnt - 1
  else cnt.

Definition update_group (group : string) (a : ascii) : string :=
  if negb (is_space a) then group ++ String a EmptyString else group.

Inductive process_string : string -> Z -> string -> list string -> list string -> Prop :=
| process_nil : forall cnt group acc,
    process_string EmptyString cnt group acc acc
| process_cons_zero_empty : forall a rest cnt group acc cnt' group',
    cnt' = update_cnt cnt a ->
    group' = update_group group a ->
    cnt' = 0%Z ->
    group' = EmptyString ->
    process_string rest cnt' EmptyString acc acc ->
    process_string (String a rest) cnt group acc acc
| process_cons_zero_nonempty : forall a rest cnt group acc cnt' group' final,
    cnt' = update_cnt cnt a ->
    group' = update_group group a ->
    cnt' = 0%Z ->
    group' <> EmptyString ->
    process_string rest cnt' EmptyString (acc ++ [group']) final ->
    process_string (String a rest) cnt group acc final
| process_cons_nonzero : forall a rest cnt group acc cnt' group' final,
    cnt' = update_cnt cnt a ->
    group' = update_group group a ->
    cnt' <> 0%Z ->
    process_string rest cnt' group' acc final ->
    process_string (String a rest) cnt group acc final.

Definition separate_paren_groups_spec (paren_string : string) (results : list string) : Prop :=
  process_string paren_string 0%Z EmptyString [] results.