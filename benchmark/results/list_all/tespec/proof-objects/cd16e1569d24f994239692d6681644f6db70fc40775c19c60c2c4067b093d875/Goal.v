From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev_loop -----*)

Definition IntList_rev_loop_safety_wit_1 :=
  ((( &( "last_spec_573" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_2 :=
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_3 :=
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_4 :=
forall (PreH1 : False),
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_rev_loop_entail_wit_1 :=
  (sll 0 (@nil Z) )
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (@nil Z)) ”
  &&  (sll 0 l1 )
  **  (sll 0 l2 )
.

Definition IntList_rev_loop_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  (sll 0 (rev (l___tespec_entry)) )
.

Definition IntList_rev_loop_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_loop_safety_wit_1 : IntList_rev_loop_safety_wit_1.
Axiom proof_of_IntList_rev_loop_safety_wit_2 : IntList_rev_loop_safety_wit_2.
Axiom proof_of_IntList_rev_loop_safety_wit_3 : IntList_rev_loop_safety_wit_3.
Axiom proof_of_IntList_rev_loop_safety_wit_4 : IntList_rev_loop_safety_wit_4.
Axiom proof_of_IntList_rev_loop_entail_wit_1 : IntList_rev_loop_entail_wit_1.
Axiom proof_of_IntList_rev_loop_return_wit_1 : IntList_rev_loop_return_wit_1.
Axiom proof_of_IntList_rev_loop_precondition_wit_1 : IntList_rev_loop_precondition_wit_1.

End VC_Correct.
