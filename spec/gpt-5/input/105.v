Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Strings.String.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.

Open Scope Z_scope.
Open Scope string_scope.

Definition is_digit (x : Z) : bool :=
Z.leb 1 x && Z.leb x 9.

Definition to_word (x : Z) : string :=
if Z.eqb x 1 then "One"
else if Z.eqb x 2 then "Two"
else if Z.eqb x 3 then "Three"
else if Z.eqb x 4 then "Four"
else if Z.eqb x 5 then "Five"
else if Z.eqb x 6 then "Six"
else if Z.eqb x 7 then "Seven"
else if Z.eqb x 8 then "Eight"
else "Nine".

Definition by_length_spec (arr : list Z) (ans : list string) : Prop :=
exists digits_desc,
Permutation digits_desc (filter is_digit arr) /\
Sorted Z.ge digits_desc /\
ans = map to_word digits_desc.