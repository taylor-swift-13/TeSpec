Require Import Coq.ZArith.ZArith.
Require Import Coq.Bool.Bool.
Require Import Coq.Strings.String.
Require Import Coq.Strings.Ascii.
Require Import Coq.Lists.List.
Require Import Coq.Classes.RelationClasses.
Require Import Coq.Classes.Morphisms.
Require Import Coq.micromega.Psatz.
Require Import Coq.Sorting.Permutation.
From AUXLib Require Import int_auto Axioms Feq Idents ListLib VMap.
Require Import SetsClass.SetsClass. Import SetsNotation.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Local Open Scope Z_scope.
Local Open Scope sets.
Local Open Scope string_scope.
Local Open Scope list.
Import naive_C_Rules.
Require Import SimpleC.EE.LLM_bench.Engineering.STSTransDataSave.IP_STSTransDataSave_lib.
Local Open Scope sac.
From SimpleC.EE.QCP_demos_LLM Require Import char_array_strategy_goal.
From SimpleC.EE.QCP_demos_LLM Require Import char_array_strategy_proof.

(*----- Function STSTransDataSave -----*)

Definition STSTransDataSave_safety_wit_1 := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (PreH1 : (0 <= ptr)) (PreH2 : (ptr <= 776)) (PreH3 : ((Zlength (data_head)) = 248)) (PreH4 : ((Zlength (data_tail)) = 8)) (PreH5 : ((Zlength (prefix)) = ptr)) (PreH6 : ((Zlength (old_dst)) = 248)) (PreH7 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((( &( "pDst" ) )) # UInt  |->_)
  **  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full (1074343936 + ptr ) 248 old_dst )
  **  (CharArray.full ((1074343936 + ptr ) + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (776 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 776) ”
.

Definition STSTransDataSave_safety_wit_2 := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (ptr < 776)) (PreH2 : (pDst = (1074343936 + ptr ))) (PreH3 : (0 <= ptr)) (PreH4 : (ptr <= 776)) (PreH5 : ((Zlength (data_head)) = 248)) (PreH6 : ((Zlength (data_tail)) = 8)) (PreH7 : ((Zlength (prefix)) = ptr)) (PreH8 : ((Zlength (old_dst)) = 248)) (PreH9 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((( &( "pDst" ) )) # UInt  |-> pDst)
  **  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 old_dst )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (0 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 0) ”
.

Definition STSTransDataSave_safety_wit_3 := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (ptr < 776)) (PreH2 : (pDst = (1074343936 + ptr ))) (PreH3 : (0 <= ptr)) (PreH4 : (ptr <= 776)) (PreH5 : ((Zlength (data_head)) = 248)) (PreH6 : ((Zlength (data_tail)) = 8)) (PreH7 : ((Zlength (prefix)) = ptr)) (PreH8 : ((Zlength (old_dst)) = 248)) (PreH9 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((( &( "pDst" ) )) # UInt  |-> pDst)
  **  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 old_dst )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (248 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 248) ”
.

Definition STSTransDataSave_safety_wit_4 := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (ptr < 776)) (PreH2 : (pDst = (1074343936 + ptr ))) (PreH3 : (0 <= ptr)) (PreH4 : (ptr <= 776)) (PreH5 : ((Zlength (data_head)) = 248)) (PreH6 : ((Zlength (data_tail)) = 8)) (PreH7 : ((Zlength (prefix)) = ptr)) (PreH8 : ((Zlength (old_dst)) = 248)) (PreH9 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((( &( "pDst" ) )) # UInt  |-> pDst)
  **  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 data_head )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (248 <= INT_MAX) ” 
  &&  “ ((INT_MIN) <= 248) ”
.

Definition STSTransDataSave_entail_wit_1 := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (PreH1 : (ptr < 776)) (PreH2 : (0 <= ptr)) (PreH3 : (ptr <= 776)) (PreH4 : ((Zlength (data_head)) = 248)) (PreH5 : ((Zlength (data_tail)) = 8)) (PreH6 : ((Zlength (prefix)) = ptr)) (PreH7 : ((Zlength (old_dst)) = 248)) (PreH8 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full (1074343936 + ptr ) 248 old_dst )
  **  (CharArray.full ((1074343936 + ptr ) + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (ptr < 776) ” 
  &&  “ ((1074343936 + ptr ) = (1074343936 + ptr )) ” 
  &&  “ (0 <= ptr) ” 
  &&  “ (ptr <= 776) ” 
  &&  “ ((Zlength (data_head)) = 248) ” 
  &&  “ ((Zlength (data_tail)) = 8) ” 
  &&  “ ((Zlength (prefix)) = ptr) ” 
  &&  “ ((Zlength (old_dst)) = 248) ” 
  &&  “ ((Zlength (suffix)) = ((1024 - ptr ) - 248 )) ”
  &&  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full (1074343936 + ptr ) 248 old_dst )
  **  (CharArray.full ((1074343936 + ptr ) + 248 ) ((1024 - ptr ) - 248 ) suffix )
.

Definition STSTransDataSave_entail_wit_2 := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (0 <= ((1024 - ptr ) - 248 ))) (PreH2 : (0 <= 8)) (PreH3 : (ptr < 776)) (PreH4 : (pDst = (1074343936 + ptr ))) (PreH5 : (0 <= ptr)) (PreH6 : (ptr <= 776)) (PreH7 : ((Zlength (data_head)) = 248)) (PreH8 : ((Zlength (data_tail)) = 8)) (PreH9 : ((Zlength (prefix)) = ptr)) (PreH10 : ((Zlength (old_dst)) = 248)) (PreH11 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  (CharArray.full pDst 248 data_head )
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (ptr < 776) ” 
  &&  “ (pDst = (1074343936 + ptr )) ” 
  &&  “ (0 <= ptr) ” 
  &&  “ (ptr <= 776) ” 
  &&  “ ((Zlength (data_head)) = 248) ” 
  &&  “ ((Zlength (data_tail)) = 8) ” 
  &&  “ ((Zlength (prefix)) = ptr) ” 
  &&  “ ((Zlength (old_dst)) = 248) ” 
  &&  “ ((Zlength (suffix)) = ((1024 - ptr ) - 248 )) ”
  &&  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 data_head )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
.

Definition STSTransDataSave_return_wit_1 := 
(
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (ptr < 776)) (PreH2 : (pDst = (1074343936 + ptr ))) (PreH3 : (0 <= ptr)) (PreH4 : (ptr <= 776)) (PreH5 : ((Zlength (data_head)) = 248)) (PreH6 : ((Zlength (data_tail)) = 8)) (PreH7 : ((Zlength (prefix)) = ptr)) (PreH8 : ((Zlength (old_dst)) = 248)) (PreH9 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> (ptr + 248 ))
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 data_head )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  EX (ptr1: Z)  (new_sram: (@list Z)) ,
  “ (STSTransDataSaveBytePost ptr ptr1 (app (data_head) (data_tail)) (app (prefix) ((app (old_dst) (suffix)))) new_sram ) ”
  &&  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr1)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 1024 new_sram )
) \/
(
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (0 <= ((1024 - ptr ) - 248 ))) (PreH2 : (0 <= 248)) (PreH3 : (ptr < 776)) (PreH4 : (pDst = (1074343936 + ptr ))) (PreH5 : (0 <= ptr)) (PreH6 : (ptr <= 776)) (PreH7 : ((Zlength (data_head)) = 248)) (PreH8 : ((Zlength (data_tail)) = 8)) (PreH9 : ((Zlength (prefix)) = ptr)) (PreH10 : ((Zlength (old_dst)) = 248)) (PreH11 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 data_head )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  EX (new_sram: (@list Z)) ,
  “ (STSTransDataSaveBytePost ptr (ptr + 248 ) (app (data_head) (data_tail)) (app (prefix) ((app (old_dst) (suffix)))) new_sram ) ”
  &&  (CharArray.full 1074343936 1024 new_sram )
).

