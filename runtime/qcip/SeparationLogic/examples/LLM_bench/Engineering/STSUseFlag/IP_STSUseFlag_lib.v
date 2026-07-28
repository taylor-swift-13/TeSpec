Require Import Coq.ZArith.ZArith.

Local Open Scope Z_scope.

(* Spec definitions for IP_STSUseFlag are added only after the annotation
   quality gate approves the annotation_scratch_lib candidate. *)

Definition STSUseFlag_TRUE32 : Z := 3952088175.

Definition STSUseFlag_FALSE32 : Z := 0.

Definition STSUseFlagMappedStatus (old_status new_status : Z) : Prop :=
  (old_status = 1 /\ new_status = 6) \/
  (old_status = 2 /\ new_status = 7) \/
  (old_status = 4 /\ new_status = 8) \/
  (old_status <> 1 /\
   old_status <> 2 /\
   old_status <> 4 /\
   new_status = old_status).

Definition STSUseFlagPost
    (old_data_src old_update old_status old_use_old : Z)
    (new_data_src new_update new_status new_use_old : Z) : Prop :=
  new_data_src = old_data_src /\
  ((old_data_src <> 1 /\
    new_update = STSUseFlag_FALSE32 /\
    new_status = old_status /\
    new_use_old = old_use_old) \/
   (old_data_src = 1 /\
    old_update = STSUseFlag_TRUE32 /\
    new_update = old_update /\
    STSUseFlagMappedStatus old_status new_status /\
    new_use_old = new_status) \/
   (old_data_src = 1 /\
    old_update <> STSUseFlag_TRUE32 /\
    old_status <> 3 /\
    new_update = old_update /\
    new_status = old_use_old /\
    new_use_old = old_use_old) \/
   (old_data_src = 1 /\
    old_update <> STSUseFlag_TRUE32 /\
    old_status = 3 /\
    new_update = old_update /\
    new_status = old_status /\
    new_use_old = old_use_old)).
