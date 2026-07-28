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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_remove_node Require Import xizi_double_link_remove_node_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_remove_node Require Import xizi_double_link_remove_node_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_remove_node Require Import xizi_double_link_remove_node_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_remove_node_entail_wit_1 : xizi_double_link_remove_node_entail_wit_1.
Proof.
  left. intros.
  assert (Hfrom : forall node prev stop last nodes,
    xizi_dllseg node prev stop last nodes **
    &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last |--
    &(node # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev **
    xizi_dllseg_shift_rev node stop nodes).
  { intros node prev stop last nodes. revert node prev.
    induction nodes as [| expected rest IH]; intros node prev.
    - simpl. Intros. destruct H. subst node. subst prev. entailer!.
    - simpl. Intros next. Intros. subst node.
      sep_apply IH. Exists next. entailer!. }
  assert (Hfocus : forall prefix start prev stop last removed suffix,
    &(prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> start **
    xizi_dllseg start prev stop last (prefix ++ removed :: suffix) **
    &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last |--
    EX node_next node_prev,
      “ removed <> NULL ” &&
      xizi_dllseg_shift prev node_prev prefix **
      &(node_prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> removed **
      &(removed # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
      &(removed # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node_prev **
      &(node_next # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> removed **
      xizi_dllseg_shift_rev node_next stop suffix).
  { intros pref. induction pref as [| current pref IH];
      intros start prev stop last removed suffix0.
    - simpl. Intros node_next. Intros. subst start.
      sep_apply Hfrom. Exists node_next prev. simpl. entailer!.
    - simpl. Intros next. Intros. subst start.
      assert (Hframe :
        XiziDLL.links current next prev **
        (xizi_dllseg next current stop last (pref ++ removed :: suffix0) **
        (&(prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> current **
         &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last)) |--
        (&(current # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> next **
         xizi_dllseg next current stop last (pref ++ removed :: suffix0) **
         &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last) **
        (&(current # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev **
         &(prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> current)).
      { unfold XiziDLL.links. entailer!. }
      lazymatch goal with
      | |- _ |-- ?Q =>
          change (XiziDLL.links current next prev **
            (xizi_dllseg next current stop last (pref ++ removed :: suffix0) **
            (&(prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> current **
             &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last)) |-- Q)
      end.
      rewrite Hframe.
      sep_apply (IH next current stop last removed suffix0).
      Intros node_next node_prev.
      Exists node_next node_prev. simpl. entailer!. }
  unfold xizi_dll, XiziDLL.dll. Intros first last.
  unfold xizi_dll_links, XiziDLL.links.
  assert (Hroot :
    (&(head # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> first **
     &(head # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last) **
    xizi_dllseg first head head last
      (prefix ++ linklist_node_pre :: suffix) |--
    &(head # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> first **
    xizi_dllseg first head head last
      (prefix ++ linklist_node_pre :: suffix) **
    &(head # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last).
  { entailer!. }
  lazymatch goal with
  | |- _ |-- ?Q =>
      change (((&(head # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> first **
                 &(head # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last) **
               xizi_dllseg first head head last
                 (prefix ++ linklist_node_pre :: suffix)) |-- Q)
  end.
  rewrite Hroot.
  rewrite (Hfocus prefix first head head last linklist_node_pre suffix).
  Intros node_next node_prev.
  Exists node_next node_prev. entailer!.
Qed.

Lemma proof_of_xizi_double_link_remove_node_return_wit_1 : xizi_double_link_remove_node_return_wit_1.
Proof.
  left. intros.
  assert (Hto : forall node prev stop nodes,
    &(node # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev **
    xizi_dllseg_shift_rev node stop nodes |--
    EX last,
      &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last **
      xizi_dllseg node prev stop last nodes).
  { intros node prev stop nodes. revert node prev.
    induction nodes as [| expected rest IH]; intros node prev.
    - simpl. Intros. subst node. Exists prev. simpl. entailer!.
    - simpl. Intros next. Intros. subst node.
      sep_apply IH. Intros last.
      Exists last. simpl. Exists next. entailer!. }
  assert (Hprev_neq : forall p q v1 v2,
    &(p # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> v1 **
    &(q # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> v2 |--
    “ p <> q ”).
  { intros p q v1 v2. destruct (Z.eq_dec p q) as [Heq | Hneq].
    - subst q.
      sep_apply (dup_store_ptr
        (&(p # "SysDoubleLinklistNode" ->ₛ "node_prev")) v1 v2).
      entailer!.
    - entailer!. }
  assert (Hrebuild : forall prefix0 prev node_prev0 node stop suffix0,
    xizi_dllseg_shift prev node_prev0 prefix0 **
    &(node_prev0 # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node **
    &(node # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node_prev0 **
    xizi_dllseg_shift_rev node stop suffix0 |--
    EX first last,
      &(prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> first **
      xizi_dllseg first prev stop last (prefix0 ++ suffix0) **
      &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last).
  { intros pref. induction pref as [| current pref IH];
      intros prev node_prev0 node stop suffix0.
    - simpl. Intros. subst node_prev0. sep_apply Hto.
      Intros last. Exists node last. entailer!.
    - simpl. Intros. sep_apply IH. Intros first last.
      prop_apply (Hprev_neq current stop prev last). Intros.
      Exists current last. simpl. Exists first.
      unfold XiziDLL.links. entailer!. }
  assert (Hreturn_frame :
    xizi_dllseg_shift head node_prev prefix **
    &(node_prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
    &(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr
      |-> linklist_node_pre **
    &(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr
      |-> linklist_node_pre **
    &(node_next # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node_prev **
    xizi_dllseg_shift_rev node_next head suffix |--
    (xizi_dllseg_shift head node_prev prefix **
     &(node_prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
     &(node_next # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node_prev **
     xizi_dllseg_shift_rev node_next head suffix) **
    (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr
       |-> linklist_node_pre **
     &(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr
       |-> linklist_node_pre)).
  { entailer!. }
  lazymatch goal with
  | |- _ |-- ?Q =>
      change ((xizi_dllseg_shift head node_prev prefix **
        &(node_prev # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
        &(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr
          |-> linklist_node_pre **
        &(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr
          |-> linklist_node_pre **
        &(node_next # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node_prev **
        xizi_dllseg_shift_rev node_next head suffix) |-- Q)
  end.
  rewrite Hreturn_frame.
  rewrite (Hrebuild prefix head node_prev node_next head suffix).
  Intros first last.
  unfold xizi_dll, XiziDLL.dll.
  Exists first last linklist_node_pre linklist_node_pre.
  simpl. unfold XiziDLL.links.
  entailer!.
Qed.
