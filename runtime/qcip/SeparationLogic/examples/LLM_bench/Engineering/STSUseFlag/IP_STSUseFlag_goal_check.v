From SimpleC.EE.LLM_bench.Engineering.STSUseFlag Require Import IP_STSUseFlag_goal IP_STSUseFlag_proof_auto IP_STSUseFlag_proof_manual.

Module VC_Correctness : VC_Correct.
  Include IP_STSUseFlag_proof_auto.
  Include IP_STSUseFlag_proof_manual.
End VC_Correctness.
