Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.

Import ListNotations.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope list.
Local Open Scope string_scope.
Local Open Scope sac.

(** QCIP-side address model adapted from [crtosverify/lib/dll.v].

    The sentinel owns its two links.  [dllseg node prev stop last nodes]
    describes the finite chain from [node] up to (but excluding) [stop], while
    remembering the predecessor on both ends.  The explicit [node <> stop]
    guard in the nonempty branch fixes the ambiguous cyclic segment admitted
    by the older definition. *)
Module Type DLL_LAYOUT.
  Parameter Inline struct_name : string.
  Parameter Inline next_field : string.
  Parameter Inline prev_field : string.
End DLL_LAYOUT.

Module AddrDLL (Layout : DLL_LAYOUT).

Import Layout.

Definition links (node next prev : addr) : Assertion :=
  &(node # struct_name ->ₛ next_field) # Ptr |-> next **
  &(node # struct_name ->ₛ prev_field) # Ptr |-> prev.

Fixpoint dllseg
  (node prev stop last : addr) (nodes : list addr) : Assertion :=
  match nodes with
  | nil => “ node = stop /\ prev = last ” && emp
  | expected :: rest =>
      “ node = expected ” &&
      “ node <> NULL ” &&
      “ node <> stop ” &&
      EX next : addr,
        links node next prev **
        dllseg next node stop last rest
  end.

Definition dll (head : addr) (nodes : list addr) : Assertion :=
  EX first last : addr,
    links head first last **
    dllseg first head head last nodes.

Lemma dll_empty : forall head,
  dll head nil |-- links head head head.
Proof.
  intros; unfold dll; Intros first last; simpl; Intros.
  destruct H as [Hfirst Hlast].
  subst first; subst last; entailer!.
Qed.

Lemma dll_empty_rev : forall head,
  links head head head |-- dll head nil.
Proof.
  intros; unfold dll; Exists head head; simpl; entailer!.
Qed.

Lemma dll_open : forall head nodes,
  dll head nodes |--
  EX first last,
    links head first last **
    dllseg first head head last nodes.
Proof.
  intros; unfold dll; Intros first last; Exists first last; entailer!.
Qed.

Lemma dll_close : forall head first last nodes,
  links head first last ** dllseg first head head last nodes |--
  dll head nodes.
Proof.
  intros; unfold dll; Exists first last; entailer!.
Qed.

Lemma dll_nonempty : forall head first rest,
  dll head (first :: rest) |--
  EX next last,
    “ first <> NULL ” &&
    “ first <> head ” &&
    links head first last **
    links first next head **
    dllseg next first head last rest.
Proof.
  intros; unfold dll; Intros actual_first last; simpl; Intros next; Intros.
  subst actual_first.
  Exists next last; entailer!.
Qed.

Lemma dll_nonempty_rev : forall head first next last rest,
  first <> NULL ->
  first <> head ->
  links head first last **
  links first next head **
  dllseg next first head last rest |--
  dll head (first :: rest).
Proof.
  intros; unfold dll; Exists first last; simpl; Exists next; entailer!.
Qed.

End AddrDLL.

Module XiziDoubleLinkLayout <: DLL_LAYOUT.
  Definition struct_name : string := "SysDoubleLinklistNode".
  Definition next_field : string := "node_next".
  Definition prev_field : string := "node_prev".
End XiziDoubleLinkLayout.

Module XiziDLL := AddrDLL XiziDoubleLinkLayout.

Definition xizi_dllseg :
  addr -> addr -> addr -> addr -> list addr -> Assertion := XiziDLL.dllseg.

Definition xizi_dll : addr -> list addr -> Assertion := XiziDLL.dll.

Definition xizi_dll_links : addr -> addr -> addr -> Assertion := XiziDLL.links.

Lemma xizi_dll_empty : forall head,
  xizi_dll head nil |-- xizi_dll_links head head head.
Proof. exact XiziDLL.dll_empty. Qed.

Lemma xizi_dll_empty_rev : forall head,
  xizi_dll_links head head head |-- xizi_dll head nil.
Proof. exact XiziDLL.dll_empty_rev. Qed.

Lemma xizi_dll_open : forall head nodes,
  xizi_dll head nodes |--
  EX first last,
    xizi_dll_links head first last **
    xizi_dllseg first head head last nodes.
Proof. exact XiziDLL.dll_open. Qed.

Lemma xizi_dll_close : forall head first last nodes,
  xizi_dll_links head first last **
  xizi_dllseg first head head last nodes |--
  xizi_dll head nodes.
Proof. exact XiziDLL.dll_close. Qed.

Lemma xizi_dll_nonempty : forall head first rest,
  xizi_dll head (first :: rest) |--
  EX next last,
    “ first <> NULL ” &&
    “ first <> head ” &&
    xizi_dll_links head first last **
    xizi_dll_links first next head **
    xizi_dllseg next first head last rest.
Proof. exact XiziDLL.dll_nonempty. Qed.

Lemma xizi_dll_nonempty_rev : forall head first next last rest,
  first <> NULL ->
  first <> head ->
  xizi_dll_links head first last **
  xizi_dll_links first next head **
  xizi_dllseg next first head last rest |--
  xizi_dll head (first :: rest).
Proof. exact XiziDLL.dll_nonempty_rev. Qed.

Lemma xizi_dllseg_unfold : forall node prev stop last nodes,
  node <> stop ->
  xizi_dllseg node prev stop last nodes |--
  EX next rest,
    “ nodes = node :: rest ” &&
    xizi_dll_links node next prev **
    xizi_dllseg next node stop last rest.
Proof.
  intros node prev stop last nodes Hneq.
  destruct nodes as [| expected rest].
  - unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros.
    destruct H as [Hsame _].
    contradiction.
  - unfold xizi_dllseg, XiziDLL.dllseg.
    simpl.
    Intros next.
    Intros.
    subst expected.
    Exists next rest.
    unfold xizi_dll_links.
    entailer!.
Qed.
