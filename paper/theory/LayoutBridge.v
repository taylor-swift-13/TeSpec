From Coq Require Import ZArith Lia List.
Import ListNotations.
Local Open Scope Z_scope.

Module LayoutBridge.
Record object_layout := {
  object_size : Z;
  object_align : Z
}.
Record field_layout := {
  field_offset : Z;
  field_size : Z;
  field_align : Z
}.
Definition object_wf (o : object_layout) : Prop :=
  0 <= object_size o /\ 0 < object_align o.
Definition field_wf (o : object_layout) (f : field_layout) : Prop :=
  0 <= field_offset f /\ 0 < field_size f /\
  field_offset f + field_size f <= object_size o /\
  0 < field_align f /\ field_offset f mod field_align f = 0.
Definition valid_base (limit : Z) (o : object_layout) (base : Z) : Prop :=
  0 <= base /\ base + object_size o <= limit /\
  base mod object_align o = 0.
Definition field_address (base : Z) (f : field_layout) := base + field_offset f.
Definition byte_domain (base size byte : Z) : Prop := base <= byte < base + size.
Definition disjoint_fields (f g : field_layout) : Prop :=
  field_offset f + field_size f <= field_offset g \/
  field_offset g + field_size g <= field_offset f.

(* Exact arithmetic condition used by the necessary-constraint pass.
   Positive widths are essential: an empty interval owns no byte. *)
Theorem positive_byte_domains_disjoint_iff : forall left width1 right width2,
  0 < width1 -> 0 < width2 ->
  (forall byte, ~ (byte_domain left width1 byte /\
                   byte_domain right width2 byte)) <->
  left + width1 <= right \/ right + width2 <= left.
Proof.
  unfold byte_domain. intros left width1 right width2 Hw1 Hw2.
  split.
  - intros Hd.
    destruct (Z_le_dec (left + width1) right); [left; assumption | ].
    destruct (Z_le_dec (right + width2) left); [right; assumption | ].
    exfalso. destruct (Z_le_dec left right).
    + apply (Hd right). lia.
    + apply (Hd left). lia.
  - intros H byte. lia.
Qed.

Theorem same_address_positive_cells_overlap : forall base width1 width2,
  0 < width1 -> 0 < width2 ->
  exists byte, byte_domain base width1 byte /\ byte_domain base width2 byte.
Proof. unfold byte_domain. intros. exists base. lia. Qed.

Theorem field_interval_bounds : forall limit o f base,
  valid_base limit o base -> field_wf o f ->
  0 <= field_address base f /\
  field_address base f + field_size f <= limit.
Proof. unfold valid_base, field_wf, field_address. intros. lia. Qed.

Theorem field_bytes_inside_object : forall o f base byte,
  field_wf o f -> byte_domain (field_address base f) (field_size f) byte ->
  byte_domain base (object_size o) byte.
Proof. unfold field_wf, field_address, byte_domain. intros. lia. Qed.

Theorem field_address_aligned : forall o f base,
  field_wf o f -> base mod field_align f = 0 ->
  field_address base f mod field_align f = 0.
Proof.
  unfold field_wf, field_address. intros o f base Hwf Hbase.
  destruct Hwf as [Ho [Hs [Hbound [Ha Hoff]]]].
  rewrite Z.add_mod by lia. rewrite Hbase, Hoff. apply Z.mod_0_l. lia.
Qed.

Theorem field_domains_disjoint : forall base f g byte,
  disjoint_fields f g ->
  ~ (byte_domain (field_address base f) (field_size f) byte /\
     byte_domain (field_address base g) (field_size g) byte).
Proof. unfold disjoint_fields, byte_domain, field_address. intros. lia. Qed.

(* A nested member is represented by composing offsets. Its size and
   alignment come from the final member, not the enclosing aggregate. *)
Definition compose_field (outer inner : field_layout) : field_layout :=
  {| field_offset := field_offset outer + field_offset inner;
     field_size := field_size inner; field_align := field_align inner |}.
Definition member_object (outer : field_layout) : object_layout :=
  {| object_size := field_size outer; object_align := field_align outer |}.

Theorem nested_address_composes : forall base outer inner,
  field_address base (compose_field outer inner) =
  field_address (field_address base outer) inner.
Proof. unfold field_address, compose_field. simpl. intros. lia. Qed.

Theorem nested_field_wf : forall o outer inner,
  field_wf o outer -> field_wf (member_object outer) inner ->
  field_offset outer mod field_align inner = 0 ->
  field_wf o (compose_field outer inner).
Proof.
  unfold field_wf, compose_field, member_object. simpl.
  intros o outer inner Ho Hi Halign.
  destruct Ho as [Ho0 [Hos [Hob [Hoa Hom]]]].
  destruct Hi as [Hi0 [His [Hib [Hia Him]]]].
  repeat split; try lia.
  rewrite Z.add_mod by lia. rewrite Halign, Him. apply Z.mod_0_l. lia.
Qed.

Theorem nested_byte_domain : forall base outer inner byte,
  field_wf (member_object outer) inner ->
  byte_domain (field_address base (compose_field outer inner)) (field_size inner) byte ->
  byte_domain (field_address base outer) (field_size outer) byte.
Proof.
  unfold field_wf, member_object, byte_domain, field_address, compose_field.
  simpl. intros. lia.
Qed.

(* An arbitrary-depth path follows addresses by summing offsets. *)
Fixpoint path_offset (path : list field_layout) : Z :=
  match path with [] => 0 | f :: tail => field_offset f + path_offset tail end.
Definition path_address (base : Z) (path : list field_layout) := base + path_offset path.

