def sum_even_at_odd_indices(l, n):
    """
    Helper function to sum even elements at odd indices starting from index n.
    """
    total = 0
    curr_n = n
    for h in l:
        # Nat.odd n in Coq corresponds to n % 2 != 0 in Python for non-negative n.
        # Z.even h in Coq corresponds to h % 2 == 0 in Python.
        if (curr_n % 2 != 0) and (h % 2 == 0):
            total += h
        curr_n += 1
    return total

def add_impl(lst):
    """
    Implementation of the add function logic.
    """
    return sum_even_at_odd_indices(lst, 0)

def _orig_problem_85_pre(lst):
    """
    Precondition: the list must not be empty.
    """
    return lst != []

def _orig_problem_85_spec(lst, output):
    """
    Specification: the output must match the result of add_impl.
    """
    return output == add_impl(lst)

def problem_85_pre(lst):
    return bool(_orig_problem_85_pre(lst))

def problem_85_spec(lst, output):
    return bool(_orig_problem_85_spec(lst, output))
