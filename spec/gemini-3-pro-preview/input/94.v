
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Import ListNotations.
Open Scope Z_scope.

Definition is_prime (n : Z) : Prop :=
  1 < n /\ forall m, 1 < m < n -> n mod m <> 0.

Fixpoint digits_sum_aux (n : nat) (fuel : nat) : Z :=
  match fuel with
  | 0%nat => 0
  | S f =>
    match n with
    | 0%nat => 0
    | _ => Z.of_nat (n mod 10)%nat + digits_sum_aux (n / 10)%nat f
    end
  end.

Definition sum_digits (n : Z) : Z :=
  let val := Z.to_nat n in
  digits_sum_aux val (S val).

Definition skjkasdkd_spec (lst : list Z) (res : Z) : Prop :=
  exists p,
    In p lst /\
    is_prime p /\
    (forall q, In q lst -> is_prime q -> q <= p) /\
    res = sum_digits p.
