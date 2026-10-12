(* The shape of the executor's original initial-satisfiability VC.
   Valuation includes unbound logical values; Heap is the assertion carrier.
   The frontend's interpretation of R remains an explicit parameter. *)
Set Implicit Arguments.

Definition initial_vc {Valuation Heap : Type}
    (R : Valuation -> Heap -> Prop) : Prop :=
  exists eta, ~ (forall h, R eta h -> False).

Definition inhabited {Valuation Heap : Type}
    (R : Valuation -> Heap -> Prop) : Prop :=
  exists eta h, R eta h.

Theorem witness_implies_initial_vc {Valuation Heap : Type}
    (R : Valuation -> Heap -> Prop) :
  inhabited R -> initial_vc R.
Proof.
  intros [eta [h HR]]. exists eta. intros Hempty. exact (Hempty h HR).
Qed.

(* Excluded middle is an explicit premise, not an added global axiom.
   In the target classical verification logic it bridges the printed
   negative-entailment encoding and ordinary existential satisfiability. *)
Theorem initial_vc_iff_inhabited {Valuation Heap : Type}
    (R : Valuation -> Heap -> Prop)
    (excluded_middle : forall A : Prop, A \/ ~ A) :
  initial_vc R <-> inhabited R.
Proof.
  split; [|apply witness_implies_initial_vc].
  intros [eta Hnotempty].
  destruct (excluded_middle (exists h, R eta h)) as [Hmodel | Hnone].
  - destruct Hmodel as [h HR]. exists eta, h. exact HR.
  - exfalso. apply Hnotempty. intros h HR. apply Hnone. exists h. exact HR.
Qed.

(* Refuting this VC establishes emptiness constructively, without needing
   a reachable execution counterexample or a concrete address assignment. *)
Theorem refuted_initial_vc_iff_empty {Valuation Heap : Type}
    (R : Valuation -> Heap -> Prop) :
  ~ initial_vc R <-> forall eta h, ~ R eta h.
Proof.
  split.
  - intros Hrefute eta h HR. apply Hrefute.
    apply witness_implies_initial_vc. exists eta, h. exact HR.
  - intros Hempty [eta Hnotempty]. apply Hnotempty. exact (Hempty eta).
Qed.

(* One impossible alternative cannot invalidate the disjunction as a whole.
   Whole-Require goals must retain every alternative before negation. *)
Example refuted_branch_can_have_satisfiable_disjunction :
  ~ initial_vc (fun (_ : unit) (_ : unit) => False) /\
  initial_vc (fun (_ : unit) (_ : unit) => False \/ True).
Proof.
  split.
  - apply (proj2 (refuted_initial_vc_iff_empty _)). intros eta h H. exact H.
  - apply witness_implies_initial_vc. exists tt, tt. right. exact I.
Qed.

Print Assumptions witness_implies_initial_vc.
Print Assumptions initial_vc_iff_inhabited.
Print Assumptions refuted_initial_vc_iff_empty.
Print Assumptions refuted_branch_can_have_satisfiable_disjunction.
