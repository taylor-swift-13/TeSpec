Require Import const_example_lessgood.qcp_goal const_example_lessgood.qcp_proof_auto const_example_lessgood.qcp_proof_manual.

Module VC_Correctness : VC_Correct.
  Include const_example_lessgood.qcp_proof_auto.
  Include const_example_lessgood.qcp_proof_manual.
End VC_Correctness.
