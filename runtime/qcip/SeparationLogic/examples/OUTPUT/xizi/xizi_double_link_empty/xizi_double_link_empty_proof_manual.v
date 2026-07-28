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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_empty Require Import xizi_double_link_empty_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_empty Require Import xizi_double_link_empty_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_empty_return_wit_1 : xizi_double_link_empty_return_wit_1.
Proof.
  left.
  intros linklist_pre nodes first last Hfirst Hhead.
  destruct nodes as [| node rest].
  - unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros.
    destruct H as [Hfirst_eq _].
    subst first.
    contradiction.
  - pose proof
      (xizi_dll_close linklist_pre first last (node :: rest)) as Hclose.
    unfold xizi_dll_links, XiziDLL.links in Hclose.
    sep_apply Hclose.
    entailer!.
    discriminate.
Qed.

Lemma proof_of_xizi_double_link_empty_return_wit_2 : xizi_double_link_empty_return_wit_2.
Proof.
  left.
  intros linklist_pre nodes first last Hfirst Hhead.
  destruct nodes as [| node rest].
  - unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros.
    destruct H as [Hfirst_eq Hlast_eq].
    subst first last.
    pose proof (xizi_dll_empty_rev linklist_pre) as Hclose.
    unfold xizi_dll_links, XiziDLL.links in Hclose.
    sep_apply Hclose.
    entailer!.
  - unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros next.
    Intros.
    subst node.
    contradiction.
Qed.
