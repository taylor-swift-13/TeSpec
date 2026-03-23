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

def problem_63_pre(n: int) -> bool:
    """
    Precondition for problem_63.
    In the Coq specification, this is defined as True.
    """
    return True

def problem_63_spec(n: int, res: int) -> bool:
    """
    Specification for problem_63.
    Checks if the provided result 'res' is equal to fibfib(n).
    """
    return res == fibfib(n)

def _impl(n: int):
    if n == 0 or n == 1:
        return 0
    elif n == 2:
        return 1
    a, b, c = 0, 0, 1
    for _ in range(3, n + 1):
        a, b, c = b, c, a + b + c
    return c

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_63_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_63_spec(*input, output))

def fibfib(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
