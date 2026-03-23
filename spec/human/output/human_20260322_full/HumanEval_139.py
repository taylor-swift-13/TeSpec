def fact(n):
    if n == 0:
        return 1
    return n * fact(n - 1)

def brazilian_factorial_impl(n):
    # In Coq: fold_right mult 1 (map fact (seq 1 n))
    # seq 1 n generates the list [1, 2, ..., n]
    # map fact applies factorial to each element
    # fold_right mult 1 multiplies them all together
    result = 1
    for i in range(1, n + 1):
        result *= fact(i)
    return result

def problem_139_pre(n):
    return n > 0

def problem_139_spec(n, output):
    return output == brazilian_factorial_impl(n)

def _impl(n):
    fac, ans = 1, 1
    for i in range(2, n + 1):
        fac *= i
        ans *= fac
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_139_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_139_spec(*input, output))

def special_factorial(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
