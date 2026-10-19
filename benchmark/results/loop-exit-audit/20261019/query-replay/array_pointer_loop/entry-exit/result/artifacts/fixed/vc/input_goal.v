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

(*----- Function sample -----*)

Definition sample_safety_wit_1 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 12)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_2 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 6)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_3 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 6)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_4 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_5 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_6 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_7 := 
  ((( &( "end_spec_388" ) )) # Ptr  |->_)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_8 := 
  ((( &( "total_spec_385" ) )) # Int  |->_)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_9 := 
  ((( &( "i_spec_382" ) )) # Int  |->_)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_10 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 0)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  “ False ”
.

Definition sample_safety_wit_12 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_13 := 
forall (PreH1 : False) ,
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 2)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  “ False ”
.

Definition sample_safety_wit_14 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 6)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_15 := 
forall (PreH1 : False) ,
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 6)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  “ False ”
.

Definition sample_safety_wit_16 := 
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 12)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition sample_safety_wit_17 := 
forall (PreH1 : False) ,
  ((( &( "end_spec_388" ) )) # Ptr  |-> 4108)
  **  ((( &( "total_spec_385" ) )) # Int  |-> 12)
  **  ((( &( "i_spec_382" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_371" ) )) # Ptr  |-> 4096)
  **  (IntArray.full 4096 3 (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))) )
|--
  “ False ”
.

Definition sample_return_wit_1 := 
forall (p_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : ((((p_pre + (3 * sizeof(INT))) - (p_pre + ((((0 + 1 ) + 1 ) + 1 ) * sizeof(INT))) ) ÷ sizeof(INT) ) = 0)) (PreH2 : ((((p_pre + (3 * sizeof(INT))) - (p_pre + (((0 + 1 ) + 1 ) * sizeof(INT))) ) ÷ sizeof(INT) ) <> 0)) (PreH3 : ((((p_pre + (3 * sizeof(INT))) - (p_pre + ((0 + 1 ) * sizeof(INT))) ) ÷ sizeof(INT) ) <> 0)) (PreH4 : ((((p_pre + (3 * sizeof(INT))) - (p_pre + (0 * sizeof(INT))) ) ÷ sizeof(INT) ) <> 0)) (PreH5 : (p_pre = 4096)) (PreH6 : (l___tespec_entry = (cons (2) ((cons (4) ((cons (6) ((@nil Z))))))))) ,
  (IntArray.full p_pre 3 l___tespec_entry )
|--
  “ ((((0 + (Znth 0 l___tespec_entry 0) ) + (Znth 1 l___tespec_entry 0) ) + (Znth 2 l___tespec_entry 0) ) = 12) ”
  &&  (IntArray.full p_pre 3 l___tespec_entry )
.

Definition sample_precondition_wit_1 :=
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons (4) ((cons (6) ((@nil Z)))))))) ”
  &&  (IntArray.full p_pre 3 l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sample_safety_wit_1 : sample_safety_wit_1.
Axiom proof_of_sample_safety_wit_2 : sample_safety_wit_2.
Axiom proof_of_sample_safety_wit_3 : sample_safety_wit_3.
Axiom proof_of_sample_safety_wit_4 : sample_safety_wit_4.
Axiom proof_of_sample_safety_wit_5 : sample_safety_wit_5.
Axiom proof_of_sample_safety_wit_6 : sample_safety_wit_6.
Axiom proof_of_sample_safety_wit_7 : sample_safety_wit_7.
Axiom proof_of_sample_safety_wit_8 : sample_safety_wit_8.
Axiom proof_of_sample_safety_wit_9 : sample_safety_wit_9.
Axiom proof_of_sample_safety_wit_10 : sample_safety_wit_10.
Axiom proof_of_sample_safety_wit_11 : sample_safety_wit_11.
Axiom proof_of_sample_safety_wit_12 : sample_safety_wit_12.
Axiom proof_of_sample_safety_wit_13 : sample_safety_wit_13.
Axiom proof_of_sample_safety_wit_14 : sample_safety_wit_14.
Axiom proof_of_sample_safety_wit_15 : sample_safety_wit_15.
Axiom proof_of_sample_safety_wit_16 : sample_safety_wit_16.
Axiom proof_of_sample_safety_wit_17 : sample_safety_wit_17.
Axiom proof_of_sample_return_wit_1 : sample_return_wit_1.
Axiom proof_of_sample_precondition_wit_1 : sample_precondition_wit_1.

End VC_Correct.
