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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_head_rec Require Import xizi_double_link_head_rec_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_head_rec Require Import xizi_double_link_head_rec_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_head_rec
      Require Import xizi_double_link_head_rec_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_head_rec_return_wit_1 : xizi_double_link_head_rec_return_wit_1.
Proof.
  aggressive_pre_process.
  subst first.
  destruct nodes as [| node rest].
  - simpl xizi_double_link_head_rec_value.
    entailer!.
  - unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros next.
    Intros.
    contradiction.
Qed.

Lemma proof_of_xizi_double_link_head_rec_return_wit_2 : xizi_double_link_head_rec_return_wit_2.
Proof.
  pre_process.
  destruct nodes as [| node rest].
  - unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros.
    destruct H as [Hsame _].
    contradiction.
  - unfold xizi_double_link_head_rec_value.
    unfold xizi_dll, XiziDLL.dll.
    unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros next.
    Intros.
    subst node.
    Exists first last.
    Exists next.
    unfold XiziDLL.links.
    entailer!.
Qed.
