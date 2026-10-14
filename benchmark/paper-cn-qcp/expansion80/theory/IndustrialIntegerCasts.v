Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
Local Open Scope Z_scope.

Definition wrap (modulus x : Z) : Z := x mod modulus.
Definition u8 (x : Z) := wrap 256 x.
Definition u16 (x : Z) := wrap 65536 x.
Definition u32 (x : Z) := wrap 4294967296 x.
Definition u64 (x : Z) := wrap 18446744073709551616 x.
Definition i32 (x : Z) :=
  if Z.geb (u32 x) 2147483648 then u32 x - 4294967296 else u32 x.

Lemma wrap_in_range : forall modulus x,
  0 < modulus -> 0 <= x < modulus -> wrap modulus x = x.
Proof. intros. unfold wrap. apply Z.mod_small. assumption. Qed.

Theorem u64_nonnegative_in_range : forall x,
  0 <= x <= 18446744073709551615 -> u64 x = x.
Proof. intros. unfold u64. apply wrap_in_range; lia. Qed.

Theorem u16_nonnegative_in_range : forall x,
  0 <= x <= 65535 -> u16 x = x.
Proof. intros. unfold u16. apply wrap_in_range; lia. Qed.

Theorem page_shift_constant : u64 12 = 12.
Proof. apply u64_nonnegative_in_range. lia. Qed.

Lemma nested_wrap : forall small large x,
  0 < small -> 0 < large -> large mod small = 0 ->
  wrap small (wrap large x) = wrap small x.
Proof.
  intros small large x Hs Hl Hdiv. unfold wrap.
  pose proof (Z.div_mod x large ltac:(lia)) as Hdecomp.
  rewrite Hdecomp at 2.
  rewrite Z.add_mod by lia.
  rewrite Z.mul_mod by lia.
  rewrite Hdiv. simpl.
  rewrite Z.mod_mod by lia. reflexivity.
Qed.

Theorem memset_byte_cast_equivalent : forall x, u8 (i32 x) = u8 x.
Proof.
  intros x. unfold i32.
  destruct (Z.geb (u32 x) 2147483648) eqn:H.
  - unfold u8, wrap. rewrite Zminus_mod.
    change ((u32 x mod 256 - 0) mod 256 = x mod 256).
    rewrite Z.sub_0_r, Z.mod_mod by lia.
    apply (nested_wrap 256 4294967296 x); try lia; reflexivity.
  - apply (nested_wrap 256 4294967296 x); try lia; reflexivity.
Qed.

Theorem copy_alloc_id_address_equivalent : forall p x,
  u64 (p + u64 (x - p)) = u64 x.
Proof.
  intros p x. unfold u64, wrap.
  rewrite Z.add_mod_idemp_r by lia.
  replace (p + (x-p)) with x by lia. reflexivity.
Qed.

Theorem u64_underflow_must_wrap : u64 (0-1) = 18446744073709551615.
Proof. reflexivity. Qed.

Print Assumptions memset_byte_cast_equivalent.
Print Assumptions copy_alloc_id_address_equivalent.
Print Assumptions u64_underflow_must_wrap.
