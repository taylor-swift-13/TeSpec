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

(*----- Function array_read_two -----*)

Definition array_read_two_return_wit_1 := 
forall (j_pre: Z) (i_pre: Z) (n_pre: Z) (p_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (p_pre = 4096)) (PreH2 : (n_pre = 5)) (PreH3 : (i_pre = 3)) (PreH4 : (j_pre = 2)) (PreH5 : (l___tespec_entry = (cons (2) ((cons (3) ((cons (5) ((cons (7) ((cons (11) ((@nil Z))))))))))))) (PreH6 : (0 <= i_pre)) (PreH7 : (i_pre < n_pre)) (PreH8 : (0 <= j_pre)) (PreH9 : (j_pre < n_pre)) (PreH10 : (i_pre <> j_pre)) (PreH11 : (0 <= (Znth (i_pre) (l___tespec_entry) (0)))) (PreH12 : ((Znth (i_pre) (l___tespec_entry) (0)) <= UINT_MAX)) (PreH13 : (0 <= (Znth (j_pre) (l___tespec_entry) (0)))) (PreH14 : ((Znth (j_pre) (l___tespec_entry) (0)) <= UINT_MAX)) ,
  (UIntArray.full p_pre n_pre l___tespec_entry )
|--
  “ (((Znth i_pre l___tespec_entry 0) + (Znth j_pre l___tespec_entry 0) ) = (((Znth (i_pre) (l___tespec_entry) (0)) + (Znth (j_pre) (l___tespec_entry) (0)) ) % ( 4294967296 ) )) ”
  &&  (UIntArray.full p_pre n_pre l___tespec_entry )
.

Definition array_read_two_precondition_wit_1 :=
exists (j_pre: Z) ,
exists (i_pre: Z) ,
exists (n_pre: Z) ,
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 5) ” 
  &&  “ (i_pre = 3) ” 
  &&  “ (j_pre = 2) ” 
  &&  “ (l___tespec_entry = (cons (2) ((cons (3) ((cons (5) ((cons (7) ((cons (11) ((@nil Z)))))))))))) ” 
  &&  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ” 
  &&  “ (0 <= j_pre) ” 
  &&  “ (j_pre < n_pre) ” 
  &&  “ (i_pre <> j_pre) ” 
  &&  “ (0 <= (Znth (i_pre) (l___tespec_entry) (0))) ” 
  &&  “ ((Znth (i_pre) (l___tespec_entry) (0)) <= UINT_MAX) ” 
  &&  “ (0 <= (Znth (j_pre) (l___tespec_entry) (0))) ” 
  &&  “ ((Znth (j_pre) (l___tespec_entry) (0)) <= UINT_MAX) ”
  &&  (UIntArray.full p_pre n_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_array_read_two_return_wit_1 : array_read_two_return_wit_1.
Axiom proof_of_array_read_two_precondition_wit_1 : array_read_two_precondition_wit_1.

End VC_Correct.
