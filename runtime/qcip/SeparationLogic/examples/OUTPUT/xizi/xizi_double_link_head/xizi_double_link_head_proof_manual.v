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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_head Require Import xizi_double_link_head_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_head Require Import xizi_double_link_head_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_head_return_wit_1 : xizi_double_link_head_return_wit_1.
Proof.
  pre_process.
  subst first.
  destruct nodes as [| node nodes].
  - unfold xizi_dllseg, XiziDLL.dllseg at 1.
    simpl.
    Intros.
    destruct H as [_ Hlast].
    subst last.
    unfold xizi_double_link_head_lib.xizi_double_link_head_value.
    change (xizi_dll_links linklist_pre linklist_pre linklist_pre |--
      “ 0 = 0 ” && xizi_dll linklist_pre nil).
    sep_apply xizi_dll_empty_rev.
    entailer!.
  - unfold xizi_dllseg, XiziDLL.dllseg at 1.
    simpl.
    Intros next.
    Intros.
    tauto.
Qed.

Lemma proof_of_xizi_double_link_head_return_wit_2 : xizi_double_link_head_return_wit_2.
Proof.
  pre_process.
  destruct nodes as [| node nodes].
  - unfold xizi_dllseg, XiziDLL.dllseg at 1.
    simpl.
    Intros.
    destruct H as [Hfirst _].
    contradiction.
  - unfold xizi_dllseg, XiziDLL.dllseg at 1.
    simpl.
    Intros next.
    Intros.
    subst node.
    unfold xizi_double_link_head_lib.xizi_double_link_head_value.
    unfold xizi_dll, XiziDLL.dll.
    Exists first last.
    simpl.
    Exists next.
    unfold XiziDLL.links.
    entailer!.
Qed.
