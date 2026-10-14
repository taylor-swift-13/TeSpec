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
Require Import p076_is_simple_power.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function p076_is_simple_power -----*)

Definition p076_is_simple_power_safety_wit_1 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition p076_is_simple_power_safety_wit_2 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 99)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((99 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (99 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_3 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 99)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_4 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 99)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_5 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 98)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((98 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (98 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_6 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 98)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_7 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 98)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_8 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 97)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((97 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (97 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_9 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 97)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_10 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 97)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_11 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 96)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((96 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (96 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_12 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 96)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_13 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 96)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_14 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 95)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((95 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (95 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_15 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 95)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_16 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 95)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_17 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 94)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((94 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (94 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_18 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 94)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_19 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 94)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_20 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 93)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((93 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (93 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_21 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 93)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_22 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 93)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_23 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 92)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((92 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (92 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_24 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 92)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_25 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 92)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_26 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 91)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((91 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (91 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_27 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 91)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_28 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 91)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_29 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 90)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((90 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (90 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_30 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 90)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_31 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 90)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_32 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 89)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((89 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (89 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_33 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 89)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_34 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 89)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_35 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 88)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((88 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (88 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_36 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 88)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_37 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 88)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_38 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 87)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((87 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (87 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_39 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 87)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_40 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 87)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_41 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 86)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((86 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (86 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_42 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 86)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_43 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 86)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_44 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 85)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((85 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (85 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_45 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 85)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_46 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 85)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_47 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 84)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((84 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (84 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_48 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 84)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_49 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 84)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_50 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 83)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((83 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (83 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_51 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 83)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_52 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 83)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_53 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 82)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((82 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (82 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_54 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 82)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_55 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 82)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_56 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 81)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((81 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (81 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_57 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 81)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_58 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 81)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_59 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 80)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((80 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (80 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_60 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 80)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_61 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 80)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_62 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 79)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((79 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (79 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_63 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 79)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_64 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 79)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_65 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 78)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((78 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (78 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_66 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 78)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_67 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 78)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_68 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 77)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((77 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (77 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_69 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 77)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_70 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 77)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_71 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 76)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((76 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (76 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_72 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 76)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_73 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 76)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_74 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 75)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((75 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (75 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_75 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 75)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_76 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 75)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_77 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 74)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((74 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (74 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_78 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 74)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_79 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 74)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_80 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 73)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((73 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (73 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_81 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 73)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_82 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 73)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_83 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 72)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((72 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (72 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_84 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 72)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_85 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 72)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_86 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 71)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((71 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (71 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_87 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 71)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_88 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 71)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_89 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 70)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((70 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (70 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_90 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 70)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_91 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 70)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_92 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 69)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((69 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (69 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_93 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 69)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_94 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 69)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_95 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 68)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((68 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (68 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_96 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 68)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_97 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 68)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_98 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 67)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((67 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (67 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_99 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 67)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_100 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 67)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_101 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 66)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((66 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (66 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_102 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 66)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_103 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 66)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_104 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 65)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((65 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (65 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_105 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 65)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_106 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 65)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_107 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 64)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((64 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (64 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_108 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 64)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_109 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 64)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_110 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 63)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((63 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (63 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_111 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 63)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_112 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 63)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_113 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 62)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((62 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (62 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_114 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 62)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_115 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 62)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_116 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 61)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((61 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (61 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_117 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 61)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_118 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 61)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_119 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 60)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((60 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (60 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_120 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 60)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_121 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 60)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_122 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 59)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((59 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (59 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_123 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 59)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_124 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 59)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_125 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 58)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((58 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (58 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_126 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 58)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_127 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 58)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_128 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 57)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((57 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (57 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_129 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 57)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_130 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 57)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_131 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 56)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((56 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (56 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_132 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 56)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_133 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 56)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_134 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 55)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((55 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (55 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_135 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 55)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_136 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 55)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_137 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 54)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((54 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (54 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_138 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 54)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_139 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 54)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_140 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 53)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((53 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (53 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_141 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 53)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_142 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 53)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_143 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 52)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((52 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (52 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_144 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 52)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_145 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 52)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_146 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 51)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((51 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (51 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_147 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 51)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_148 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 51)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_149 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 50)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((50 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (50 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_150 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 50)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_151 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 50)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_152 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 49)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((49 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (49 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_153 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 49)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_154 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 49)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_155 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 48)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((48 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (48 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_156 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 48)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_157 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 48)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_158 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 47)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((47 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (47 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_159 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 47)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_160 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 47)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_161 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 46)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((46 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (46 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_162 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 46)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_163 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 46)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_164 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 45)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((45 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (45 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_165 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 45)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_166 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 45)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_167 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 44)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((44 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (44 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_168 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 44)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_169 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 44)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_170 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 43)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((43 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (43 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_171 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 43)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_172 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 43)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_173 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 42)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((42 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (42 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_174 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 42)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_175 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 42)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_176 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 41)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((41 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (41 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_177 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 41)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_178 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 41)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_179 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 40)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((40 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (40 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_180 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 40)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_181 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 40)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_182 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 39)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((39 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (39 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_183 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 39)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_184 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 39)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_185 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 38)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((38 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (38 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_186 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 38)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_187 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 38)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_188 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 37)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((37 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (37 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_189 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 37)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_190 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 37)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_191 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 36)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((36 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (36 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_192 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 36)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_193 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 36)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_194 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 35)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((35 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (35 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_195 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 35)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_196 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 35)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_197 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 34)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((34 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (34 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_198 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 34)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_199 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 34)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_200 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 33)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((33 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (33 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_201 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 33)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_202 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 33)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_203 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 32)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((32 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (32 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_204 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 32)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_205 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 32)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_206 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 31)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((31 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (31 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_207 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 31)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_208 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 31)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_209 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 30)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((30 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (30 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_210 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 30)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_211 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 30)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_212 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 29)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((29 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (29 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_213 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 29)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_214 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 29)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_215 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 28)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((28 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (28 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_216 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 28)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_217 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 28)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_218 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 27)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((27 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (27 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_219 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 27)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_220 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 27)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_221 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 26)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((26 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (26 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_222 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 26)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_223 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 26)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_224 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 25)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((25 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (25 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_225 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 25)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_226 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 25)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_227 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 24)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((24 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (24 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_228 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 24)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_229 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 24)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_230 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 23)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((23 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (23 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_231 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 23)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_232 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 23)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_233 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 22)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((22 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (22 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_234 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 22)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_235 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 22)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_236 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 21)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((21 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (21 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_237 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 21)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_238 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 21)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_239 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 20)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((20 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (20 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_240 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 20)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_241 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 20)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_242 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 19)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((19 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (19 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_243 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 19)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_244 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 19)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_245 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 18)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((18 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (18 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_246 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 18)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_247 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 18)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_248 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 17)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((17 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (17 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_249 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 17)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_250 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 17)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_251 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 16)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((16 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (16 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_252 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 16)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_253 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 16)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_254 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 15)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((15 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (15 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_255 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 15)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_256 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 15)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_257 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 14)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((14 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (14 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_258 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 14)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_259 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 14)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_260 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((13 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (13 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_261 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_262 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_263 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((12 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (12 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_264 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_265 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_266 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 11)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((11 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (11 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_267 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 11)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_268 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 11)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_269 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 10)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((10 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (10 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_270 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 10)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_271 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 10)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_272 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 9)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((9 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (9 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_273 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 9)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_274 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 9)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_275 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((8 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (8 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_276 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_277 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_278 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 7)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((7 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (7 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_279 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 7)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_280 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 7)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_281 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 6)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((6 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (6 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_282 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 6)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_283 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 6)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_284 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 5)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((5 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (5 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_285 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 5)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_286 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 5)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_287 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((4 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (4 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_288 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_289 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_290 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((3 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (3 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_291 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_292 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_293 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((2 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (2 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_294 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_295 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_296 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_297 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_298 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_299 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((0 + 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (0 + 1 )) ”
.

Definition p076_is_simple_power_safety_wit_300 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_301 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ ((1 * 1 ) <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= (1 * 1 )) ”
.

Definition p076_is_simple_power_safety_wit_302 := 
  ((( &( "count_spec_387" ) )) # Int  |->_)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition p076_is_simple_power_safety_wit_303 := 
  ((( &( "p_spec_384" ) )) # Int  |->_)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition p076_is_simple_power_safety_wit_304 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 0)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_305 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 1)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_306 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 2)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_307 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 3)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_308 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 4)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_309 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 5)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_310 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 6)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_311 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 7)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_312 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 8)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_313 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 9)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_314 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 10)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_315 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 11)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_316 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 12)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_317 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 13)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_318 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 14)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_319 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 15)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_320 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 16)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_321 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 17)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_322 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 18)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_323 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 19)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_324 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 20)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_325 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 21)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_326 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 22)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_327 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 23)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_328 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 24)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_329 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 25)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_330 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 26)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_331 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 27)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_332 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 28)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_333 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 29)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_334 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 30)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_335 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 31)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_336 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 32)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_337 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 33)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_338 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 34)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_339 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 35)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_340 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 36)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_341 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 37)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_342 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 38)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_343 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 39)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_344 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 40)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_345 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 41)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_346 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 42)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_347 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 43)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_348 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 44)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_349 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 45)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_350 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 46)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_351 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 47)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_352 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 48)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_353 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 49)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_354 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 50)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_355 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 51)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_356 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 52)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_357 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 53)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_358 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 54)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_359 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 55)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_360 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 56)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_361 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 57)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_362 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 58)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_363 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 59)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_364 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 60)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_365 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 61)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_366 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 62)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_367 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 63)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_368 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 64)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_369 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 65)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_370 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 66)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_371 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 67)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_372 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 68)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_373 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 69)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_374 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 70)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_375 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 71)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_376 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 72)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_377 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 73)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_378 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 74)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_379 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 75)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_380 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 76)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_381 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 77)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_382 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 78)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_383 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 79)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_384 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 80)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_385 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 81)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_386 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 82)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_387 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 83)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_388 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 84)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_389 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 85)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_390 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 86)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_391 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 87)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_392 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 88)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_393 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 89)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_394 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 90)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_395 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 91)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_396 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 92)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_397 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 93)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_398 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 94)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_399 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 95)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_400 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 96)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_401 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 97)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_402 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 98)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_403 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 99)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_safety_wit_404 := 
  ((( &( "count_spec_387" ) )) # Int  |-> 100)
  **  ((( &( "p_spec_384" ) )) # Int  |-> 1)
  **  ((( &( "x_spec_375" ) )) # Int  |-> 3)
  **  ((( &( "n_spec_372" ) )) # Int  |-> 1)
|--
  “ (100 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 100) ”
.

Definition p076_is_simple_power_return_wit_1 := 
(
  TT && emp 
|--
  “ (is_simple_power_spec 3 1 0 ) ”
  &&  emp
) \/
(
  TT && emp 
|--
  “ (is_simple_power_spec 3 1 0 ) ”
  &&  emp
).

Definition p076_is_simple_power_return_wit_1_split_goal_1 := 
  (is_simple_power_spec 3 1 0 )
.

Definition p076_is_simple_power_precondition_wit_1 :=
~ ((  “ (3 = 3) ” 
  &&  “ (1 = 1) ” 
  &&  “ (1 <= 3) ” 
  &&  “ (3 <= INT_MAX) ” 
  &&  “ (1 <= 1) ” 
  &&  “ (1 <= INT_MAX) ” 
  &&  “ ((3 * 1 ) <= INT_MAX) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_p076_is_simple_power_safety_wit_1 : p076_is_simple_power_safety_wit_1.
Axiom proof_of_p076_is_simple_power_safety_wit_2 : p076_is_simple_power_safety_wit_2.
Axiom proof_of_p076_is_simple_power_safety_wit_3 : p076_is_simple_power_safety_wit_3.
Axiom proof_of_p076_is_simple_power_safety_wit_4 : p076_is_simple_power_safety_wit_4.
Axiom proof_of_p076_is_simple_power_safety_wit_5 : p076_is_simple_power_safety_wit_5.
Axiom proof_of_p076_is_simple_power_safety_wit_6 : p076_is_simple_power_safety_wit_6.
Axiom proof_of_p076_is_simple_power_safety_wit_7 : p076_is_simple_power_safety_wit_7.
Axiom proof_of_p076_is_simple_power_safety_wit_8 : p076_is_simple_power_safety_wit_8.
Axiom proof_of_p076_is_simple_power_safety_wit_9 : p076_is_simple_power_safety_wit_9.
Axiom proof_of_p076_is_simple_power_safety_wit_10 : p076_is_simple_power_safety_wit_10.
Axiom proof_of_p076_is_simple_power_safety_wit_11 : p076_is_simple_power_safety_wit_11.
Axiom proof_of_p076_is_simple_power_safety_wit_12 : p076_is_simple_power_safety_wit_12.
Axiom proof_of_p076_is_simple_power_safety_wit_13 : p076_is_simple_power_safety_wit_13.
Axiom proof_of_p076_is_simple_power_safety_wit_14 : p076_is_simple_power_safety_wit_14.
Axiom proof_of_p076_is_simple_power_safety_wit_15 : p076_is_simple_power_safety_wit_15.
Axiom proof_of_p076_is_simple_power_safety_wit_16 : p076_is_simple_power_safety_wit_16.
Axiom proof_of_p076_is_simple_power_safety_wit_17 : p076_is_simple_power_safety_wit_17.
Axiom proof_of_p076_is_simple_power_safety_wit_18 : p076_is_simple_power_safety_wit_18.
Axiom proof_of_p076_is_simple_power_safety_wit_19 : p076_is_simple_power_safety_wit_19.
Axiom proof_of_p076_is_simple_power_safety_wit_20 : p076_is_simple_power_safety_wit_20.
Axiom proof_of_p076_is_simple_power_safety_wit_21 : p076_is_simple_power_safety_wit_21.
Axiom proof_of_p076_is_simple_power_safety_wit_22 : p076_is_simple_power_safety_wit_22.
Axiom proof_of_p076_is_simple_power_safety_wit_23 : p076_is_simple_power_safety_wit_23.
Axiom proof_of_p076_is_simple_power_safety_wit_24 : p076_is_simple_power_safety_wit_24.
Axiom proof_of_p076_is_simple_power_safety_wit_25 : p076_is_simple_power_safety_wit_25.
Axiom proof_of_p076_is_simple_power_safety_wit_26 : p076_is_simple_power_safety_wit_26.
Axiom proof_of_p076_is_simple_power_safety_wit_27 : p076_is_simple_power_safety_wit_27.
Axiom proof_of_p076_is_simple_power_safety_wit_28 : p076_is_simple_power_safety_wit_28.
Axiom proof_of_p076_is_simple_power_safety_wit_29 : p076_is_simple_power_safety_wit_29.
Axiom proof_of_p076_is_simple_power_safety_wit_30 : p076_is_simple_power_safety_wit_30.
Axiom proof_of_p076_is_simple_power_safety_wit_31 : p076_is_simple_power_safety_wit_31.
Axiom proof_of_p076_is_simple_power_safety_wit_32 : p076_is_simple_power_safety_wit_32.
Axiom proof_of_p076_is_simple_power_safety_wit_33 : p076_is_simple_power_safety_wit_33.
Axiom proof_of_p076_is_simple_power_safety_wit_34 : p076_is_simple_power_safety_wit_34.
Axiom proof_of_p076_is_simple_power_safety_wit_35 : p076_is_simple_power_safety_wit_35.
Axiom proof_of_p076_is_simple_power_safety_wit_36 : p076_is_simple_power_safety_wit_36.
Axiom proof_of_p076_is_simple_power_safety_wit_37 : p076_is_simple_power_safety_wit_37.
Axiom proof_of_p076_is_simple_power_safety_wit_38 : p076_is_simple_power_safety_wit_38.
Axiom proof_of_p076_is_simple_power_safety_wit_39 : p076_is_simple_power_safety_wit_39.
Axiom proof_of_p076_is_simple_power_safety_wit_40 : p076_is_simple_power_safety_wit_40.
Axiom proof_of_p076_is_simple_power_safety_wit_41 : p076_is_simple_power_safety_wit_41.
Axiom proof_of_p076_is_simple_power_safety_wit_42 : p076_is_simple_power_safety_wit_42.
Axiom proof_of_p076_is_simple_power_safety_wit_43 : p076_is_simple_power_safety_wit_43.
Axiom proof_of_p076_is_simple_power_safety_wit_44 : p076_is_simple_power_safety_wit_44.
Axiom proof_of_p076_is_simple_power_safety_wit_45 : p076_is_simple_power_safety_wit_45.
Axiom proof_of_p076_is_simple_power_safety_wit_46 : p076_is_simple_power_safety_wit_46.
Axiom proof_of_p076_is_simple_power_safety_wit_47 : p076_is_simple_power_safety_wit_47.
Axiom proof_of_p076_is_simple_power_safety_wit_48 : p076_is_simple_power_safety_wit_48.
Axiom proof_of_p076_is_simple_power_safety_wit_49 : p076_is_simple_power_safety_wit_49.
Axiom proof_of_p076_is_simple_power_safety_wit_50 : p076_is_simple_power_safety_wit_50.
Axiom proof_of_p076_is_simple_power_safety_wit_51 : p076_is_simple_power_safety_wit_51.
Axiom proof_of_p076_is_simple_power_safety_wit_52 : p076_is_simple_power_safety_wit_52.
Axiom proof_of_p076_is_simple_power_safety_wit_53 : p076_is_simple_power_safety_wit_53.
Axiom proof_of_p076_is_simple_power_safety_wit_54 : p076_is_simple_power_safety_wit_54.
Axiom proof_of_p076_is_simple_power_safety_wit_55 : p076_is_simple_power_safety_wit_55.
Axiom proof_of_p076_is_simple_power_safety_wit_56 : p076_is_simple_power_safety_wit_56.
Axiom proof_of_p076_is_simple_power_safety_wit_57 : p076_is_simple_power_safety_wit_57.
Axiom proof_of_p076_is_simple_power_safety_wit_58 : p076_is_simple_power_safety_wit_58.
Axiom proof_of_p076_is_simple_power_safety_wit_59 : p076_is_simple_power_safety_wit_59.
Axiom proof_of_p076_is_simple_power_safety_wit_60 : p076_is_simple_power_safety_wit_60.
Axiom proof_of_p076_is_simple_power_safety_wit_61 : p076_is_simple_power_safety_wit_61.
Axiom proof_of_p076_is_simple_power_safety_wit_62 : p076_is_simple_power_safety_wit_62.
Axiom proof_of_p076_is_simple_power_safety_wit_63 : p076_is_simple_power_safety_wit_63.
Axiom proof_of_p076_is_simple_power_safety_wit_64 : p076_is_simple_power_safety_wit_64.
Axiom proof_of_p076_is_simple_power_safety_wit_65 : p076_is_simple_power_safety_wit_65.
Axiom proof_of_p076_is_simple_power_safety_wit_66 : p076_is_simple_power_safety_wit_66.
Axiom proof_of_p076_is_simple_power_safety_wit_67 : p076_is_simple_power_safety_wit_67.
Axiom proof_of_p076_is_simple_power_safety_wit_68 : p076_is_simple_power_safety_wit_68.
Axiom proof_of_p076_is_simple_power_safety_wit_69 : p076_is_simple_power_safety_wit_69.
Axiom proof_of_p076_is_simple_power_safety_wit_70 : p076_is_simple_power_safety_wit_70.
Axiom proof_of_p076_is_simple_power_safety_wit_71 : p076_is_simple_power_safety_wit_71.
Axiom proof_of_p076_is_simple_power_safety_wit_72 : p076_is_simple_power_safety_wit_72.
Axiom proof_of_p076_is_simple_power_safety_wit_73 : p076_is_simple_power_safety_wit_73.
Axiom proof_of_p076_is_simple_power_safety_wit_74 : p076_is_simple_power_safety_wit_74.
Axiom proof_of_p076_is_simple_power_safety_wit_75 : p076_is_simple_power_safety_wit_75.
Axiom proof_of_p076_is_simple_power_safety_wit_76 : p076_is_simple_power_safety_wit_76.
Axiom proof_of_p076_is_simple_power_safety_wit_77 : p076_is_simple_power_safety_wit_77.
Axiom proof_of_p076_is_simple_power_safety_wit_78 : p076_is_simple_power_safety_wit_78.
Axiom proof_of_p076_is_simple_power_safety_wit_79 : p076_is_simple_power_safety_wit_79.
Axiom proof_of_p076_is_simple_power_safety_wit_80 : p076_is_simple_power_safety_wit_80.
Axiom proof_of_p076_is_simple_power_safety_wit_81 : p076_is_simple_power_safety_wit_81.
Axiom proof_of_p076_is_simple_power_safety_wit_82 : p076_is_simple_power_safety_wit_82.
Axiom proof_of_p076_is_simple_power_safety_wit_83 : p076_is_simple_power_safety_wit_83.
Axiom proof_of_p076_is_simple_power_safety_wit_84 : p076_is_simple_power_safety_wit_84.
Axiom proof_of_p076_is_simple_power_safety_wit_85 : p076_is_simple_power_safety_wit_85.
Axiom proof_of_p076_is_simple_power_safety_wit_86 : p076_is_simple_power_safety_wit_86.
Axiom proof_of_p076_is_simple_power_safety_wit_87 : p076_is_simple_power_safety_wit_87.
Axiom proof_of_p076_is_simple_power_safety_wit_88 : p076_is_simple_power_safety_wit_88.
Axiom proof_of_p076_is_simple_power_safety_wit_89 : p076_is_simple_power_safety_wit_89.
Axiom proof_of_p076_is_simple_power_safety_wit_90 : p076_is_simple_power_safety_wit_90.
Axiom proof_of_p076_is_simple_power_safety_wit_91 : p076_is_simple_power_safety_wit_91.
Axiom proof_of_p076_is_simple_power_safety_wit_92 : p076_is_simple_power_safety_wit_92.
Axiom proof_of_p076_is_simple_power_safety_wit_93 : p076_is_simple_power_safety_wit_93.
Axiom proof_of_p076_is_simple_power_safety_wit_94 : p076_is_simple_power_safety_wit_94.
Axiom proof_of_p076_is_simple_power_safety_wit_95 : p076_is_simple_power_safety_wit_95.
Axiom proof_of_p076_is_simple_power_safety_wit_96 : p076_is_simple_power_safety_wit_96.
Axiom proof_of_p076_is_simple_power_safety_wit_97 : p076_is_simple_power_safety_wit_97.
Axiom proof_of_p076_is_simple_power_safety_wit_98 : p076_is_simple_power_safety_wit_98.
Axiom proof_of_p076_is_simple_power_safety_wit_99 : p076_is_simple_power_safety_wit_99.
Axiom proof_of_p076_is_simple_power_safety_wit_100 : p076_is_simple_power_safety_wit_100.
Axiom proof_of_p076_is_simple_power_safety_wit_101 : p076_is_simple_power_safety_wit_101.
Axiom proof_of_p076_is_simple_power_safety_wit_102 : p076_is_simple_power_safety_wit_102.
Axiom proof_of_p076_is_simple_power_safety_wit_103 : p076_is_simple_power_safety_wit_103.
Axiom proof_of_p076_is_simple_power_safety_wit_104 : p076_is_simple_power_safety_wit_104.
Axiom proof_of_p076_is_simple_power_safety_wit_105 : p076_is_simple_power_safety_wit_105.
Axiom proof_of_p076_is_simple_power_safety_wit_106 : p076_is_simple_power_safety_wit_106.
Axiom proof_of_p076_is_simple_power_safety_wit_107 : p076_is_simple_power_safety_wit_107.
Axiom proof_of_p076_is_simple_power_safety_wit_108 : p076_is_simple_power_safety_wit_108.
Axiom proof_of_p076_is_simple_power_safety_wit_109 : p076_is_simple_power_safety_wit_109.
Axiom proof_of_p076_is_simple_power_safety_wit_110 : p076_is_simple_power_safety_wit_110.
Axiom proof_of_p076_is_simple_power_safety_wit_111 : p076_is_simple_power_safety_wit_111.
Axiom proof_of_p076_is_simple_power_safety_wit_112 : p076_is_simple_power_safety_wit_112.
Axiom proof_of_p076_is_simple_power_safety_wit_113 : p076_is_simple_power_safety_wit_113.
Axiom proof_of_p076_is_simple_power_safety_wit_114 : p076_is_simple_power_safety_wit_114.
Axiom proof_of_p076_is_simple_power_safety_wit_115 : p076_is_simple_power_safety_wit_115.
Axiom proof_of_p076_is_simple_power_safety_wit_116 : p076_is_simple_power_safety_wit_116.
Axiom proof_of_p076_is_simple_power_safety_wit_117 : p076_is_simple_power_safety_wit_117.
Axiom proof_of_p076_is_simple_power_safety_wit_118 : p076_is_simple_power_safety_wit_118.
Axiom proof_of_p076_is_simple_power_safety_wit_119 : p076_is_simple_power_safety_wit_119.
Axiom proof_of_p076_is_simple_power_safety_wit_120 : p076_is_simple_power_safety_wit_120.
Axiom proof_of_p076_is_simple_power_safety_wit_121 : p076_is_simple_power_safety_wit_121.
Axiom proof_of_p076_is_simple_power_safety_wit_122 : p076_is_simple_power_safety_wit_122.
Axiom proof_of_p076_is_simple_power_safety_wit_123 : p076_is_simple_power_safety_wit_123.
Axiom proof_of_p076_is_simple_power_safety_wit_124 : p076_is_simple_power_safety_wit_124.
Axiom proof_of_p076_is_simple_power_safety_wit_125 : p076_is_simple_power_safety_wit_125.
Axiom proof_of_p076_is_simple_power_safety_wit_126 : p076_is_simple_power_safety_wit_126.
Axiom proof_of_p076_is_simple_power_safety_wit_127 : p076_is_simple_power_safety_wit_127.
Axiom proof_of_p076_is_simple_power_safety_wit_128 : p076_is_simple_power_safety_wit_128.
Axiom proof_of_p076_is_simple_power_safety_wit_129 : p076_is_simple_power_safety_wit_129.
Axiom proof_of_p076_is_simple_power_safety_wit_130 : p076_is_simple_power_safety_wit_130.
Axiom proof_of_p076_is_simple_power_safety_wit_131 : p076_is_simple_power_safety_wit_131.
Axiom proof_of_p076_is_simple_power_safety_wit_132 : p076_is_simple_power_safety_wit_132.
Axiom proof_of_p076_is_simple_power_safety_wit_133 : p076_is_simple_power_safety_wit_133.
Axiom proof_of_p076_is_simple_power_safety_wit_134 : p076_is_simple_power_safety_wit_134.
Axiom proof_of_p076_is_simple_power_safety_wit_135 : p076_is_simple_power_safety_wit_135.
Axiom proof_of_p076_is_simple_power_safety_wit_136 : p076_is_simple_power_safety_wit_136.
Axiom proof_of_p076_is_simple_power_safety_wit_137 : p076_is_simple_power_safety_wit_137.
Axiom proof_of_p076_is_simple_power_safety_wit_138 : p076_is_simple_power_safety_wit_138.
Axiom proof_of_p076_is_simple_power_safety_wit_139 : p076_is_simple_power_safety_wit_139.
Axiom proof_of_p076_is_simple_power_safety_wit_140 : p076_is_simple_power_safety_wit_140.
Axiom proof_of_p076_is_simple_power_safety_wit_141 : p076_is_simple_power_safety_wit_141.
Axiom proof_of_p076_is_simple_power_safety_wit_142 : p076_is_simple_power_safety_wit_142.
Axiom proof_of_p076_is_simple_power_safety_wit_143 : p076_is_simple_power_safety_wit_143.
Axiom proof_of_p076_is_simple_power_safety_wit_144 : p076_is_simple_power_safety_wit_144.
Axiom proof_of_p076_is_simple_power_safety_wit_145 : p076_is_simple_power_safety_wit_145.
Axiom proof_of_p076_is_simple_power_safety_wit_146 : p076_is_simple_power_safety_wit_146.
Axiom proof_of_p076_is_simple_power_safety_wit_147 : p076_is_simple_power_safety_wit_147.
Axiom proof_of_p076_is_simple_power_safety_wit_148 : p076_is_simple_power_safety_wit_148.
Axiom proof_of_p076_is_simple_power_safety_wit_149 : p076_is_simple_power_safety_wit_149.
Axiom proof_of_p076_is_simple_power_safety_wit_150 : p076_is_simple_power_safety_wit_150.
Axiom proof_of_p076_is_simple_power_safety_wit_151 : p076_is_simple_power_safety_wit_151.
Axiom proof_of_p076_is_simple_power_safety_wit_152 : p076_is_simple_power_safety_wit_152.
Axiom proof_of_p076_is_simple_power_safety_wit_153 : p076_is_simple_power_safety_wit_153.
Axiom proof_of_p076_is_simple_power_safety_wit_154 : p076_is_simple_power_safety_wit_154.
Axiom proof_of_p076_is_simple_power_safety_wit_155 : p076_is_simple_power_safety_wit_155.
Axiom proof_of_p076_is_simple_power_safety_wit_156 : p076_is_simple_power_safety_wit_156.
Axiom proof_of_p076_is_simple_power_safety_wit_157 : p076_is_simple_power_safety_wit_157.
Axiom proof_of_p076_is_simple_power_safety_wit_158 : p076_is_simple_power_safety_wit_158.
Axiom proof_of_p076_is_simple_power_safety_wit_159 : p076_is_simple_power_safety_wit_159.
Axiom proof_of_p076_is_simple_power_safety_wit_160 : p076_is_simple_power_safety_wit_160.
Axiom proof_of_p076_is_simple_power_safety_wit_161 : p076_is_simple_power_safety_wit_161.
Axiom proof_of_p076_is_simple_power_safety_wit_162 : p076_is_simple_power_safety_wit_162.
Axiom proof_of_p076_is_simple_power_safety_wit_163 : p076_is_simple_power_safety_wit_163.
Axiom proof_of_p076_is_simple_power_safety_wit_164 : p076_is_simple_power_safety_wit_164.
Axiom proof_of_p076_is_simple_power_safety_wit_165 : p076_is_simple_power_safety_wit_165.
Axiom proof_of_p076_is_simple_power_safety_wit_166 : p076_is_simple_power_safety_wit_166.
Axiom proof_of_p076_is_simple_power_safety_wit_167 : p076_is_simple_power_safety_wit_167.
Axiom proof_of_p076_is_simple_power_safety_wit_168 : p076_is_simple_power_safety_wit_168.
Axiom proof_of_p076_is_simple_power_safety_wit_169 : p076_is_simple_power_safety_wit_169.
Axiom proof_of_p076_is_simple_power_safety_wit_170 : p076_is_simple_power_safety_wit_170.
Axiom proof_of_p076_is_simple_power_safety_wit_171 : p076_is_simple_power_safety_wit_171.
Axiom proof_of_p076_is_simple_power_safety_wit_172 : p076_is_simple_power_safety_wit_172.
Axiom proof_of_p076_is_simple_power_safety_wit_173 : p076_is_simple_power_safety_wit_173.
Axiom proof_of_p076_is_simple_power_safety_wit_174 : p076_is_simple_power_safety_wit_174.
Axiom proof_of_p076_is_simple_power_safety_wit_175 : p076_is_simple_power_safety_wit_175.
Axiom proof_of_p076_is_simple_power_safety_wit_176 : p076_is_simple_power_safety_wit_176.
Axiom proof_of_p076_is_simple_power_safety_wit_177 : p076_is_simple_power_safety_wit_177.
Axiom proof_of_p076_is_simple_power_safety_wit_178 : p076_is_simple_power_safety_wit_178.
Axiom proof_of_p076_is_simple_power_safety_wit_179 : p076_is_simple_power_safety_wit_179.
Axiom proof_of_p076_is_simple_power_safety_wit_180 : p076_is_simple_power_safety_wit_180.
Axiom proof_of_p076_is_simple_power_safety_wit_181 : p076_is_simple_power_safety_wit_181.
Axiom proof_of_p076_is_simple_power_safety_wit_182 : p076_is_simple_power_safety_wit_182.
Axiom proof_of_p076_is_simple_power_safety_wit_183 : p076_is_simple_power_safety_wit_183.
Axiom proof_of_p076_is_simple_power_safety_wit_184 : p076_is_simple_power_safety_wit_184.
Axiom proof_of_p076_is_simple_power_safety_wit_185 : p076_is_simple_power_safety_wit_185.
Axiom proof_of_p076_is_simple_power_safety_wit_186 : p076_is_simple_power_safety_wit_186.
Axiom proof_of_p076_is_simple_power_safety_wit_187 : p076_is_simple_power_safety_wit_187.
Axiom proof_of_p076_is_simple_power_safety_wit_188 : p076_is_simple_power_safety_wit_188.
Axiom proof_of_p076_is_simple_power_safety_wit_189 : p076_is_simple_power_safety_wit_189.
Axiom proof_of_p076_is_simple_power_safety_wit_190 : p076_is_simple_power_safety_wit_190.
Axiom proof_of_p076_is_simple_power_safety_wit_191 : p076_is_simple_power_safety_wit_191.
Axiom proof_of_p076_is_simple_power_safety_wit_192 : p076_is_simple_power_safety_wit_192.
Axiom proof_of_p076_is_simple_power_safety_wit_193 : p076_is_simple_power_safety_wit_193.
Axiom proof_of_p076_is_simple_power_safety_wit_194 : p076_is_simple_power_safety_wit_194.
Axiom proof_of_p076_is_simple_power_safety_wit_195 : p076_is_simple_power_safety_wit_195.
Axiom proof_of_p076_is_simple_power_safety_wit_196 : p076_is_simple_power_safety_wit_196.
Axiom proof_of_p076_is_simple_power_safety_wit_197 : p076_is_simple_power_safety_wit_197.
Axiom proof_of_p076_is_simple_power_safety_wit_198 : p076_is_simple_power_safety_wit_198.
Axiom proof_of_p076_is_simple_power_safety_wit_199 : p076_is_simple_power_safety_wit_199.
Axiom proof_of_p076_is_simple_power_safety_wit_200 : p076_is_simple_power_safety_wit_200.
Axiom proof_of_p076_is_simple_power_safety_wit_201 : p076_is_simple_power_safety_wit_201.
Axiom proof_of_p076_is_simple_power_safety_wit_202 : p076_is_simple_power_safety_wit_202.
Axiom proof_of_p076_is_simple_power_safety_wit_203 : p076_is_simple_power_safety_wit_203.
Axiom proof_of_p076_is_simple_power_safety_wit_204 : p076_is_simple_power_safety_wit_204.
Axiom proof_of_p076_is_simple_power_safety_wit_205 : p076_is_simple_power_safety_wit_205.
Axiom proof_of_p076_is_simple_power_safety_wit_206 : p076_is_simple_power_safety_wit_206.
Axiom proof_of_p076_is_simple_power_safety_wit_207 : p076_is_simple_power_safety_wit_207.
Axiom proof_of_p076_is_simple_power_safety_wit_208 : p076_is_simple_power_safety_wit_208.
Axiom proof_of_p076_is_simple_power_safety_wit_209 : p076_is_simple_power_safety_wit_209.
Axiom proof_of_p076_is_simple_power_safety_wit_210 : p076_is_simple_power_safety_wit_210.
Axiom proof_of_p076_is_simple_power_safety_wit_211 : p076_is_simple_power_safety_wit_211.
Axiom proof_of_p076_is_simple_power_safety_wit_212 : p076_is_simple_power_safety_wit_212.
Axiom proof_of_p076_is_simple_power_safety_wit_213 : p076_is_simple_power_safety_wit_213.
Axiom proof_of_p076_is_simple_power_safety_wit_214 : p076_is_simple_power_safety_wit_214.
Axiom proof_of_p076_is_simple_power_safety_wit_215 : p076_is_simple_power_safety_wit_215.
Axiom proof_of_p076_is_simple_power_safety_wit_216 : p076_is_simple_power_safety_wit_216.
Axiom proof_of_p076_is_simple_power_safety_wit_217 : p076_is_simple_power_safety_wit_217.
Axiom proof_of_p076_is_simple_power_safety_wit_218 : p076_is_simple_power_safety_wit_218.
Axiom proof_of_p076_is_simple_power_safety_wit_219 : p076_is_simple_power_safety_wit_219.
Axiom proof_of_p076_is_simple_power_safety_wit_220 : p076_is_simple_power_safety_wit_220.
Axiom proof_of_p076_is_simple_power_safety_wit_221 : p076_is_simple_power_safety_wit_221.
Axiom proof_of_p076_is_simple_power_safety_wit_222 : p076_is_simple_power_safety_wit_222.
Axiom proof_of_p076_is_simple_power_safety_wit_223 : p076_is_simple_power_safety_wit_223.
Axiom proof_of_p076_is_simple_power_safety_wit_224 : p076_is_simple_power_safety_wit_224.
Axiom proof_of_p076_is_simple_power_safety_wit_225 : p076_is_simple_power_safety_wit_225.
Axiom proof_of_p076_is_simple_power_safety_wit_226 : p076_is_simple_power_safety_wit_226.
Axiom proof_of_p076_is_simple_power_safety_wit_227 : p076_is_simple_power_safety_wit_227.
Axiom proof_of_p076_is_simple_power_safety_wit_228 : p076_is_simple_power_safety_wit_228.
Axiom proof_of_p076_is_simple_power_safety_wit_229 : p076_is_simple_power_safety_wit_229.
Axiom proof_of_p076_is_simple_power_safety_wit_230 : p076_is_simple_power_safety_wit_230.
Axiom proof_of_p076_is_simple_power_safety_wit_231 : p076_is_simple_power_safety_wit_231.
Axiom proof_of_p076_is_simple_power_safety_wit_232 : p076_is_simple_power_safety_wit_232.
Axiom proof_of_p076_is_simple_power_safety_wit_233 : p076_is_simple_power_safety_wit_233.
Axiom proof_of_p076_is_simple_power_safety_wit_234 : p076_is_simple_power_safety_wit_234.
Axiom proof_of_p076_is_simple_power_safety_wit_235 : p076_is_simple_power_safety_wit_235.
Axiom proof_of_p076_is_simple_power_safety_wit_236 : p076_is_simple_power_safety_wit_236.
Axiom proof_of_p076_is_simple_power_safety_wit_237 : p076_is_simple_power_safety_wit_237.
Axiom proof_of_p076_is_simple_power_safety_wit_238 : p076_is_simple_power_safety_wit_238.
Axiom proof_of_p076_is_simple_power_safety_wit_239 : p076_is_simple_power_safety_wit_239.
Axiom proof_of_p076_is_simple_power_safety_wit_240 : p076_is_simple_power_safety_wit_240.
Axiom proof_of_p076_is_simple_power_safety_wit_241 : p076_is_simple_power_safety_wit_241.
Axiom proof_of_p076_is_simple_power_safety_wit_242 : p076_is_simple_power_safety_wit_242.
Axiom proof_of_p076_is_simple_power_safety_wit_243 : p076_is_simple_power_safety_wit_243.
Axiom proof_of_p076_is_simple_power_safety_wit_244 : p076_is_simple_power_safety_wit_244.
Axiom proof_of_p076_is_simple_power_safety_wit_245 : p076_is_simple_power_safety_wit_245.
Axiom proof_of_p076_is_simple_power_safety_wit_246 : p076_is_simple_power_safety_wit_246.
Axiom proof_of_p076_is_simple_power_safety_wit_247 : p076_is_simple_power_safety_wit_247.
Axiom proof_of_p076_is_simple_power_safety_wit_248 : p076_is_simple_power_safety_wit_248.
Axiom proof_of_p076_is_simple_power_safety_wit_249 : p076_is_simple_power_safety_wit_249.
Axiom proof_of_p076_is_simple_power_safety_wit_250 : p076_is_simple_power_safety_wit_250.
Axiom proof_of_p076_is_simple_power_safety_wit_251 : p076_is_simple_power_safety_wit_251.
Axiom proof_of_p076_is_simple_power_safety_wit_252 : p076_is_simple_power_safety_wit_252.
Axiom proof_of_p076_is_simple_power_safety_wit_253 : p076_is_simple_power_safety_wit_253.
Axiom proof_of_p076_is_simple_power_safety_wit_254 : p076_is_simple_power_safety_wit_254.
Axiom proof_of_p076_is_simple_power_safety_wit_255 : p076_is_simple_power_safety_wit_255.
Axiom proof_of_p076_is_simple_power_safety_wit_256 : p076_is_simple_power_safety_wit_256.
Axiom proof_of_p076_is_simple_power_safety_wit_257 : p076_is_simple_power_safety_wit_257.
Axiom proof_of_p076_is_simple_power_safety_wit_258 : p076_is_simple_power_safety_wit_258.
Axiom proof_of_p076_is_simple_power_safety_wit_259 : p076_is_simple_power_safety_wit_259.
Axiom proof_of_p076_is_simple_power_safety_wit_260 : p076_is_simple_power_safety_wit_260.
Axiom proof_of_p076_is_simple_power_safety_wit_261 : p076_is_simple_power_safety_wit_261.
Axiom proof_of_p076_is_simple_power_safety_wit_262 : p076_is_simple_power_safety_wit_262.
Axiom proof_of_p076_is_simple_power_safety_wit_263 : p076_is_simple_power_safety_wit_263.
Axiom proof_of_p076_is_simple_power_safety_wit_264 : p076_is_simple_power_safety_wit_264.
Axiom proof_of_p076_is_simple_power_safety_wit_265 : p076_is_simple_power_safety_wit_265.
Axiom proof_of_p076_is_simple_power_safety_wit_266 : p076_is_simple_power_safety_wit_266.
Axiom proof_of_p076_is_simple_power_safety_wit_267 : p076_is_simple_power_safety_wit_267.
Axiom proof_of_p076_is_simple_power_safety_wit_268 : p076_is_simple_power_safety_wit_268.
Axiom proof_of_p076_is_simple_power_safety_wit_269 : p076_is_simple_power_safety_wit_269.
Axiom proof_of_p076_is_simple_power_safety_wit_270 : p076_is_simple_power_safety_wit_270.
Axiom proof_of_p076_is_simple_power_safety_wit_271 : p076_is_simple_power_safety_wit_271.
Axiom proof_of_p076_is_simple_power_safety_wit_272 : p076_is_simple_power_safety_wit_272.
Axiom proof_of_p076_is_simple_power_safety_wit_273 : p076_is_simple_power_safety_wit_273.
Axiom proof_of_p076_is_simple_power_safety_wit_274 : p076_is_simple_power_safety_wit_274.
Axiom proof_of_p076_is_simple_power_safety_wit_275 : p076_is_simple_power_safety_wit_275.
Axiom proof_of_p076_is_simple_power_safety_wit_276 : p076_is_simple_power_safety_wit_276.
Axiom proof_of_p076_is_simple_power_safety_wit_277 : p076_is_simple_power_safety_wit_277.
Axiom proof_of_p076_is_simple_power_safety_wit_278 : p076_is_simple_power_safety_wit_278.
Axiom proof_of_p076_is_simple_power_safety_wit_279 : p076_is_simple_power_safety_wit_279.
Axiom proof_of_p076_is_simple_power_safety_wit_280 : p076_is_simple_power_safety_wit_280.
Axiom proof_of_p076_is_simple_power_safety_wit_281 : p076_is_simple_power_safety_wit_281.
Axiom proof_of_p076_is_simple_power_safety_wit_282 : p076_is_simple_power_safety_wit_282.
Axiom proof_of_p076_is_simple_power_safety_wit_283 : p076_is_simple_power_safety_wit_283.
Axiom proof_of_p076_is_simple_power_safety_wit_284 : p076_is_simple_power_safety_wit_284.
Axiom proof_of_p076_is_simple_power_safety_wit_285 : p076_is_simple_power_safety_wit_285.
Axiom proof_of_p076_is_simple_power_safety_wit_286 : p076_is_simple_power_safety_wit_286.
Axiom proof_of_p076_is_simple_power_safety_wit_287 : p076_is_simple_power_safety_wit_287.
Axiom proof_of_p076_is_simple_power_safety_wit_288 : p076_is_simple_power_safety_wit_288.
Axiom proof_of_p076_is_simple_power_safety_wit_289 : p076_is_simple_power_safety_wit_289.
Axiom proof_of_p076_is_simple_power_safety_wit_290 : p076_is_simple_power_safety_wit_290.
Axiom proof_of_p076_is_simple_power_safety_wit_291 : p076_is_simple_power_safety_wit_291.
Axiom proof_of_p076_is_simple_power_safety_wit_292 : p076_is_simple_power_safety_wit_292.
Axiom proof_of_p076_is_simple_power_safety_wit_293 : p076_is_simple_power_safety_wit_293.
Axiom proof_of_p076_is_simple_power_safety_wit_294 : p076_is_simple_power_safety_wit_294.
Axiom proof_of_p076_is_simple_power_safety_wit_295 : p076_is_simple_power_safety_wit_295.
Axiom proof_of_p076_is_simple_power_safety_wit_296 : p076_is_simple_power_safety_wit_296.
Axiom proof_of_p076_is_simple_power_safety_wit_297 : p076_is_simple_power_safety_wit_297.
Axiom proof_of_p076_is_simple_power_safety_wit_298 : p076_is_simple_power_safety_wit_298.
Axiom proof_of_p076_is_simple_power_safety_wit_299 : p076_is_simple_power_safety_wit_299.
Axiom proof_of_p076_is_simple_power_safety_wit_300 : p076_is_simple_power_safety_wit_300.
Axiom proof_of_p076_is_simple_power_safety_wit_301 : p076_is_simple_power_safety_wit_301.
Axiom proof_of_p076_is_simple_power_safety_wit_302 : p076_is_simple_power_safety_wit_302.
Axiom proof_of_p076_is_simple_power_safety_wit_303 : p076_is_simple_power_safety_wit_303.
Axiom proof_of_p076_is_simple_power_safety_wit_304 : p076_is_simple_power_safety_wit_304.
Axiom proof_of_p076_is_simple_power_safety_wit_305 : p076_is_simple_power_safety_wit_305.
Axiom proof_of_p076_is_simple_power_safety_wit_306 : p076_is_simple_power_safety_wit_306.
Axiom proof_of_p076_is_simple_power_safety_wit_307 : p076_is_simple_power_safety_wit_307.
Axiom proof_of_p076_is_simple_power_safety_wit_308 : p076_is_simple_power_safety_wit_308.
Axiom proof_of_p076_is_simple_power_safety_wit_309 : p076_is_simple_power_safety_wit_309.
Axiom proof_of_p076_is_simple_power_safety_wit_310 : p076_is_simple_power_safety_wit_310.
Axiom proof_of_p076_is_simple_power_safety_wit_311 : p076_is_simple_power_safety_wit_311.
Axiom proof_of_p076_is_simple_power_safety_wit_312 : p076_is_simple_power_safety_wit_312.
Axiom proof_of_p076_is_simple_power_safety_wit_313 : p076_is_simple_power_safety_wit_313.
Axiom proof_of_p076_is_simple_power_safety_wit_314 : p076_is_simple_power_safety_wit_314.
Axiom proof_of_p076_is_simple_power_safety_wit_315 : p076_is_simple_power_safety_wit_315.
Axiom proof_of_p076_is_simple_power_safety_wit_316 : p076_is_simple_power_safety_wit_316.
Axiom proof_of_p076_is_simple_power_safety_wit_317 : p076_is_simple_power_safety_wit_317.
Axiom proof_of_p076_is_simple_power_safety_wit_318 : p076_is_simple_power_safety_wit_318.
Axiom proof_of_p076_is_simple_power_safety_wit_319 : p076_is_simple_power_safety_wit_319.
Axiom proof_of_p076_is_simple_power_safety_wit_320 : p076_is_simple_power_safety_wit_320.
Axiom proof_of_p076_is_simple_power_safety_wit_321 : p076_is_simple_power_safety_wit_321.
Axiom proof_of_p076_is_simple_power_safety_wit_322 : p076_is_simple_power_safety_wit_322.
Axiom proof_of_p076_is_simple_power_safety_wit_323 : p076_is_simple_power_safety_wit_323.
Axiom proof_of_p076_is_simple_power_safety_wit_324 : p076_is_simple_power_safety_wit_324.
Axiom proof_of_p076_is_simple_power_safety_wit_325 : p076_is_simple_power_safety_wit_325.
Axiom proof_of_p076_is_simple_power_safety_wit_326 : p076_is_simple_power_safety_wit_326.
Axiom proof_of_p076_is_simple_power_safety_wit_327 : p076_is_simple_power_safety_wit_327.
Axiom proof_of_p076_is_simple_power_safety_wit_328 : p076_is_simple_power_safety_wit_328.
Axiom proof_of_p076_is_simple_power_safety_wit_329 : p076_is_simple_power_safety_wit_329.
Axiom proof_of_p076_is_simple_power_safety_wit_330 : p076_is_simple_power_safety_wit_330.
Axiom proof_of_p076_is_simple_power_safety_wit_331 : p076_is_simple_power_safety_wit_331.
Axiom proof_of_p076_is_simple_power_safety_wit_332 : p076_is_simple_power_safety_wit_332.
Axiom proof_of_p076_is_simple_power_safety_wit_333 : p076_is_simple_power_safety_wit_333.
Axiom proof_of_p076_is_simple_power_safety_wit_334 : p076_is_simple_power_safety_wit_334.
Axiom proof_of_p076_is_simple_power_safety_wit_335 : p076_is_simple_power_safety_wit_335.
Axiom proof_of_p076_is_simple_power_safety_wit_336 : p076_is_simple_power_safety_wit_336.
Axiom proof_of_p076_is_simple_power_safety_wit_337 : p076_is_simple_power_safety_wit_337.
Axiom proof_of_p076_is_simple_power_safety_wit_338 : p076_is_simple_power_safety_wit_338.
Axiom proof_of_p076_is_simple_power_safety_wit_339 : p076_is_simple_power_safety_wit_339.
Axiom proof_of_p076_is_simple_power_safety_wit_340 : p076_is_simple_power_safety_wit_340.
Axiom proof_of_p076_is_simple_power_safety_wit_341 : p076_is_simple_power_safety_wit_341.
Axiom proof_of_p076_is_simple_power_safety_wit_342 : p076_is_simple_power_safety_wit_342.
Axiom proof_of_p076_is_simple_power_safety_wit_343 : p076_is_simple_power_safety_wit_343.
Axiom proof_of_p076_is_simple_power_safety_wit_344 : p076_is_simple_power_safety_wit_344.
Axiom proof_of_p076_is_simple_power_safety_wit_345 : p076_is_simple_power_safety_wit_345.
Axiom proof_of_p076_is_simple_power_safety_wit_346 : p076_is_simple_power_safety_wit_346.
Axiom proof_of_p076_is_simple_power_safety_wit_347 : p076_is_simple_power_safety_wit_347.
Axiom proof_of_p076_is_simple_power_safety_wit_348 : p076_is_simple_power_safety_wit_348.
Axiom proof_of_p076_is_simple_power_safety_wit_349 : p076_is_simple_power_safety_wit_349.
Axiom proof_of_p076_is_simple_power_safety_wit_350 : p076_is_simple_power_safety_wit_350.
Axiom proof_of_p076_is_simple_power_safety_wit_351 : p076_is_simple_power_safety_wit_351.
Axiom proof_of_p076_is_simple_power_safety_wit_352 : p076_is_simple_power_safety_wit_352.
Axiom proof_of_p076_is_simple_power_safety_wit_353 : p076_is_simple_power_safety_wit_353.
Axiom proof_of_p076_is_simple_power_safety_wit_354 : p076_is_simple_power_safety_wit_354.
Axiom proof_of_p076_is_simple_power_safety_wit_355 : p076_is_simple_power_safety_wit_355.
Axiom proof_of_p076_is_simple_power_safety_wit_356 : p076_is_simple_power_safety_wit_356.
Axiom proof_of_p076_is_simple_power_safety_wit_357 : p076_is_simple_power_safety_wit_357.
Axiom proof_of_p076_is_simple_power_safety_wit_358 : p076_is_simple_power_safety_wit_358.
Axiom proof_of_p076_is_simple_power_safety_wit_359 : p076_is_simple_power_safety_wit_359.
Axiom proof_of_p076_is_simple_power_safety_wit_360 : p076_is_simple_power_safety_wit_360.
Axiom proof_of_p076_is_simple_power_safety_wit_361 : p076_is_simple_power_safety_wit_361.
Axiom proof_of_p076_is_simple_power_safety_wit_362 : p076_is_simple_power_safety_wit_362.
Axiom proof_of_p076_is_simple_power_safety_wit_363 : p076_is_simple_power_safety_wit_363.
Axiom proof_of_p076_is_simple_power_safety_wit_364 : p076_is_simple_power_safety_wit_364.
Axiom proof_of_p076_is_simple_power_safety_wit_365 : p076_is_simple_power_safety_wit_365.
Axiom proof_of_p076_is_simple_power_safety_wit_366 : p076_is_simple_power_safety_wit_366.
Axiom proof_of_p076_is_simple_power_safety_wit_367 : p076_is_simple_power_safety_wit_367.
Axiom proof_of_p076_is_simple_power_safety_wit_368 : p076_is_simple_power_safety_wit_368.
Axiom proof_of_p076_is_simple_power_safety_wit_369 : p076_is_simple_power_safety_wit_369.
Axiom proof_of_p076_is_simple_power_safety_wit_370 : p076_is_simple_power_safety_wit_370.
Axiom proof_of_p076_is_simple_power_safety_wit_371 : p076_is_simple_power_safety_wit_371.
Axiom proof_of_p076_is_simple_power_safety_wit_372 : p076_is_simple_power_safety_wit_372.
Axiom proof_of_p076_is_simple_power_safety_wit_373 : p076_is_simple_power_safety_wit_373.
Axiom proof_of_p076_is_simple_power_safety_wit_374 : p076_is_simple_power_safety_wit_374.
Axiom proof_of_p076_is_simple_power_safety_wit_375 : p076_is_simple_power_safety_wit_375.
Axiom proof_of_p076_is_simple_power_safety_wit_376 : p076_is_simple_power_safety_wit_376.
Axiom proof_of_p076_is_simple_power_safety_wit_377 : p076_is_simple_power_safety_wit_377.
Axiom proof_of_p076_is_simple_power_safety_wit_378 : p076_is_simple_power_safety_wit_378.
Axiom proof_of_p076_is_simple_power_safety_wit_379 : p076_is_simple_power_safety_wit_379.
Axiom proof_of_p076_is_simple_power_safety_wit_380 : p076_is_simple_power_safety_wit_380.
Axiom proof_of_p076_is_simple_power_safety_wit_381 : p076_is_simple_power_safety_wit_381.
Axiom proof_of_p076_is_simple_power_safety_wit_382 : p076_is_simple_power_safety_wit_382.
Axiom proof_of_p076_is_simple_power_safety_wit_383 : p076_is_simple_power_safety_wit_383.
Axiom proof_of_p076_is_simple_power_safety_wit_384 : p076_is_simple_power_safety_wit_384.
Axiom proof_of_p076_is_simple_power_safety_wit_385 : p076_is_simple_power_safety_wit_385.
Axiom proof_of_p076_is_simple_power_safety_wit_386 : p076_is_simple_power_safety_wit_386.
Axiom proof_of_p076_is_simple_power_safety_wit_387 : p076_is_simple_power_safety_wit_387.
Axiom proof_of_p076_is_simple_power_safety_wit_388 : p076_is_simple_power_safety_wit_388.
Axiom proof_of_p076_is_simple_power_safety_wit_389 : p076_is_simple_power_safety_wit_389.
Axiom proof_of_p076_is_simple_power_safety_wit_390 : p076_is_simple_power_safety_wit_390.
Axiom proof_of_p076_is_simple_power_safety_wit_391 : p076_is_simple_power_safety_wit_391.
Axiom proof_of_p076_is_simple_power_safety_wit_392 : p076_is_simple_power_safety_wit_392.
Axiom proof_of_p076_is_simple_power_safety_wit_393 : p076_is_simple_power_safety_wit_393.
Axiom proof_of_p076_is_simple_power_safety_wit_394 : p076_is_simple_power_safety_wit_394.
Axiom proof_of_p076_is_simple_power_safety_wit_395 : p076_is_simple_power_safety_wit_395.
Axiom proof_of_p076_is_simple_power_safety_wit_396 : p076_is_simple_power_safety_wit_396.
Axiom proof_of_p076_is_simple_power_safety_wit_397 : p076_is_simple_power_safety_wit_397.
Axiom proof_of_p076_is_simple_power_safety_wit_398 : p076_is_simple_power_safety_wit_398.
Axiom proof_of_p076_is_simple_power_safety_wit_399 : p076_is_simple_power_safety_wit_399.
Axiom proof_of_p076_is_simple_power_safety_wit_400 : p076_is_simple_power_safety_wit_400.
Axiom proof_of_p076_is_simple_power_safety_wit_401 : p076_is_simple_power_safety_wit_401.
Axiom proof_of_p076_is_simple_power_safety_wit_402 : p076_is_simple_power_safety_wit_402.
Axiom proof_of_p076_is_simple_power_safety_wit_403 : p076_is_simple_power_safety_wit_403.
Axiom proof_of_p076_is_simple_power_safety_wit_404 : p076_is_simple_power_safety_wit_404.
Axiom proof_of_p076_is_simple_power_return_wit_1 : p076_is_simple_power_return_wit_1.
Axiom proof_of_p076_is_simple_power_precondition_wit_1 : p076_is_simple_power_precondition_wit_1.

End VC_Correct.
