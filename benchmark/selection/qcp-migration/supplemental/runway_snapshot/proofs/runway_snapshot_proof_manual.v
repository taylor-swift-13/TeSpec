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
Require Import runway_snapshot_goal.

Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Local Open Scope sac.

Ltac choose_tick_branch c t wd wa d a :=
 match goal with
 | |- ?P |-- ?A || ?B => first [eapply derivable1_trans; [|apply derivable1_orp_intros1]; choose_tick_branch c t wd wa d a | eapply derivable1_trans; [|apply derivable1_orp_intros2]; choose_tick_branch c t wd wa d a]
 | _ => Exists c (t+1) wd wa d a; entailer!; lia
 end.
Lemma proof_of_tick_return_wit_16 : tick_return_wit_16.
Proof. unfold tick_return_wit_16; intros; choose_tick_branch c0 t0 wd0 wa0 d0 a0. Qed.
