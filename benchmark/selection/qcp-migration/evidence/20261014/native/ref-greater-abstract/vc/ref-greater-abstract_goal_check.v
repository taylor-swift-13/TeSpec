Require Import ref-greater-abstract_goal ref-greater-abstract_proof_auto ref-greater-abstract_proof_manual.

Module VC_Correctness : VC_Correct.
  Include ref-greater-abstract_proof_auto.
  Include ref-greater-abstract_proof_manual.
End VC_Correctness.
