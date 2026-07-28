From SimpleC.EE.LLM_bench.Engineering.STSTransDataSave Require Import IP_STSTransDataSave_goal IP_STSTransDataSave_proof_auto IP_STSTransDataSave_proof_manual.

Module VC_Correctness : VC_Correct.
  Include char_array_strategy_proof.
  Include IP_STSTransDataSave_proof_auto.
  Include IP_STSTransDataSave_proof_manual.
End VC_Correctness.
