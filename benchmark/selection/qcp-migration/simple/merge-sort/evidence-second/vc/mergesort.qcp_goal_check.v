Require Import mergesort.qcp_goal mergesort.qcp_proof_auto mergesort.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include mergesort.qcp_proof_auto.
  Include mergesort.qcp_proof_manual.
End VC_Correctness.
