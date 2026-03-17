
def precondition(input_tuple):
    return (
        isinstance(input_tuple, tuple)
        and len(input_tuple) == 1
        and isinstance(input_tuple[0], int)
        and input_tuple[0] >= 0
    )

def postcondition(input_tuple, output):
    n = input_tuple[0]
    if not isinstance(output, int) or output < 0 or output % 2 != 0:
        return False
    base_cases = {0: 0, 1: 0, 2: 2, 3: 0}
    if n in base_cases and output != base_cases[n]:
        return False
    return True

def _impl(n: int):
    """The Fib4 number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
    fib4(0) -> 0
    fib4(1) -> 0
    fib4(2) -> 2
    fib4(3) -> 0
    fib4(n) -> fib4(n-1) + fib4(n-2) + fib4(n-3) + fib4(n-4).
    Please write a function to efficiently compute the n-th element of the fib4 number sequence.  Do not use recursion.
    4
    8
    14"""
    if n == 0:
        return 0
    elif n == 1:
        return 0
    elif n == 2:
        return 2
    elif n == 3:
        return 0
    else:
        a, b, c, d = 0, 0, 2, 0
        for i in range(4, n + 1):
            a, b, c, d = b, c, d, a + b + c + d
        return d

def fib4(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
