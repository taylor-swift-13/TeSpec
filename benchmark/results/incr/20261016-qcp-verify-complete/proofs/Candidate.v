Require Import PrimaryQcpGoal.
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


Theorem primary_incr_safety_wit_1 : PrimaryQcpGoal.incr_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.incr_safety_wit_1.
  intros p_pre v PreH1 PreH2 h Hheap.
  change ((1 <= 2147483647) /\ (-2147483648 <= 1)).
  lia.
Qed.
Theorem primary_incr_return_wit_1 : PrimaryQcpGoal.incr_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.incr_return_wit_1.
  left.
  intros p_pre v PreH1 PreH2.
  assert (Heq : unsigned_last_nbits (v + 1) 32 =
                (v + 1) % 4294967296).
  { change (Z.modulo (v + 1) 4294967296 =
            Z.rem (v + 1) 4294967296).
    symmetry.
    apply Z.rem_mod_nonneg; lia. }
  rewrite Heq.
  intros h Hheap.
  exact Hheap.
Qed.
Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.
Definition proof_of_incr_safety_wit_1 := primary_incr_safety_wit_1.
Definition proof_of_incr_return_wit_1 := primary_incr_return_wit_1.
End PrimaryCertificate.
Print Assumptions primary_incr_safety_wit_1.
Print Assumptions primary_incr_return_wit_1.
