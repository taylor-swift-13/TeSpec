
def precondition(input):
    n = input[0]
    # n must be an integer and non-negative
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    # Output must be a non-negative integer
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # Verify base cases
    if n == 0:
        return output == 0
    if n == 1:
        return output == 0
    if n == 2:
        return output == 2
    if n == 3:
        return output == 0
    # For larger n, compute the expected value iteratively to verify
    fib4_vals = [0, 0, 2, 0]
    for i in range(4, n + 1):
        next_val = fib4_vals[0] + fib4_vals[1] + fib4_vals[2] + fib4_vals[3]
        fib4_vals[0] = fib4_vals[1]
        fib4_vals[1] = fib4_vals[2]
        fib4_vals[2] = fib4_vals[3]
        fib4_vals[3] = next_val
    return output == fib4_vals[3]

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
