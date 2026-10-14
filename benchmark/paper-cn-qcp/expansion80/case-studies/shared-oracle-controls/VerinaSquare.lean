import Std.Tactic
-- Semantic control matching VERINA basic/48's original postcondition.
-- Checked with Lean 4.34.0, not the task's pinned 4.18.0 agent pipeline.
def squarePost (n : Nat) (result : Bool) : Prop :=
  result ↔ ∃ i : Nat, i * i = n

theorem notSquareTwo : ¬ ∃ i : Nat, i * i = 2 := by
  rintro ⟨i, h⟩
  cases i with
  | zero => simp at h
  | succ j =>
    cases j with
    | zero => simp at h
    | succ k =>
      have htwo : 2 ≤ k+1+1 := by omega
      have hm : 2*2 ≤ (k+1+1)*(k+1+1) := Nat.mul_le_mul htwo htwo
      omega

theorem notSquareThree : ¬ ∃ i : Nat, i * i = 3 := by
  rintro ⟨i, h⟩
  cases i with
  | zero => simp at h
  | succ j =>
    cases j with
    | zero => simp at h
    | succ k =>
      have htwo : 2 ≤ k+1+1 := by omega
      have hm : 2*2 ≤ (k+1+1)*(k+1+1) := Nat.mul_le_mul htwo htwo
      omega

theorem squareZero : squarePost 0 true := by
  constructor
  · intro _; exact ⟨0, rfl⟩
  · intro _; rfl
theorem squareOne : squarePost 1 true := by
  constructor
  · intro _; exact ⟨1, rfl⟩
  · intro _; rfl
theorem squareFour : squarePost 4 true := by
  constructor
  · intro _; exact ⟨2, rfl⟩
  · intro _; rfl
theorem nonsquareTwo : squarePost 2 false := by
  constructor
  · intro h; cases h
  · intro h; exact False.elim (notSquareTwo h)
theorem nonsquareThree : squarePost 3 false := by
  constructor
  · intro h; cases h
  · intro h; exact False.elim (notSquareThree h)
theorem rejectWrongFalse : ¬ squarePost 4 false := by
  intro h
  have hc := h.mpr ⟨2, rfl⟩
  cases hc
theorem rejectWrongTrue : ¬ squarePost 3 true := by
  intro h
  exact notSquareThree (h.mp rfl)
#print axioms squareFour
#print axioms nonsquareThree
#print axioms rejectWrongFalse
#print axioms rejectWrongTrue
