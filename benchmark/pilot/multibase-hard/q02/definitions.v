Require Import Coq.ZArith.ZArith.
Open Scope Z_scope.

Record BundleModel := {
  total0 : Z; total1 : Z;
  single_a0 : Z; single_a1 : Z; single_atag : Z;
  single_b0 : Z; single_b1 : Z; single_btag : Z;
  double_a0 : Z; double_a1 : Z; double_atag : Z;
  double_b0 : Z; double_b1 : Z; double_btag : Z
}.

Definition BundleStep
  (pre : BundleModel) (sd dd : Z)
  (post : BundleModel) (ret : Z) : Prop :=
  single_a0 post = single_a0 pre + sd /\
  single_b0 post = single_b0 pre + sd /\
  single_a1 post = single_a1 pre /\
  single_b1 post = single_b1 pre /\
  double_a0 post = double_a0 pre + dd /\
  double_b0 post = double_b0 pre + dd /\
  double_a1 post = double_a1 pre /\
  double_b1 post = double_b1 pre /\
  total0 post =
    total0 pre + single_a0 post + single_b0 post /\
  total1 post =
    total1 pre + double_a0 post + double_b0 post /\
  ret = total0 post + total1 post /\
  single_atag post = single_atag pre /\
  single_btag post = single_btag pre /\
  double_atag post = double_atag pre /\
  double_btag post = double_btag pre.