Theorem path_offset_append : forall prefix suffix,
  path_offset (prefix ++ suffix) = path_offset prefix + path_offset suffix.
Proof. induction prefix; simpl; intros; [lia | rewrite IHprefix; lia]. Qed.

Theorem path_address_composes : forall base prefix suffix,
  path_address base (prefix ++ suffix) = path_address (path_address base prefix) suffix.
Proof. unfold path_address. intros. rewrite path_offset_append. lia. Qed.

Theorem path_aligned : forall path base alignment,
  0 < alignment -> base mod alignment = 0 ->
  Forall (fun f => field_offset f mod alignment = 0) path ->
  path_address base path mod alignment = 0.
Proof.
  induction path as [|f tail IH]; intros base alignment Ha Hb Hall.
  - unfold path_address. simpl. rewrite Z.add_0_r. exact Hb.
  - inversion Hall as [|? ? Hf Htail]; subst.
    change ((base + (field_offset f + path_offset tail)) mod alignment = 0).
    replace (base + (field_offset f + path_offset tail)) with
      ((base + field_offset f) + path_offset tail) by lia.
    apply IH; auto.
    rewrite Z.add_mod by lia. rewrite Hb, Hf. apply Z.mod_0_l. lia.
Qed.
(* Each step is checked against its immediately enclosing aggregate.
   This relation records arbitrary-depth bounds independently of alignment. *)
Inductive path_wf : object_layout -> list field_layout -> object_layout -> Prop :=
| path_here : forall o, path_wf o [] o
| path_step : forall o f tail leaf,
    field_wf o f -> path_wf (member_object f) tail leaf ->
    path_wf o (f :: tail) leaf.

Theorem path_interval_relative : forall o path leaf,
  path_wf o path leaf ->
  0 <= path_offset path /\
  path_offset path + object_size leaf <= object_size o.
Proof.
  intros o path leaf Hpath. induction Hpath; simpl.
  - lia.
  - unfold field_wf in H. unfold member_object in IHHpath. simpl in IHHpath. lia.
Qed.

Theorem path_interval_bounds : forall limit o path leaf base,
  valid_base limit o base -> path_wf o path leaf ->
  0 <= path_address base path /\
  path_address base path + object_size leaf <= limit.
Proof.
  intros limit o path leaf base Hb Hp.
  pose proof (path_interval_relative _ _ _ Hp).
  unfold valid_base, path_address in *. lia.
Qed.

Theorem nested_paths_disjoint : forall base outer1 outer2 path1 path2 leaf1 leaf2 byte,
  disjoint_fields outer1 outer2 ->
  path_wf (member_object outer1) path1 leaf1 ->
  path_wf (member_object outer2) path2 leaf2 ->
  ~ (byte_domain (path_address (field_address base outer1) path1) (object_size leaf1) byte /\
     byte_domain (path_address (field_address base outer2) path2) (object_size leaf2) byte).
Proof.
  intros base outer1 outer2 path1 path2 leaf1 leaf2 byte Hd Hp1 Hp2.
  pose proof (path_interval_relative _ _ _ Hp1).
  pose proof (path_interval_relative _ _ _ Hp2).
  unfold disjoint_fields, member_object, byte_domain, path_address, field_address in *.
  simpl in *. lia.
Qed.
Theorem field_alignment_from_object : forall limit o f base,
  object_wf o -> valid_base limit o base -> field_wf o f ->
  (field_align f | object_align o) ->
  field_address base f mod field_align f = 0.
Proof.
  intros limit o f base Ho Hb Hf Hdiv.
  apply field_address_aligned with (o := o); [exact Hf | ].
  destruct Ho as [Hos Hoa].
  destruct Hb as [Hb0 [Hbound Hmod]].
  destruct Hf as [Hf0 [Hfs [Hfb [Hfa Hfm]]]].
  apply Z.mod_divide; [lia | ].
  eapply Z.divide_trans; [exact Hdiv | ].
  apply Z.mod_divide; [lia | exact Hmod].
Qed.

Theorem field_address_positive : forall o f base,
  0 < base -> field_wf o f -> 0 < field_address base f.
Proof. unfold field_wf, field_address. intros. lia. Qed.

Theorem field_address_nonzero : forall o f base,
  0 < base -> field_wf o f -> field_address base f <> 0.
Proof.
  intros o f base Hb Hf.
  pose proof (field_address_positive o f base Hb Hf). lia.
Qed.

End LayoutBridge.
Print Assumptions LayoutBridge.positive_byte_domains_disjoint_iff.
Print Assumptions LayoutBridge.same_address_positive_cells_overlap.
Print Assumptions LayoutBridge.field_interval_bounds.
Print Assumptions LayoutBridge.field_bytes_inside_object.
Print Assumptions LayoutBridge.field_address_aligned.
Print Assumptions LayoutBridge.field_domains_disjoint.
Print Assumptions LayoutBridge.nested_address_composes.
Print Assumptions LayoutBridge.nested_field_wf.
Print Assumptions LayoutBridge.nested_byte_domain.
Print Assumptions LayoutBridge.path_offset_append.
Print Assumptions LayoutBridge.path_address_composes.
Print Assumptions LayoutBridge.path_aligned.
Print Assumptions LayoutBridge.path_interval_relative.
Print Assumptions LayoutBridge.path_interval_bounds.
Print Assumptions LayoutBridge.nested_paths_disjoint.
Print Assumptions LayoutBridge.field_alignment_from_object.
Print Assumptions LayoutBridge.field_address_positive.
Print Assumptions LayoutBridge.field_address_nonzero.
