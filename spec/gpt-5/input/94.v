Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.

Open Scope Z_scope.

Definition int := Z.

Fixpoint sum_list (ds : list Z) : Z :=
  match ds with
  | nil => 0
  | d :: ds' => d + sum_list ds'
  end.

Fixpoint digits_value (ds : list Z) : Z :=
  match ds with
  | nil => 0
  | d :: ds' => d + 10 * digits_value ds'
  end.

Definition digit (d : Z) : Prop := 0 <= d <= 9.

Definition all_digits (ds : list Z) : Prop := Forall digit ds.

Definition divides_Z (d n : Z) : Prop := exists k : Z, n = d * k.

Definition prime_Z (n : Z) : Prop :=
  2 <= n /\ forall d : Z, 2 <= d < n -> ~ divides_Z d n.

Definition sum_digits_10 (n s : Z) : Prop :=
  0 <= n /\ exists ds : list Z, all_digits ds /\ digits_value ds = n /\ s = sum_list ds.

Definition max_prime_in_list (lst : list Z) (p : Z) : Prop :=
  In p lst /\ prime_Z p /\ forall y, In y lst -> prime_Z y -> y <= p.

Definition skjkasdkd_spec (lst : list int) (res : int) : Prop :=
  exists p : Z, max_prime_in_list lst p /\ sum_digits_10 p res.