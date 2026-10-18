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

(*----- Function read -----*)

Definition read_return_wit_1 := 
forall (i_pre: Z) (n_pre: Z) (p_pre: Z) (l___tespec_entry: (@list Z)) (PreH1 : (p_pre = 4096)) (PreH2 : (n_pre = 4)) (PreH3 : (i_pre = 1)) (PreH4 : (l___tespec_entry = (cons ((-7)) ((cons (0) ((cons (7) ((cons (12) ((@nil Z))))))))))) (PreH5 : (0 <= i_pre)) (PreH6 : (i_pre < n_pre)) ,
  (IntArray.full p_pre n_pre l___tespec_entry )
|--
  EX (l2: (@list Z)) ,
  (IntArray.full p_pre n_pre l2 )
.

Definition read_precondition_wit_1 :=
exists (i_pre: Z) ,
exists (n_pre: Z) ,
exists (p_pre: Z) ,
exists (l___tespec_entry: (@list Z)) ,
~ ((  “ (p_pre = 4096) ” 
  &&  “ (n_pre = 4) ” 
  &&  “ (i_pre = 1) ” 
  &&  “ (l___tespec_entry = (cons ((-7)) ((cons (0) ((cons (7) ((cons (12) ((@nil Z)))))))))) ” 
  &&  “ (0 <= i_pre) ” 
  &&  “ (i_pre < n_pre) ”
  &&  (IntArray.full p_pre n_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_read_return_wit_1 : read_return_wit_1.
Axiom proof_of_read_precondition_wit_1 : read_precondition_wit_1.

End VC_Correct.
