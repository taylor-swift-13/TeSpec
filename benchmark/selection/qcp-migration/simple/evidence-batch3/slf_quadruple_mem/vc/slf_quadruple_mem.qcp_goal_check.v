Require Import slf_quadruple_mem.qcp_goal slf_quadruple_mem.qcp_proof_auto slf_quadruple_mem.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include slf_quadruple_mem.qcp_proof_auto.
  Include slf_quadruple_mem.qcp_proof_manual.
End VC_Correctness.
