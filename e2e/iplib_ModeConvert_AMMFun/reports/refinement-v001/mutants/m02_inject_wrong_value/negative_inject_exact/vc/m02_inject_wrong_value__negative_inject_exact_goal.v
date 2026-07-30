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
  ((( &( "pIp" ) )) # Ptr  |-> 53248)
  **  ((( &( "p" ) )) # Ptr  |-> 53248)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 12)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ (((-5) - (-10) ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= ((-5) - (-10) )) ”
.

Definition ModeConvert_AMMFun_safety_wit_2 := 
forall (PreH1 : (((-5) - (-10) ) < 5)) ,
  ((( &( "pIp" ) )) # Ptr  |-> 53248)
  **  ((( &( "p" ) )) # Ptr  |-> 53248)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 12)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_safety_wit_3 := 
  ((( &( "pIp" ) )) # Ptr  |-> 53248)
  **  ((( &( "p" ) )) # Ptr  |-> 53248)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ (((-4) + 0 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= ((-4) + 0 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_4 := 
forall (PreH1 : ((-5) > ((-4) + 0 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 53248)
  **  ((( &( "p" ) )) # Ptr  |-> 53248)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_safety_wit_5 := 
  ((( &( "pIp" ) )) # Ptr  |-> 53248)
  **  ((( &( "p" ) )) # Ptr  |-> 53248)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ (((-4) + 0 ) <= 9223372036854775807) ” 
  &&  “ ((-9223372036854775808) <= ((-4) + 0 )) ”
.

Definition ModeConvert_AMMFun_safety_wit_6 := 
forall (PreH1 : ((-5) > ((-4) + 0 ))) ,
  ((( &( "pIp" ) )) # Ptr  |-> 53248)
  **  ((( &( "p" ) )) # Ptr  |-> 53248)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  “ False ”
.

Definition ModeConvert_AMMFun_return_wit_1 := 
(
  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
|--
  EX (new_mode: Z) ,
  “ (new_mode = 1) ”
  &&  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_starTime")) # Int64  |-> (-5))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "tm3")) # Int64  |-> (-4))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csMnvData_F_MnvNextMode")) # UInt  |-> 0)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "m_WorkMode")) # UInt  |-> new_mode)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csOrb19_Para_I_t0")) # Int64  |-> (-10))
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "csModePara_dt_OrbitInject")) # Int64  |-> 5)
  **  ((&((53248)  # "__ModeConvert_AMM" ->ₛ "LmtT_ModeSwitch_AMM")) # Int64  |-> 0)
) \/
(
forall (PreH1 : (53248 <> 0)) ,
  TT && emp 
|--
  “ (0 = 1) ” 
  &&  “ (0 = 1) ”
  &&  emp
).

Definition ModeConvert_AMMFun_return_wit_1_split_goal_1 := 
forall (PreH1 : (53248 <> 0)) ,
  (0 = 1)
.

Definition ModeConvert_AMMFun_return_wit_1_split_goal_2 := 
forall (PreH1 : (53248 <> 0)) ,
  (0 = 1)
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
