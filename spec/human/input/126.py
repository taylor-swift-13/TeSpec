def problem_126_pre(l):
    return True

def problem_126_spec(l, b):
    # We strictly implement the Coq spec 'Sorted Nat.lt l <-> b = true'.
    # Note: Nat.lt requires strictly ascending order (no duplicates),
    # which overrides the informal problem description.
    sorted_nat_lt = all(l[i] < l[i+1] for i in range(len(l) - 1))
    b_eq_true = (b == True)
    return sorted_nat_lt == b_eq_true
