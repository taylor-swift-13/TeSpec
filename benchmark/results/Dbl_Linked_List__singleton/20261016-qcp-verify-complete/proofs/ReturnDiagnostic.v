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
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.


Theorem primary_singleton_safety_wit_1 : PrimaryQcpGoal.singleton_safety_wit_1.
Proof.
  unfold PrimaryQcpGoal.singleton_safety_wit_1.
  intros element_pre e retval PreH1 PreH2 h Hheap.
  split.
  - change (0 <= 2147483647)%Z. lia.
  - change (-2147483648 <= 0)%Z. lia.
Qed.
Theorem primary_singleton_safety_wit_2 : PrimaryQcpGoal.singleton_safety_wit_2.
Proof.
  unfold PrimaryQcpGoal.singleton_safety_wit_2.
  intros element_pre e retval PreH1 PreH2 h Hheap.
  split.
  - change (0 <= 2147483647)%Z. lia.
  - change (-2147483648 <= 0)%Z. lia.
Qed.
Theorem primary_singleton_return_wit_1 : PrimaryQcpGoal.singleton_return_wit_1.
Proof.
  unfold PrimaryQcpGoal.singleton_return_wit_1.
  intros element_pre e retval PreH1 PreH2.
  subst element_pre.
  unfold Dll.
  intros h Hheap.
  right.
  split; [exact PreH1 |].
  exists 0, 0.
  cbn [DLLLeft DLLRight].
  revert h Hheap.
  entailer!.
Show.
Abort.
