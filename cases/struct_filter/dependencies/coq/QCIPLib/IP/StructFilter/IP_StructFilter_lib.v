Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Require Import Coq.Strings.String.
From SimpleC.SL Require Import Mem SeparationLogic.
Require Import SetsClass.SetsClass. Import SetsNotation.
Require Import Logic.LogicGenerator.demo932.Interface.

Local Open Scope Z_scope.
Local Open Scope string_scope.

Import ListNotations.
Import naive_C_Rules.
Local Open Scope sac.

(* Representation of a length-n float64 array as a contiguous store of 8-byte cells.
   Values are kept as abstract mathematical integers (Z), matching the QCP-front-end
   adaptation that treats float64/double as opaque 64-bit words in the store. *)
Fixpoint FloatArray_full (a: addr) (n: Z) (l: list Z): Assertion :=
  match l with
  | nil     => “ n = 0 ” && emp
  | z :: l0 => “ n > 0 ” &&
               a # Int64 |-> z **
               FloatArray_full (a + sizeof(INT64)) (n - 1) l0
  end.

(* Record capturing the 18 read-only coefficients of STRUCT_FILTER. *)
Record STRUCT_FILTER_rep : Type := mk_STRUCT_FILTER_rep {
  sf_A11 : Z; sf_H1 : Z; sf_D1 : Z;
  sf_A32 : Z; sf_A33 : Z; sf_H2 : Z; sf_H3 : Z; sf_D2 : Z;
  sf_A54 : Z; sf_A55 : Z; sf_H4 : Z; sf_H5 : Z; sf_D3 : Z;
  sf_A76 : Z; sf_A77 : Z; sf_H6 : Z; sf_H7 : Z; sf_D4 : Z
}.

(* Spatial representation of a STRUCT_FILTER pointer, exposed with 18 scalar
   parameters so that the C annotation does not need to pass a Rocq record. *)
