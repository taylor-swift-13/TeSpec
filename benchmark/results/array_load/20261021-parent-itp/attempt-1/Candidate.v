Require Import ExecutionGoal.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Classes.RelationClasses.
Require Import Coq.Classes.Morphisms.
Require Import Coq.micromega.Psatz.
Require Import Coq.Sorting.Permutation.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.


(* Diagnostic replacement: no unconditional refutation is asserted. *)
Definition diagnostic_antecedent (l : list Z) (r : Z) : expr :=
  IntArray.full (&("a_spec_396")) 3 l **
  ((&("zero_spec_399")) # Int |-> r).

Definition diagnostic_consequent (r : Z) : expr :=
  “ (0 = 0) ” && “ (INT_MIN <= r) ” && “ (r <= INT_MAX) ” &&
  ((&("zero_spec_399")) # Int |-> 0) **
  IntArray.full (&("a_spec_396")) 3 (0 :: 1 :: 2 :: nil).

Definition diagnostic_spatial_branch : Prop :=
  forall (l : list Z) (r : Z), INT_MIN <= r -> r <= INT_MAX ->
  diagnostic_antecedent l r |-- diagnostic_consequent r.

Definition diagnostic_pure_branch : Prop :=
forall (l2: (@list Z)) (retval: Z) (PreH1 : ((INT_MIN) <= retval)) (PreH2 : (retval <= INT_MAX)) ,
  TT && emp 
|--
  “ (l2 = (cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) ” 
  &&  “ (retval = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  emp
.

Lemma diagnostic_pure_branch_false : ~ diagnostic_pure_branch.
Proof.
  intro H.
  assert (Hlo : INT_MIN <= 0) by (change (-2147483648 <= 0); lia).
  assert (Hhi : 0 <= INT_MAX) by (change (0 <= 2147483647); lia).
  specialize (H nil 0 Hlo Hhi).
  assert (He : (TT && emp) (@ConAssertion.empty_state STS_naive.sts)).
  { change (True /\ ConAssertion.state_empty
      (@ConAssertion.empty_state STS_naive.sts)).
    split; [exact I | apply ConAssertion.empty_state_is_empty]. }
  specialize (H _ He).
  cbv [andp coq_prop] in H.
  assert (E : (nil : list Z) = 0 :: 1 :: 2 :: nil) by tauto.
  discriminate E.
Qed.

Lemma diagnostic_parent_iff_spatial_branch :
  ExecutionGoal.main_entail_wit_6 <-> diagnostic_spatial_branch.
Proof.
  change (diagnostic_spatial_branch \/ diagnostic_pure_branch <->
    diagnostic_spatial_branch).
  split.
  - intros [H | H]; [exact H | exfalso; exact (diagnostic_pure_branch_false H)].
  - intro H; left; exact H.
Qed.

(* This is the exact pointwise semantic characterization, with both
   original numeric premises retained. *)
Lemma diagnostic_parent_iff_models :
  ExecutionGoal.main_entail_wit_6 <->
  (forall (l : list Z) (r : Z), INT_MIN <= r -> r <= INT_MAX ->
   forall s : model,
   diagnostic_antecedent l r s -> diagnostic_consequent r s).
Proof.
  exact diagnostic_parent_iff_spatial_branch.
Qed.

Definition diagnostic_no_spatial_models : Prop :=
  forall (l : list Z) (r : Z) (s : model),
    ~ diagnostic_antecedent l r s.

Lemma diagnostic_vacuous_parent :
  diagnostic_no_spatial_models -> ExecutionGoal.main_entail_wit_6.
Proof.
  intro Hempty.
  apply diagnostic_parent_iff_models.
  intros l r Hlo Hhi s HA.
  exfalso; exact (Hempty l r s HA).
Qed.

Lemma diagnostic_refutation_requires_nonvacuity :
  ~ ExecutionGoal.main_entail_wit_6 -> ~ diagnostic_no_spatial_models.
Proof.
  intros Hneg Hempty.
  exact (Hneg (diagnostic_vacuous_parent Hempty)).
Qed.

(* Invalid local storage is one concrete source of vacuity.  No
   assumption that this local has a valid address is introduced. *)
Lemma diagnostic_invalid_local_has_no_models :
  ~ isvalidptr_int (&("zero_spec_399")) -> diagnostic_no_spatial_models.
Proof.
  intros Hinvalid l r s HA.
  unfold diagnostic_antecedent in HA.
  destruct HA as [sa [sz [Hjoin [Harray Hzero]]]].
  unfold store_int in Hzero.
  cbv [andp coq_prop] in Hzero.
  apply Hinvalid.
  tauto.
Qed.

Lemma diagnostic_invalid_local_vacuous_parent :
  ~ isvalidptr_int (&("zero_spec_399")) ->
  ExecutionGoal.main_entail_wit_6.
Proof.
  intro Hinvalid.
  apply diagnostic_vacuous_parent.
  exact (diagnostic_invalid_local_has_no_models Hinvalid).
Qed.

(* An explicit countermodel refutes the FULL parent, but this lemma
   does not provide that missing runtime countermodel. *)
Lemma diagnostic_countermodel_refutes_parent :
  forall (l : list Z) (r : Z) (s : model),
  INT_MIN <= r -> r <= INT_MAX ->
  diagnostic_antecedent l r s -> ~ diagnostic_consequent r s ->
  ~ ExecutionGoal.main_entail_wit_6.
Proof.
  intros l r s Hlo Hhi HA Hnot HB.
  apply diagnostic_parent_iff_models in HB.
  exact (Hnot (HB l r Hlo Hhi s HA)).
Qed.

Print Assumptions diagnostic_pure_branch_false.
Print Assumptions diagnostic_parent_iff_models.
Print Assumptions diagnostic_vacuous_parent.
Print Assumptions diagnostic_invalid_local_vacuous_parent.
Print Assumptions diagnostic_countermodel_refutes_parent.
