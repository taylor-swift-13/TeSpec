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
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function verify_main -----*)

Definition verify_main_safety_wit_1 := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (retval_2: Z) (two: Z) (second_2: Z) (second_3: Z) (third: Z) (PreH1 : (second_3 = 4100)) (PreH2 : (third = 4104)) (PreH3 : (two = 2)) (PreH4 : (second_2 = 4100)) (PreH5 : (retval_2 = 2)) (PreH6 : (second = 4100)) (PreH7 : (one = 1)) (PreH8 : (retval = 1)) (PreH9 : (zero = 0)) ,
  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
  **  ((( &( "two_spec_467" ) )) # Int  |-> 2)
  **  ((( &( "third_spec_494" ) )) # Ptr  |-> 4104)
|--
  TT && emp 
.

Definition verify_main_safety_wit_2 := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (retval_2: Z) (two: Z) (second_2: Z) (PreH1 : (two = 2)) (PreH2 : (second_2 = 4100)) (PreH3 : (retval_2 = 2)) (PreH4 : (second = 4100)) (PreH5 : (one = 1)) (PreH6 : (retval = 1)) (PreH7 : (zero = 0)) ,
  ((( &( "third_spec_494" ) )) # Ptr  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "two_spec_467" ) )) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_3 := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (PreH1 : (second = 4100)) (PreH2 : (one = 1)) (PreH3 : (retval = 1)) (PreH4 : (zero = 0)) ,
  ((( &( "two_spec_467" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_4 := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (PreH1 : (second = 4100)) (PreH2 : (one = 1)) (PreH3 : (retval = 1)) (PreH4 : (zero = 0)) ,
  ((( &( "two_spec_467" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  TT && emp 
.

Definition verify_main_safety_wit_5 := 
forall (zero: Z) (retval: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval = 1)) (PreH3 : (zero = 0)) ,
  ((( &( "second_spec_449" ) )) # Ptr  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_6 := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  ((( &( "one_spec_428" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_7 := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  ((( &( "one_spec_428" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  TT && emp 
.

Definition verify_main_safety_wit_8 := 
  ((( &( "zero_spec_401" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_safety_wit_9 := 
  ((( &( "zero_spec_401" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition verify_main_entail_wit_1 := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (retval_2: Z) (two: Z) (second_2: Z) (PreH1 : (two = 2)) (PreH2 : (second_2 = 4100)) (PreH3 : (retval_2 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (second = 4100)) (PreH5 : (one = 1)) (PreH6 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH7 : (zero = 0)) (PreH8 : ((INT_MIN) <= retval)) (PreH9 : (retval <= INT_MAX)) (PreH10 : ((INT_MIN) <= retval_2)) (PreH11 : (retval_2 <= INT_MAX)) ,
  ((( &( "third_spec_494" ) )) # Ptr  |-> (4096 + (2 * sizeof(INT))))
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (third: Z)  (second_3: Z) ,
  “ (second_3 = 4100) ” 
  &&  “ (third = 4104) ” 
  &&  “ (two = 2) ” 
  &&  “ (second_2 = 4100) ” 
  &&  “ (retval_2 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (second = 4100) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "third_spec_494" ) )) # Ptr  |-> 4104)
.

Definition verify_main_entail_wit_2 := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (retval_2: Z) (PreH1 : (retval_2 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (second = 4100)) (PreH3 : (one = 1)) (PreH4 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH5 : (zero = 0)) (PreH6 : ((INT_MIN) <= retval)) (PreH7 : (retval <= INT_MAX)) (PreH8 : ((INT_MIN) <= retval_2)) (PreH9 : (retval_2 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "two_spec_467" ) )) # Int  |-> retval_2)
|--
  EX (second_2: Z)  (two: Z) ,
  “ (two = 2) ” 
  &&  “ (second_2 = 4100) ” 
  &&  “ (retval_2 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (second = 4100) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= retval_2) ” 
  &&  “ (retval_2 <= INT_MAX) ”
  &&  ((( &( "two_spec_467" ) )) # Int  |-> 2)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_3 := 
forall (zero: Z) (retval: Z) (one: Z) (PreH1 : (one = 1)) (PreH2 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH3 : (zero = 0)) (PreH4 : ((INT_MIN) <= retval)) (PreH5 : (retval <= INT_MAX)) ,
  ((( &( "second_spec_449" ) )) # Ptr  |-> (4096 + (1 * sizeof(INT))))
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  EX (second: Z) ,
  “ (second = 4100) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
.

Definition verify_main_entail_wit_4 := 
forall (zero: Z) (retval: Z) (PreH1 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (zero = 0)) (PreH3 : ((INT_MIN) <= retval)) (PreH4 : (retval <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "one_spec_428" ) )) # Int  |-> retval)
|--
  EX (one: Z) ,
  “ (one = 1) ” 
  &&  “ (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_5 := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (zero = 0) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_entail_wit_6 := 
forall (a_pre: Z) (a0___tespec_entry: Z) (retval: Z) (PreH1 : (retval = (Znth (0) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH2 : (a_pre = 4096)) (PreH3 : (a0___tespec_entry = 4096)) (PreH4 : (a_pre = a0___tespec_entry)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> retval)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
|--
  EX (zero: Z) ,
  “ (zero = 0) ”
  &&  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_return_wit_1 := 
forall (a0___tespec_entry: Z) (zero: Z) (retval: Z) (one: Z) (second: Z) (retval_2: Z) (two: Z) (second_2: Z) (second_3: Z) (third: Z) (PreH1 : (second_3 = 4100)) (PreH2 : (third = 4104)) (PreH3 : (two = 2)) (PreH4 : (second_2 = 4100)) (PreH5 : (retval_2 = (Znth (2) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH6 : (second = 4100)) (PreH7 : (one = 1)) (PreH8 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH9 : (zero = 0)) (PreH10 : ((INT_MIN) <= retval)) (PreH11 : (retval <= INT_MAX)) (PreH12 : ((INT_MIN) <= retval_2)) (PreH13 : (retval_2 <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 = 0) ”
  &&  (IntArray.full a0___tespec_entry 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1_pure := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (PreH1 : (second = 4100)) (PreH2 : (one = 1)) (PreH3 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (zero = 0)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  ((( &( "two_spec_467" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
  **  ((( &( "one_spec_428" ) )) # Int  |-> 1)
  **  ((( &( "second_spec_449" ) )) # Ptr  |-> 4100)
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ”
.

Definition verify_main_partial_solve_wit_1_aux := 
forall (zero: Z) (retval: Z) (one: Z) (second: Z) (PreH1 : (second = 4100)) (PreH2 : (one = 1)) (PreH3 : (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0)))) (PreH4 : (zero = 0)) (PreH5 : ((INT_MIN) <= retval)) (PreH6 : (retval <= INT_MAX)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 2) ” 
  &&  “ (2 < 3) ” 
  &&  “ (second = 4100) ” 
  &&  “ (one = 1) ” 
  &&  “ (retval = (Znth (1) ((cons (0) ((cons (1) ((cons (2) ((@nil Z)))))))) (0))) ” 
  &&  “ (zero = 0) ” 
  &&  “ ((INT_MIN) <= retval) ” 
  &&  “ (retval <= INT_MAX) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_1 := verify_main_partial_solve_wit_1_pure -> verify_main_partial_solve_wit_1_aux.

Definition verify_main_partial_solve_wit_2_pure := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  ((( &( "one_spec_428" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
  **  ((( &( "zero_spec_401" ) )) # Int  |-> 0)
  **  ((( &( "first_spec_416" ) )) # Ptr  |-> 4096)
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ”
.

Definition verify_main_partial_solve_wit_2_aux := 
forall (zero: Z) (PreH1 : (zero = 0)) ,
  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 1) ” 
  &&  “ (1 < 3) ” 
  &&  “ (zero = 0) ”
  &&  (IntArray.full 4096 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_2 := verify_main_partial_solve_wit_2_pure -> verify_main_partial_solve_wit_2_aux.

Definition verify_main_partial_solve_wit_3_pure := 
forall (a_pre: Z) (a0___tespec_entry: Z) (PreH1 : (a_pre = 4096)) (PreH2 : (a0___tespec_entry = 4096)) (PreH3 : (a_pre = a0___tespec_entry)) ,
  ((( &( "zero_spec_401" ) )) # Int  |->_)
  **  ((( &( "a_spec_390" ) )) # Ptr  |-> a_pre)
  **  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ”
.

Definition verify_main_partial_solve_wit_3_aux := 
forall (a_pre: Z) (a0___tespec_entry: Z) (PreH1 : (a_pre = 4096)) (PreH2 : (a0___tespec_entry = 4096)) (PreH3 : (a_pre = a0___tespec_entry)) ,
  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
|--
  “ (0 <= 0) ” 
  &&  “ (0 < 3) ” 
  &&  “ (a_pre = 4096) ” 
  &&  “ (a0___tespec_entry = 4096) ” 
  &&  “ (a_pre = a0___tespec_entry) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )
.

Definition verify_main_partial_solve_wit_3 := verify_main_partial_solve_wit_3_pure -> verify_main_partial_solve_wit_3_aux.

Definition verify_main_precondition_wit_1 :=
exists (a_pre: Z) ,
exists (a0___tespec_entry: Z) ,
~ ((  “ (a_pre = 4096) ” 
  &&  “ (a0___tespec_entry = 4096) ” 
  &&  “ (a_pre = a0___tespec_entry) ”
  &&  (IntArray.full a_pre 3 (cons (0) ((cons (1) ((cons (2) ((@nil Z))))))) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_verify_main_safety_wit_1 : verify_main_safety_wit_1.
Axiom proof_of_verify_main_safety_wit_2 : verify_main_safety_wit_2.
Axiom proof_of_verify_main_safety_wit_3 : verify_main_safety_wit_3.
Axiom proof_of_verify_main_safety_wit_4 : verify_main_safety_wit_4.
Axiom proof_of_verify_main_safety_wit_5 : verify_main_safety_wit_5.
Axiom proof_of_verify_main_safety_wit_6 : verify_main_safety_wit_6.
Axiom proof_of_verify_main_safety_wit_7 : verify_main_safety_wit_7.
Axiom proof_of_verify_main_safety_wit_8 : verify_main_safety_wit_8.
Axiom proof_of_verify_main_safety_wit_9 : verify_main_safety_wit_9.
Axiom proof_of_verify_main_entail_wit_1 : verify_main_entail_wit_1.
Axiom proof_of_verify_main_entail_wit_2 : verify_main_entail_wit_2.
Axiom proof_of_verify_main_entail_wit_3 : verify_main_entail_wit_3.
Axiom proof_of_verify_main_entail_wit_4 : verify_main_entail_wit_4.
Axiom proof_of_verify_main_entail_wit_5 : verify_main_entail_wit_5.
Axiom proof_of_verify_main_entail_wit_6 : verify_main_entail_wit_6.
Axiom proof_of_verify_main_return_wit_1 : verify_main_return_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_1_pure : verify_main_partial_solve_wit_1_pure.
Axiom proof_of_verify_main_partial_solve_wit_1 : verify_main_partial_solve_wit_1.
Axiom proof_of_verify_main_partial_solve_wit_2_pure : verify_main_partial_solve_wit_2_pure.
Axiom proof_of_verify_main_partial_solve_wit_2 : verify_main_partial_solve_wit_2.
Axiom proof_of_verify_main_partial_solve_wit_3_pure : verify_main_partial_solve_wit_3_pure.
Axiom proof_of_verify_main_partial_solve_wit_3 : verify_main_partial_solve_wit_3.
Axiom proof_of_verify_main_precondition_wit_1 : verify_main_precondition_wit_1.

End VC_Correct.
