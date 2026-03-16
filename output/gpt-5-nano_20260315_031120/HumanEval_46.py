
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    if not isinstance(output, int):
        return False

    # Reference fib4 implementation for verification
    if n == 0:
        expected = 0
    elif n == 1:
        expected = 0
    elif n == 2:
        expected = 2
    elif n == 3:
        expected = 0
    else:
        arr = [0, 0, 2, 0]  # fib4(0), fib4(1), fib4(2), fib4(3)
        for i in range(4, n + 1):
            val = arr[i - 1] + arr[i - 2] + arr[i - 3] + arr[i - 4]
            arr.append(val)
        expected = arr[n]

    return output == expected

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
