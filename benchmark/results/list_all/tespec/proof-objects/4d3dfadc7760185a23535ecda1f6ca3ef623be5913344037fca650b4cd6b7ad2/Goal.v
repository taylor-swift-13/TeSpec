From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev_loop -----*)

Definition IntList_rev_loop_safety_wit_1 :=
  ((( &( "last_spec_573" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_2 :=
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_3 :=
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_4 :=
forall (PreH1 : False),
  ((( &( "cur_spec_575" ) )) # Ptr  |-> 8192)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_rev_loop_safety_wit_5 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> y)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_6 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> y)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_7 :=
forall (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_loop_safety_wit_8 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_9 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_loop_safety_wit_10 :=
forall (y: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "cur_spec_575" ) )) # Ptr  |-> 0)
  **  ((( &( "last_spec_573" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_562" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_loop_entail_wit_1 :=
(
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> 8192)
  **  ((y) # Int  |-> (-1))
  **  ((8192) # Int  |-> 2)
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (cons ((-1)) ((cons (2) ((@nil Z)))))) ”
  &&  (sll y l1 )
  **  (sll 0 l2 )
) \/
(
forall (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : ((-1) <= INT_MAX)) (PreH3 : (2 >= INT_MIN)) (PreH4 : ((-1) >= INT_MIN)) (PreH5 : (y <> 0)) (PreH6 : (y_2 = 0)) (PreH7 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> 8192)
  **  ((y) # Int  |-> (-1))
  **  ((8192) # Int  |-> 2)
|--
  EX (y_3: Z) (l0: (@list Z)) (x: Z),
  “ (y <> 0) ”
  &&  “ ((app ((rev ((@nil Z)))) ((cons (x) (l0)))) = (cons ((-1)) ((cons (2) ((@nil Z)))))) ”
  &&  (sll y_3 l0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> x)
).

Definition IntList_rev_loop_entail_wit_2 :=
(
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> (-1))
  **  ((8192) # Int  |-> 2)
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (cons ((-1)) ((cons (2) ((@nil Z)))))) ”
  &&  (sll 8192 l1 )
  **  (sll y l2 )
) \/
(
forall (y: Z) (y_2: Z) (PreH1 : (2 <= INT_MAX)) (PreH2 : ((-1) <= INT_MAX)) (PreH3 : (2 >= INT_MIN)) (PreH4 : ((-1) >= INT_MIN)) (PreH5 : (y_2 = 0)) (PreH6 : (y <> 0)),
  ((8196) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> 0)
  **  ((y) # Int  |-> (-1))
  **  ((8192) # Int  |-> 2)
|--
  EX (y_3: Z) (l0: (@list Z)) (x: Z) (l1: (@list Z)),
  “ (y <> 0) ”
  &&  “ ((app ((rev ((cons (x) (l0))))) (l1)) = (cons ((-1)) ((cons (2) ((@nil Z)))))) ”
  &&  (sll y_3 l0 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> x)
  **  (sll 8192 l1 )
).

Definition IntList_rev_loop_entail_wit_3 :=
  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  EX (l2: (@list Z)) (l1: (@list Z)),
  “ ((app ((rev (l2))) (l1)) = (cons ((-1)) ((cons (2) ((@nil Z)))))) ”
  &&  “ (8192 <> 0) ”
  &&  (sll 0 l1 )
  **  (sll 8192 l2 )
.

Definition IntList_rev_loop_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll y (rev (l___tespec_entry)) )
.

Definition IntList_rev_loop_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z),
  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_rev_loop_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_loop_safety_wit_1 : IntList_rev_loop_safety_wit_1.
Axiom proof_of_IntList_rev_loop_safety_wit_2 : IntList_rev_loop_safety_wit_2.
Axiom proof_of_IntList_rev_loop_safety_wit_3 : IntList_rev_loop_safety_wit_3.
Axiom proof_of_IntList_rev_loop_safety_wit_4 : IntList_rev_loop_safety_wit_4.
Axiom proof_of_IntList_rev_loop_safety_wit_5 : IntList_rev_loop_safety_wit_5.
Axiom proof_of_IntList_rev_loop_safety_wit_6 : IntList_rev_loop_safety_wit_6.
Axiom proof_of_IntList_rev_loop_safety_wit_7 : IntList_rev_loop_safety_wit_7.
Axiom proof_of_IntList_rev_loop_safety_wit_8 : IntList_rev_loop_safety_wit_8.
Axiom proof_of_IntList_rev_loop_safety_wit_9 : IntList_rev_loop_safety_wit_9.
Axiom proof_of_IntList_rev_loop_safety_wit_10 : IntList_rev_loop_safety_wit_10.
Axiom proof_of_IntList_rev_loop_entail_wit_1 : IntList_rev_loop_entail_wit_1.
Axiom proof_of_IntList_rev_loop_entail_wit_2 : IntList_rev_loop_entail_wit_2.
Axiom proof_of_IntList_rev_loop_entail_wit_3 : IntList_rev_loop_entail_wit_3.
Axiom proof_of_IntList_rev_loop_return_wit_1 : IntList_rev_loop_return_wit_1.
Axiom proof_of_IntList_rev_loop_partial_solve_wit_1 : IntList_rev_loop_partial_solve_wit_1.
Axiom proof_of_IntList_rev_loop_precondition_wit_1 : IntList_rev_loop_precondition_wit_1.

End VC_Correct.
