From Coq Require Import ZArith Lia.
Local Open Scope Z_scope.

(* Semantic equivalence of the two annotation forms in the least-root
   comparison. The left side quantifies over all nonnegative integers;
   the right side is a finite arithmetic checker for the same relation. *)
Theorem least_root_finite_characterization (n r : Z) :
  (0 <= r /\ forall k : Z, 0 <= k -> (r <= k <-> n <= k * k)) <->
  (0 <= r /\ n <= r * r /\ (r = 0 \/ (r - 1) * (r - 1) < n)).
Proof.
  split.
  - intros [Hr H]. split; [exact Hr|]. split.
    + apply (proj1 (H r Hr)). lia.
    + destruct (Z.eq_dec r 0) as [Hz|Hnz]; [left; exact Hz|right].
      assert (Hpred : 0 <= r - 1) by lia.
      assert (Hnot : ~ n <= (r - 1) * (r - 1)).
      { intros Hbad. pose proof (proj2 (H (r - 1) Hpred) Hbad). lia. }
      lia.
  - intros [Hr [Hsquare Hprevious]]. split; [exact Hr|].
    intros k Hk. split; intros Hcompare.
    + nia.
    + destruct Hprevious as [Hz|Hprevious]; nia.
Qed.

Print Assumptions least_root_finite_characterization.
