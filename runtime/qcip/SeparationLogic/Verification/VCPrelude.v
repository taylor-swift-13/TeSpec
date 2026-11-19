(* Compatibility entry point for the native QCP VC printer. *)
Require Export Coq.ZArith.ZArith Coq.Bool.Bool Coq.Strings.String Coq.Strings.Ascii Coq.Lists.List.
Require Export Coq.Classes.RelationClasses Coq.Classes.Morphisms Coq.micromega.Psatz Coq.Sorting.Permutation.
From AUXLib Require Export int_auto Axioms Feq Idents ListLib VMap.
Require Export SetsClass.SetsClass.
Export SetsNotation.
From SimpleC.SL Require Export Mem SeparationLogic.
Require Export Logic.LogicGenerator.demo932.Interface.
Global Open Scope Z_scope.
Global Open Scope sets.
Global Open Scope string_scope.
Global Open Scope list.

(* Noninteger Znth defaults are supplied by explicit binders in each VC. *)
Polymorphic Class Inhabited (A : Type) := inhabitant : A.
