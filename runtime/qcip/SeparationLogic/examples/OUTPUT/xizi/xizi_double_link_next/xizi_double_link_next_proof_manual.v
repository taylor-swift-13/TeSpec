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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next Require Import xizi_double_link_next_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next Require Import xizi_double_link_next_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next Require Import xizi_double_link_next_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_next_entail_wit_1 : xizi_double_link_next_entail_wit_1.
Proof.
  pre_process.
  assert (Hptr_neq : forall p q v w,
    store_ptr p v ** store_ptr q w |-- “ p <> q ”).
  {
    intros p q v w.
    unfold store_ptr.
    Intros.
    sep_apply_l_atomic (store_4byte_store_4byte_noinit p v).
    sep_apply_l_atomic (store_4byte_store_4byte_noinit q w).
    prop_apply (store_4byte_valid p q).
    Intros.
    entailer!.
  }
  assert (Hsplit : forall first prev last before,
    xizi_dllseg first prev linklist_pre last
      (before ++ linklist_node_pre :: nodes_after) |--
    EX node_next node_prev,
      xizi_dllseg first prev linklist_node_pre node_prev before **
      xizi_dll_links linklist_node_pre node_next node_prev **
      xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after).
  {
    intros first prev last before.
    revert first prev.
    induction before as [| a before IH]; intros first prev.
    - simpl.
      unfold xizi_dllseg, XiziDLL.dllseg.
      simpl.
      Intros next.
      Intros.
      subst first.
      Exists next prev.
      unfold xizi_dll_links, XiziDLL.links.
      entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros next.
      Intros.
      sep_apply_l_atomic (IH next first).
      Intros node_next node_prev.
      unfold xizi_dll_links, XiziDLL.links in *.
      sepcon_assoc_change.
      prop_apply_p (Hptr_neq
        (&(first # "SysDoubleLinklistNode" ->ₛ "node_next"))
        (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next"))
        next node_next).
      Intros.
      Exists node_next node_prev.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Exists next.
      entailer!.
      intro Heq.
      rewrite Heq in H2.
      apply H2.
      reflexivity.
  }
  unfold xizi_dll, XiziDLL.dll.
  Intros first last.
  sep_apply_l_atomic (Hsplit first linklist_pre last nodes_before).
  Intros node_next node_prev.
  Exists node_next node_prev last first.
  unfold xizi_dll_links, XiziDLL.links.
  entailer!.
Qed.

Lemma proof_of_xizi_double_link_next_return_wit_1 : xizi_double_link_next_return_wit_1.
Proof.
  pre_process.
  assert (Hptr_neq : forall p q v w,
    store_ptr p v ** store_ptr q w |-- “ p <> q ”).
  {
    intros p q v w.
    unfold store_ptr.
    Intros.
    sep_apply_l_atomic (store_4byte_store_4byte_noinit p v).
    sep_apply_l_atomic (store_4byte_store_4byte_noinit q w).
    prop_apply (store_4byte_valid p q).
    Intros.
    entailer!.
  }
  assert (Hjoin : forall sentinel_first first0 start_prev prev0 last0 before,
    &(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
    (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
     (xizi_dllseg first0 start_prev linklist_node_pre prev0 before **
      (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
       (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev0 **
        xizi_dllseg node_next linklist_node_pre linklist_pre last0 nodes_after)))) |--
    (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
     (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
      xizi_dllseg first0 start_prev linklist_pre last0
        (before ++ linklist_node_pre :: nodes_after)))).
  {
    intros sentinel_first first0 start_prev prev0 last0 before.
    revert sentinel_first first0 start_prev prev0.
    induction before as [| a before IH]; intros sentinel_first first0 start_prev prev0.
    - simpl.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros.
      destruct H as [Hfirst Hprev].
      subst first0; subst prev0.
      unfold xizi_dll_links, XiziDLL.links in *.
      sepcon_assoc_change.
      prop_apply_p (Hptr_neq
        (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next"))
        (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next"))
        sentinel_first node_next).
      Intros.
      assert (Hnode_head : linklist_node_pre <> linklist_pre).
      { intro Heq; rewrite Heq in H; apply H; reflexivity. }
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Exists node_next.
      entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros next0.
      Intros.
      unfold xizi_dll_links, XiziDLL.links in *.
      sepcon_assoc_change.
      prop_apply_p (Hptr_neq
        (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next"))
        (&(first0 # "SysDoubleLinklistNode" ->ₛ "node_next"))
        sentinel_first next0).
      Intros.
      assert (Hfirst_head : first0 <> linklist_pre).
      { intro Heq; rewrite Heq in H2; apply H2; reflexivity. }
      unfold xizi_dllseg, XiziDLL.links in IH.
      fold XiziDLL.dllseg.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Exists next0.
      split_pure_spatial.
      + cancel (&(first0 # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> start_prev).
        cancel (&(first0 # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> next0).
        transitivity
          (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
           (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
            (xizi_dllseg next0 first0 linklist_node_pre prev0 before **
             (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
              (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev0 **
               xizi_dllseg node_next linklist_node_pre linklist_pre last0 nodes_after))))).
        * entailer!.
        * transitivity
            (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
             (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
              xizi_dllseg next0 first0 linklist_pre last0
                (before ++ linklist_node_pre :: nodes_after))).
          -- exact (IH sentinel_first next0 first0 prev0).
          -- entailer!.
      + entailer!.
  }
  unfold xizi_dll, XiziDLL.dll.
  Exists first last.
  sepcon_assoc_change.
  split_pure_spatial.
  - sepcon_assoc_change.
    subst_all_strings.
    unfold XiziDLL.links.
    transitivity
      (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> first **
       (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last **
        xizi_dllseg first linklist_pre linklist_pre last
          (nodes_before ++ linklist_node_pre :: nodes_after))).
    + exact (Hjoin first first linklist_pre node_prev last nodes_before).
    + entailer!.
  - subst node_next.
    assert (Hseg_nil : forall prev0 last0 nodes,
      xizi_dllseg linklist_pre prev0 linklist_pre last0 nodes |--
      “ nodes = nil ”).
    {
      intros prev0 last0 nodes.
      destruct nodes as [| a rest].
      + entailer!.
      + unfold xizi_dllseg, XiziDLL.dllseg.
        simpl.
        Intros next0.
        Intros.
        contradiction.
    }
    prop_apply_p (Hseg_nil linklist_node_pre last nodes_after).
    Intros.
    dump_pre_spatial.
    subst nodes_after.
    reflexivity.
Qed.

Lemma proof_of_xizi_double_link_next_return_wit_2 : xizi_double_link_next_return_wit_2.
Proof.
  pre_process.
  assert (Hptr_neq : forall p q v w,
    store_ptr p v ** store_ptr q w |-- “ p <> q ”).
  {
    intros p q v w.
    unfold store_ptr.
    Intros.
    sep_apply_l_atomic (store_4byte_store_4byte_noinit p v).
    sep_apply_l_atomic (store_4byte_store_4byte_noinit q w).
    prop_apply (store_4byte_valid p q).
    Intros.
    entailer!.
  }
  assert (Hjoin : forall sentinel_first first0 start_prev prev0 last0 before,
    &(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
    (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
     (xizi_dllseg first0 start_prev linklist_node_pre prev0 before **
      (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
       (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev0 **
        xizi_dllseg node_next linklist_node_pre linklist_pre last0 nodes_after)))) |--
    (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
     (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
      xizi_dllseg first0 start_prev linklist_pre last0
        (before ++ linklist_node_pre :: nodes_after)))).
  {
    intros sentinel_first first0 start_prev prev0 last0 before.
    revert sentinel_first first0 start_prev prev0.
    induction before as [| a before IH]; intros sentinel_first first0 start_prev prev0.
    - simpl.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros.
      destruct H as [Hfirst Hprev].
      subst first0; subst prev0.
      unfold xizi_dll_links, XiziDLL.links in *.
      sepcon_assoc_change.
      prop_apply_p (Hptr_neq
        (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next"))
        (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next"))
        sentinel_first node_next).
      Intros.
      assert (Hnode_head : linklist_node_pre <> linklist_pre).
      { intro Heq; rewrite Heq in H; apply H; reflexivity. }
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Exists node_next.
      entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros next0.
      Intros.
      unfold xizi_dll_links, XiziDLL.links in *.
      sepcon_assoc_change.
      prop_apply_p (Hptr_neq
        (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next"))
        (&(first0 # "SysDoubleLinklistNode" ->ₛ "node_next"))
        sentinel_first next0).
      Intros.
      assert (Hfirst_head : first0 <> linklist_pre).
      { intro Heq; rewrite Heq in H2; apply H2; reflexivity. }
      unfold xizi_dllseg, XiziDLL.links in IH.
      fold XiziDLL.dllseg.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Exists next0.
      split_pure_spatial.
      + cancel (&(first0 # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> start_prev).
        cancel (&(first0 # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> next0).
        transitivity
          (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
           (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
            (xizi_dllseg next0 first0 linklist_node_pre prev0 before **
             (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> node_next **
              (&(linklist_node_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> prev0 **
               xizi_dllseg node_next linklist_node_pre linklist_pre last0 nodes_after))))).
        * entailer!.
        * transitivity
            (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> sentinel_first **
             (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last0 **
              xizi_dllseg next0 first0 linklist_pre last0
                (before ++ linklist_node_pre :: nodes_after))).
          -- exact (IH sentinel_first next0 first0 prev0).
          -- entailer!.
      + entailer!.
  }
  unfold xizi_dll, XiziDLL.dll.
  Exists first last.
  sepcon_assoc_change.
  split_pure_spatial.
  - sepcon_assoc_change.
    subst_all_strings.
    unfold XiziDLL.links.
    transitivity
      (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> first **
       (&(linklist_pre # "SysDoubleLinklistNode" ->ₛ "node_prev") # Ptr |-> last **
        xizi_dllseg first linklist_pre linklist_pre last
          (nodes_before ++ linklist_node_pre :: nodes_after))).
    + exact (Hjoin first first linklist_pre node_prev last nodes_before).
    + entailer!.
  - assert (Hseg_value : forall node0 prev0 last0 nodes,
      node0 <> linklist_pre ->
      xizi_dllseg node0 prev0 linklist_pre last0 nodes |--
      “ node0 = xizi_double_link_next_value nodes ”).
    {
      intros node0 prev0 last0 nodes Hneq.
      destruct nodes as [| a rest].
      + unfold xizi_dllseg, XiziDLL.dllseg.
        simpl.
        Intros.
        destruct H as [Heq _].
        exfalso.
        apply Hneq.
        exact Heq.
      + unfold xizi_dllseg, XiziDLL.dllseg.
        simpl.
        Intros next0.
        Intros.
        unfold xizi_double_link_next_value.
        simpl.
        entailer!.
    }
    prop_apply_p (Hseg_value node_next linklist_node_pre last nodes_after PreH1).
    Intros.
    dump_pre_spatial.
    assumption.
Qed.
