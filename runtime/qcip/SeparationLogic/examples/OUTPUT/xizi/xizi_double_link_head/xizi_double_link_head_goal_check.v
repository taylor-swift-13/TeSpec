From SimpleC.EE.OUTPUT.xizi.xizi_double_link_head Require Import xizi_double_link_head_goal xizi_double_link_head_proof_auto xizi_double_link_head_proof_manual.

Module VC_Correctness : VC_Correct.
  Include xizi_double_link_strategy_proof.
  Include xizi_double_link_head_proof_auto.
  Include xizi_double_link_head_proof_manual.
End VC_Correctness.