Definition StructFilterRep (p: addr)
  (a11 h1 d1 a32 a33 h2 h3 d2 a54 a55 h4 h5 d3 a76 a77 h6 h7 d4 : Z)
  : Assertion :=
  &(p # "TAG_STRUCT_FILTER" ->ₛ "A11") # Int64 |-> a11 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "H1")  # Int64 |-> h1 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "D1")  # Int64 |-> d1 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "A32") # Int64 |-> a32 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "A33") # Int64 |-> a33 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "H2")  # Int64 |-> h2 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "H3")  # Int64 |-> h3 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "D2")  # Int64 |-> d2 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "A54") # Int64 |-> a54 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "A55") # Int64 |-> a55 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "H4")  # Int64 |-> h4 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "H5")  # Int64 |-> h5 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "D3")  # Int64 |-> d3 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "A76") # Int64 |-> a76 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "A77") # Int64 |-> a77 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "H6")  # Int64 |-> h6 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "H7")  # Int64 |-> h7 **
  &(p # "TAG_STRUCT_FILTER" ->ₛ "D4")  # Int64 |-> d4.

(* Build a STRUCT_FILTER_rep from a coefficient list of length 18. *)
Definition filter_coeffs_to_rep (coeffs: list Z) : STRUCT_FILTER_rep :=
  mk_STRUCT_FILTER_rep
    (Znth 0 coeffs 0) (Znth 1 coeffs 0) (Znth 2 coeffs 0)
    (Znth 3 coeffs 0) (Znth 4 coeffs 0) (Znth 5 coeffs 0) (Znth 6 coeffs 0) (Znth 7 coeffs 0)
    (Znth 8 coeffs 0) (Znth 9 coeffs 0) (Znth 10 coeffs 0) (Znth 11 coeffs 0) (Znth 12 coeffs 0)
    (Znth 13 coeffs 0) (Znth 14 coeffs 0) (Znth 15 coeffs 0) (Znth 16 coeffs 0) (Znth 17 coeffs 0).

(* Helper accessors for the old state list X. *)
Definition X0 (X: list Z) : Z := Znth 0 X 0.
Definition X1 (X: list Z) : Z := Znth 1 X 0.
Definition X2 (X: list Z) : Z := Znth 2 X 0.
Definition X3 (X: list Z) : Z := Znth 3 X 0.
Definition X4 (X: list Z) : Z := Znth 4 X 0.
Definition X5 (X: list Z) : Z := Znth 5 X 0.
Definition X6 (X: list Z) : Z := Znth 6 X 0.
Definition X7 (X: list Z) : Z := Znth 7 X 0.

(* Intermediate signals used only inside the spec; they do not appear in C annotation. *)
Definition StructFilter_U2 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  (sf_A11 f) * (X0 old_X) + (sf_H1 f) * kp * Ang +
  (sf_D1 f) * kp * Ang +
  kd * dAng.

Definition StructFilter_Y2 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  X1 old_X + (sf_D2 f) * (StructFilter_U2 old_X f kp kd Ang dAng).

Definition StructFilter_Y3 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  X3 old_X + (sf_D3 f) * (StructFilter_Y2 old_X f kp kd Ang dAng).

(* New state vector components, derived from the old state and inputs only. *)
Definition StructFilterNewX0 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp: Z) (Ang: Z) : Z :=
  (sf_A11 f) * (X0 old_X) + (sf_H1 f) * kp * Ang.

Definition StructFilterNewX1 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  X2 old_X + (sf_H2 f) * (StructFilter_U2 old_X f kp kd Ang dAng).

Definition StructFilterNewX2 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  (sf_A32 f) * (X1 old_X) + (sf_A33 f) * (X2 old_X) + (sf_H3 f) * (StructFilter_U2 old_X f kp kd Ang dAng).

Definition StructFilterNewX3 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  X4 old_X + (sf_H4 f) * (StructFilter_Y2 old_X f kp kd Ang dAng).

Definition StructFilterNewX4 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  (sf_A54 f) * (X3 old_X) + (sf_A55 f) * (X4 old_X) + (sf_H5 f) * (StructFilter_Y2 old_X f kp kd Ang dAng).

Definition StructFilterNewX5 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  X6 old_X + (sf_H6 f) * (StructFilter_Y3 old_X f kp kd Ang dAng).

Definition StructFilterNewX6 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  (sf_A76 f) * (X5 old_X) + (sf_A77 f) * (X6 old_X) + (sf_H7 f) * (StructFilter_Y3 old_X f kp kd Ang dAng).

Definition StructFilterNewX7 (old_X: list Z) (prd ki Ang: Z) : Z :=
  X7 old_X + prd * ki * Ang.

(* Return value Y4: computed from old X[5], filter->D4, and Y3. *)
Definition StructFilterY4 (old_X: list Z) (f: STRUCT_FILTER_rep) (kp kd: Z) (Ang dAng: Z) : Z :=
  X5 old_X + (sf_D4 f) * (StructFilter_Y3 old_X f kp kd Ang dAng).

(* Signed 64-bit range. *)
Definition int64_bounded (z: Z) : Prop := -9223372036854775808 <= z <= 9223372036854775807.

(* Bounds required so that every arithmetic subexpression in the filter update
   stays inside the signed 64-bit range.  This predicate is required by the
   C contract; it is not part of the functional postcondition. *)
Definition StructFilterInputsBounded
  (old_X filter_coeffs old_PIDPara: list Z)
  (Ang dAng prd: Z) : Prop :=
  let f  := filter_coeffs_to_rep filter_coeffs in
  let kp := Znth 0 old_PIDPara 0 in
  let ki := Znth 1 old_PIDPara 0 in
  let kd := Znth 2 old_PIDPara 0 in
  let u2 := StructFilter_U2 old_X f kp kd Ang dAng in
  let y2 := StructFilter_Y2 old_X f kp kd Ang dAng in
  let y3 := StructFilter_Y3 old_X f kp kd Ang dAng in
  Zlength old_X = 8 /\
  Zlength filter_coeffs = 18 /\
  Zlength old_PIDPara = 3 /\
  (* base inputs *)
  int64_bounded (X0 old_X) /\ int64_bounded (X1 old_X) /\ int64_bounded (X2 old_X) /\
  int64_bounded (X3 old_X) /\ int64_bounded (X4 old_X) /\ int64_bounded (X5 old_X) /\
  int64_bounded (X6 old_X) /\ int64_bounded (X7 old_X) /\
  int64_bounded (Znth 0 filter_coeffs 0) /\ int64_bounded (Znth 1 filter_coeffs 0) /\
  int64_bounded (Znth 2 filter_coeffs 0) /\ int64_bounded (Znth 3 filter_coeffs 0) /\
  int64_bounded (Znth 4 filter_coeffs 0) /\ int64_bounded (Znth 5 filter_coeffs 0) /\
  int64_bounded (Znth 6 filter_coeffs 0) /\ int64_bounded (Znth 7 filter_coeffs 0) /\
  int64_bounded (Znth 8 filter_coeffs 0) /\ int64_bounded (Znth 9 filter_coeffs 0) /\
  int64_bounded (Znth 10 filter_coeffs 0) /\ int64_bounded (Znth 11 filter_coeffs 0) /\
  int64_bounded (Znth 12 filter_coeffs 0) /\ int64_bounded (Znth 13 filter_coeffs 0) /\
  int64_bounded (Znth 14 filter_coeffs 0) /\ int64_bounded (Znth 15 filter_coeffs 0) /\
  int64_bounded (Znth 16 filter_coeffs 0) /\ int64_bounded (Znth 17 filter_coeffs 0) /\
  int64_bounded kp /\ int64_bounded ki /\ int64_bounded kd /\
  int64_bounded Ang /\ int64_bounded dAng /\ int64_bounded prd /\
  (* controller *)
  int64_bounded (sf_A11 f * X0 old_X) /\
  int64_bounded (sf_H1 f * kp) /\
  int64_bounded (sf_H1 f * kp * Ang) /\
  int64_bounded (StructFilterNewX0 old_X f kp Ang) /\
  int64_bounded (sf_D1 f * kp) /\
  int64_bounded (sf_D1 f * kp * Ang) /\
  int64_bounded (StructFilterNewX0 old_X f kp Ang + sf_D1 f * kp * Ang) /\
  int64_bounded u2 /\
  int64_bounded (kd * dAng) /\
  (* first filter section *)
  int64_bounded y2 /\
  int64_bounded (sf_D2 f * u2) /\
  int64_bounded (StructFilterNewX1 old_X f kp kd Ang dAng) /\
  int64_bounded (sf_H2 f * u2) /\
  int64_bounded (StructFilterNewX2 old_X f kp kd Ang dAng) /\
  int64_bounded (sf_H3 f * u2) /\
  int64_bounded (sf_A32 f * X1 old_X + sf_A33 f * X2 old_X) /\
  int64_bounded (sf_A33 f * X2 old_X) /\
  int64_bounded (sf_A32 f * X1 old_X) /\
  (* second filter section *)
  int64_bounded y3 /\
  int64_bounded (sf_D3 f * y2) /\
  int64_bounded (StructFilterNewX3 old_X f kp kd Ang dAng) /\
  int64_bounded (sf_H4 f * y2) /\
  int64_bounded (StructFilterNewX4 old_X f kp kd Ang dAng) /\
  int64_bounded (sf_H5 f * y2) /\
  int64_bounded (sf_A54 f * X3 old_X + sf_A55 f * X4 old_X) /\
  int64_bounded (sf_A55 f * X4 old_X) /\
  int64_bounded (sf_A54 f * X3 old_X) /\
  (* third filter section / return value *)
  int64_bounded (StructFilterY4 old_X f kp kd Ang dAng) /\
  int64_bounded (sf_D4 f * y3) /\
  int64_bounded (StructFilterNewX5 old_X f kp kd Ang dAng) /\
  int64_bounded (sf_H6 f * y3) /\
  int64_bounded (StructFilterNewX6 old_X f kp kd Ang dAng) /\
  int64_bounded (sf_H7 f * y3) /\
  int64_bounded (sf_A76 f * X5 old_X + sf_A77 f * X6 old_X) /\
  int64_bounded (sf_A77 f * X6 old_X) /\
  int64_bounded (sf_A76 f * X5 old_X) /\
  (* integrator *)
  int64_bounded (StructFilterNewX7 old_X prd ki Ang) /\
  int64_bounded (prd * ki * Ang) /\
  int64_bounded (prd * ki).

(* Compact post-state relation: old state + inputs uniquely determine new state and return.
   filter_coeffs must have length 18 and list the coefficients in the order:
   A11, H1, D1, A32, A33, H2, H3, D2, A54, A55, H4, H5, D3, A76, A77, H6, H7, D4. *)
Definition StructFilterPost
  (old_X: list Z)
  (filter_coeffs: list Z)
  (pid_para: list Z)
  (Ang dAng prd: Z)
  (new_X: list Z)
  (ret: Z) : Prop :=
  let f := filter_coeffs_to_rep filter_coeffs in
  let kp := Znth 0 pid_para 0 in
  let ki := Znth 1 pid_para 0 in
  let kd := Znth 2 pid_para 0 in
  Zlength filter_coeffs = 18 /\
  Zlength new_X = 8 /\ ret = StructFilterY4 old_X f kp kd Ang dAng /\
  Znth 0 new_X 0 = StructFilterNewX0 old_X f kp Ang /\
  Znth 1 new_X 0 = StructFilterNewX1 old_X f kp kd Ang dAng /\
  Znth 2 new_X 0 = StructFilterNewX2 old_X f kp kd Ang dAng /\
  Znth 3 new_X 0 = StructFilterNewX3 old_X f kp kd Ang dAng /\
  Znth 4 new_X 0 = StructFilterNewX4 old_X f kp kd Ang dAng /\
  Znth 5 new_X 0 = StructFilterNewX5 old_X f kp kd Ang dAng /\
  Znth 6 new_X 0 = StructFilterNewX6 old_X f kp kd Ang dAng /\
  Znth 7 new_X 0 = StructFilterNewX7 old_X prd ki Ang.