Definition STSTransDataSave_return_wit_2 := 
(
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (PreH1 : (ptr >= 776)) (PreH2 : (0 <= ptr)) (PreH3 : (ptr <= 776)) (PreH4 : ((Zlength (data_head)) = 248)) (PreH5 : ((Zlength (data_tail)) = 8)) (PreH6 : ((Zlength (prefix)) = ptr)) (PreH7 : ((Zlength (old_dst)) = 248)) (PreH8 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full (1074343936 + ptr ) 248 old_dst )
  **  (CharArray.full ((1074343936 + ptr ) + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  EX (ptr1: Z)  (new_sram: (@list Z)) ,
  “ (STSTransDataSaveBytePost ptr ptr1 (app (data_head) (data_tail)) (app (prefix) ((app (old_dst) (suffix)))) new_sram ) ”
  &&  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr1)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 1024 new_sram )
) \/
(
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (PreH1 : (0 <= ((1024 - ptr ) - 248 ))) (PreH2 : (0 <= 248)) (PreH3 : (ptr >= 776)) (PreH4 : (0 <= ptr)) (PreH5 : (ptr <= 776)) (PreH6 : ((Zlength (data_head)) = 248)) (PreH7 : ((Zlength (data_tail)) = 8)) (PreH8 : ((Zlength (prefix)) = ptr)) (PreH9 : ((Zlength (old_dst)) = 248)) (PreH10 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full (1074343936 + ptr ) 248 old_dst )
  **  (CharArray.full ((1074343936 + ptr ) + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  EX (new_sram: (@list Z)) ,
  “ (STSTransDataSaveBytePost ptr ptr (app (data_head) (data_tail)) (app (prefix) ((app (old_dst) (suffix)))) new_sram ) ”
  &&  (CharArray.full 1074343936 1024 new_sram )
).

Definition STSTransDataSave_partial_solve_wit_1_pure := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (ptr < 776)) (PreH2 : (pDst = (1074343936 + ptr ))) (PreH3 : (0 <= ptr)) (PreH4 : (ptr <= 776)) (PreH5 : ((Zlength (data_head)) = 248)) (PreH6 : ((Zlength (data_tail)) = 8)) (PreH7 : ((Zlength (prefix)) = ptr)) (PreH8 : ((Zlength (old_dst)) = 248)) (PreH9 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((( &( "pDst" ) )) # UInt  |-> pDst)
  **  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 old_dst )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (248 = 248) ” 
  &&  “ ((Zlength (data_head)) = 248) ” 
  &&  “ ((Zlength (old_dst)) = 248) ” 
  &&  “ (0 <= 248) ” 
  &&  “ (248 < INT_MAX) ”
.

Definition STSTransDataSave_partial_solve_wit_1_aux := 
forall (suffix: (@list Z)) (old_dst: (@list Z)) (prefix: (@list Z)) (data_tail: (@list Z)) (data_head: (@list Z)) (ptr: Z) (pDst: Z) (PreH1 : (ptr < 776)) (PreH2 : (pDst = (1074343936 + ptr ))) (PreH3 : (0 <= ptr)) (PreH4 : (ptr <= 776)) (PreH5 : ((Zlength (data_head)) = 248)) (PreH6 : ((Zlength (data_tail)) = 8)) (PreH7 : ((Zlength (prefix)) = ptr)) (PreH8 : ((Zlength (old_dst)) = 248)) (PreH9 : ((Zlength (suffix)) = ((1024 - ptr ) - 248 ))) ,
  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full pDst 248 old_dst )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
|--
  “ (248 = 248) ” 
  &&  “ ((Zlength (data_head)) = 248) ” 
  &&  “ ((Zlength (old_dst)) = 248) ” 
  &&  “ (0 <= 248) ” 
  &&  “ (248 < INT_MAX) ” 
  &&  “ (0 <= ((1024 - ptr ) - 248 )) ” 
  &&  “ (0 <= 8) ” 
  &&  “ (ptr < 776) ” 
  &&  “ (pDst = (1074343936 + ptr )) ” 
  &&  “ (0 <= ptr) ” 
  &&  “ (ptr <= 776) ” 
  &&  “ ((Zlength (data_head)) = 248) ” 
  &&  “ ((Zlength (data_tail)) = 8) ” 
  &&  “ ((Zlength (prefix)) = ptr) ” 
  &&  “ ((Zlength (old_dst)) = 248) ” 
  &&  “ ((Zlength (suffix)) = ((1024 - ptr ) - 248 )) ”
  &&  (CharArray.full pDst 248 old_dst )
  **  (CharArray.full (&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) 248 data_head )
  **  ((&(( &( "sSTSTran" ) )->ₛ "ptr")) # UInt  |-> ptr)
  **  (CharArray.full ((&(( &( "sSTSTran" ) )->ₛ "dataBuf") + (0 * sizeof(UCHAR) ) ) + 248 ) 8 data_tail )
  **  (CharArray.full 1074343936 ptr prefix )
  **  (CharArray.full (pDst + 248 ) ((1024 - ptr ) - 248 ) suffix )
.

Definition STSTransDataSave_partial_solve_wit_1 := STSTransDataSave_partial_solve_wit_1_pure -> STSTransDataSave_partial_solve_wit_1_aux.

Module Type VC_Correct.

Include char_array_Strategy_Correct.

Axiom proof_of_STSTransDataSave_safety_wit_1 : STSTransDataSave_safety_wit_1.
Axiom proof_of_STSTransDataSave_safety_wit_2 : STSTransDataSave_safety_wit_2.
Axiom proof_of_STSTransDataSave_safety_wit_3 : STSTransDataSave_safety_wit_3.
Axiom proof_of_STSTransDataSave_safety_wit_4 : STSTransDataSave_safety_wit_4.
Axiom proof_of_STSTransDataSave_entail_wit_1 : STSTransDataSave_entail_wit_1.
Axiom proof_of_STSTransDataSave_entail_wit_2 : STSTransDataSave_entail_wit_2.
Axiom proof_of_STSTransDataSave_return_wit_1 : STSTransDataSave_return_wit_1.
Axiom proof_of_STSTransDataSave_return_wit_2 : STSTransDataSave_return_wit_2.
Axiom proof_of_STSTransDataSave_partial_solve_wit_1_pure : STSTransDataSave_partial_solve_wit_1_pure.
Axiom proof_of_STSTransDataSave_partial_solve_wit_1 : STSTransDataSave_partial_solve_wit_1.

End VC_Correct.
