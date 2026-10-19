Require Import ConcreteCell ExecutionGoal.
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
Theorem entry_cell : (4096 # UInt |-> (4294967294)) (st (cell 255 255 255 254)).
Proof. exact ReferenceProof.entry_cell. Qed.
Theorem exit_cell : (4096 # UInt |-> (4294967295)) (st (cell 255 255 255 255)).
Proof. exact ReferenceProof.exit_cell. Qed.
Theorem refute_incr_return_wit_1_split_goal_spatial : ~ ExecutionGoal.incr_return_wit_1_split_goal_spatial.
Proof. exact ReferenceProof.refute_incr_return_wit_1_split_goal_spatial. Qed.
Theorem refute_incr_return_wit_1 : ~ ExecutionGoal.incr_return_wit_1.
Proof. exact ReferenceProof.refute_incr_return_wit_1. Qed.
Theorem entry_sat : ExecutionGoal.incr_precondition_wit_1.
Proof. exact ReferenceProof.entry_sat. Qed.
Print Assumptions entry_cell.
Print Assumptions exit_cell.
Print Assumptions refute_incr_return_wit_1_split_goal_spatial.
Print Assumptions refute_incr_return_wit_1.
Print Assumptions entry_sat.
