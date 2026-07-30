Require Import v001__inject_exact_goal v001__inject_exact_proof_auto v001__inject_exact_proof_manual.

Module VC_Correctness : VC_Correct.
  Include v001__inject_exact_proof_auto.
  Include v001__inject_exact_proof_manual.
End VC_Correctness.
