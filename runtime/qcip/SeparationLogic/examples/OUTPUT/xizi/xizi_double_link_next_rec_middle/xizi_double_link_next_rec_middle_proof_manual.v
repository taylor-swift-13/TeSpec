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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_middle Require Import xizi_double_link_next_rec_middle_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_middle Require Import xizi_double_link_next_rec_middle_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_middle Require Import xizi_double_link_next_rec_middle_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_next_rec_middle_entail_wit_1 : xizi_double_link_next_rec_middle_entail_wit_1.
Proof.
  assert (Hnext_neq : forall p pnext q qnext,
    &(q # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> qnext **
    &(p # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> pnext |--
    “ p <> q ”).
  {
    intros p pnext q qnext.
    destruct (Z.eq_dec p q) as [Heq | Hne].
    - subst q.
      sep_apply
        (dup_store_ptr
           (&(p # "SysDoubleLinklistNode" ->ₛ "node_next")) qnext pnext).
      entailer!.
    - entailer!.
  }
  assert (Hlinks_neq : forall p pnext pprev q qnext qprev,
    xizi_dll_links p pnext pprev ** xizi_dll_links q qnext qprev |--
    “ p <> q ”).
  {
    intros.
    unfold xizi_dll_links, XiziDLL.links.
    prop_apply_p (Hnext_neq p pnext q qnext).
    Intros_p Hneq.
    entailer!.
  }
  assert (Hsplit : forall start prev stop last nodes_before node nodes_after,
    xizi_dllseg start prev stop last (nodes_before ++ node :: nodes_after) |--
    EX node_prev node_next,
      xizi_dllseg start prev node node_prev nodes_before **
      xizi_dll_links node node_next node_prev **
      xizi_dllseg node_next node stop last nodes_after).
  {
    intros start prev stop last nodes_before.
    revert start prev.
    induction nodes_before as [| first rest IH];
      intros start prev node nodes_after.
    - simpl.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros node_next.
      Intros.
      subst start.
      Exists prev node_next.
      simpl.
      entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros next.
      Intros.
      subst start.
      sep_apply (IH next first node nodes_after).
      Intros node_prev node_next.
      fold xizi_dll_links.
      prop_apply_p
        (Hlinks_neq node node_next node_prev first next prev).
      Intros_p Hnode_first.
      Exists node_prev node_next.
      simpl.
      Exists next.
      entailer!.
  }
  pre_process.
  subst linklist_pre; subst linklist_node_pre.
  unfold xizi_dll, XiziDLL.dll.
  Intros first last.
  sep_apply
    (Hsplit
       first head head last nodes_before node nodes_after).
  Intros node_prev node_next.
  unfold xizi_dll_links, XiziDLL.links.
  Exists node_next node_prev last first.
  entailer!.
Qed.

Lemma proof_of_xizi_double_link_next_rec_middle_return_wit_1 : xizi_double_link_next_rec_middle_return_wit_1.
Proof.
  assert (Hnext_neq : forall p pnext q qnext,
    &(q # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> qnext **
    &(p # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> pnext |--
    “ p <> q ”).
  {
    intros p pnext q qnext.
    destruct (Z.eq_dec p q) as [Heq | Hne].
    - subst q.
      sep_apply
        (dup_store_ptr
           (&(p # "SysDoubleLinklistNode" ->ₛ "node_next")) qnext pnext).
      entailer!.
    - entailer!.
  }
  assert (Hreassemble :
    forall sentinel_first sentinel_last start prev stop last nodes_before
           node nodes_after node_prev node_next,
      node <> NULL ->
      xizi_dllseg start prev node node_prev nodes_before **
      (&(node # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
       (&(node # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node_prev **
        (&(stop # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
         (&(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> sentinel_last **
          xizi_dllseg node_next node stop last nodes_after)))) |--
      xizi_dllseg start prev stop last (nodes_before ++ node :: nodes_after) **
      (&(stop # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
       &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> sentinel_last)).
  {
    intros sentinel_first sentinel_last start prev stop last nodes_before.
    revert start prev.
    induction nodes_before as [| first rest IH];
      intros start prev node nodes_after node_prev node_next Hnode_null.
    - simpl.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros.
      destruct H as [Hstart Hprev].
      subst start; subst prev.
      prop_apply_p (Hnext_neq node node_next stop sentinel_first).
      Intros_p Hnode_stop.
      unfold XiziDLL.links.
      Exists node_next.
      entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros next.
      Intros.
      subst start.
      fold XiziDLL.dllseg.
      fold xizi_dllseg.
      rewrite (IH next first node nodes_after node_prev node_next Hnode_null).
      unfold XiziDLL.links.
      prop_apply_p (Hnext_neq first next stop sentinel_first).
      Intros_p Hfirst_stop.
      Exists next.
      entailer!.
  }
  pre_process.
  subst node_next; subst linklist_pre; subst linklist_node_pre.
  destruct nodes_after as [| after rest].
  - simpl xizi_double_link_next_value.
    sepcon_lift
      ((&(head # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> last).
    sepcon_lift
      ((&(head # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> first).
    sepcon_lift (xizi_dllseg head node head last nil).
    sepcon_lift
      ((&(node # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> node_prev).
    sepcon_lift
      ((&(node # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> head).
    sepcon_lift (xizi_dllseg first head node node_prev nodes_before).
    sepcon_lift (xizi_dllseg head node head last nil).
    sepcon_lift
      ((&(node # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> node_prev).
    sepcon_lift
      ((&(node # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> head).
    sepcon_lift (xizi_dllseg first head node node_prev nodes_before).
    rewrite
      (Hreassemble
         first last first head head last nodes_before node nil node_prev head
         PreH4).
    unfold xizi_dll, XiziDLL.dll.
    Exists first last.
    unfold xizi_dllseg, XiziDLL.links.
    entailer!.
  - cbn [xizi_dllseg XiziDLL.dllseg].
    Intros next.
    Intros.
    contradiction.
Qed.

Lemma proof_of_xizi_double_link_next_rec_middle_return_wit_2 : xizi_double_link_next_rec_middle_return_wit_2.
Proof.
  assert (Hnext_neq : forall p pnext q qnext,
    &(q # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> qnext **
    &(p # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> pnext |--
    “ p <> q ”).
  {
    intros p pnext q qnext.
    destruct (Z.eq_dec p q) as [Heq | Hne].
    - subst q.
      sep_apply
        (dup_store_ptr
           (&(p # "SysDoubleLinklistNode" ->ₛ "node_next")) qnext pnext).
      entailer!.
    - entailer!.
  }
  assert (Hreassemble :
    forall sentinel_first sentinel_last start prev stop last nodes_before
           node nodes_after node_prev node_next,
      node <> NULL ->
      xizi_dllseg start prev node node_prev nodes_before **
      (&(node # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
       (&(node # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> node_prev **
        (&(stop # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
         (&(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> sentinel_last **
          xizi_dllseg node_next node stop last nodes_after)))) |--
      xizi_dllseg start prev stop last (nodes_before ++ node :: nodes_after) **
      (&(stop # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
       &(stop # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> sentinel_last)).
  {
    intros sentinel_first sentinel_last start prev stop last nodes_before.
    revert start prev.
    induction nodes_before as [| first rest IH];
      intros start prev node nodes_after node_prev node_next Hnode_null.
    - simpl.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros.
      destruct H as [Hstart Hprev].
      subst start; subst prev.
      prop_apply_p (Hnext_neq node node_next stop sentinel_first).
      Intros_p Hnode_stop.
      unfold XiziDLL.links.
      Exists node_next.
      entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros next.
      Intros.
      subst start.
      fold XiziDLL.dllseg.
      fold xizi_dllseg.
      rewrite (IH next first node nodes_after node_prev node_next Hnode_null).
      unfold XiziDLL.links.
      prop_apply_p (Hnext_neq first next stop sentinel_first).
      Intros_p Hfirst_stop.
      Exists next.
      entailer!.
  }
  assert (Hcons_head : forall node prev stop last expected rest,
    xizi_dllseg node prev stop last (expected :: rest) |--
    “ node = expected ”).
  {
    intros.
    unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros next.
    Intros.
    entailer!.
  }
  left.
  pre_process.
  subst linklist_pre; subst linklist_node_pre.
  destruct nodes_after as [| after rest].
  - cbn [xizi_dllseg XiziDLL.dllseg].
    Intros.
    destruct H as [Hsame Hlast].
    contradiction.
  - prop_apply_p
      (Hcons_head
         node_next node head last after rest).
    Intros_p Hhead.
    subst after.
    sepcon_lift
      ((&(head # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> last).
    sepcon_lift
      ((&(head # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> first).
    sepcon_lift (xizi_dllseg node_next node head last (node_next :: rest)).
    sepcon_lift
      ((&(node # "SysDoubleLinklistNode" ->ₛ "node_prev")) # Ptr |-> node_prev).
    sepcon_lift
      ((&(node # "SysDoubleLinklistNode" ->ₛ "node_next")) # Ptr |-> node_next).
    sepcon_lift (xizi_dllseg first head node node_prev nodes_before).
    rewrite
      (Hreassemble
         first last first head head last nodes_before node
         (node_next :: rest) node_prev node_next PreH4).
    unfold xizi_dll, XiziDLL.dll.
    Exists first last.
    simpl xizi_double_link_next_value.
    unfold xizi_dllseg, XiziDLL.links.
    entailer!.
Qed.
