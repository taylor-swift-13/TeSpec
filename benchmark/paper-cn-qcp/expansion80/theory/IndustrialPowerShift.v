Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
Require Import IndustrialIntegerCasts.
Local Open Scope Z_scope.

Theorem power_two_shift_integer : forall order,
  Z.shiftl 1 order = 2 ^ order.
Proof. apply Z.shiftl_1_l. Qed.

Theorem power_two_fits_u64 : forall order,
  0 <= order < 64 -> 0 < 2 ^ order < 18446744073709551616.
Proof.
  intros order H. split.
  - apply Z.pow_pos_nonneg; lia.
  - change (2 ^ order < 2 ^ 64).
    apply Z.pow_lt_mono_r; lia.
Qed.

Theorem power_two_shift_u64 : forall order,
  0 <= order < 64 -> u64 (Z.shiftl 1 order) = 2 ^ order.
Proof.
  intros order H. rewrite power_two_shift_integer.
  apply u64_nonnegative_in_range.
  pose proof (power_two_fits_u64 order H). lia.
Qed.

Theorem allocator_power_two_shift : forall order,
  0 <= order < 11 -> u64 (Z.shiftl 1 order) = u64 (2 ^ order).
Proof. intros. rewrite power_two_shift_integer. reflexivity. Qed.

Print Assumptions power_two_shift_integer.
Print Assumptions power_two_fits_u64.
Print Assumptions power_two_shift_u64.
Print Assumptions allocator_power_two_shift.
