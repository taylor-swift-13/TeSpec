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
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_last Require Import xizi_double_link_next_rec_last_goal.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_last Require Import xizi_double_link_next_rec_last_proof_auto.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
From QCIPLib.xizi.xizi_double_link_common Require Import xizi_double_link_lib.
From SimpleC.EE.OUTPUT.xizi.xizi_double_link_next_rec_last
      Require Import xizi_double_link_next_rec_last_lib.
Local Open Scope sac.

Lemma proof_of_xizi_double_link_next_rec_last_entail_wit_1 : xizi_double_link_next_rec_last_entail_wit_1.
Proof.
  assert (Hlinks_neq_framed : forall a an ap b bn bp P Q,
    P ** (xizi_dll_links b bn bp ** (Q ** XiziDLL.links a an ap)) |--
    “ a <> b ” &&
    (P ** (xizi_dll_links b bn bp ** (Q ** XiziDLL.links a an ap)))).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity ((&( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an **
                     &( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> bn) ** TT).
      + entailer!.
        apply derivable1_truep_intros.
      + sep_apply (dup_store_ptr
          (&( a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hsplit : forall nodes_before first prev selected stop last nodes_after,
    xizi_dllseg first prev stop last (nodes_before ++ selected :: nodes_after) |--
    EX node_prev next,
      xizi_dllseg first prev selected node_prev nodes_before **
      xizi_dll_links selected next node_prev **
      xizi_dllseg next selected stop last nodes_after).
  {
    induction nodes_before as [| a nodes_before IH]; intros.
    - simpl.
      unfold xizi_dllseg, XiziDLL.dllseg.
      simpl.
      Intros next.
      Intros.
      subst first.
      Exists prev next.
      simpl.
      entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros next.
      Intros.
      subst first.
      sep_apply (IH next a selected stop last nodes_after).
      Intros node_prev selected_next.
      etransitivity.
      + apply (Hlinks_neq_framed
          a next prev selected selected_next node_prev
          (xizi_dllseg next a selected node_prev nodes_before)
          (xizi_dllseg selected_next selected stop last nodes_after)).
      + Intros_p Hneq.
        Exists node_prev selected_next.
        simpl.
        Exists next.
        unfold xizi_dll_links, XiziDLL.links.
        entailer!.
  }
  pre_process.
  sep_apply xizi_dll_open.
  Intros first last.
  sep_apply (Hsplit nodes_before first linklist_pre linklist_node_pre linklist_pre last nodes_after).
  Intros node_prev node_next.
  unfold xizi_dll_links, XiziDLL.links.
  Exists node_next node_prev last first.
  entailer!.
Qed.

Lemma proof_of_xizi_double_link_next_rec_last_return_wit_1 : xizi_double_link_next_rec_last_return_wit_1.
Proof.
  assert (Hstop_nil : forall P Q R stop prev last nodes,
    P ** (Q ** (R ** xizi_dllseg stop prev stop last nodes)) |--
    “ nodes = nil ” &&
    (P ** (Q ** (R ** xizi_dllseg stop prev stop last nodes)))).
  {
    intros.
    destruct nodes as [| a nodes].
    - entailer!.
    - unfold xizi_dllseg, XiziDLL.dllseg.
      simpl.
      Intros next.
      Intros.
      congruence.
  }
  assert (Hlinks_neq_tail : forall a an ap b bn bp Q,
    xizi_dll_links a an ap ** (xizi_dll_links b bn bp ** Q) |--
    “ a <> b ” &&
    (xizi_dll_links a an ap ** (xizi_dll_links b bn bp ** Q))).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity ((&( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an **
                     &( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> bn) ** TT).
      + entailer!.
        apply derivable1_truep_intros.
      + sep_apply (dup_store_ptr
          (&( a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hlinks_neq_outer_tail2 : forall a an ap b bn bp P Q R,
    xizi_dll_links b bn bp ** (P ** (Q ** (R ** xizi_dll_links a an ap))) |--
    “ a <> b ” &&
    (xizi_dll_links b bn bp ** (P ** (Q ** (R ** xizi_dll_links a an ap))))).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity ((&( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an **
                     &( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> bn) ** TT).
      + entailer!.
        apply derivable1_truep_intros.
      + sep_apply (dup_store_ptr
          (&( a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hmerge :
    forall nodes_before sentinel_first sentinel_last first prev stop selected node_prev next nodes_after,
    selected <> NULL ->
    xizi_dll_links stop sentinel_first sentinel_last **
    (xizi_dllseg first prev selected node_prev nodes_before **
     (xizi_dll_links selected next node_prev **
      xizi_dllseg next selected stop sentinel_last nodes_after)) |--
    xizi_dll_links stop sentinel_first sentinel_last **
    xizi_dllseg first prev stop sentinel_last
      (nodes_before ++ selected :: nodes_after)).
  {
    induction nodes_before as [| a nodes_before IH]; intros.
    - simpl.
      Intros.
      destruct H0 as [Hfirst Hprev].
      subst first.
      subst node_prev.
      fold xizi_dll_links.
      fold xizi_dllseg.
      etransitivity.
      + apply (Hlinks_neq_tail stop sentinel_first sentinel_last
          selected next prev (xizi_dllseg next selected stop sentinel_last nodes_after)).
      + Intros_p Hneq.
        simpl.
        Exists next.
        entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros link_next.
      Intros.
      subst first.
      fold xizi_dllseg.
      fold xizi_dll_links.
      etransitivity.
      + apply (Hlinks_neq_outer_tail2 stop sentinel_first sentinel_last
          a link_next prev
          (xizi_dllseg link_next a selected node_prev nodes_before)
          (xizi_dll_links selected next node_prev)
          (xizi_dllseg next selected stop sentinel_last nodes_after)).
      + Intros_p Hstopa.
        transitivity (xizi_dll_links a link_next prev **
                      (xizi_dll_links stop sentinel_first sentinel_last **
                       (xizi_dllseg link_next a selected node_prev nodes_before **
                        (xizi_dll_links selected next node_prev **
                         xizi_dllseg next selected stop sentinel_last nodes_after)))).
        * entailer!.
        * transitivity (xizi_dll_links a link_next prev **
                        (xizi_dll_links stop sentinel_first sentinel_last **
                         xizi_dllseg link_next a stop sentinel_last
                           (nodes_before ++ selected :: nodes_after))).
          -- cancel (xizi_dll_links a link_next prev).
             apply (IH sentinel_first sentinel_last link_next a stop selected
                      node_prev next nodes_after H).
          -- simpl.
             Exists link_next.
             entailer!.
  }
  pre_process.
  subst node_next.
  transitivity (xizi_dll_links linklist_pre first last **
                (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before **
                 (xizi_dll_links linklist_node_pre linklist_pre node_prev **
                  xizi_dllseg linklist_pre linklist_node_pre linklist_pre last nodes_after))).
  - unfold xizi_dll_links, XiziDLL.links.
    entailer!.
  - etransitivity.
    + apply (Hstop_nil
        (xizi_dll_links linklist_pre first last)
        (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before)
        (xizi_dll_links linklist_node_pre linklist_pre node_prev)
        linklist_pre linklist_node_pre last nodes_after).
    + Intros_p Hnil.
      subst nodes_after.
      unfold xizi_double_link_next_rec_last_value.
      etransitivity.
      * apply (Hmerge nodes_before first last first
          linklist_pre linklist_pre linklist_node_pre node_prev linklist_pre nil PreH2).
      * sep_apply xizi_dll_close.
        entailer!.
Qed.

Lemma proof_of_xizi_double_link_next_rec_last_return_wit_2 : xizi_double_link_next_rec_last_return_wit_2.
Proof.
  assert (Hcons : forall P Q R node prev stop last nodes,
    node <> stop ->
    P ** (Q ** (R ** xizi_dllseg node prev stop last nodes)) |--
    “ exists rest, nodes = node :: rest ” &&
    (P ** (Q ** (R ** xizi_dllseg node prev stop last nodes)))).
  {
    intros.
    destruct nodes as [| a nodes].
    - unfold xizi_dllseg, XiziDLL.dllseg.
      simpl.
      Intros.
      destruct H0 as [Hnode _].
      contradiction.
    - unfold xizi_dllseg, XiziDLL.dllseg.
      simpl.
      Intros link_next.
      Intros.
      subst a.
      Exists link_next.
      entailer!.
      exists nodes.
      reflexivity.
  }
  assert (Hlinks_neq_tail : forall a an ap b bn bp Q,
    xizi_dll_links a an ap ** (xizi_dll_links b bn bp ** Q) |--
    “ a <> b ” &&
    (xizi_dll_links a an ap ** (xizi_dll_links b bn bp ** Q))).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity ((&( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an **
                     &( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> bn) ** TT).
      + entailer!.
        apply derivable1_truep_intros.
      + sep_apply (dup_store_ptr
          (&( a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hlinks_neq_outer_tail2 : forall a an ap b bn bp P Q R,
    xizi_dll_links b bn bp ** (P ** (Q ** (R ** xizi_dll_links a an ap))) |--
    “ a <> b ” &&
    (xizi_dll_links b bn bp ** (P ** (Q ** (R ** xizi_dll_links a an ap))))).
  {
    intros.
    destruct (Z.eq_dec a b) as [Heq | Hneq].
    - subst b.
      unfold xizi_dll_links, XiziDLL.links.
      transitivity ((&( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> an **
                     &( a # "SysDoubleLinklistNode" ->ₛ "node_next") # Ptr |-> bn) ** TT).
      + entailer!.
        apply derivable1_truep_intros.
      + sep_apply (dup_store_ptr
          (&( a # "SysDoubleLinklistNode" ->ₛ "node_next")) an bn).
        entailer!.
    - entailer!.
  }
  assert (Hmerge :
    forall nodes_before sentinel_first sentinel_last first prev stop selected node_prev next nodes_after,
    selected <> NULL ->
    xizi_dll_links stop sentinel_first sentinel_last **
    (xizi_dllseg first prev selected node_prev nodes_before **
     (xizi_dll_links selected next node_prev **
      xizi_dllseg next selected stop sentinel_last nodes_after)) |--
    xizi_dll_links stop sentinel_first sentinel_last **
    xizi_dllseg first prev stop sentinel_last
      (nodes_before ++ selected :: nodes_after)).
  {
    induction nodes_before as [| a nodes_before IH]; intros.
    - simpl.
      Intros.
      destruct H0 as [Hfirst Hprev].
      subst first.
      subst node_prev.
      fold xizi_dll_links.
      fold xizi_dllseg.
      etransitivity.
      + apply (Hlinks_neq_tail stop sentinel_first sentinel_last
          selected next prev (xizi_dllseg next selected stop sentinel_last nodes_after)).
      + Intros_p Hneq.
        simpl.
        Exists next.
        entailer!.
    - simpl app.
      unfold xizi_dllseg, XiziDLL.dllseg at 1.
      simpl.
      Intros link_next.
      Intros.
      subst first.
      fold xizi_dllseg.
      fold xizi_dll_links.
      etransitivity.
      + apply (Hlinks_neq_outer_tail2 stop sentinel_first sentinel_last
          a link_next prev
          (xizi_dllseg link_next a selected node_prev nodes_before)
          (xizi_dll_links selected next node_prev)
          (xizi_dllseg next selected stop sentinel_last nodes_after)).
      + Intros_p Hstopa.
        transitivity (xizi_dll_links a link_next prev **
                      (xizi_dll_links stop sentinel_first sentinel_last **
                       (xizi_dllseg link_next a selected node_prev nodes_before **
                        (xizi_dll_links selected next node_prev **
                         xizi_dllseg next selected stop sentinel_last nodes_after)))).
        * entailer!.
        * transitivity (xizi_dll_links a link_next prev **
                        (xizi_dll_links stop sentinel_first sentinel_last **
                         xizi_dllseg link_next a stop sentinel_last
                           (nodes_before ++ selected :: nodes_after))).
          -- cancel (xizi_dll_links a link_next prev).
             apply (IH sentinel_first sentinel_last link_next a stop selected
                      node_prev next nodes_after H).
          -- simpl.
             Exists link_next.
             entailer!.
  }
  pre_process.
  transitivity (xizi_dll_links linklist_pre first last **
                (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before **
                 (xizi_dll_links linklist_node_pre node_next node_prev **
                  xizi_dllseg node_next linklist_node_pre linklist_pre last nodes_after))).
  - unfold xizi_dll_links, XiziDLL.links.
    entailer!.
  - etransitivity.
    + apply (Hcons
        (xizi_dll_links linklist_pre first last)
        (xizi_dllseg first linklist_pre linklist_node_pre node_prev nodes_before)
        (xizi_dll_links linklist_node_pre node_next node_prev)
        node_next linklist_node_pre linklist_pre last nodes_after PreH1).
    + Intros_p Hshape.
      destruct Hshape as [rest Hshape].
      subst nodes_after.
      unfold xizi_double_link_next_rec_last_value.
      etransitivity.
      * apply (Hmerge nodes_before first last first
          linklist_pre linklist_pre linklist_node_pre node_prev node_next
          (node_next :: rest) PreH2).
      * sep_apply xizi_dll_close.
        entailer!.
Qed.
