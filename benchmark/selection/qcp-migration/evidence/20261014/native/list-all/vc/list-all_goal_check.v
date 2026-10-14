Require Import list-all_goal list-all_proof_auto list-all_proof_manual.

Module VC_Correctness : VC_Correct.
  Include list-all_proof_auto.
  Include list-all_proof_manual.
End VC_Correctness.
