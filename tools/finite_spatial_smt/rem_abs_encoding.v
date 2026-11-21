(* Arithmetic used by the SMT encoding of QCP's Z.rem. *)
From Coq Require Import ZArith Lia.
Local Open Scope Z_scope.
Lemma rem_abs_encoding (a b : Z) :
  Z.rem a b =
    if b =? 0 then a
    else if 0 <=? a then a mod (Z.abs b) else - ((-a) mod (Z.abs b)).
Proof.
  destruct (b =? 0) eqn:Hz.
  - apply Z.eqb_eq in Hz. subst b. destruct a; reflexivity.
  - apply Z.eqb_neq in Hz.
    assert (Habs : Z.rem a b = Z.rem a (Z.abs b)).
    { destruct (Z.abs_spec b) as [[_ E]|[_ E]]; rewrite E.
      - reflexivity.
      - symmetry. apply Z.rem_opp_r'. }
    rewrite Habs. assert (Hpos : 0 < Z.abs b) by lia.
    destruct (0 <=? a) eqn:Ha.
    + apply Z.leb_le in Ha. apply Z.rem_mod_nonneg; lia.
    + apply Z.leb_gt in Ha.
      replace (Z.rem a (Z.abs b)) with (- Z.rem (-a) (Z.abs b))
        by (rewrite Z.rem_opp_l'; lia).
      rewrite Z.rem_mod_nonneg by lia. reflexivity.
Qed.
Print Assumptions rem_abs_encoding.
