Require Import ReadCounterHeap ReadUnknown06Goal.
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




Require Import ReferenceProof.
Theorem case_06_return_refuted : ~ ReadUnknown06Goal.read_return_wit_1.
Proof. exact ReferenceProof.case_06_return_refuted. Qed.
Theorem case_06_spatial_refuted : ~ ReadUnknown06Goal.read_return_wit_1_split_goal_spatial.
Proof. exact ReferenceProof.case_06_spatial_refuted. Qed.
Theorem case_06_entry_sat : ReadUnknown06Goal.read_precondition_wit_1.
Proof. exact ReferenceProof.case_06_entry_sat. Qed.
Print Assumptions case_06_return_refuted.
Print Assumptions case_06_spatial_refuted.
Print Assumptions case_06_entry_sat.
