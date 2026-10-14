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
Local Open Scope sac.
Definition UndefStructPredState (p:Z) : Assertion := &(p # "State" ->ₛ "ModeA") # Int |->_ ** &(p # "State" ->ₛ "ModeD") # Int |->_ ** &(p # "State" ->ₛ "W_A") # Int |->_ ** &(p # "State" ->ₛ "W_D") # Int |->_ ** &(p # "State" ->ₛ "Runway_Time") # Int |->_ ** &(p # "State" ->ₛ "Plane_Counter") # Int |->_.
