Require Import Coq.ZArith.ZArith Coq.micromega.Lia.
Open Scope Z_scope.
Definition CN_valid (a d wa wd t c:Z) : Prop :=
 (a=0 \/ a=1) /\ (d=0 \/ d=1) /\ (a=0 \/ d=0) /\ wa>=0 /\ wd>=0 /\ 0<=t<=5 /\ 0<=c<=3 /\
 ((a=0 /\ d=0)->c=0) /\ (t>0->(a=1 \/ d=1)) /\ ((c>0 /\ a=1)->wd>0) /\ ((c>0 /\ d=1)->wa>0).
Definition QCP_linear_valid (a d wa wd t c:Z) : Prop :=
 0<=a<=1 /\ 0<=d<=1 /\ a+d<=1 /\ wa>=0 /\ wd>=0 /\ 0<=t<=5 /\ 0<=c<=3 /\ c<=3*(a+d) /\ t<=5*(a+d) /\ c<=3*(1-a+wd) /\ c<=3*(1-d+wa).
Theorem valid_encoding_equivalent : forall a d wa wd t c, CN_valid a d wa wd t c <-> QCP_linear_valid a d wa wd t c.
Proof. intros; unfold CN_valid, QCP_linear_valid; intuition lia. Qed.
