From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_1c59d86d2590d95de97f91f1.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function sizeOf -----*)

Definition sizeOf_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (d___tespec_entry: Z) (p_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (d___tespec_entry = 8192)) (PreH4 : (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z))))))) (PreH5 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  EX (p_size_2: Z),
  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  “ (p_size_2 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
.

Definition sizeOf_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (d___tespec_entry: Z),
exists (p_pre: Z),
~ ((  EX (p_size: Z),
  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons (1) ((@nil Z)))))) ”
  &&  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_sizeOf_return_wit_1 : sizeOf_return_wit_1.
Axiom proof_of_sizeOf_precondition_wit_1 : sizeOf_precondition_wit_1.

End VC_Correct.
