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

def problem_85_pre(lst):
    """
    Precondition: the list must not be empty.
    """
    return lst != []

def problem_85_spec(lst, output):
    """
    Specification: the output must match the result of add_impl.
    """
    return output == add_impl(lst)

def _impl(lst):
    s = 0
    for i in range(1, len(lst), 2):
        if lst[i] % 2 == 0:
            s += lst[i]
    return s

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_85_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_85_spec(*input, output))

def add(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
