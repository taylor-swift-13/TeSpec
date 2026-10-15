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

(*----- Function init_array -----*)

Definition init_array_safety_wit_1 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 7)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_2 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 6)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_3 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 5)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_4 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 4)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_5 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 3)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_6 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_7 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_8 := 
  ((( &( "j_spec_385" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (127) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_9 := 
  ((( &( "j_spec_385" ) )) # UInt  |->_)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (127) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  TT && emp 
.

Definition init_array_safety_wit_10 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 0)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (127) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_11 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_12 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 2)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_13 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 3)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_14 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 4)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_15 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 5)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_16 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 6)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_17 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 7)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_safety_wit_18 := 
forall (PreH1 : False) ,
  ((( &( "j_spec_385" ) )) # UInt  |-> 8)
  **  ((( &( "p_spec_374" ) )) # Ptr  |-> 4096)
  **  ((( &( "n_spec_371" ) )) # UInt  |-> 8)
  **  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((@nil Z))))))))))))))))) )
|--
  “ False ”
.

Definition init_array_entail_wit_1 := 
  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_2 := 
  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_3 := 
  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_4 := 
  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_5 := 
  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (0) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_6 := 
  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (0) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_7 := 
  (CharArray.full 4096 8 (cons (0) ((cons (0) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_8 := 
  (CharArray.full 4096 8 (cons (0) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_entail_wit_9 := 
  (CharArray.full 4096 8 (cons (127) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))) )
|--
  EX (li: (@list Z)) ,
  (CharArray.full 4096 8 li )
.

Definition init_array_return_wit_1 := 
forall (n_pre: Z) (p_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) >= n_pre)) (PreH2 : ((((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH3 : (((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH4 : ((((((0 + 1 ) + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH5 : (((((0 + 1 ) + 1 ) + 1 ) + 1 ) < n_pre)) (PreH6 : ((((0 + 1 ) + 1 ) + 1 ) < n_pre)) (PreH7 : (((0 + 1 ) + 1 ) < n_pre)) (PreH8 : ((0 + 1 ) < n_pre)) (PreH9 : (0 < n_pre)) (PreH10 : (p_pre = 4096)) (PreH11 : (n_pre = 8)) (PreH12 : (l___tespec_entry = (cons (127) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z))))))))))))))))))) (PreH13 : (0 <= n_pre)) (PreH14 : (n_pre <= UINT_MAX)) ,
  (CharArray.full p_pre n_pre (replace_Znth (7) (0) ((replace_Znth (6) (0) ((replace_Znth (5) (0) ((replace_Znth (4) (0) ((replace_Znth (3) (0) ((replace_Znth (2) (0) ((replace_Znth (1) (0) ((replace_Znth (0) (0) (l___tespec_entry)))))))))))))))) )
|--
  EX (l2: (@list Z)) ,
  (CharArray.full p_pre n_pre l2 )
.

Definition init_array_precondition_wit_1 :=
exists (n_pre: Z) ,
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 8) ” 
  &&  “ (l___tespec_entry = (cons (127) ((cons (40) ((cons (81) ((cons (122) ((cons (35) ((cons (76) ((cons (117) ((cons (30) ((@nil Z)))))))))))))))))) ” 
  &&  “ (0 <= n_pre) ” 
  &&  “ (n_pre <= UINT_MAX) ”
  &&  (CharArray.full p_pre n_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_init_array_safety_wit_1 : init_array_safety_wit_1.
Axiom proof_of_init_array_safety_wit_2 : init_array_safety_wit_2.
Axiom proof_of_init_array_safety_wit_3 : init_array_safety_wit_3.
Axiom proof_of_init_array_safety_wit_4 : init_array_safety_wit_4.
Axiom proof_of_init_array_safety_wit_5 : init_array_safety_wit_5.
Axiom proof_of_init_array_safety_wit_6 : init_array_safety_wit_6.
Axiom proof_of_init_array_safety_wit_7 : init_array_safety_wit_7.
Axiom proof_of_init_array_safety_wit_8 : init_array_safety_wit_8.
Axiom proof_of_init_array_safety_wit_9 : init_array_safety_wit_9.
Axiom proof_of_init_array_safety_wit_10 : init_array_safety_wit_10.
Axiom proof_of_init_array_safety_wit_11 : init_array_safety_wit_11.
Axiom proof_of_init_array_safety_wit_12 : init_array_safety_wit_12.
Axiom proof_of_init_array_safety_wit_13 : init_array_safety_wit_13.
Axiom proof_of_init_array_safety_wit_14 : init_array_safety_wit_14.
Axiom proof_of_init_array_safety_wit_15 : init_array_safety_wit_15.
Axiom proof_of_init_array_safety_wit_16 : init_array_safety_wit_16.
Axiom proof_of_init_array_safety_wit_17 : init_array_safety_wit_17.
Axiom proof_of_init_array_safety_wit_18 : init_array_safety_wit_18.
Axiom proof_of_init_array_entail_wit_1 : init_array_entail_wit_1.
Axiom proof_of_init_array_entail_wit_2 : init_array_entail_wit_2.
Axiom proof_of_init_array_entail_wit_3 : init_array_entail_wit_3.
Axiom proof_of_init_array_entail_wit_4 : init_array_entail_wit_4.
Axiom proof_of_init_array_entail_wit_5 : init_array_entail_wit_5.
Axiom proof_of_init_array_entail_wit_6 : init_array_entail_wit_6.
Axiom proof_of_init_array_entail_wit_7 : init_array_entail_wit_7.
Axiom proof_of_init_array_entail_wit_8 : init_array_entail_wit_8.
Axiom proof_of_init_array_entail_wit_9 : init_array_entail_wit_9.
Axiom proof_of_init_array_return_wit_1 : init_array_return_wit_1.
Axiom proof_of_init_array_precondition_wit_1 : init_array_precondition_wit_1.

End VC_Correct.
