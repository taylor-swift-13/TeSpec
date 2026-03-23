def fibfib(n: int) -> int:
    """The FibFib number sequence is a sequence similar to the Fibbonacci sequence that's defined as follows:
    fibfib(0) == 0
    fibfib(1) == 0
    fibfib(2) == 1
    fibfib(n) == fibfib(n-1) + fibfib(n-2) + fibfib(n-3).
    """
    if n == 0:
        return 0
    if n == 1:
        return 0
    if n == 2:
        return 1
    
    # Iterative approach for efficiency to compute the n-th element
    # a, b, c represent fibfib(i-3), fibfib(i-2), fibfib(i-1)
    a, b, c = 0, 0, 1
    for _ in range(3, n + 1):
        a, b, c = b, c, a + b + c
    return c

def _orig_problem_63_pre(n: int) -> bool:
    """
    Precondition for problem_63.
    In the Coq specification, this is defined as True.
    """
    return True

def _orig_problem_63_spec(n: int, output: int) -> bool:
    """
    Specification for problem_63.
    Checks if the provided result 'output' is equal to fibfib(n).
    """
    return output == fibfib(n)

def problem_63_pre(n):
    return bool(_orig_problem_63_pre(n))

def problem_63_spec(n, output):
    return bool(_orig_problem_63_spec(n, output))
