Require Import ref-frame_goal ref-frame_proof_auto ref-frame_proof_manual.

Module VC_Correctness : VC_Correct.
  Include ref-frame_proof_auto.
  Include ref-frame_proof_manual.
End VC_Correctness.
