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
Require Import SimpleC.EE.QCP_demos_human.sll_layout32.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function reverse -----*)

Definition reverse_safety_wit_1 := 
  ((( &( "w_spec_421" ) )) # Ptr  |->_)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
  **  (sll32 4096 (cons (1952723005) ((cons ((-428826563)) ((cons (1100648095) ((cons (1222722771) ((cons ((-637351359)) ((cons (605155675) ((cons (1853301338) ((cons ((-1950506154)) ((@nil Z))))))))))))))))) )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition reverse_safety_wit_2 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> 4096)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_3 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_2)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_4 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_3)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_2)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_5 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_4)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_3)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_6 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_5)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_4)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_7 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_6 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_6)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_5)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_safety_wit_8 := 
forall (y: Z) (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y_7 <> 0)) (PreH3 : (y_6 <> 0)) (PreH4 : (y_5 <> 0)) (PreH5 : (y_4 <> 0)) (PreH6 : (y_3 <> 0)) (PreH7 : (y_2 <> 0)) (PreH8 : (y <> 0)) (PreH9 : (y <> 0)) (PreH10 : (y_2 <> 0)) (PreH11 : (y_3 <> 0)) (PreH12 : (y_4 <> 0)) (PreH13 : (y_5 <> 0)) (PreH14 : (y_6 <> 0)) (PreH15 : (y_7 = 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y_7 + 4 )) # Ptr  |-> 0)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> 4096)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
  **  ((( &( "v_spec_424" ) )) # Ptr  |-> y_7)
  **  ((( &( "w_spec_421" ) )) # Ptr  |-> y_6)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> 4096)
|--
  “ False ”
.

Definition reverse_return_wit_1 := 
forall (y_2: Z) (y_3: Z) (y_4: Z) (y_5: Z) (y_6: Z) (y_7: Z) (y: Z) (y_8: Z) (PreH1 : (y_8 = 0)) (PreH2 : (y <> 0)) (PreH3 : (y_7 <> 0)) (PreH4 : (y_6 <> 0)) (PreH5 : (y_5 <> 0)) (PreH6 : (y_4 <> 0)) (PreH7 : (y_3 <> 0)) (PreH8 : (y_2 <> 0)) (PreH9 : (y_2 <> 0)) (PreH10 : (y_3 <> 0)) (PreH11 : (y_4 <> 0)) (PreH12 : (y_5 <> 0)) (PreH13 : (y_6 <> 0)) (PreH14 : (y_7 <> 0)) (PreH15 : (y <> 0)) ,
  ((4100) # Ptr  |-> 0)
  **  (((y + 4 )) # Ptr  |-> y_7)
  **  ((y) # Int  |-> (-1950506154))
  **  (((y_7 + 4 )) # Ptr  |-> y_6)
  **  ((y_7) # Int  |-> 1853301338)
  **  (((y_6 + 4 )) # Ptr  |-> y_5)
  **  ((y_6) # Int  |-> 605155675)
  **  (((y_5 + 4 )) # Ptr  |-> y_4)
  **  ((y_5) # Int  |-> (-637351359))
  **  (((y_4 + 4 )) # Ptr  |-> y_3)
  **  ((y_4) # Int  |-> 1222722771)
  **  (((y_3 + 4 )) # Ptr  |-> y_2)
  **  ((y_3) # Int  |-> 1100648095)
  **  (((y_2 + 4 )) # Ptr  |-> 4096)
  **  ((y_2) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
|--
  (sll32 y (cons ((-1950506154)) ((cons (1853301338) ((cons (605155675) ((cons ((-637351359)) ((cons (1222722771) ((cons (1100648095) ((cons ((-428826563)) ((cons (1952723005) ((@nil Z))))))))))))))))) )
.

Definition reverse_partial_solve_wit_1 := 
  (sll32 4096 (cons (1952723005) ((cons ((-428826563)) ((cons (1100648095) ((cons (1222722771) ((cons ((-637351359)) ((cons (605155675) ((cons (1853301338) ((cons ((-1950506154)) ((@nil Z))))))))))))))))) )
|--
  EX (y: Z)  (y_2: Z)  (y_3: Z)  (y_4: Z)  (y_5: Z)  (y_6: Z)  (y_7: Z)  (y_8: Z) ,
  “ (y_8 = 0) ” 
  &&  “ (y_7 <> 0) ” 
  &&  “ (y_6 <> 0) ” 
  &&  “ (y_5 <> 0) ” 
  &&  “ (y_4 <> 0) ” 
  &&  “ (y_3 <> 0) ” 
  &&  “ (y_2 <> 0) ” 
  &&  “ (y <> 0) ” 
  &&  “ (4096 <> 0) ”
  &&  ((4100) # Ptr  |-> y)
  **  (((y_7 + 4 )) # Ptr  |-> y_8)
  **  ((y_7) # Int  |-> (-1950506154))
  **  (((y_6 + 4 )) # Ptr  |-> y_7)
  **  ((y_6) # Int  |-> 1853301338)
  **  (((y_5 + 4 )) # Ptr  |-> y_6)
  **  ((y_5) # Int  |-> 605155675)
  **  (((y_4 + 4 )) # Ptr  |-> y_5)
  **  ((y_4) # Int  |-> (-637351359))
  **  (((y_3 + 4 )) # Ptr  |-> y_4)
  **  ((y_3) # Int  |-> 1222722771)
  **  (((y_2 + 4 )) # Ptr  |-> y_3)
  **  ((y_2) # Int  |-> 1100648095)
  **  (((y + 4 )) # Ptr  |-> y_2)
  **  ((y) # Int  |-> (-428826563))
  **  ((4096) # Int  |-> 1952723005)
.

Definition reverse_precondition_wit_1 :=
~ ((  “ (4096 = 4096) ” 
  &&  “ ((cons (1952723005) ((cons ((-428826563)) ((cons (1100648095) ((cons (1222722771) ((cons ((-637351359)) ((cons (605155675) ((cons (1853301338) ((cons ((-1950506154)) ((@nil Z))))))))))))))))) = (cons (1952723005) ((cons ((-428826563)) ((cons (1100648095) ((cons (1222722771) ((cons ((-637351359)) ((cons (605155675) ((cons (1853301338) ((cons ((-1950506154)) ((@nil Z)))))))))))))))))) ”
  &&  (sll32 4096 (cons (1952723005) ((cons ((-428826563)) ((cons (1100648095) ((cons (1222722771) ((cons ((-637351359)) ((cons (605155675) ((cons (1853301338) ((cons ((-1950506154)) ((@nil Z))))))))))))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_reverse_safety_wit_1 : reverse_safety_wit_1.
Axiom proof_of_reverse_safety_wit_2 : reverse_safety_wit_2.
Axiom proof_of_reverse_safety_wit_3 : reverse_safety_wit_3.
Axiom proof_of_reverse_safety_wit_4 : reverse_safety_wit_4.
Axiom proof_of_reverse_safety_wit_5 : reverse_safety_wit_5.
Axiom proof_of_reverse_safety_wit_6 : reverse_safety_wit_6.
Axiom proof_of_reverse_safety_wit_7 : reverse_safety_wit_7.
Axiom proof_of_reverse_safety_wit_8 : reverse_safety_wit_8.
Axiom proof_of_reverse_return_wit_1 : reverse_return_wit_1.
Axiom proof_of_reverse_partial_solve_wit_1 : reverse_partial_solve_wit_1.
Axiom proof_of_reverse_precondition_wit_1 : reverse_precondition_wit_1.

End VC_Correct.
