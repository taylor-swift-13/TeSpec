From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_17cfb40defe94e3d4b7fa3ed.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev -----*)

Definition IntList_rev_safety_wit_1 :=
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_2 :=
forall (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)),
  ((( &( "ys_spec_705" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_704" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_691" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_689" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_3 :=
forall (y: Z) (PreH1 : False),
  ((( &( "ys_spec_705" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_704" ) )) # Ptr  |-> y)
  **  ((( &( "tmp_spec_691" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_689" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_safety_wit_4 :=
forall (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)),
  ((( &( "ys_spec_689" ) )) # Ptr  |-> y)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_5 :=
forall (PreH1 : False),
  ((( &( "ys_spec_689" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_688" ) )) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (0 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (0 + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_rev_safety_wit_6 :=
  ((( &( "ys_spec_667" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_rev_safety_wit_7 :=
forall (PreH1 : False),
  ((( &( "ys_spec_667" ) )) # Ptr  |-> 8192)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_476" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_rev_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (app ((rev ((@nil Z)))) ((cons ((-1)) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_entail_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (app ((rev ((cons ((-1)) ((@nil Z)))))) ((cons (2) ((@nil Z))))) )
.

Definition IntList_rev_entail_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  EX (retval: Z),
  “ (retval = y) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll retval (app ((rev (l___tespec_entry))) ((@nil Z))) )
.

Definition IntList_rev_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y_2 = 0)) (PreH5 : (y <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  (sll y (rev (l___tespec_entry)) )
.

Definition IntList_rev_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll xs_pre l___tespec_entry )
|--
  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll 0 (@nil Z) )
  **  (sll xs_pre l___tespec_entry )
.

Definition IntList_rev_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre (cons (2) ((@nil Z))) )
  **  (sll y (cons ((-1)) ((@nil Z))) )
.

Definition IntList_rev_partial_solve_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y_2 = 0)) (PreH4 : (y <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
|--
  “ (y <> 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (cons ((-1)) ((cons (2) ((@nil Z))))) )
  **  (sll y_2 (@nil Z) )
  **  ((( &( "tmp_spec_474" ) )) # Ptr  |-> y)
  **  ((( &( "ys_spec_667" ) )) # Ptr  |-> xs_pre)
  **  ((( &( "xs_spec_666" ) )) # Ptr  |-> 0)
.

Definition IntList_rev_partial_solve_wit_4 :=
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

Definition IntList_rev_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_safety_wit_1 : IntList_rev_safety_wit_1.
Axiom proof_of_IntList_rev_safety_wit_2 : IntList_rev_safety_wit_2.
Axiom proof_of_IntList_rev_safety_wit_3 : IntList_rev_safety_wit_3.
Axiom proof_of_IntList_rev_safety_wit_4 : IntList_rev_safety_wit_4.
Axiom proof_of_IntList_rev_safety_wit_5 : IntList_rev_safety_wit_5.
Axiom proof_of_IntList_rev_safety_wit_6 : IntList_rev_safety_wit_6.
Axiom proof_of_IntList_rev_safety_wit_7 : IntList_rev_safety_wit_7.
Axiom proof_of_IntList_rev_entail_wit_1 : IntList_rev_entail_wit_1.
Axiom proof_of_IntList_rev_entail_wit_2 : IntList_rev_entail_wit_2.
Axiom proof_of_IntList_rev_entail_wit_3 : IntList_rev_entail_wit_3.
Axiom proof_of_IntList_rev_return_wit_1 : IntList_rev_return_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_1 : IntList_rev_partial_solve_wit_1.
Axiom proof_of_IntList_rev_partial_solve_wit_2 : IntList_rev_partial_solve_wit_2.
Axiom proof_of_IntList_rev_partial_solve_wit_3 : IntList_rev_partial_solve_wit_3.
Axiom proof_of_IntList_rev_partial_solve_wit_4 : IntList_rev_partial_solve_wit_4.
Axiom proof_of_IntList_rev_precondition_wit_1 : IntList_rev_precondition_wit_1.

End VC_Correct.
