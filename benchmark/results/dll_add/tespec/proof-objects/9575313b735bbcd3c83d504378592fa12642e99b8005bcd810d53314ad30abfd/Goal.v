From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import DLLSupplement.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function add -----*)

Definition add_safety_wit_1 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (20 = a_2)) (PreH3 : ((cons (40) ((@nil Z))) = tl_2)) (PreH4 : (30 = a)) (PreH5 : ((@nil Z) = tl)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |->_)
  **  (DLLRight q_2 12288 (cons (40) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 20)
  **  (DLLLeft q 8192 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 30)
  **  ((( &( "new_node_spec_488" ) )) # Ptr  |-> retval)
  **  ((( &( "element_spec_465" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 12288)
|--
  TT && emp 
.

Definition add_safety_wit_2 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (20 = a_2)) (PreH3 : ((cons (40) ((@nil Z))) = tl_2)) (PreH4 : (30 = a)) (PreH5 : ((@nil Z) = tl)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |->_)
  **  (DLLRight q_2 12288 (cons (40) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 20)
  **  (DLLLeft q 8192 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 30)
  **  ((( &( "new_node_spec_488" ) )) # Ptr  |-> retval)
  **  ((( &( "element_spec_465" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 12288)
|--
  TT && emp 
.

Definition add_safety_wit_3 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (20 = a_2)) (PreH3 : ((cons (40) ((@nil Z))) = tl_2)) (PreH4 : (30 = a)) (PreH5 : ((@nil Z) = tl)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
  **  (DLLRight q_2 12288 (cons (40) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 20)
  **  (DLLLeft q 8192 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 30)
  **  ((( &( "new_node_spec_488" ) )) # Ptr  |-> retval)
  **  ((( &( "element_spec_465" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 12288)
|--
  TT && emp 
.

Definition add_safety_wit_4 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 0)
  **  (DLLRight q_2 12288 tl_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> a_2)
  **  (DLLLeft q 8192 tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> a)
  **  ((( &( "new_node_spec_488" ) )) # Ptr  |-> retval)
  **  ((( &( "element_spec_465" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 12288)
|--
  “ False ”
.

Definition add_safety_wit_5 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (20 = a_2)) (PreH3 : ((cons (40) ((@nil Z))) = tl_2)) (PreH4 : (30 = a)) (PreH5 : ((@nil Z) = tl)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 12288)
  **  (DLLRight q_2 12288 (cons (40) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> 20)
  **  (DLLLeft q 8192 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 30)
  **  ((( &( "new_node_spec_488" ) )) # Ptr  |-> retval)
  **  ((( &( "element_spec_465" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 12288)
|--
  TT && emp 
.

Definition add_safety_wit_6 :=
forall (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : False),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 7)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> 12288)
  **  (DLLRight q_2 12288 tl_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (12288 + 4)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (12288 + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (12288 + 0)) # Int  |-> a_2)
  **  (DLLLeft q 8192 tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (8192 + 8)) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> a)
  **  ((( &( "new_node_spec_488" ) )) # Ptr  |-> retval)
  **  ((( &( "element_spec_465" ) )) # Int  |-> 7)
  **  ((( &( "n_spec_463" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # Int  |-> 10)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (4096 + 8)) # Ptr  |-> 12288)
|--
  “ False ”
.

Definition add_return_wit_1 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (e___tespec_entry: Z) (element_pre: Z) (n_pre: Z) (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z) (retval: Z) (PreH1 : (q___tespec_entry <> 0)) (PreH2 : (n_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (lr___tespec_entry = (cons (a_2) (tl_2)))) (PreH5 : (ll___tespec_entry = (cons (a) (tl)))) (PreH6 : (element_pre = 7)) (PreH7 : (n_pre = 4096)) (PreH8 : (e___tespec_entry = 7)) (PreH9 : (h___tespec_entry = 10)) (PreH10 : (ll___tespec_entry = (cons (30) ((@nil Z))))) (PreH11 : (lr___tespec_entry = (cons (20) ((cons (40) ((@nil Z))))))) (PreH12 : (p___tespec_entry = 8192)) (PreH13 : (q___tespec_entry = 12288)) (PreH14 : (element_pre = e___tespec_entry)) (PreH15 : (n_pre <> 0)) (PreH16 : (0 <= retval)) (PreH17 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> element_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> n_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (retval + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLRight q_2 q___tespec_entry tl_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q___tespec_entry + 4)) # Ptr  |-> retval)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (q___tespec_entry + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q___tespec_entry + 0)) # Int  |-> a_2)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |-> n_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> retval)
|--
  (“ (n_pre = 0) ”
  &&  (Dll retval (@nil Z) e___tespec_entry (@nil Z) ))
  ||
  (“ (n_pre <> 0) ”
  &&  (Dll retval (cons (h___tespec_entry) (ll___tespec_entry)) e___tespec_entry lr___tespec_entry ))
.

Definition add_partial_solve_wit_1 :=
forall (lr___tespec_entry: (@list Z)) (ll___tespec_entry: (@list Z)) (q___tespec_entry: Z) (p___tespec_entry: Z) (h___tespec_entry: Z) (e___tespec_entry: Z) (element_pre: Z) (n_pre: Z) (PreH1 : (element_pre = 7)) (PreH2 : (n_pre = 4096)) (PreH3 : (e___tespec_entry = 7)) (PreH4 : (h___tespec_entry = 10)) (PreH5 : (ll___tespec_entry = (cons (30) ((@nil Z))))) (PreH6 : (lr___tespec_entry = (cons (20) ((cons (40) ((@nil Z))))))) (PreH7 : (p___tespec_entry = 8192)) (PreH8 : (q___tespec_entry = 12288)) (PreH9 : (element_pre = e___tespec_entry)) (PreH10 : (n_pre <> 0)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft p___tespec_entry n_pre ll___tespec_entry )
  **  (DLLRight q___tespec_entry n_pre lr___tespec_entry )
|--
  EX (a: Z) (tl: (@list Z)) (q: Z) (a_2: Z) (tl_2: (@list Z)) (q_2: Z),
  “ (lr___tespec_entry = (cons (a_2) (tl_2))) ”
  &&  “ (ll___tespec_entry = (cons (a) (tl))) ”
  &&  “ (element_pre = 7) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (e___tespec_entry = 7) ”
  &&  “ (h___tespec_entry = 10) ”
  &&  “ (ll___tespec_entry = (cons (30) ((@nil Z)))) ”
  &&  “ (lr___tespec_entry = (cons (20) ((cons (40) ((@nil Z)))))) ”
  &&  “ (p___tespec_entry = 8192) ”
  &&  “ (q___tespec_entry = 12288) ”
  &&  “ (element_pre = e___tespec_entry) ”
  &&  “ (n_pre <> 0) ”
  &&  (DLLRight q_2 q___tespec_entry tl_2 )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (q___tespec_entry + 4)) # Ptr  |-> n_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (q___tespec_entry + 8)) # Ptr  |-> q_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (q___tespec_entry + 0)) # Int  |-> a_2)
  **  (DLLLeft q p___tespec_entry tl )
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (p___tespec_entry + 8)) # Ptr  |-> n_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p___tespec_entry + 4)) # Ptr  |-> q)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p___tespec_entry + 0)) # Int  |-> a)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
.

Definition add_precondition_wit_1 :=
exists (lr___tespec_entry: (@list Z)),
exists (ll___tespec_entry: (@list Z)),
exists (q___tespec_entry: Z),
exists (p___tespec_entry: Z),
exists (h___tespec_entry: Z),
exists (e___tespec_entry: Z),
exists (element_pre: Z),
exists (n_pre: Z),
~ ((  (“ (element_pre = 7) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (e___tespec_entry = 7) ”
  &&  “ (h___tespec_entry = 10) ”
  &&  “ (ll___tespec_entry = (cons (30) ((@nil Z)))) ”
  &&  “ (lr___tespec_entry = (cons (20) ((cons (40) ((@nil Z)))))) ”
  &&  “ (p___tespec_entry = 8192) ”
  &&  “ (q___tespec_entry = 12288) ”
  &&  “ (element_pre = e___tespec_entry) ”
  &&  “ (n_pre <> 0) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (n_pre + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (n_pre + 4)) # Ptr  |-> p___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=8; size=4; align=4 *) (n_pre + 8)) # Ptr  |-> q___tespec_entry)
  **  (DLLLeft p___tespec_entry n_pre ll___tespec_entry )
  **  (DLLRight q___tespec_entry n_pre lr___tespec_entry ))
  ||
  (“ (element_pre = 7) ”
  &&  “ (n_pre = 4096) ”
  &&  “ (e___tespec_entry = 7) ”
  &&  “ (h___tespec_entry = 10) ”
  &&  “ (ll___tespec_entry = (cons (30) ((@nil Z)))) ”
  &&  “ (lr___tespec_entry = (cons (20) ((cons (40) ((@nil Z)))))) ”
  &&  “ (p___tespec_entry = 8192) ”
  &&  “ (q___tespec_entry = 12288) ”
  &&  “ (element_pre = e___tespec_entry) ”
  &&  “ (n_pre = 0) ”
  &&  “ (ll___tespec_entry = (@nil Z)) ”
  &&  “ (lr___tespec_entry = (@nil Z)) ”
  &&  emp)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_add_safety_wit_1 : add_safety_wit_1.
Axiom proof_of_add_safety_wit_2 : add_safety_wit_2.
Axiom proof_of_add_safety_wit_3 : add_safety_wit_3.
Axiom proof_of_add_safety_wit_4 : add_safety_wit_4.
Axiom proof_of_add_safety_wit_5 : add_safety_wit_5.
Axiom proof_of_add_safety_wit_6 : add_safety_wit_6.
Axiom proof_of_add_return_wit_1 : add_return_wit_1.
Axiom proof_of_add_partial_solve_wit_1 : add_partial_solve_wit_1.
Axiom proof_of_add_precondition_wit_1 : add_precondition_wit_1.

End VC_Correct.
