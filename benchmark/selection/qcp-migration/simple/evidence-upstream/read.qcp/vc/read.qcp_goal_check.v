Require Import read.qcp_goal read.qcp_proof_auto read.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include read.qcp_proof_auto.
  Include read.qcp_proof_manual.
End VC_Correctness.
