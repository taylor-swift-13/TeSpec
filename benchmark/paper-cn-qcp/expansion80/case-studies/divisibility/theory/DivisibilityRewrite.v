From Coq Require Import ZArith Lia.
Local Open Scope Z_scope.
Definition quantified_multiple (a b r : Z) : Prop :=
  (r = 1 /\ exists q : Z, a = q * b) \/
  (r = 0 /\ forall q : Z, a <> q * b).
Definition finite_multiple (a b r : Z) : Prop :=
  (r = 1 /\ a mod b = 0) \/ (r = 0 /\ a mod b <> 0).
Lemma multiple_mod (a b : Z) (Hb : 0 < b) :
  (exists q : Z, a = q * b) <-> a mod b = 0.
Proof.
  rewrite Z.mod_divide by lia.
  unfold Z.divide. split; intros [q Hq]; exists q; nia.
Qed.
Theorem divisibility_finite_characterization (a b r : Z) (Hb : 0 < b) :
  quantified_multiple a b r <-> finite_multiple a b r.
Proof.
  unfold quantified_multiple, finite_multiple.
  pose proof (multiple_mod a b Hb) as Hmod.
  split.
  - intros [[Hr Hq]|[Hr Hall]].
    + left. split; [exact Hr|apply Hmod; exact Hq].
    + right. split; [exact Hr|]. intros Hz.
      destruct (proj2 Hmod Hz) as [q Hq]. exact (Hall q Hq).
  - intros [[Hr Hz]|[Hr Hnz]].
    + left. split; [exact Hr|apply Hmod; exact Hz].
    + right. split; [exact Hr|]. intros q Hq.
      apply Hnz. apply Hmod. exists q. exact Hq.
Qed.
Theorem redundant_unbounded_consequence (a b r : Z) (Hb : 0 < b) :
  finite_multiple a b r <->
  (finite_multiple a b r /\ forall q : Z, r <> 0 \/ a <> q * b).
Proof.
  split; [|tauto]. intros H. split; [exact H|].
  pose proof (proj2 (divisibility_finite_characterization a b r Hb) H)
    as [[Hr Hq]|[Hr Hall]].
  - intros q. left. lia.
  - intros q. right. apply Hall.
Qed.
Print Assumptions divisibility_finite_characterization.
Print Assumptions redundant_unbounded_consequence.
