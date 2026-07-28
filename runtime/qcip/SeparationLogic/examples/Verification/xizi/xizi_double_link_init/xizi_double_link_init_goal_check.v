From SimpleC.EE.Verification.xizi.xizi_double_link_init Require Import xizi_double_link_init_goal xizi_double_link_init_proof_auto xizi_double_link_init_proof_manual.

Module VC_Correctness : VC_Correct.
  Include xizi_double_link_init_proof_auto.
  Include xizi_double_link_init_proof_manual.
End VC_Correctness.
