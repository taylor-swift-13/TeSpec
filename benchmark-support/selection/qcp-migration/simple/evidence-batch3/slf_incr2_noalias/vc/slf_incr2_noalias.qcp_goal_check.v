Require Import slf_incr2_noalias.qcp_goal slf_incr2_noalias.qcp_proof_auto slf_incr2_noalias.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf_incr2_noalias.qcp_proof_auto.
  Include slf_incr2_noalias.qcp_proof_manual.
End VC_Correctness.
