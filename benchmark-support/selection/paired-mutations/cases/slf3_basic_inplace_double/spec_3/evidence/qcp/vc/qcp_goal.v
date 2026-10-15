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

(*----- Function inplace_double -----*)

Definition inplace_double_safety_wit_1 := 
forall (p_pre: Z) (old: Z) (PreH1 : ((-1073741824) <= old)) (PreH2 : (old <= 1073741823)) ,
  ((( &( "m" ) )) # Int  |->_)
  **  ((( &( "n" ) )) # Int  |-> old)
  **  ((( &( "p" ) )) # Ptr  |-> p_pre)
  **  ((p_pre) # Int  |-> old)
|--
  “ ((old + old ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (old + old )) ”
.

Definition inplace_double_return_wit_1 := 
(
forall (p_pre: Z) (old: Z) (PreH1 : ((-1073741824) <= old)) (PreH2 : (old <= 1073741823)) ,
  ((p_pre) # Int  |-> (old + old ))
|--
  TT && emp 
) \/
(
forall (p_pre: Z) (old: Z) (PreH1 : ((old + old ) <= INT_MAX)) (PreH2 : ((old + old ) >= INT_MIN)) (PreH3 : ((-1073741824) <= old)) (PreH4 : (old <= 1073741823)) ,
  ((p_pre) # Int  |-> (old + old ))
|--
  TT && emp 
).

Definition inplace_double_return_wit_1_split_goal_spatial := 
forall (p_pre: Z) (old: Z) (PreH1 : ((old + old ) <= INT_MAX)) (PreH2 : ((old + old ) >= INT_MIN)) (PreH3 : ((-1073741824) <= old)) (PreH4 : (old <= 1073741823)) ,
  ((p_pre) # Int  |-> (old + old ))
|--
  TT && emp 
.

Module Type VC_Correct.

Axiom proof_of_inplace_double_safety_wit_1 : inplace_double_safety_wit_1.
Axiom proof_of_inplace_double_return_wit_1 : inplace_double_return_wit_1.

End VC_Correct.
