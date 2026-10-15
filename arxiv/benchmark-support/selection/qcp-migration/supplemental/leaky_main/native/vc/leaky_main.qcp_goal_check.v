Require Import leaky_main.qcp_goal leaky_main.qcp_proof_auto leaky_main.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include leaky_main.qcp_proof_auto.
  Include leaky_main.qcp_proof_manual.
End VC_Correctness.
