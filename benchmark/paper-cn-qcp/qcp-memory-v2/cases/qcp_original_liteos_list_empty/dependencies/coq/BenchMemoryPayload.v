From Coq Require Import ZArith.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import Logic.LogicGenerator.demo932.Interface.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope sac.
Definition int_payload (p v: Z): Assertion := store_int p v.
Definition empty_payload (p v: Z): Assertion := “ v = 0 ” && emp.
