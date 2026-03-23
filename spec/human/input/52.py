def below_threshold(l: list, t: int) -> bool:
    """Return True if all numbers in the list l are below threshold t.
    >>> below_threshold([1, 2, 4, 10], 100)
    True
    >>> below_threshold([1, 20, 4, 10], 5)
    False
    """
    return all(x < t for x in l)

def _orig_problem_52_pre(l: list) -> bool:
    """
    Precondition: no special constraints for `below_threshold`.
    """
    return True

def _orig_problem_52_spec(l: list, t: int, output: bool) -> bool:
    """
    Specification: (forall x, In x l -> x < t) <-> (output = true)
    """
    return all((x < t for x in l)) == output

def problem_52_pre(l, t):
    return bool(_orig_problem_52_pre(l))

def problem_52_spec(l, t, output):
    return bool(_orig_problem_52_spec(l, t, output))
