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

(*----- Function ModeConvert_AMMFun -----*)

Definition ModeConvert_AMMFun_safety_wit_1 := 
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 17)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ ((101 - 200 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= (101 - 200 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_2 := 
forall (PreH1 : ((101 - 200 ) > 0)) ,
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 17)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_safety_wit_3 := 
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 1)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ ((100 + 0 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= (100 + 0 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_4 := 
forall (PreH1 : (101 <= (100 + 0 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 1)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_safety_wit_5 := 
forall (PreH1 : (101 > (100 + 0 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 1)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ (2 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 2) ”
.

Definition ModeConvert_AMMFun_safety_wit_6 := 
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 1)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ ((100 + 0 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= (100 + 0 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_7 := 
forall (PreH1 : (101 <= (100 + 0 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 1)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_safety_wit_8 := 
forall (PreH1 : (101 > (100 + 0 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 81920)
  **  ((( &( "p" ) )) # Ptr  |-> 81920)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 1)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ (1 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 1) ”
.

Definition ModeConvert_AMMFun_return_wit_1 := 
(
  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 1)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  EX (new_mode: Z) ,
  “ (new_mode = 17) ”
  &&  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 101)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 100)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 4294967295)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> new_mode)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 200)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 0)
  **  ((&((81920)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
) \/
(
forall (PreH1 : (81920 <> 0)) ,
  TT && emp 
|--
  “ (1 = 17) ” 
  &&  “ (1 = 17) ”
  &&  emp
).

Definition ModeConvert_AMMFun_return_wit_1_split_goal_1 := 
forall (PreH1 : (81920 <> 0)) ,
  (1 = 17)
.

Definition ModeConvert_AMMFun_return_wit_1_split_goal_2 := 
forall (PreH1 : (81920 <> 0)) ,
  (1 = 17)
.

Module Type VC_Correct.

Axiom proof_of_ModeConvert_AMMFun_safety_wit_1 : ModeConvert_AMMFun_safety_wit_1.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_2 : ModeConvert_AMMFun_safety_wit_2.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_3 : ModeConvert_AMMFun_safety_wit_3.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_4 : ModeConvert_AMMFun_safety_wit_4.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_5 : ModeConvert_AMMFun_safety_wit_5.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_6 : ModeConvert_AMMFun_safety_wit_6.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_7 : ModeConvert_AMMFun_safety_wit_7.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_8 : ModeConvert_AMMFun_safety_wit_8.
Axiom proof_of_ModeConvert_AMMFun_return_wit_1 : ModeConvert_AMMFun_return_wit_1.

End VC_Correct.
