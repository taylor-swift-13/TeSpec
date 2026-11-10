Require Import Candidate.

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
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.



Definition strong_original_statement :=  forall (n_pre: Z) (element_pre: Z) (lr: (@list Z)) (ll: (@list Z)) (q: Z) (p: Z) (h: Z) (e: Z) (retval: Z) (a: Z) (tl: (@list Z)) (q_2: Z) (PreH1 : (lr = (cons (a) (tl)))) (PreH2 : (q <> 0)) (PreH3 : (n_pre <> 0)) (PreH4 : (retval <> 0)) (PreH5 : (element_pre = e)) (PreH6 : (n_pre <> 0)) ,
  ((&((q)  # "node" ->ₛ "prev")) # Ptr  |-> retval)
  **  (DLLRight q_2 q tl )
  **  ((&((q)  # "node" ->ₛ "next")) # Ptr  |-> q_2)
  **  ((&((q)  # "node" ->ₛ "data")) # Int  |-> a)
  **  ((&((retval)  # "node" ->ₛ "data")) # Int  |-> element_pre)
  **  ((&((retval)  # "node" ->ₛ "prev")) # Ptr  |-> n_pre)
  **  ((&((retval)  # "node" ->ₛ "next")) # Ptr  |-> q)
  **  ((&((n_pre)  # "node" ->ₛ "data")) # Int  |-> h)
  **  ((&((n_pre)  # "node" ->ₛ "prev")) # Ptr  |-> p)
  **  ((&((n_pre)  # "node" ->ₛ "next")) # Ptr  |-> retval)
  **  (DLLLeft p n_pre ll )
|--
  “ (n_pre <> 0) ”
  &&  (Dll retval (cons (h) (ll)) e lr ).
Goal True. idtac "AUDIT_0". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_1.
Goal True. idtac "AUDIT_1". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_1.
Goal True. idtac "AUDIT_2". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_2.
Goal True. idtac "AUDIT_3". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_2.
Goal True. idtac "AUDIT_4". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_3.
Goal True. idtac "AUDIT_5". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_3.
Goal True. idtac "AUDIT_6". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_4.
Goal True. idtac "AUDIT_7". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_4.
Goal True. idtac "AUDIT_8". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_5.
Goal True. idtac "AUDIT_9". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_5.
Goal True. idtac "AUDIT_10". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_6.
Goal True. idtac "AUDIT_11". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_6.
Goal True. idtac "AUDIT_12". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_7.
Goal True. idtac "AUDIT_13". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_7.
Goal True. idtac "AUDIT_14". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_8.
Goal True. idtac "AUDIT_15". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_8.
Goal True. idtac "AUDIT_16". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_9.
Goal True. idtac "AUDIT_17". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_9.
Goal True. idtac "AUDIT_18". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_10.
Goal True. idtac "AUDIT_19". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_10.
Goal True. idtac "AUDIT_20". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_safety_wit_11.
Goal True. idtac "AUDIT_21". exact I. Qed.
Print Assumptions Candidate.primary_add_safety_wit_11.
Goal True. idtac "AUDIT_22". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_return_wit_1.
Goal True. idtac "AUDIT_23". exact I. Qed.
Print Assumptions Candidate.primary_add_return_wit_1.
Goal True. idtac "AUDIT_24". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_return_wit_2.
Goal True. idtac "AUDIT_25". exact I. Qed.
Print Assumptions Candidate.primary_add_return_wit_2.
Goal True. idtac "AUDIT_26". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_return_wit_3.
Goal True. idtac "AUDIT_27". exact I. Qed.
Print Assumptions Candidate.primary_add_return_wit_3.
Goal True. idtac "AUDIT_28". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_partial_solve_wit_1.
Goal True. idtac "AUDIT_29". exact I. Qed.
Print Assumptions Candidate.primary_add_partial_solve_wit_1.
Goal True. idtac "AUDIT_30". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_partial_solve_wit_2.
Goal True. idtac "AUDIT_31". exact I. Qed.
Print Assumptions Candidate.primary_add_partial_solve_wit_2.
Goal True. idtac "AUDIT_32". exact I. Qed.
Print Assumptions PrimaryQcpGoal.add_partial_solve_wit_3.
Goal True. idtac "AUDIT_33". exact I. Qed.
Print Assumptions Candidate.primary_add_partial_solve_wit_3.
Goal True. idtac "AUDIT_34". exact I. Qed.
Print Assumptions strong_original_statement.
Goal True. idtac "AUDIT_35". exact I. Qed.
Print Assumptions Candidate.strong_add_return_wit_1.
Goal True. idtac "AUDIT_36". exact I. Qed.
Print Assumptions logic_equiv_sepcon_comm.
Goal True. idtac "AUDIT_37". exact I. Qed.
Print Assumptions logic_equiv_sepcon_emp.
Goal True. idtac "AUDIT_38". exact I. Qed.
Print Assumptions store_ptr_undef_store_ptr.
Goal True. idtac "AUDIT_39". exact I. Qed.
Print Assumptions _derivable1_andp_intros.
Goal True. idtac "AUDIT_40". exact I. Qed.
Print Assumptions Axioms.functional_extensionality.
Goal True. idtac "AUDIT_41". exact I. Qed.
Print Assumptions Axioms.propositional_extensionality.
