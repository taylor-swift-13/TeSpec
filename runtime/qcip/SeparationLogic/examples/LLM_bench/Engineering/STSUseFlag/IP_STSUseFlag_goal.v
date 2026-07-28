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
Require Import SimpleC.EE.LLM_bench.Engineering.STSUseFlag.IP_STSUseFlag_lib.
Local Open Scope sac.

(*----- Function STSUseFlag -----*)

Definition STSUseFlag_safety_wit_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition STSUseFlag_safety_wit_2 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (3952088175 <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= 3952088175) ”
.

Definition STSUseFlag_safety_wit_3 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (update = 3952088175)) (PreH2 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition STSUseFlag_safety_wit_4 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 1)) (PreH2 : (update = 3952088175)) (PreH3 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (6 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 6) ”
.

Definition STSUseFlag_safety_wit_5 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 1)) (PreH2 : (update = 3952088175)) (PreH3 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition STSUseFlag_safety_wit_6 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 2)) (PreH2 : (status <> 1)) (PreH3 : (update = 3952088175)) (PreH4 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (7 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 7) ”
.

Definition STSUseFlag_safety_wit_7 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 2)) (PreH2 : (status <> 1)) (PreH3 : (update = 3952088175)) (PreH4 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (4 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 4) ”
.

Definition STSUseFlag_safety_wit_8 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 4)) (PreH2 : (status <> 2)) (PreH3 : (status <> 1)) (PreH4 : (update = 3952088175)) (PreH5 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (8 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 8) ”
.

Definition STSUseFlag_safety_wit_9 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (update <> 3952088175)) (PreH2 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (3 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 3) ”
.

Definition STSUseFlag_safety_wit_10 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (data_src <> 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition STSUseFlag_return_wit_1 := 
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 1)) (PreH2 : (update = 3952088175)) (PreH3 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> 6)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> 6)
|--
  EX (data_src1: Z)  (update1: Z)  (status1: Z)  (use_old1: Z) ,
  “ (STSUseFlagPost data_src update status use_old data_src1 update1 status1 use_old1 ) ”
  &&  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src1)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old1)
) \/
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 1)) (PreH2 : (update = 3952088175)) (PreH3 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update 6 6 ) ”
  &&  emp
).

Definition STSUseFlag_return_wit_1_split_goal_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 1)) (PreH2 : (update = 3952088175)) (PreH3 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update 6 6 ) ”
.

Definition STSUseFlag_return_wit_2 := 
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 2)) (PreH2 : (status <> 1)) (PreH3 : (update = 3952088175)) (PreH4 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> 7)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> 7)
|--
  EX (data_src1: Z)  (update1: Z)  (status1: Z)  (use_old1: Z) ,
  “ (STSUseFlagPost data_src update status use_old data_src1 update1 status1 use_old1 ) ”
  &&  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src1)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old1)
) \/
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 2)) (PreH2 : (status <> 1)) (PreH3 : (update = 3952088175)) (PreH4 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update 7 7 ) ”
  &&  emp
).

Definition STSUseFlag_return_wit_2_split_goal_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 2)) (PreH2 : (status <> 1)) (PreH3 : (update = 3952088175)) (PreH4 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update 7 7 ) ”
.

Definition STSUseFlag_return_wit_3 := 
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 4)) (PreH2 : (status <> 2)) (PreH3 : (status <> 1)) (PreH4 : (update = 3952088175)) (PreH5 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> 8)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> 8)
|--
  EX (data_src1: Z)  (update1: Z)  (status1: Z)  (use_old1: Z) ,
  “ (STSUseFlagPost data_src update status use_old data_src1 update1 status1 use_old1 ) ”
  &&  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src1)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old1)
) \/
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 4)) (PreH2 : (status <> 2)) (PreH3 : (status <> 1)) (PreH4 : (update = 3952088175)) (PreH5 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update 8 8 ) ”
  &&  emp
).

Definition STSUseFlag_return_wit_3_split_goal_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 4)) (PreH2 : (status <> 2)) (PreH3 : (status <> 1)) (PreH4 : (update = 3952088175)) (PreH5 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update 8 8 ) ”
.

Definition STSUseFlag_return_wit_4 := 
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 4)) (PreH2 : (status <> 2)) (PreH3 : (status <> 1)) (PreH4 : (update = 3952088175)) (PreH5 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> status)
|--
  EX (data_src1: Z)  (update1: Z)  (status1: Z)  (use_old1: Z) ,
  “ (STSUseFlagPost data_src update status use_old data_src1 update1 status1 use_old1 ) ”
  &&  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src1)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old1)
) \/
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 4)) (PreH2 : (status <> 2)) (PreH3 : (status <> 1)) (PreH4 : (update = 3952088175)) (PreH5 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update status status ) ”
  &&  emp
).

