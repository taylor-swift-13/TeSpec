def fib_spec(n: int, fib_n: int) -> bool:
    p1 = (fib_n == 0) if n == 0 else True
    p2 = (fib_n == 1) if (n == 1 or n == 2) else True
    p3 = False if n >= 3 else True
    return p1 and p2 and p3

def _impl(n: int):
    if n == 0: return 0
    if n <= 2: return 1
    a, b = 1, 1
    for _ in range(3, n + 1):
        a, b, = b, a + b
    return b

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(fib_spec(*input, output))

def fib(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
