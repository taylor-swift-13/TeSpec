Require Import v002__inject_exact_goal v002__inject_exact_proof_auto v002__inject_exact_proof_manual.

Module VC_Correctness : VC_Correct.
  Include v002__inject_exact_proof_auto.
  Include v002__inject_exact_proof_manual.
End VC_Correctness.
