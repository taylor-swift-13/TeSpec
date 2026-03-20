Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.Bool.Bool.

Open Scope Z_scope.

Definition freq (z : Z) (l : list Z) : nat :=
  length (filter (fun x => Z.eqb x z) l).

Definition search_spec (lst : list Z) (ans : Z) : Prop :=
  Forall (fun x => x > 0) lst /\
  lst <> nil /\
  ((exists n : Z, n > 0 /\ Z.of_nat (freq n lst) >= n) ->
     ans > 0 /\ Z.of_nat (freq ans lst) >= ans /\
     forall n : Z, n > 0 -> Z.of_nat (freq n lst) >= n -> n <= ans) /\
  ((forall n : Z, ~(n > 0 /\ Z.of_nat (freq n lst) >= n)) ->
     ans = -1).