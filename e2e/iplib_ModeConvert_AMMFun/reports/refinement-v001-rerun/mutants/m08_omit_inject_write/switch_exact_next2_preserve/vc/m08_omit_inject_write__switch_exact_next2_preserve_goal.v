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
  ((( &( "pIp" ) )) # Ptr  |-> 49152)
  **  ((( &( "p" ) )) # Ptr  |-> 49152)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 11)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
|--
  “ ((15 - 1 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= (15 - 1 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_2 := 
forall (PreH1 : ((15 - 1 ) >= 15)) ,
  ((( &( "pIp" ) )) # Ptr  |-> 49152)
  **  ((( &( "p" ) )) # Ptr  |-> 49152)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 11)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_safety_wit_3 := 
  ((( &( "pIp" ) )) # Ptr  |-> 49152)
  **  ((( &( "p" ) )) # Ptr  |-> 49152)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 11)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
|--
  “ ((10 + 5 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= (10 + 5 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_4 := 
forall (PreH1 : (15 > (10 + 5 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 49152)
  **  ((( &( "p" ) )) # Ptr  |-> 49152)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 11)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_safety_wit_5 := 
  ((( &( "pIp" ) )) # Ptr  |-> 49152)
  **  ((( &( "p" ) )) # Ptr  |-> 49152)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 11)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
|--
  “ ((10 + 5 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= (10 + 5 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_6 := 
forall (PreH1 : (15 > (10 + 5 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 49152)
  **  ((( &( "p" ) )) # Ptr  |-> 49152)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 11)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_return_wit_1 := 
  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 11)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
|--
  EX (new_mode: Z) ,
  “ (new_mode = 11) ”
  &&  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> 10)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 2)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> new_mode)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> 1)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 15)
  **  ((&((49152)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 5)
.

Module Type VC_Correct.

Axiom proof_of_ModeConvert_AMMFun_safety_wit_1 : ModeConvert_AMMFun_safety_wit_1.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_2 : ModeConvert_AMMFun_safety_wit_2.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_3 : ModeConvert_AMMFun_safety_wit_3.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_4 : ModeConvert_AMMFun_safety_wit_4.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_5 : ModeConvert_AMMFun_safety_wit_5.
Axiom proof_of_ModeConvert_AMMFun_safety_wit_6 : ModeConvert_AMMFun_safety_wit_6.
Axiom proof_of_ModeConvert_AMMFun_return_wit_1 : ModeConvert_AMMFun_return_wit_1.

End VC_Correct.
