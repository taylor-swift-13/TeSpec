def _orig_problem_83_pre(n: int) -> bool:
    """
    Checks the precondition for problem 83: n must be a positive integer.
    """
    return n > 0

def _orig_problem_83_spec(n: int, count: int) -> bool:
    """
    Checks if the given count is the number of n-digit positive integers 
    that start or end with 1, according to the Coq specification.
    """
    if not n > 0:
        return True
    if n == 1:
        return count == 1
    elif n > 1:
        return count == 18 * 10 ** (n - 2)
    return False

def problem_83_pre(n):
    return bool(_orig_problem_83_pre(n))

def problem_83_spec(n, output):
    return bool(_orig_problem_83_spec(n, output))
