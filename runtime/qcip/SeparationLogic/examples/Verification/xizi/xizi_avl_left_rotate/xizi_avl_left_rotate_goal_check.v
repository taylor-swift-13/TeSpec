From SimpleC.EE.Verification.xizi.xizi_avl_left_rotate Require Import xizi_avl_left_rotate_goal xizi_avl_left_rotate_proof_auto xizi_avl_left_rotate_proof_manual.

Module VC_Correctness : VC_Correct.
  Include xizi_avl_left_rotate_proof_auto.
  Include xizi_avl_left_rotate_proof_manual.
End VC_Correctness.
