Require Import read2.qcp_goal read2.qcp_proof_auto read2.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include read2.qcp_proof_auto.
  Include read2.qcp_proof_manual.
End VC_Correctness.
