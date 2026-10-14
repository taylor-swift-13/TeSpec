(* Concrete witnesses for finite byte heaps at arbitrary distinct addresses. *)
Require Import Coq.ZArith.ZArith Coq.Lists.List Coq.micromega.Lia.
Require Import ConcreteByteWitness.
From SimpleC.SL Require Import Mem SeparationLogic.
Import naive_C_Rules ListNotations.
Local Open Scope Z_scope.
Local Open Scope sac.

Fixpoint cell_memory (cells : list (Z * Z)) : Mem.mem :=
  match cells with
  | [] => Mem.empty_mem
  | (address, byte_value) :: tail =>
      Mem.mem_byte_update (cell_memory tail) address byte_value
  end.
Fixpoint cell_resources (cells : list (Z * Z)) :=
  match cells with
  | [] => emp
  | (address, byte_value) :: tail => store_byte address byte_value ** cell_resources tail
  end.
Fixpoint indexed_bytes (address : Z) (bytes : list Z) : list (Z * Z) :=
  match bytes with
  | [] => []
  | byte_value :: tail => (address, byte_value) :: indexed_bytes (address + 1) tail
  end.

Lemma cell_memory_absent : forall cells address,
  ~ In address (map fst cells) -> cell_memory cells address = Mem.Noperm.
Proof.
  induction cells as [|[p byte_value] tail IH]; intros address Habsent.
  - reflexivity.
  - cbn [cell_memory]. unfold Mem.mem_byte_update.
    destruct (Mem.addr_eqb address p) eqn:Heq.
    + apply Mem.addr_eqb_eq in Heq. subst address. exfalso.
      apply Habsent. cbn. left. reflexivity.
    + apply IH. intro Hin. apply Habsent. cbn. right. exact Hin.
Qed.

Theorem distinct_byte_cells_have_witness : forall cells,
  NoDup (map fst cells) -> cell_resources cells (memory_state (cell_memory cells)).
Proof.
  induction cells as [|[address byte_value] tail IH]; intro Hdistinct.
  - apply ConAssertion.empty_state_is_empty.
  - inversion Hdistinct as [|head rest Habsent Htail]; subst.
    cbn [cell_resources cell_memory].
    exists (memory_state (Mem.single_byte_mem address byte_value)),
           (memory_state (cell_memory tail)).
    split.
    + apply memory_state_join_byte. apply cell_memory_absent. exact Habsent.
    + split; [apply single_byte_state_holds | apply IH; exact Htail].
Qed.

Theorem cell_resources_append : forall prefix suffix,
  cell_resources (prefix ++ suffix) |-- cell_resources prefix ** cell_resources suffix.
Proof.
  induction prefix as [|[address byte_value] tail IH]; intro suffix.
  - cbn [cell_resources app]. entailer!.
  - cbn [cell_resources app]. sep_apply (IH suffix). entailer!.
Qed.

Theorem indexed_bytes_are_byte_resources : forall bytes address,
  cell_resources (indexed_bytes address bytes) --||-- byte_resources address bytes.
Proof.
  induction bytes as [|byte_value tail IH]; intro address; cbn [cell_resources indexed_bytes byte_resources].
  - split; apply derivable1_refl.
  - destruct (IH (address + 1)) as [Hforward Hbackward]. split.
    + apply derivable1_sepcon_mono; [apply derivable1_refl | exact Hforward].
    + apply derivable1_sepcon_mono; [apply derivable1_refl | exact Hbackward].
Qed.

Lemma indexed_bytes_address_lower_bound : forall bytes address q,
  In q (map fst (indexed_bytes address bytes)) -> address <= q.
Proof.
  induction bytes as [|byte_value tail IH]; intros address q Hin.
  - contradiction.
  - cbn in Hin. destruct Hin as [Heq | Hin].
    + subst q. lia.
    + pose proof (IH (address + 1) q Hin). lia.
Qed.

Theorem indexed_bytes_have_distinct_addresses : forall bytes address,
  NoDup (map fst (indexed_bytes address bytes)).
Proof.
  induction bytes as [|byte_value tail IH]; intro address.
  - constructor.
  - cbn. constructor.
    + intro Hin. pose proof (indexed_bytes_address_lower_bound tail (address + 1) address Hin). lia.
    + apply IH.
Qed.

Print Assumptions distinct_byte_cells_have_witness.
Print Assumptions cell_resources_append.
Print Assumptions indexed_bytes_are_byte_resources.
Print Assumptions indexed_bytes_have_distinct_addresses.