Definition STSUseFlag_return_wit_4_split_goal_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 4)) (PreH2 : (status <> 2)) (PreH3 : (status <> 1)) (PreH4 : (update = 3952088175)) (PreH5 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update status status ) ”
.

Definition STSUseFlag_return_wit_5 := 
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 3)) (PreH2 : (update <> 3952088175)) (PreH3 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> use_old)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  EX (data_src1: Z)  (update1: Z)  (status1: Z)  (use_old1: Z) ,
  “ (STSUseFlagPost data_src update status use_old data_src1 update1 status1 use_old1 ) ”
  &&  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src1)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old1)
) \/
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 3)) (PreH2 : (update <> 3952088175)) (PreH3 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update use_old use_old ) ”
  &&  emp
).

Definition STSUseFlag_return_wit_5_split_goal_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status <> 3)) (PreH2 : (update <> 3952088175)) (PreH3 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update use_old use_old ) ”
.

Definition STSUseFlag_return_wit_6 := 
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 3)) (PreH2 : (update <> 3952088175)) (PreH3 : (data_src = 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  EX (data_src1: Z)  (update1: Z)  (status1: Z)  (use_old1: Z) ,
  “ (STSUseFlagPost data_src update status use_old data_src1 update1 status1 use_old1 ) ”
  &&  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src1)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old1)
) \/
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 3)) (PreH2 : (update <> 3952088175)) (PreH3 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update status use_old ) ”
  &&  emp
).

Definition STSUseFlag_return_wit_6_split_goal_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (status = 3)) (PreH2 : (update <> 3952088175)) (PreH3 : (data_src = 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src update status use_old ) ”
.

Definition STSUseFlag_return_wit_7 := 
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (data_src <> 1)) ,
  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> 0)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old)
|--
  EX (data_src1: Z)  (update1: Z)  (status1: Z)  (use_old1: Z) ,
  “ (STSUseFlagPost data_src update status use_old data_src1 update1 status1 use_old1 ) ”
  &&  ((&(( &( "sSTSAtt" ) )->ₛ "dataSrc")) # UInt  |-> data_src1)
  **  ((&(( &( "sBusSTSObj" ) )->ₛ "update")) # UInt  |-> update1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "stsFlg")) # UInt  |-> status1)
  **  ((&(( &( "sSTSAtt" ) )->ₛ "useOld")) # UInt  |-> use_old1)
) \/
(
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (data_src <> 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src 0 status use_old ) ”
  &&  emp
).

Definition STSUseFlag_return_wit_7_split_goal_1 := 
forall (use_old: Z) (status: Z) (update: Z) (data_src: Z) (PreH1 : (data_src <> 1)) ,
  TT && emp 
|--
  “ (STSUseFlagPost data_src update status use_old data_src 0 status use_old ) ”
.

Module Type VC_Correct.


Axiom proof_of_STSUseFlag_safety_wit_1 : STSUseFlag_safety_wit_1.
Axiom proof_of_STSUseFlag_safety_wit_2 : STSUseFlag_safety_wit_2.
Axiom proof_of_STSUseFlag_safety_wit_3 : STSUseFlag_safety_wit_3.
Axiom proof_of_STSUseFlag_safety_wit_4 : STSUseFlag_safety_wit_4.
Axiom proof_of_STSUseFlag_safety_wit_5 : STSUseFlag_safety_wit_5.
Axiom proof_of_STSUseFlag_safety_wit_6 : STSUseFlag_safety_wit_6.
Axiom proof_of_STSUseFlag_safety_wit_7 : STSUseFlag_safety_wit_7.
Axiom proof_of_STSUseFlag_safety_wit_8 : STSUseFlag_safety_wit_8.
Axiom proof_of_STSUseFlag_safety_wit_9 : STSUseFlag_safety_wit_9.
Axiom proof_of_STSUseFlag_safety_wit_10 : STSUseFlag_safety_wit_10.
Axiom proof_of_STSUseFlag_return_wit_1 : STSUseFlag_return_wit_1.
Axiom proof_of_STSUseFlag_return_wit_2 : STSUseFlag_return_wit_2.
Axiom proof_of_STSUseFlag_return_wit_3 : STSUseFlag_return_wit_3.
Axiom proof_of_STSUseFlag_return_wit_4 : STSUseFlag_return_wit_4.
Axiom proof_of_STSUseFlag_return_wit_5 : STSUseFlag_return_wit_5.
Axiom proof_of_STSUseFlag_return_wit_6 : STSUseFlag_return_wit_6.
Axiom proof_of_STSUseFlag_return_wit_7 : STSUseFlag_return_wit_7.

End VC_Correct.
