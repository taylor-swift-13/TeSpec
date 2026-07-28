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
From SimpleC.EE.Verification.xizi.xizi_double_link_init Require Import xizi_double_link_init_goal.
From SimpleC.EE.Verification.xizi.xizi_double_link_init Require Import xizi_double_link_init_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Require Import QCIPLib.xizi.xizi_double_link_common.xizi_double_link_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_init_return_wit_1 : xizi_double_link_init_return_wit_1.
Proof.
  pre_process.
  exact (xizi_dll_nil_rev linklist_head_pre).
Qed.
